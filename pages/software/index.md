---
layout: default
title: Software
nav_order: 40
---

# Software
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

## Introduction

The Sailor Hat for Raspberry Pi requires additional software on the Raspberry Pi Operating System to fully utilize the device functionality. An installation script is provided to automatically install all required software on a fresh Raspberry Pi OS installation. Using the installation script is described in the [Getting Started Section](../getting-started/).

For manual installation, the required software and configuration changes as well as the firmware software details are described below.

## Raspberry Pi device tree changes

### Installing the device tree overlays

Raspberry Pi uses a [Device Tree (DT)](https://www.raspberrypi.org/documentation/configuration/device-tree.md) to describe the hardware present in the Pi.
Using the CAN interface on the SH-RPi requires applying two  device tree overlays to customize the hardware configuration. The device tree overlays apply the following changes:

1. Add another channel with its own Chip Enable (CE) pin to the SPI0 bus.
2. Define a new CAN controller using the new SPI0 channel.

The device tree overlay source files are located in the SH-RPi-daemon repository. To install them manually, first clone the repository on your Raspberry Pi:

    git clone https://github.com/hatlabs/SH-RPi-daemon.git

Then, go to the overlays directory:

    cd SH-RPi-daemon/overlays

The overlays need to be compiled to binary format:

    dtc -@ -I dts -O dtb -o spi0-3cs.dtbo spi0-3cs-overlay.dts
    dtc -@ -I dts -O dtb -o mcp2515-can2.dtbo mcp2515-can2-overlay.dts

Once compiled, copy the files to `/boot/overlays`:

    sudo install -o root spi0-3cs.dtbo /boot/overlays
    sudo install -o root mcp2515-can2.dtbo /boot/overlays

### Enabling I2C and SPI

Next, I2C and SPI interfaces need to be enabled. This can be done either by running `raspi-config` or by editing `/boot/config.txt` directly.

If you use `raspi-config`, skip until the end of this subsection.

    sudo nano /boot/config.txt

First, enable I2C. Find the following line:

    #dtparam=i2c_arm=on

and edit it by removing the comment marker at the beginning:

    dtparam=i2c_arm=on
   
Do the same for SPI by uncommenting the following line:

    #dtparam=spi=on

Write the file by pressing Ctrl-O. Then exit Nano by pressing Ctrl-X.

### Enabling the new interfaces

Again, edit `/boot/config.txt`:

    sudo nano /boot/config.txt

Scroll down to the `[all]` section.

You need to add three new lines there. First, enable the RTC (if your device has one):

    dtoverlay=i2c-rtc,ds3231

Next, define the new CAN interface:

    dtoverlay=mcp2515-can2,oscillator=16000000,interrupt=5,cs2=6

Finally, configure the kernel to signal the Sailor Hat on power off:

    dtoverlay=gpio-poweroff,gpiopin=2,input,active_low=17

Again, write the file by pressing Ctrl-O and exit Nano by pressing Ctrl-X.

## Raspberry Pi configuration file changes for CAN interface

The I2C kernel module needs to be loaded at boot time:

    sudo nano /etc/modules

Add the following line:

    i2c-dev

Save and exit.

Next, create a network interface definition for the CAN interface:

    sudo nano /etc/network/interfaces.d/can0

Add the following lines:

    auto can0
    iface can0 can static
        bitrate 250000
        up /sbin/ifconfig can0 txqueuelen 100

Save and exit.

## Raspberry Pi configuration file changes for the RTC

Raspberry Pi doesn't have a real-time clock by default.
Instead, the system implements a "fake hwclock" that fetches the current time from the internet and then saves the time to a file at regular intervals. The time is then set from that file at boot to avoid things such as filesystem checks at every boot.

If your SH-RPi has a real-time clock, this fake hwclock functionality needs to be disabled and replaced with actual hwclock calls. These four commands do the trick:

     sudo apt-get -y remove fake-hwclock
     sudo update-rc.d -f fake-hwclock remove
     sudo systemctl disable fake-hwclock
     sudo sed -i -e "s,^\(if \[ \-e /run/systemd/system \] ; then\),if  false; then\n#\1," /lib/udev/hwclock-set

## Raspberry Pi daemon

To make the Raspberry Pi OS aware of the power state, a daemon (service software) needs to be installed.

If you have cloned the SH-RPi-daemon repository, you can install the daemon by issuing the following commands:

    sudo apt-get -y install python3-setuptools
    sudo python3 setup.py install

Next, you will have to install the service definition file and enable the service:

    sudo install -o root sh-rpi-daemon.service /lib/systemd/system
    sudo systemctl daemon-reload
    sudo systemctl enable sh-rpi-daemon

That's it!

## Firmware

The program code running on the onboard ATtiny1614 microcontroller is called the SH-RPi firmware.

The firmware repository is at [https://github.com/hatlabs/SH-RPi-firmware](https://github.com/hatlabs/SH-RPi-firmware).

- TODO: How to install the firmware

