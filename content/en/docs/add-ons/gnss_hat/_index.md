---
title: Waveshare MAX-M8Q GNSS HAT
weight: 400
---

The Waveshare MAX-M8Q GNSS HAT provides a high-quality GNSS receiver for the Raspberry Pi, based on the U-blox MAX-M8Q module. MAX-M8Q features a multi-constellation GNSS receiver with a high sensitivity of -167 dBm. It supports GPS, GLONASS, BeiDou and Galileo and can receive concurrently from three of these. Additionally, several augmentation schemes such as SBAS, QZSS, IMES and D-GPS are supported.

This page describes the installation and configuration of the GNSS HAT when used together with the Sailor Hat for Raspberry Pi. For further details on the GNSS HAT, see the [Waveshare wiki page](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT).

## Connecting the HAT

Insert the stack-through header into the GNSS HAT GPIO connector. Then, plug the HAT onto the Raspberry Pi's 40-pin GPIO header. The GNSS HAT can be stacked on top of other hats.

### Using the GNSS HAT together with the RS485 HAT

The MAX-M8Q GNSS HAT features a TIMEPULSE (PPS) feature that is used to provide a highly
accurate GNSS time reference to the Raspberry Pi. Unfortunately, this time pulse feature is connected to a GPIO pin that is also used by the RS485 HAT. If these two devices are used together, the conflicting GPIO pin must be physically disconnected. The easiest way
to do this is to cut the respective pin on the stack-through header. The figure below highlights the pin that needs to be cut.

{{< imgrel "pps_pin.jpg" "50%" >}}
The pin that needs to be cut when using the GNSS HAT together with the RS485 HAT.
{{< /imgrel >}}

To ensure the correct pin is cut, insert the stack-through header partially onto the GNSS HAT GPIO connector. Then, cut the top of the pin that is highlighted in the figure above. Disconnect the stack-through header and then cut the pin at the base of the connector.

## Software Configuration

GNSS HAT software installation will be automated using the Sailor Hat installation script. 
As of now, you need to configure the GNSS HAT manually according to the instructions on the [Waveshare MAX-M8Q GNSS HAT wiki page](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT). You do not need the steps beyond `gpsd` configuration.

Depending on the configuration, the GNSS HAT will provide a serial device `/dev/ttyAMA0` or `/dev/ttyS0` for NMEA 0183 data. OpenPlotter has a nifty serial device configuration utility which can be used to set up and connect the GNSS HAT to Signal K.

## Backup Battery

The GNSS HAT features a backup battery connector. The backup battery is used to store ephemeris information in case the Raspberry Pi is powered off. The backup battery is not mandatory but will speed up the time it takes to get a GNSS fix after powering on the Raspberry Pi.

The backup battery type is ML1220. It is a rechargeable Lithium cell and must **not** be replaced with a non-rechargeable battery. Doing so will result in a risk of explosion and fire! Advanced users can, at their own risk, remove the R3 resistor to disable the charging functionality to use a non-rechargeable CR1220 battery. The schematics and PCB layout are available at the [Waveshare wiki page](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT).
