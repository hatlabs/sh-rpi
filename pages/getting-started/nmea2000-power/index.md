---
layout: default
title: NMEA 2000 power
nav_order: 1
parent: Getting Started
---

# Powering via NMEA 2000

It is possible to power the Raspberry Pi via the NMEA 2000 network. To stay compliant with the NMEA 2000 specification and to ensure safe and uninterrupted operation of the NMEA 2000 network, it is important to observe some restrictions in the device connections.

The following diagrams illustrate the valid powering schemes.
In the diagrams, dashed lines illustrate the isolation barrier

![Powered externally](assets/Power-diagram-n2k-and-power.png "Powered externally")\\
*Always OK: SH-RPi powered with a dedicated power cable.*

![Powered via NMEA 2000 bus](assets/Power-diagram-pure-n2k.png "Powered via NMEA 2000 bus")\\
*OK: SH-RPi powered via the NMEA 2000 network, no external connections.*

![Powered externally, galvanic connections](assets/Power-diagram-unisolated-conx.png "Powered externally, galvanic connections")\\
*OK: SH-RPi powered with a dedicated power cable and connected to external devices with a galvanic connection such as USB or unisolated RS-422.*

![Powered via NMEA 2000 bus, isolated connections](assets/Power-diagram-isolated-conx.png "Powered via NMEA 2000 bus, isolated connections")\\
*OK: SH-RPi powered via the NMEA 2000 network and connected to external devices with an isolated connection such as Ethernet or isolated NMEA 0183.*

![Powered via NMEA 2000 bus, USB-powered peripherals](assets/Power-diagram-isolated-peripherals.png "Powered via NMEA 2000 bus, USB-powered peripherals")\\
*OK: SH-RPi powered via the NMEA 2000 network having peripherals such as keyboard, mouse, or a GPS receiver that are powered by the Raspberry Pi and not connected elsewhere.*

![Not permitted: powered via NMEA 2000 and galvanic connections](assets/Power-diagram-illegal.png "Not permitted: powered via NMEA 2000 and galvanic connections")\\
*Not permitted: SH-RPi powered via the NMEA 2000 and connected to external devices with a galvanic connection. This setup will cause a lot of noise and may impact the reliability of the Raspberry Pi or other devices.*
