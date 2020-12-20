#![no_std]

use {
    usb_device::{
        bus::{UsbBus, UsbBusAllocator},
        prelude::*,
    },
    usbd_hid::descriptor::generator_prelude::*,
    usbd_hid::hid_class::HIDClass,
};

#[derive(Debug)]
pub struct PinState {
    pub joy_right: bool,
    pub joy_left: bool,
    pub joy_up: bool,
    pub joy_down: bool,
    pub buttons: [bool; 10],
}

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

pub struct Device<'a, USB: UsbBus> {
    hid: HIDClass<'a, USB>,
    dev: UsbDevice<'a, USB>,
    report: InputReport,
    report_pending: bool,
}

impl<'a, USB: UsbBus> Device<'a, USB> {
    pub fn new(bus: &'a UsbBusAllocator<USB>, serial_num: &'a str) -> Self {
        let hid = HIDClass::new(bus, InputReport::desc(), 1);

        let dev = UsbDeviceBuilder::new(bus, UsbVidPid(0x1209, 0xeeee))
            .manufacturer("Villa Labs")
            .product("Lithe Joystick")
            .serial_number(serial_num)
            .device_class(0x00)
            .device_sub_class(0x00)
            .device_protocol(0x00)
            .build();

        Self {
            hid: hid,
            dev: dev,
            report: InputReport {
                x: 0x7f,
                y: 0x7f,
                buttons0: 0x0,
                buttons1: 0x0,
            },
            report_pending: false,
        }
    }

    pub fn process_pins(&mut self, pins: &PinState) {
        let prev_report = self.report.clone();
        self.report.x = if pins.joy_right {
            0xff
        } else if pins.joy_left {
            0x00
        } else {
            0x7f
        };

        self.report.y = if pins.joy_down {
            0xff
        } else if pins.joy_up {
            0x0
        } else {
            0x7f
        };

        self.report.buttons0 = 0;
        for i in 0..8 {
            self.report.buttons0 |= if pins.buttons[i] { 1 << i } else { 0x0 };
            //self.report.buttons0 <<= 1;
        }

        self.report.buttons1 = 0;
        for i in 9..=8 {
            self.report.buttons1 |= if pins.buttons[i] { 0x1 } else { 0x0 };
            self.report.buttons1 <<= 1;
        }

        //self.report.buttons0 = if pins.buttons[0] { 0x1 } else { 0x0 };

        if prev_report != self.report {
            self.report_pending = true;
        }

        if self.report_pending {
            self.report_pending = match self.hid.push_input(&self.report) {
                Err(_) => true,
                _ => false,
            };
        }
    }

    pub fn usb_poll(&mut self) {
        self.dev.poll(&mut [&mut self.hid]);
    }
}

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
