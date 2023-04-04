---
title: Waveshare 2-Channel Isolated CAN HAT
weight: 200
---

The Waveshare 2-Channel Isolated CAN HAT provides two isolated CAN interfaces for the Raspberry Pi. The CAN HAT is based on the MCP2515 CAN controller and SI65HVD230/SN65HVD230 CAN transceivers. The HAT can be used to implement a single compliant NMEA 2000 interface or two other CAN interfaces. When used as an NMEA 2000 interface, the second channel should be unused due to NMEA 2000 isolation requirements.

The HAT has an integrated isolated DC/DC transformer and doesn't require external power input.

This page describes the installation and configuration of the CAN HAT when used together with the Sailor Hat for Raspberry Pi. For further details on the CAN HAT, see the [Waveshare wiki page](https://www.waveshare.com/wiki/2-CH_CAN_HAT).

## Jumper Configuration

{{% alert title="Warning" color="warning" %}}
Verify the jumper positions before connecting the HAT!
{{% /alert %}}

The CAN HAT has two jumpers for onboard CAN bus termination resistors. For normal operation, they must be set to the `OFF` position!

Additionally, the CAN HAT has a voltage selection jumper. It must be set to `3V3` when using with a Raspberry Pi, otherwise damage to the Raspberry Pi may occur.

## Connecting the HAT

Carefully insert the stack-through header into the CAN HAT GPIO connector. Then,
plug the HAT onto the Raspberry Pi's or the Sailor Hat's 40-pin GPIO header. The connector edge should be secured to the board below with the hex standoffs.

When using the HAT with an NMEA 2000 interface, only the CAN0 interface should be used. The CAN1 interface should be left unconnected. The figure below shows the wiring for the NMEA 2000 interface.

{{< imgrel "can_hat_wiring.jpg" "50%" >}}
Wiring for the NMEA 2000 interface. The red wire is left unconnected.
{{< /imgrel >}}

## Software Configuration

The Sailor Hat installation script can be used to configure and enable the CAN interface. If you want do perform a manual installation, see the [Waveshare wiki page](https://www.waveshare.com/wiki/2-CH_CAN_HAT) for details.

## Powering the SH-RPi using the NMEA 2000 Interface

It is possible to power the Raspberry Pi using the NMEA 2000 interface. For this, the NMEA 2000 power and ground wirens should be connected to the SH-RPi power input, while the H and L wires should go to the CAN0 header on the CAN HAT. Additionally, a ground connection should be made between the SH-RPi and the CAN HAT as shown in the figure below.

{{< imgrel "can_hat_n2k_power.jpg" "50%" >}}
Wiring configuration for powering the SH-RPi using the NMEA 2000 interface.
{{< /imgrel >}}

