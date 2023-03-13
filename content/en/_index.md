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

Sailor Hat for Raspberry Pi (SH-RPi for short) is a power management and NMEA 2000 interface board for the Raspberry Pi.
When connected to a Raspberry Pi single board computer (not included!), it allows you to build boat servers running [Signal K](https://signalk.org), [OpenPlotter](https://openmarine.net/openplotter), or your own custom IoT software and power them directly from the boat's 12V or 24V network and interface safely with the boat's NMEA 2000 data network.

To use the SH-RPi, you need to bring your own Raspberry Pi. All models supporting the 40-pin GPIO header (that is, every model since the Pi 1 Model B+) are supported.

{{< imgrel SH-RPi-1.0.0-render.jpg "60%" >}}
Sailor Hat for Raspberry Pi v1.0.0.
{{< /imgrel >}}

Central use cases include:

- Safely power the computer using your boat's 12V or 24V power system.
SH-RPi has a wide voltage range (8-32V) power input with additional filtering and surge protection.
- Keep the server running during power glitches or brownouts.
The integrated supercapacitor ensures that intermittent power outages are totally ignored.
- Power even a Raspberry Pi 4B directly from the NMEA 2000 bus.
SH-RPi includes a current limiting circuit that limits the maximum input current to approximately 0.8A.
The supercapacitor provides ample peak power capability to run even power-hungry single-board computers with multiple peripheral devices such as a screen and an SSD drive.
- Shut the server down safely when the power is switched off.
The computer is informed about the power outage and the supercapacitor provides power while the computer shuts down in a controlled fashion. The supercapacitor is able to power a single Raspberry Pi 4B for up to 80 seconds, far more than the typical shutdown time of 10-15 seconds or less.
No more corrupted SD cards!
- Interface the Raspberry Pi with the boat's NMEA 2000 network or an automotive CAN bus.
SH-RPi includes an isolated NMEA 2000 interface that is compliant with the NMEA 2000 specification.
- Keep the computer in time with the optional integrated real-time clock and a backup battery.
- Reset the Raspberry Pi automatically if it has crashed.
- Stack other Raspberry Pi hats on top of SH-RPi to further add or customize the functionality.
SH-RPi has been designed to not interfere with other devices using the SPI data interface.
- Don't disturb other boat navigation and safety systems.
SH-RPi complies with the relevant European and maritime electromagnetic compatibility standards, ensuring that the device does not interfere with other sensitive devices such as the VHF radio or the GPS.

Sailor Hat for Raspberry Pi is open hardware, licensed under the Creative Commons Attribution-ShareAlike 4.0 International license.
You can create your own SH-RPi derivatives as long as you share them under similar terms!

## Getting the hardware

Ready-made CE-certified SH-RPi boards can be purchased from [Hat Labs Ltd](https://hatlabs.fi).
All design files are also available at the [SH-RPi hardware GitHub repository](https://github.com/hatlabs/sh-rpi-hardware/).
