#![no_std]
#![no_main]

use {
    cortex_m::interrupt::free as disable_interrupts,
    rtic::app,
    rtic::{Exclusive, Mutex},
    stm32f0xx_hal::{
        gpio::gpioc::{PC10, PC11, PC12, PC13},
        gpio::{Input, PullUp},
        pac,
        prelude::*,
        time::KiloHertz,
        timers::{Event, Timer},
        usb,
    },
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

#[app(device = stm32f0xx_hal::pac, peripherals = true)]
const APP: () = {
    struct Resources {
        usb_bus: &'static UsbBusAllocator<usb::UsbBusType>,
        usb_device: UsbDevice<'static, usb::UsbBusType>,
        usb_hid: HIDClass<'static, usb::UsbBusType>,
        timer: Timer<pac::TIM7>,
        joy_right: PC10<Input<PullUp>>,
        joy_left: PC11<Input<PullUp>>,
        joy_up: PC12<Input<PullUp>>,
        joy_down: PC13<Input<PullUp>>,
        report: InputReport,
        report_pending: bool,
    }

    #[init]
    fn init(ctx: init::Context) -> init::LateResources {
        static mut USB_BUS: Option<UsbBusAllocator<usb::UsbBusType>> = None;

        // Alias peripherals
        let mut dp: pac::Peripherals = ctx.device;

        // This enables clock for SYSCFG and remaps USB pins to PA9 and PA10.
        usb::remap_pins(&mut dp.RCC, &mut dp.SYSCFG);

        #[cfg(feature = "semihosting")]
        hprintln!("Initializing peripherals").unwrap();
        let mut rcc = dp
            .RCC
            .configure()
            .usbsrc(stm32f0xx_hal::rcc::USBClockSource::HSI48)
            .hsi48()
            .enable_crs(dp.CRS)
            .sysclk(48.mhz())
            .pclk(24.mhz())
            .freeze(&mut dp.FLASH);

        // User Button and USB
        let gpioa = dp.GPIOA.split(&mut rcc);
        let gpioc = dp.GPIOC.split(&mut rcc);
        let (usb_dm, usb_dp, joy_right, joy_left, joy_up, joy_down) = disable_interrupts(|cs| {
            (
                gpioa.pa11,
                gpioa.pa12,
                gpioc.pc10.into_pull_up_input(cs),
                gpioc.pc11.into_pull_up_input(cs),
                gpioc.pc12.into_pull_up_input(cs),
                gpioc.pc13.into_pull_up_input(cs),
            )
        });

        let usb = usb::Peripheral {
            usb: dp.USB,
            pin_dm: usb_dm,
            pin_dp: usb_dp,
        };
        *USB_BUS = Some(usb::UsbBus::new(usb));

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
        let mut timer = Timer::tim7(dp.TIM7, KiloHertz(2), &mut rcc);
        timer.listen(Event::TimeOut);

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

    #[task(binds = TIM7, resources = [joy_right, joy_left, joy_up, joy_down, report, report_pending, timer, usb_hid])]
    fn tim7_handler(ctx: tim7_handler::Context) {
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
    mut shared_hid: impl Mutex<T = HIDClass<'static, usb::UsbBusType>>,
    report: &InputReport,
) -> bool {
    shared_hid.lock(|hid| match hid.push_input(report) {
        Err(_) => true,
        _ => false,
    })
}
