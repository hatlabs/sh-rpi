---
type: docs
title: Introduction
linkTitle: "Home"
weight: 1
cascade:
# cf: https://www.docsy.dev/docs/adding-content/content/#alternative-site-structure
  - type: "docs"
    no_list: true
    _target:
    path: "/**"
---

{{% pageinfo color="primary" %}}
Looking for the old Sailor Hat for Raspberry Pi v1.0.0 documentation? It's available at [docs.hatlabs.fi/sh-rpi-v1](https://docs.hatlabs.fi/sh-rpi-v1/).
{{% /pageinfo %}}

The Sailor Hat for Raspberry Pi (SH-RPi) is a versatile power management board designed for the Raspberry Pi and similar single-board computers. With the SH-RPi connected, you can create deeply integrated servers that shut down safely when power is turned off and wake up automatically when power is restored.

SH-RPi supports all Raspberry Pi models with a 40-pin GPIO header (every model since the Pi 1 Model B+). Additionally, it is compatible with Raspberry Pi Compute Module 4 boards and other single-board computers that have a 40-pin Raspberry Pi-compatible GPIO header or an external I2C interface with a 5V power input.

{{< imgrel shrpi_v2.0.0_top_render_ortho.jpg "60%" >}}
Sailor Hat for Raspberry Pi v2.0.0.
{{< /imgrel >}}

## Key Features

- **Wide voltage range input**: Safely power your Raspberry Pi using a 12 V or 24 V power system commonly found in vehicles and boats. The SH-RPi has a 10-32 V input range with additional filtering and surge protection.
- **High output current capacity**: 3 A of continuous output current at 5 V (subject to environment temperature), with peak currents up to 5 A. With active cooling, 4 A of continuous output current is possible. The SH-RPi can power even the most demanding Raspberry Pi setups.
- **Power glitch resilience**: Integrated supercapacitors ensure intermittent power outages are ignored, keeping your server running during brownouts or power glitches.
- **NMEA 2000 bus compatibility**: Power your Raspberry Pi directly from the NMEA 2000 bus. SH-RPi includes a current-limiting circuit, limiting the maximum input current to approximately 0.8 A. The supercapacitors provide peak power capability for power-hungry devices like screens and SSD drives.
- **Safe shutdown**: The Raspberry Pi is informed about power outages and shuts down safely, powered by the supercapacitors. This eliminates the risk of corrupted SD cards.
- **Real-time clock**: Keep your Raspberry Pi synchronized with the integrated real-time clock and backup battery.
- **Watchdog timer**: Automatically reset your Raspberry Pi in case of a crash with the built-in watchdog timer.
- **Stackable**: Add more functionality by stacking other Raspberry Pi hats, such as GPS, NMEA 2000, or NMEA 0183.

Sailor Hat for Raspberry Pi is open hardware, licensed under the Creative Commons Attribution-ShareAlike 4.0 International license.

## Getting the Hardware

You can purchase SH-RPi boards from [Hat Labs Ltd](https://shop.hatlabs.fi/products/sh-rpi). All design files are also available at the [SH-RPi hardware GitHub repository](https://github.com/hatlabs/sh-rpi-hardware/).
