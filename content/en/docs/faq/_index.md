---
title: Frequently Asked Questions
weight: 450
---

## Can I power the Raspberry Pi using the standard USB-C connector while the SH-RPi is connected?

The answer is no. Or at least, this should be avoided. Nothing will happen if the SH-RPi is powered and the supercaps are charged above 5V. However, if the supercaps are discharged, they will be back-powered through the 5V bus. In practice, this will likely overpower the USB power supply and cause it to shut down without any permanent damage. However, this is not a controlled situation and damage is possible to the power supply, the Raspberry Pi, or the SH-RPi itself.

Another aspect is that even with the supercaps charged, the daemon software will not see any input voltage and will trigger a shutdown immediately after booting.

