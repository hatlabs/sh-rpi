---
title: Getting Started
weight: 200
---

## Hardware assembly

SH-RPi is delivered fully assembled. The hardware installation steps are:

1. Insert the 40-pin stackthrough header into the SH-RPi through the socket on the bottom side, pins facing upwards.
2. Plug the SH-RPi onto the Raspberry Pi GPIO header (optionally using the hex standoffs).
3. Attach appropriate power wires to the terminal plugs. The terminal plugs arrive with the screws tightened, so ensure you loosen them before inserting the wires.

{{< imgrel "shrpi_v2_hardware_assembly.jpg" "50%" >}}
Hardware assembly diagram for SH-RPi v2.0.0.
{{< /imgrel >}}

### Power Connection

{{% alert title="Warning" color="warning" %}}
Never connect the power input to the 5V output connector! Doing so will permanently damage the Raspberry Pi and the SH-RPi.
{{% /alert %}}

Connect a 10-32 V power source to the SH-RPi power input connector as shown in the following figure.

{{< imgrel "shrpi_power_input.jpg" "50%" >}}
Connect the power source to the connector circled in green.
{{< /imgrel >}}

The power source must be rated for at least 1.0 A current at the specified output voltage.
If possible, choose a power supply with a higher output voltage, such as 24 V, for slightly more efficient operation. Otherwise, 12 V power systems on boats and vehicles, or DC power sources, work well.

## Software Installation

Additional software is required for the Raspberry Pi OS to run the system service that will automatically initiate system shutdown when power is cut.
An automated installation script is provided to simplify the installation process.

### Automated installation

An automated installation script is provided. The script is tested on newly flashed Raspberry Pi OS and may fail on heavily modified systems.
Installation has not been tested on other operating systems.

To run the automated installation script, copy and paste the following command onto the Raspberry Pi command prompt:

    curl -L \
        https://raw.githubusercontent.com/hatlabs/SH-RPi-daemon/main/install-online.sh \
        | sudo bash

The command spans three lines, and when you paste it into your terminal window, it may display line continuation characters. That's okay. Press "Enter" to run the command.

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

## Enclosures

If you plan to use your Raspberry Pi and SH-RPi outdoors, in a vehicle or on a boat, or in highly condensing environments, always place the device in a waterproof enclosure!
Hat Labs
offers a variety of [waterproof enclosures](https://shop.hatlabs.fi/collections/accessories-enclosures), some with pre-drilled holes for standard connectors.

**Note:** Images and technical drawings of the different enclosures will be added here once they are available.

### Drilling holes

If you're using an enclosure without pre-drilled holes, you'll need to drill the holes yourself.

At a minimum, you need one hole for power input and, for any metal enclosure, another for a Wi-Fi antenna or a wired Ethernet connector.

Plan the hole/connector placement to fit your intended installation location.
If you're planning to wall-mount the enclosure, place the connectors facing down to minimize the chances for water ingress.

Both aluminum and polycarbonate are relatively soft and can be drilled with a step drill bit (one that looks like a small metal Christmas tree).
When drilling plastic, standard metal drill bits may easily bite too hard and crack the wall.

{{< imgrel "step_drill_bit.jpg" "50%" >}}
An example of step drill bits.
{{< /imgrel >}}

Suitable hole sizes for different connectors:

- SMA (Wi-Fi antenna): 6.5-7 mm or 1/4"
- PG7 cable gland and M12 (NMEA 2000) panel connector: 12.5 mm or 1/2"
- SP13 panel connectors (blue-black plastic connectors): 13 mm.
- PG9 cable gland: 16 mm or 5/8"
- RJ45 panel connector: 21-22 mm
- USB type A panel connector: 21-22 mm

### Mounting the Raspberry Pi

The enclosures provided by Hat Labs include mounting adapters that can be used to mount the Raspberry Pi.

**Note:** Add images of the different mounting adapters once they are finished.

### Soldering the panel connectors

When soldering the internal wires to the panel connectors, always use heat shrink tubing on the individual wires.
Always remember to slide the heat shrink onto the wires _before_ soldering...
Usually, you can first add solder to the connector pin cavity, then re-melt the solder and insert the wire.

### Connecting a fan

Placing a fan inside the enclosure is recommended to improve air circulation and heat transfer through the enclosure
surfaces.
A small 40mm fan can be mounted in the enclosure with double-sided tape or hot glue. 

The fan should be connected to the generic 5V output connector on the SH-RPi:

{{< imgrel "shrpi_5v_output.jpg" "50%" >}}
Connect the fan to the connector indicated by the red arrow.
{{< /imgrel >}}

### Finalizing installation

Once you have completed drilling holes, mounting the Raspberry Pi, soldering the panel connectors, and connecting the fan, close the enclosure to protect your SH-RPi and Raspberry Pi from the elements. Ensure that all connections are secure and the enclosure is tightly sealed to prevent water ingress.

### Testing the system

After completing the installation, power up your Raspberry Pi and SH-RPi system to ensure that everything is functioning correctly. Check that the Raspberry Pi boots up, the fan is operating, and the SH-RPi is communicating with the Raspberry Pi. Once you have verified that everything is working, you can proceed with configuring your software and integrating the system into your intended environment.

Congratulations! You have successfully completed the hardware assembly and enclosure setup for your SH-RPi and
