---
title: Compute Module 4
weight: 100
---

The [Compute Module 4](https://www.raspberrypi.org/products/compute-module-4/) is a small form factor computer module that plugs into a carrier board. Providing CPU performance identical to the Raspberry Pi 4B,tThe CM4 is a powerful, flexible, and low-cost solution for embedded applications. When building embedded computers, the CM4 has several advantages over the Raspberry Pi 4B:

- Built-in eMMC flash memory: The CM4 boards have, depending on the model, up to 32 GB of eMMC flash memory. This memory is both more reliable and faster than the SD card used in the Raspberry Pi 4B.
- Option for an external WiFi antenna: The CM4 has a dedicated connector for an external WiFi antenna. This is useful if the signal strength of the internal WiFi antenna is not sufficient.
- M.2 connector: Many base boards have an M.2 connector that can be used to connect an M.2 SSD or an M.2 WiFi module.
- Lower power consumption: in informal testing, we have found a CM4 and a base board to consume over 20% less power than a Raspberry Pi 4B.

On the downside, most of the CM4 base boards do not include an USB 3.0 hub, meaning that the USB ports are limited to USB 2.0 speeds. Also, flashing the eMMC is slightly more complicated than flashing an SD card. The process is described below.

## Flashing the eMMC Memory on the CM4

First, you need to download a suitable image. We are using the [OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/downloading.html) Headless image as an example, but the process is the same for other images. **Note:** Always use a 64-bit image! Some software components will have issues when running on a 32-bit system (InfluxDB, in particular).

The eMMC memory can be flashed with the same image as the Raspberry Pi 4B. The flashing process has two extra steps. First, the CM4 needs to be switched into a special BOOT mode which actually *prevents* the device from booting and allows flashing the eMMC. Second, on the computer used for flashing, a small `rpiboot` utility needs to be installed and run to allow mounting the eMMC memory on your computer. Once these steps are completed, the flashing process is identical to the one used for the Raspberry Pi 4B.

For Windows, the `rpiboot` is available as a pre-compiled executable, but for Linux and MacOS, you need to compile it from source. The process for each platform is described in the chapters below.

Notes on the installation process:

1. To flash the eMMC, the base board needs to be switched to BOOT mode. On the Waveshare CM4-IO-BASE boards, the small BOOT switch next to the HDMI0 connector needs to be turned to the ON position.
2. The base board needs to be connected to an external power source during the flashing process. Use the SH-RPi board for this purpose!

### Windows

1. To set up the flashing mode on the host computer, follow the instructions provided in the [Raspberry Pi documentation](https://www.raspberrypi.com/documentation/computers/compute-module.html#flashing-the-compute-module-emmc).
2. Follow the [installation instructions for OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html).
3. **Note:** Do not boot the system yet! We need to adjust a few settings first, as described in the CM4 Configuration section below. 
4. After changing the configuration settings, switch the BOOT switch back to OFF position and reboot the system. You can then continue with the OpenPlotter instructions.

### Mac

On a Mac, you need to compile the `rpiboot` utility from source. 

1. To compile the utility, you need to have [Homebrew](https://brew.sh/) installed. Do that first. 
2. Then, follow the [steps given in the `usbboot` repository](https://github.com/raspberrypi/usbboot#macos). When you run the `sudo ./rpiboot`, you should have the CM4 base board connected to your computer and powered up using the SH-RPi. If you get an error message, check the USB cable and the BOOT switch on the base board.
3. Follow the [installation instructions for OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html). **Note:** Do not boot the system yet! We need to adjust a few settings first, as described in the CM4 Configuration section below.
4. After changing the configuration settings, switch the BOOT switch back to OFF position and reboot the system. You can then continue with the OpenPlotter instructions.

### Linux

Like on a Mac, you need to compile the `rpiboot` utility from source on Linux.

1. To compile the utility, you need to have [Homebrew](https://brew.sh/) installed. Do that first. 
2. Then, follow the [steps given in the `usbboot` repository](https://github.com/raspberrypi/usbboot#linux--cygwin--wsl). When you run the `sudo ./rpiboot`, you should have the CM4 base board connected to your computer and powered up using the SH-RPi. If you get an error message, check the USB cable and the BOOT switch on the base board.
3. Follow the [installation instructions for OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html). **Note:** Do not boot the system yet! We need to adjust a few settings first, as described in the CM4 Configuration section below.
4. After changing the configuration settings, switch the BOOT switch back to OFF position and reboot the system. You can then continue with the OpenPlotter instructions.

## CM4 Configuration

### Enabling USB Ports

Before you boot the system for the first time, you need to make a few changes to the configuration. By default, the USB ports are disabled on the CM4. Obviously, this can be a major issue if you want to use the system with a keyboard and mouse. To enable the USB ports, you need to edit the `config.txt` file on the eMMC memory. The Boot partition should already be mounted on your computer as a USB drive. Open the drive and edit the `config.txt` file. Add the following line to the end of the file:
    
    dtoverlay=dwc2,dr_mode=host
    
Save the file and close it.

<!-- ### Configure WiFi Client

If you want to have the Pi connect to an existing WiFi network, you need to edit the `wpa_supplicant.conf` file. Open the `wpa_supplicant.conf` file and add the following lines to the end of the file:
    
    ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
    country=GB
    update_config=1

    network={
        ssid="YourNetwork"
        psk="YourPassword"
    }

Replace `GB` with your country code and `YourNetwork` and `YourPassword` with the name and password of your WiFi network. If you want, you can add multiple `network` sections. The Pi will then connect to the first available network.

Save the file and close it. -->

### Enable External WiFi Antenna

If you have an external WiFi antenna, you need to edit the `config.txt` file again. Add the following line to the end of the file:
    
    dtparam=ant2

Other possible values are `ant1` for the PCB antenna and `noant` for disabling both antennas. The default value is `ant1`.
