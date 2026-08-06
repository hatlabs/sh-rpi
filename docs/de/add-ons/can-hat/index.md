---
title: Waveshare 2-Channel Isolated CAN HAT
translated_from: 91112523c75ae01ec3e4cdcdabdcff0fe5fdbd78
---

# CAN HAT

Das Waveshare 2-Channel Isolated CAN HAT stellt dem Raspberry Pi zwei galvanisch getrennte CAN-Schnittstellen bereit. Das CAN HAT basiert auf dem CAN-Controller MCP2515 und den CAN-Transceivern SI65HVD230/SN65HVD230. Mit dem HAT lässt sich eine normkonforme NMEA-2000-Schnittstelle oder zwei andere CAN-Schnittstellen aufbauen. Bei Verwendung als NMEA-2000-Schnittstelle sollte der zweite Kanal wegen der Isolationsanforderungen von NMEA 2000 unbenutzt bleiben.

Das HAT hat einen integrierten isolierten DC/DC-Wandler und benötigt keine externe Spannungsversorgung.

Diese Seite beschreibt die Installation und Konfiguration des CAN HAT im Zusammenspiel mit dem Sailor Hat for Raspberry Pi. Weitere Einzelheiten zum CAN HAT finden Sie auf der [Waveshare-Wiki-Seite](https://www.waveshare.com/wiki/2-CH_CAN_HAT).

## Jumper-Konfiguration

!!! warning
    Prüfen Sie die Stellung der Jumper, bevor Sie das HAT anschließen!

Das CAN HAT hat zwei Jumper für die Abschlusswiderstände des CAN-Busses auf der Platine. Im normalen Betrieb müssen sie auf `OFF` stehen!

Außerdem hat das CAN HAT einen Jumper zur Spannungswahl. Er muss bei Verwendung mit einem Raspberry Pi auf `3V3` stehen, sonst kann der Raspberry Pi beschädigt werden.

## Das HAT anschließen

Setzen Sie die Durchsteck-Stiftleiste vorsichtig in den GPIO-Anschluss des CAN HAT ein. Stecken Sie das HAT dann
auf die 40-polige GPIO-Stiftleiste des Raspberry Pi oder des Sailor Hat. Die Kante mit dem Anschluss sollte mit den Sechskant-Abstandsbolzen an der darunterliegenden Platine befestigt werden.

Wird das HAT als NMEA-2000-Schnittstelle verwendet, darf nur die Schnittstelle CAN0 genutzt werden. Die Schnittstelle CAN1 bleibt unbeschaltet. Die Abbildung unten zeigt die Verdrahtung für die NMEA-2000-Schnittstelle.

<figure markdown="span">
![](can_hat_wiring.jpg){ width="50%" }
<figcaption>Verdrahtung für die NMEA-2000-Schnittstelle. Die rote Ader bleibt unbeschaltet.</figcaption>
</figure>

## Software-Konfiguration

Mit dem Installationsskript des Sailor Hat lässt sich die CAN-Schnittstelle konfigurieren und aktivieren. Wenn Sie eine manuelle Installation durchführen möchten, finden Sie Einzelheiten auf der [Waveshare-Wiki-Seite](https://www.waveshare.com/wiki/2-CH_CAN_HAT).

## Den SH-RPi über die NMEA-2000-Schnittstelle versorgen

Es ist möglich, den Raspberry Pi über die NMEA-2000-Schnittstelle zu versorgen. Dazu werden die Spannungs- und Masseadern von NMEA 2000 an den Spannungseingang des SH-RPi angeschlossen, während die Adern H und L auf die Stiftleiste CAN0 des CAN HAT gehen. Zusätzlich muss zwischen dem SH-RPi und dem CAN HAT eine Masseverbindung hergestellt werden, wie in der Abbildung unten gezeigt.

<figure markdown="span">
![](can_hat_n2k_power.jpg){ width="50%" }
<figcaption>Verdrahtung für die Versorgung des SH-RPi über die NMEA-2000-Schnittstelle.</figcaption>
</figure>
