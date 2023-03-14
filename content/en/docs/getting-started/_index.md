---
title: Getting Started
weight: 200
---

## Hardware assembly

SH-RPi is delivered fully assembled. The hardware installation steps are:

1. Insert the 40-pin stackthrough header into the SH-RPi through the socket on the bottom side, pins towards the top.
2. Plug the SH-RPi on the Raspberry Pi GPIO header (optionally using the hex standoffs)
3. Attach suitable power wires to the terminal plugs. The terminal plugs arrive with the screws closed, so pay attention to open them first before inserting the wires.

{{< imgrel "shrpi_v2_hardware_assembly.jpg" "50%" >}}
Hardware assembly diagram for SH-RPi v2.0.0.
{{< /imgrel >}}


### Power Connection

{{% alert title="Warning" color="warning" %}}
Never connect the power input to the 5V output connector! Doing so will permanently damage the Raspberry Pi and the SH-RPi.
{{% /alert %}}

Connect a 10-32 V power source to the SH-RPi power input connector as shown in the following figure.

{{< imgrel "shrpi_power_input.jpg" "50%" >}}
Connect the power source to the connector circled in green color.
{{< /imgrel >}}

The power source must be rated for at least 1.0 A current at the stated output voltage.
If you can choose, pick a power supply with a higher output voltage such as 24 V, as that results in slightly more efficient operation. Otherwise, 12 V power systems on boats and vehicles, or DC power sources work fine.

## Software Installation

Some additional software is required for the Raspberry Pi OS to run the system service that will automatically initiate system shutdown once the power is cut.
An automated installation script is provided to make the installation process easier.

### Automated installation

An automated installation script is provided. The script is tested on newly flashed Raspberry Pi OS and might fail on a heavily modified system.
Installation has not been tested on any other operating systems.

To run the automated installation script, copy-paste the following command onto the Raspberry Pi command prompt:

    curl -L \
        https://raw.githubusercontent.com/hatlabs/SH-RPi-daemon/main/install-online.sh \
        | sudo bash

The command is three lines and when you paste it to your terminal window, it might show up with line continuation characters. That's OK. Press "Enter" to run the command.

{{< imgrel "automated-installation-screenshot.png" "80%" >}}
Installation command in terminal
{{< /imgrel >}}

The command will fetch the installation script and execute it automatically.

The automated installation script will:

- enable the I2C interface, required for the SH-RPi to communicate with the Raspberry Pi
- if support for the NMEA 2000 interface add-on card is selected
  - enable the SPI interface and a device overlay
  - define the CAN network interface
- if support for the NMEA 0183 interface add-on card is selected
  - enable the SPI interface and a device overlay
- enable the device overlay for the real-time clock
- install the SH-RPi service software


{{% alert title="Note" color="info" %}}
The sections below are still heavily under construction and will be updated as the enclosure options become available.
{{% /alert %}}

<div class="-text-500">

## Enclosures

If you are going to use your Raspberry Pi and SH-RPi outside, in a vehicle or on a boat, or wherever in a highly condensing environment, you should always place the device in a waterproof enclosure!
Hat Labs offers several types of [waterproof enclosures](https://shop.hatlabs.fi/collections/accessories-enclosures), some with pre-drilled holes for standard connectors.

### Drilling holes

If you are going to use an enclosure without pre-drilled holes, you need to drill the holes yourself.

At a very minimum, you need one hole for power input, and on any metal enclosure, another for a WiFi antenna or a wired ethernet connector.

Plan the hole/connector placement to fit your intended installation location.
If you are planning to wall-mount the enclosure, place the connectors facing down to minimize the chances for water ingress.

Both aluminum and polycarbonate are relatively soft and can be drilled with a step drill bit (one that looks like a small metal Christmas tree).
When drilling plastic, standard metal drill bits may easily bite too hard and crack the wall.

{{< imgrel "step_drill_bit.jpg" "50%" >}}
An example of step drill bits.
{{< /imgrel >}}

Suitable hole sizes for different connectors:

- SMA (WiFi antenna): 6.5-7 mm or 1/4"
- PG7 cable gland and M12 (NMEA 2000) panel connector: 12.5 mm or 1/2"
- SP13 panel connectors (blue-black plastic connectors): 13 mm.
- PG9 cable gland: 16 mm or 5/8"
- RJ45 panel connector: 21-22 mm
- USB type A panel connector: 21-22 mm

### Mounting the Raspberry Pi

The enclosures provided by Hat Labs include mounting adapters that can be used to mount the Raspberry Pi.

### Soldering the panel connectors

When soldering the internal wires to the panel connectors, always use heat shrink tube on the individual wires.
Always remember to slide the heat shrink on the wires _before_ soldering...
Usually you can first add solder to the connector pin cavity and then re-melt the solder and insert the wire.

### Connecting a fan

Placing a fan inside the enclosure is recommended to improve air circulation and heat transfer through the enclosure surfaces.
A small 40mm fan can be mounted in the enclosure with two-sided tape or hot glue. 

The fan should be connected to the generic 5V output connector on the SH-RPi:

{{< imgrel "shrpi_5v_output.jpg" "50%" >}}
Connect the fan to the connector indicated by the red arrow.
{{< /imgrel >}}

</div>

