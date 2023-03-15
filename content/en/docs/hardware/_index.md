---
linkTitle: Hardware
title: Hardware Description
weight: 300
---


## Tour Around the Board

Different functional blocks of the Sailor Hat for Raspberry Pi are described below.

{{< imgrel "SH-RPi-2.0.0-func.jpg" "60%" >}}
Functional blocks of the SH-RPi.
{{< /imgrel >}}

1.  Power input and protection. 
    Power input is provided through a Phoenix MC compatible 3.81 mm (0.15") pitch connector.
    The permitted voltage range is 9-32V.
    The protection circuitry at power input includes:
    - 4 A SMD fuse
    - 33 V transient voltage suppressor (5000W peak pulse power capability)
    - Reverse polarity protection diode
    - A choke and a pi-filter for controlling conducted electromagnetic interference
2.  First stage step-down (buck) converter with current limiting.
    The buck converter transforms the input voltage into a 8.8 V potential that the supercapacitor bank can handle.
    The step-down converter circuit also includes a separate current limiter that throttles the input current to 0.8 A (at the default setting).
3.  Three 20F 3.0 V supercapacitors.
    The supercapacitor bank acts as a power reservoir for the Raspberry Pi.
    It can power a Raspberry Pi 4B for up to 70 seconds (subject to the amount of additional peripherals, of course), and lower-power models for much longer.
    The supercapacitor also makes it possible to power the Raspberry Pi using a low-power interface such as the NMEA 2000 bus that limits the maximum individual node current to 1.0 A.
4.  Microcontroller.
    The SH-RPi operations are controlled by an ATtiny1616 microcontroller.
    The microcontroller performs the following functions:
    - Measures the input voltage
    - Measures the input current
    - Measures the supercapacitor voltage
    - Controls the status LED array
    - Controls the 5V output
    - Receives real-time clock interrupt information
    - Communicates the SH-RPi status to the Raspberry Pi service over I2C
5.  Second stage buck converter.
    The buck converter converts the supercapacitor bank potential into the 5V Raspberry Pi input voltage.
    The buck converter operation is controlled by the microcontroller. The microcontroller enables the boost converter when the supercapacitor voltage has risen above 8.0 V.
    During system shutdown or watchdog reboot, the microcontroller disables the boost converter to cut the Raspberry Pi input voltage.
6.  Status LED array.
    The four status LEDs indicate the board operational status LEDs as described in Section [LEDs](#sec_leds).
7.  Real-time clock.
    The board includes a PCF8563 real-time clock that can keep accurate time even in the absence of internet or GPS connectivity.
    The RTC communicates with the Raspberry Pi over I2C.

## Connectors

<div class="row">
  <div class="col-sm-6">
 
{{< imgrel "SH-RPi-2.0.0-conx.jpg" "100%" >}}
SH-RPi connectors, top side.
{{< /imgrel >}}

   </div>
   <div class="col-sm-6">
    
{{< imgrel "SH-RPi-2.0.0-conx-back.jpg" "100%" >}}
SH-RPi connectors, bottom side.
{{< /imgrel >}}

   </div>   
</div>

1. Power input connector.
   The power connector is a Phoenix MC compatible 3.81 mm (0.15") pitch connector.
   The sales package includes a compatible screw terminal plug.
2. 5V output connector.
   External 5V peripherals can be connected to this connector. The 5V output connector is a Phoenix MC compatible 3.81 mm (0.15") pitch connector as well.
3. Pass-through Raspberry Pi GPIO header.
   This is a standard 2x20 pin Raspberry Pi GPIO header. A provided stackthrough connector should be inserted to connect the SH-RPi to a Raspberry Pi.
   Additional hats can be stacked on top of the Sailor Hat.
4. ATtiny1616 programming and debugging header.
   The header can be used to program the microcontroller with an external programmer or to enable onboard programming.
5. Current limiter header.
   Jumpers can be placed on the current limiter header to change the current limit setting to 1.8 A or 2.8 A (the default is 0.8 A).
6. External interrupt header. Not functional in v2.0.0 hardware.
7. CR1220 battery connector for real-time clock (on the bottom side).
   The real-time clock requires a CR1220 backup battery to keep time when the system is powered off.
   The battery must be oriented positive (flatter) side away from the board.


{{% pageinfo color="warning" %}}
The content below has not yet been updated to reflect v2 hardware changes.
{{% /pageinfo %}}

<div style="-moz-filter: opacity(30%); -webkit-filter: opacity(30%); filter: opacity(30%);">

## Power Supply

The SH-RPi includes an integrated power supply subsystem that provides a clean power supply to the Raspberry Pi from a noisy power source, like a boat's "house" battery system.
The power supply permits input voltages between 8-32 V (although the output will be disabled if the input is less than 10V, to protect the vessel batteries from deep discharging).

The input current is limited to a maximum of 0.8 A at 12 V.
Above that limit, a current limiting circuit starts throttling the buck converter to control the maximum current drawn from the power input.

The power supply output voltage is normally at 5.1 V.
The maximum steady-state output current is about 1.2 A, or about twice the current consumption of a Raspberry Pi 4B. Maximum output currents over 3 A can be sustained over several hundred milliseconds.

## Peripherals

### LEDs
<a name="sec_leds"></a>

{{< imgrel "SH-RPi-1.0.0-leds.jpg" "50%" >}}
SH-RPi indicator LEDs.
{{< /imgrel >}}

SH-RPi includes a number of LEDs to indicate the state of operation.

1. Main LED array
2. CAN power (on whenever input voltage is present at the CAN power pins)
3. CAN receive and transmit (blink whenever data is received or transmitted over the CAN bus)

The main LED array LEDs are as follows:

- Vin: A green LED that indicates the 12/24V input voltage. The LED states are:
   * Vin < 10 V: LED off
   * 10 V < Vin < 11.5 V: LED blinking 50% on/off
   * Vin > 11.5 V: LED solid on
- 5V: Red LED solid on when 5V is enabled by the microcontroller
- Vcap: Green LED that blinks according to the supercapacitor voltage. 100% off is 0 V, 100% on is 2.75 V.
- Status: Different blink patterns indicate the state of the board as follows.

{{< imgrel "blink_patterns.png" "75%" >}}
Blink patterns
{{< /imgrel >}}

Different board statuses are:
- Charging: the supercapacitor is charging but the voltage is too low to turn the 5V output on
- On: 5V output is turned on
- Watchdog enabled: 5V output is on, watchdog is enabled
- Watchdog reboot: The daemon has not communicated in 10 seconds; the Raspberry Pi is reset by turning 5V off for two seconds
- Depleting: Input voltage is not present and the supercapacitor is depleting
- Shutting down: The daemon has requested a shutdown; the watchdog is turned off and the firmware waits until the kernel is shut down (as indicated by SDA being set low)
- Off: 5V is turned off and the board is expected to be powered off.
If the board remains powered, it will restart in 5 seconds.

### I2C

I2C (Inter-Integrated Circuit) is a popular synchronous serial communication bus commonly used for interfacing with a number of different ICs.
It uses two data wires in addition to voltage and ground.

The SH-RPi microcontroller communicates with the Raspberry Pi operating system over I2C. The microcontroller uses I2C address 0x6d.

If the optional DS3231 real-time clock is installed, it additionally reserves the I2C address 0x68. 


</div>