#![no_std]
#![no_main]

use {
    cortex_m::interrupt::free as disable_interrupts,
    lithe,
    rtic::app,
    stm32f0xx_hal::{
        gpio::gpioc::{PC10, PC11, PC12, PC13},
        gpio::{Input, PullUp},
        pac,
        prelude::*,
        time::KiloHertz,
        timers::{Event, Timer},
        usb,
    },
    usb_device::bus::UsbBusAllocator,
};

#[cfg(not(feature = "semihosting"))]
use panic_halt as _;

#[cfg(feature = "semihosting")]
use {
    cortex_m_semihosting::hprintln,
    panic_semihosting as _, // logs messages to the host stderr; requires a debugger
};

#[app(device = stm32f0xx_hal::pac, peripherals = true)]
const APP: () = {
    struct Resources {
        usb_bus: &'static UsbBusAllocator<usb::UsbBusType>,
        lithe: lithe::Device<'static, usb::UsbBusType>,
        timer: Timer<pac::TIM7>,
        joy_right: PC10<Input<PullUp>>,
        joy_left: PC11<Input<PullUp>>,
        joy_up: PC12<Input<PullUp>>,
        joy_down: PC13<Input<PullUp>>,
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

        let lithe = lithe::Device::new(USB_BUS.as_ref().unwrap(), &"12345");

        #[cfg(feature = "semihosting")]
        hprintln!("Setting up timer...").unwrap();
        let mut timer = Timer::tim7(dp.TIM7, KiloHertz(2), &mut rcc);
        timer.listen(Event::TimeOut);

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
        }
    }

    #[task(binds = TIM7, resources = [joy_right, joy_left, joy_up, joy_down, lithe, timer])]
    fn tim7_handler(ctx: tim7_handler::Context) {
        let pins = lithe::PinState {
            joy_right: ctx.resources.joy_right.is_low().unwrap(),
            joy_left: ctx.resources.joy_left.is_low().unwrap(),
            joy_up: ctx.resources.joy_up.is_low().unwrap(),
            joy_down: ctx.resources.joy_down.is_low().unwrap(),
            buttons: [false; 10],
        };
        ctx.resources.lithe.process_pins(&pins);
        ctx.resources.timer.wait().ok();
    }

    #[task(binds = USB, resources = [lithe])]
    fn usb_handler(ctx: usb_handler::Context) {
        ctx.resources.lithe.usb_poll();
    }
};
