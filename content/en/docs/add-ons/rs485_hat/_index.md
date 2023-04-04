---
title: Waveshare 2-Channel Isolated RS485 HAT
weight: 300
---

The Waveshare 2-Channel Isolated RS485 HAT provides two isolated RS-485 interfaces for the Raspberry Pi. It can be used to implement a bidirectional NMEA 0183 interface or two generic bidirectional RS-485 interfaces. When used as an NMEA 0183 interface, one channel is used for receiving and the other for transmitting data.

The HAT has an integrated isolated DC/DC transformer and doesn't require external power input.

The RS485 HAT can be used simultaneously with the SH-RPi and the CAN HAT. 

This page describes the installation and configuration of the RS485 HAT when used together with the Sailor Hat for Raspberry Pi. For further details on the RS485 HAT, see the [Waveshare wiki page](https://www.waveshare.com/wiki/2-CH_RS485_HAT).


## Jumper Configuration

{{% alert title="Warning" color="warning" %}}
Verify the jumper positions before connecting the HAT!
{{% /alert %}}

The RS485 HAT has two jumpers for onboard RS-485 bus termination resistors. NMEA 0183 does not use terminators, and the jumpers must be set to the `OFF` position!

## Connecting the HAT

Carefully insert the stack-through header into the RS-485 HAT GPIO connector. Then,
plug the HAT onto the Raspberry Pi's or the Sailor Hat's 40-pin GPIO header. The connector edge should be secured to the board below with the hex standoffs. 

When using the HAT as an NMEA 0183 interface, Channel 1 is used for receiving data (RX) and Channel 2 for transmitting data (TX). The transmitting device TX A and B wires (or TX+ and TX-) should be connected to the HAT Channel 1 A and B terminals, while the receiving device RX A and B wires (or RX+ and RX-) should be connected to the HAT Channel 2 A and B terminals. The figure below shows the wiring for the NMEA 0183 interface.

{{< imgrel "nmea0183_wiring.jpg" "50%" >}}
Wiring for the NMEA 0183 interface. The wiring colors may vary depending on the device.
{{< /imgrel >}}

## Software Configuration

The Sailor Hat installation script can be used to configure and enable the RS-485 interface. The interface will be provided by two serial devices: `/dev/ttySC0` and `/dev/ttySC1`. Of these, `/dev/ttySC0` is used for receiving data and `/dev/ttySC1` for transmitting data. These can be configured in the Signal K data connections or any other NMEA 0183 application of your choice.

If you want do perform a manual installation, see the [Waveshare wiki page](https://www.waveshare.com/wiki/2-CH_RS485_HAT) for details.
