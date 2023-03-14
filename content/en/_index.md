---
type: docs
title: Introduction
#description: "Sailor Hat for Raspberry Pi is a power management and NMEA 2000 board for the marine environment."
#permalink: /
linkTitle: "Home"
weight: 1
cascade:
# cf: https://www.docsy.dev/docs/adding-content/content/#alternative-site-structure
#  - type: "blog"
#    toc_root: true
#    _target:
#    path: "/news/**"
  - type: "docs"
    no_list: true
    _target:
    path: "/**"
---

Sailor Hat for Raspberry Pi (SH-RPi for short) is a smart power management board for the Raspberry Pi and similar single-board computers.
When connected to a Raspberry Pi, it allows you to build deeply integrated servers that shut down safely when the power is turned off, and wake up automatically when the power is turned on.

All Raspberry Pi models supporting the 40-pin GPIO header (that is, every model since the Pi 1 Model B+) are supported.
Additionally, the SH-RPi can be used with Raspberry Pi Compute Module 4 boards and similar single-board computers, as long as they have a 40-pin Raspberry Pi compatible GPIO header, or an external I2C interface and a 5V power input.


{{< imgrel shrpi_v2.0.0_top_render_ortho.jpg "60%" >}}
Sailor Hat for Raspberry Pi v2.0.0.
{{< /imgrel >}}

Central use cases include:

- Safely power the computer using a 12V or 24V power system commonly present on vehicles and boats.
SH-RPi has a wide voltage range (9-32V) power input with additional filtering and surge protection.
- Keep the server running during power glitches or brownouts.
The integrated supercapacitors ensure that intermittent power outages are totally ignored.
- Power the computer directly from the NMEA 2000 bus.
SH-RPi includes a current limiting circuit that by default limits the maximum input current to approximately 0.8 A.
The supercapacitors provide peak power capability to run even power-hungry single-board computers with multiple peripheral devices such as a screen and an SSD drive.
- Shut the server down safely when the power is switched off.
The computer is informed about the power outage and the supercapacitors provide power while the computer shuts down in a controlled fashion. The supercapacitors are able to power a single Raspberry Pi 4B for up to 70 seconds, far more than the typical shutdown time of 10-15 seconds or less.
No more corrupted SD cards!
- Keep the computer in time with the integrated real-time clock and a backup battery.
- Reset the Raspberry Pi automatically if it has crashed with the built-in watchdog timer.
- Stack other Raspberry Pi hats on top of SH-RPi to add interfaces and functionality such as GPS, NMEA 2000 or NMEA 0183.

Sailor Hat for Raspberry Pi is open hardware, licensed under the Creative Commons Attribution-ShareAlike 4.0 International license.

## Getting the hardware

SH-RPi boards can be purchased from [Hat Labs Ltd](https://shop.hatlabs.fi).
All design files are also available at the [SH-RPi hardware GitHub repository](https://github.com/hatlabs/sh-rpi-hardware/).
