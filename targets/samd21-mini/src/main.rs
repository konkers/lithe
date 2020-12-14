#![no_std]
#![no_main]

extern crate atsamd_hal as hal;

use {
    cortex_m::interrupt::free as disable_interrupts,
    hal::{
        clock::GenericClockController,
        define_pins,
        gpio::{self, Floating, Input, IntoFunction, Pa0, Pa1, Pa2, Pa3, Port, PullUp},
        prelude::*,
        target_device as pac,
        timer::TimerCounter,
        usb::UsbBus,
    },
    rtic::app,
    rtic::{Exclusive, Mutex},
    usb_device::{bus::UsbBusAllocator, prelude::*},
    usbd_hid::descriptor::generator_prelude::*,
    usbd_hid::hid_class::HIDClass,
};

#[cfg(not(feature = "semihosting"))]
use panic_halt as _;

#[cfg(feature = "semihosting")]
use {
    cortex_m_semihosting::hprintln,
    panic_semihosting as _, // logs messages to the host stderr; requires a debugger
};
#[gen_hid_descriptor(
    (collection = APPLICATION, usage_page = GENERIC_DESKTOP, usage = JOYSTICK) = {
        (usage = X,) = {x=input;};
        (usage = Y,) = {y=input;};
        (usage_page = BUTTON, usage_min = BUTTON_1, usage_max = BUTTON_8) = {
            #[packed_bits 8] #[item_settings data,variable,absolute] buttons0=input;
        };
        (usage_page = BUTTON, usage_min = 9, usage_max = 10) = {
            #[packed_bits 2] #[item_settings data,variable,absolute] buttons1=input;
        };
    }
)]
#[derive(PartialEq)]
pub struct InputReport {
    pub x: u8,
    pub y: u8,
    pub buttons0: u8,
    pub buttons1: u8,
}

define_pins!(
    struct Pins,
    target_device: pac,
    pin joy_right = a0,
    pin joy_left = a1,
    pin joy_up = a2,
    pin joy_down = a3,
    pin usb_dm = a24,
    pin usb_dp = a25,
);

#[app(device = hal::target_device, peripherals = true)]
const APP: () = {
    struct Resources {
        usb_bus: &'static UsbBusAllocator<UsbBus>,
        usb_device: UsbDevice<'static, UsbBus>,
        usb_hid: HIDClass<'static, UsbBus>,
        timer: TimerCounter<pac::TC4>,
        joy_right: Pa0<Input<PullUp>>,
        joy_left: Pa1<Input<PullUp>>,
        joy_up: Pa2<Input<PullUp>>,
        joy_down: Pa3<Input<PullUp>>,
        report: InputReport,
        report_pending: bool,
    }

    #[init]
    fn init(ctx: init::Context) -> init::LateResources {
        static mut USB_BUS: Option<UsbBusAllocator<UsbBus>> = None;

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

        let usb_dm = pins.usb_dm.into_function(&mut pins.port);
        let usb_dp = pins.usb_dp.into_function(&mut pins.port);

        let usb_clock = &clocks.usb(&gclk0).unwrap();

        *USB_BUS = Some(UsbBusAllocator::new(UsbBus::new(
            usb_clock, &mut dp.PM, usb_dm, usb_dp, dp.USB,
        )));

        #[cfg(feature = "semihosting")]
        hprintln!("Initializing peripherals").unwrap();

        #[cfg(feature = "semihosting")]
        hprintln!("Preparing HID mouse...").unwrap();
        let usb_hid = HIDClass::new(USB_BUS.as_ref().unwrap(), InputReport::desc(), 1);

        #[cfg(feature = "semihosting")]
        hprintln!("Defining USB parameters...").unwrap();
        let usb_device = UsbDeviceBuilder::new(USB_BUS.as_ref().unwrap(), UsbVidPid(0, 0x3821))
            .manufacturer("JoshFTW")
            .product("BBTrackball")
            .serial_number("RustFW")
            .device_class(0x00)
            .device_sub_class(0x00)
            .device_protocol(0x00)
            .build();

        #[cfg(feature = "semihosting")]
        hprintln!("Setting up timer...").unwrap();
        // gclk0 represents a configured clock using the system 48MHz oscillator
        // configure a clock for the TC4 and TC5 peripherals
        let tc45 = &clocks.tc4_tc5(&gclk0).unwrap();
        // instantiate a timer objec for the TC4 peripheral
        let mut timer = TimerCounter::tc4_(tc45, dp.TC4, &mut dp.PM);
        timer.enable_interrupt();
        timer.start(2.hz());

        #[cfg(feature = "semihosting")]
        hprintln!("Defining late resources...").unwrap();
        init::LateResources {
            usb_bus: USB_BUS.as_ref().unwrap(),
            usb_device,
            usb_hid,
            timer,
            joy_right,
            joy_left,
            joy_up,
            joy_down,
            report: InputReport {
                x: 0x7f,
                y: 0x7f,
                buttons0: 0x0,
                buttons1: 0x0,
            },
            report_pending: false,
        }
    }

    #[task(binds = TC4, resources = [joy_right, joy_left, joy_up, joy_down, report, report_pending, timer, usb_hid])]
    fn tc4_handler(ctx: tc4_handler::Context) {
        let prev_report = ctx.resources.report.clone();
        ctx.resources.report.x = if ctx.resources.joy_right.is_low().unwrap() {
            0xff
        } else if ctx.resources.joy_left.is_low().unwrap() {
            0x00
        } else {
            0x7f
        };

        ctx.resources.report.y = if ctx.resources.joy_down.is_low().unwrap() {
            0xff
        } else if ctx.resources.joy_up.is_low().unwrap() {
            0x00
        } else {
            0x7f
        };

        if prev_report != *ctx.resources.report {
            *ctx.resources.report_pending = true;
        }

        if *ctx.resources.report_pending {
            *ctx.resources.report_pending =
                send_report(Exclusive(ctx.resources.usb_hid), &ctx.resources.report);
        }

        ctx.resources.timer.wait().ok();
    }

    #[task(binds = USB, resources = [usb_device, usb_hid])]
    fn usb_handler(ctx: usb_handler::Context) {
        let dev = ctx.resources.usb_device;
        let hid = ctx.resources.usb_hid;

        // USB dev poll only in the interrupt handler
        dev.poll(&mut [hid]);
    }
};

fn send_report(
    mut shared_hid: impl Mutex<T = HIDClass<'static, UsbBus>>,
    report: &InputReport,
) -> bool {
    shared_hid.lock(|hid| match hid.push_input(report) {
        Err(_) => true,
        _ => false,
    })
}
