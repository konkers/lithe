#![no_std]
#![no_main]

extern crate atsamd_hal as hal;

use {
    arrayvec::ArrayString,
    core::fmt::{self, Write},
    core::str,
    hal::{
        clock::GenericClockController,
        define_pins,
        gpio::{
            self, Floating, Input, IntoFunction, Pa14, Pa15, Pa16, Pa18, Pa2, Pa20, Pa21, Pa4, Pa6, Pa7, Pa8,
            Pa9, Pb8, Pb9, Port, PullUp, Output, PushPull,
        },
        prelude::*,
        target_device as pac,
        timer::TimerCounter,
        usb::UsbBus,
    },
    lithe,
    rtic::app,
    usb_device::bus::UsbBusAllocator,
};

#[cfg(not(feature = "semihosting"))]
use panic_halt as _;

#[cfg(feature = "semihosting")]
use {
    cortex_m_semihosting::hprintln,
    panic_semihosting as _, // logs messages to the host stderr; requires a debugger
};

define_pins!(
    struct Pins,
    target_device: pac,
    pin joy_right = b8,
    pin joy_left = a2,
    pin joy_up = a4,
    pin joy_down = b9,
    pin button0 = a8,
    pin button1 = a9,
    pin button2 = a14,
    pin button3 = a15,
    pin button4 = a20,
    pin button5 = a21,
    pin button6 = a6,
    pin button7 = a7,
    pin timing_out0 = a18,
    pin timing_out1 = a16,
    pin usb_dm = a24,
    pin usb_dp = a25,
);

#[app(device = hal::target_device, peripherals = true)]
const APP: () = {
    struct Resources {
        usb_bus: &'static UsbBusAllocator<UsbBus>,
        lithe: lithe::Device<'static, UsbBus>,
        timer: TimerCounter<pac::TC4>,
        joy_right: Pb8<Input<PullUp>>,
        joy_left: Pa2<Input<PullUp>>,
        joy_up: Pa4<Input<PullUp>>,
        joy_down: Pb9<Input<PullUp>>,
        button0: Pa8<Input<PullUp>>,
        button1: Pa9<Input<PullUp>>,
        button2: Pa14<Input<PullUp>>,
        button3: Pa15<Input<PullUp>>,
        button4: Pa20<Input<PullUp>>,
        button5: Pa21<Input<PullUp>>,
        button6: Pa6<Input<PullUp>>,
        button7: Pa7<Input<PullUp>>,
        timing_out0: Pa18<Output<PushPull>>,
        timing_out1: Pa16<Output<PushPull>>,
    }

    #[init]
    fn init(ctx: init::Context) -> init::LateResources {
        static mut USB_BUS: Option<UsbBusAllocator<UsbBus>> = None;
        static mut SERIAL: Option<ArrayString<[u8; 64]>> = None;

        // Alias peripherals
        let mut dp: pac::Peripherals = ctx.device;

        let mut clocks = GenericClockController::with_external_32kosc(
            dp.GCLK,
            &mut dp.PM,
            &mut dp.SYSCTRL,
            &mut dp.NVMCTRL,
        );
        let gclk0 = clocks.gclk0();

        let mut pins = Pins::new(dp.PORT);
        let joy_right = pins.joy_right.into_pull_up_input(&mut pins.port);
        let joy_left = pins.joy_left.into_pull_up_input(&mut pins.port);
        let joy_up = pins.joy_up.into_pull_up_input(&mut pins.port);
        let joy_down = pins.joy_down.into_pull_up_input(&mut pins.port);
        let button0 = pins.button0.into_pull_up_input(&mut pins.port);
        let button1 = pins.button1.into_pull_up_input(&mut pins.port);
        let button2 = pins.button2.into_pull_up_input(&mut pins.port);
        let button3 = pins.button3.into_pull_up_input(&mut pins.port);
        let button4 = pins.button4.into_pull_up_input(&mut pins.port);
        let button5 = pins.button5.into_pull_up_input(&mut pins.port);
        let button6 = pins.button6.into_pull_up_input(&mut pins.port);
        let button7 = pins.button7.into_pull_up_input(&mut pins.port);
        let timing_out0 = pins.timing_out0.into_push_pull_output(&mut pins.port);
        let timing_out1 = pins.timing_out1.into_push_pull_output(&mut pins.port);

        let usb_dm = pins.usb_dm.into_function(&mut pins.port);
        let usb_dp = pins.usb_dp.into_function(&mut pins.port);

        let usb_clock = &clocks.usb(&gclk0).unwrap();

        *USB_BUS = Some(UsbBusAllocator::new(UsbBus::new(
            usb_clock, &mut dp.PM, usb_dm, usb_dp, dp.USB,
        )));

        let (serial0, serial1, serial2, serial3) = unsafe {
            let serial0: *const u32 = 0x0080A00C as *const u32;
            let serial1: *const u32 = 0x0080A040 as *const u32;
            let serial2: *const u32 = 0x0080A044 as *const u32;
            let serial3: *const u32 = 0x0080A048 as *const u32;
            (*serial0, *serial1, *serial2, *serial3)
        };
        *SERIAL = Some(ArrayString::new());
        write!(
            SERIAL.as_mut().unwrap(),
            "{:08X}{:08X}{:08X}{:08X}",
            serial0,
            serial1,
            serial2,
            serial3
        )
        .unwrap();

        #[cfg(feature = "semihosting")]
        hprintln!("Preparing HID mouse...").unwrap();
        let lithe = lithe::Device::new(USB_BUS.as_ref().unwrap(), SERIAL.as_ref().unwrap());

        #[cfg(feature = "semihosting")]
        hprintln!("Setting up timer...").unwrap();
        // gclk0 represents a configured clock using the system 48MHz oscillator
        // configure a clock for the TC4 and TC5 peripherals
        let tc45 = &clocks.tc4_tc5(&gclk0).unwrap();
        // instantiate a timer objec for the TC4 peripheral
        let mut timer = TimerCounter::tc4_(tc45, dp.TC4, &mut dp.PM);
        timer.start(10.khz());
        timer.enable_interrupt();

        #[cfg(feature = "semihosting")]
        hprintln!("Defining late resources...").unwrap();
        init::LateResources {
            usb_bus: USB_BUS.as_ref().unwrap(),
            lithe,
            timer,
            joy_right,
            joy_left,
            joy_up,
            joy_down,
            button0,
            button1,
            button2,
            button3,
            button4,
            button5,
            button6,
            button7,
            timing_out0,
            timing_out1,
        }
    }

    #[task(binds = TC4, resources = [button0, button1, button2, 
        button3, button4, button5, button6, button7, joy_right, 
        joy_left, joy_up, joy_down, lithe, timing_out0, timer])]
    fn tc4_handler(ctx: tc4_handler::Context) {
        ctx.resources.timing_out0.set_high().ok();
        let pins = lithe::PinState {
            joy_right: ctx.resources.joy_right.is_low().unwrap(),
            joy_left: ctx.resources.joy_left.is_low().unwrap(),
            joy_up: ctx.resources.joy_up.is_low().unwrap(),
            joy_down: ctx.resources.joy_down.is_low().unwrap(),
            buttons: [
                ctx.resources.button0.is_low().unwrap(),
                ctx.resources.button1.is_low().unwrap(),
                ctx.resources.button2.is_low().unwrap(),
                ctx.resources.button3.is_low().unwrap(),
                ctx.resources.button4.is_low().unwrap(),
                ctx.resources.button5.is_low().unwrap(),
                ctx.resources.button6.is_low().unwrap(),
                ctx.resources.button7.is_low().unwrap(),
                false,
                false,
            ],
        };
        //   rprintln!("t: {:?}", &pins);
        ctx.resources.lithe.process_pins(&pins);
        ctx.resources.timer.wait().ok();
        ctx.resources.timing_out0.set_low().ok();
    }

    #[task(binds = USB, resources = [lithe, timing_out1])]
    fn usb_handler(ctx: usb_handler::Context) {
        ctx.resources.timing_out1.set_high().ok();
        ctx.resources.lithe.usb_poll();
        ctx.resources.timing_out1.set_low().ok();
    }
};

pub struct ByteMutWriter<'a> {
    pub buf: &'a mut [u8],
    pub cursor: usize,
}

impl<'a> ByteMutWriter<'a> {
    pub fn new(buf: &'a mut [u8]) -> Self {
        ByteMutWriter { buf, cursor: 0 }
    }

    pub fn as_str(&self) -> &str {
        str::from_utf8(&self.buf[0..self.cursor]).unwrap()
    }

    #[inline]
    pub fn capacity(&self) -> usize {
        self.buf.len()
    }

    pub fn clear(&mut self) {
        self.cursor = 0;
    }

    pub fn len(&self) -> usize {
        self.cursor
    }

    pub fn empty(&self) -> bool {
        self.cursor == 0
    }

    pub fn full(&self) -> bool {
        self.capacity() == self.cursor
    }
}

impl fmt::Write for ByteMutWriter<'_> {
    fn write_str(&mut self, s: &str) -> fmt::Result {
        let cap = self.capacity();
        for (i, &b) in self.buf[self.cursor..cap]
            .iter_mut()
            .zip(s.as_bytes().iter())
        {
            *i = b;
        }
        self.cursor = usize::min(cap, self.cursor + s.as_bytes().len());
        Ok(())
    }
}
