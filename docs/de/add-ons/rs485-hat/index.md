---
title: Waveshare 2-Channel Isolated RS485 HAT
translated_from: 7f4b38c33361ca8118a3f68c596e0fb1633d6f5e
---

# RS485 HAT

Das Waveshare 2-Channel Isolated RS485 HAT stellt dem Raspberry Pi zwei galvanisch getrennte RS-485-Schnittstellen bereit. Damit lässt sich eine bidirektionale NMEA-0183-Schnittstelle oder zwei allgemeine bidirektionale RS-485-Schnittstellen aufbauen. Bei Verwendung als NMEA-0183-Schnittstelle dient ein Kanal dem Empfangen und der andere dem Senden von Daten.

Das HAT hat einen integrierten isolierten DC/DC-Wandler und benötigt keine externe Spannungsversorgung.

Das RS485 HAT lässt sich gleichzeitig mit dem SH-RPi und dem CAN HAT verwenden.

Diese Seite beschreibt die Installation und Konfiguration des RS485 HAT im Zusammenspiel mit dem Sailor Hat for Raspberry Pi. Weitere Einzelheiten zum RS485 HAT finden Sie auf der [Waveshare-Wiki-Seite](https://www.waveshare.com/wiki/2-CH_RS485_HAT).


## Jumper-Konfiguration

!!! warning
    Prüfen Sie die Stellung der Jumper, bevor Sie das HAT anschließen!

Das RS485 HAT hat zwei Jumper für die Abschlusswiderstände des RS-485-Busses auf der Platine. NMEA 0183 verwendet keine Abschlusswiderstände, daher müssen die Jumper auf `OFF` stehen!

## Das HAT anschließen

Setzen Sie die Durchsteck-Stiftleiste vorsichtig in den GPIO-Anschluss des RS-485 HAT ein. Stecken Sie das HAT dann
auf die 40-polige GPIO-Stiftleiste des Raspberry Pi oder des Sailor Hat. Die Kante mit dem Anschluss sollte mit den Sechskant-Abstandsbolzen an der darunterliegenden Platine befestigt werden.

Wird das HAT als NMEA-0183-Schnittstelle verwendet, dient Kanal 1 dem Empfangen von Daten (RX) und Kanal 2 dem Senden (TX). Die Adern TX A und B (oder TX+ und TX-) des sendenden Geräts werden an die Klemmen A und B von Kanal 1 des HAT angeschlossen, die Adern RX A und B (oder RX+ und RX-) des empfangenden Geräts an die Klemmen A und B von Kanal 2. Die Abbildung unten zeigt die Verdrahtung für die NMEA-0183-Schnittstelle.

<figure markdown="span">
![](nmea0183_wiring.jpg){ width="50%" }
<figcaption>Verdrahtung für die NMEA-0183-Schnittstelle. Die Aderfarben können je nach Gerät abweichen.</figcaption>
</figure>

## Software-Konfiguration

Mit dem Installationsskript des Sailor Hat lässt sich die RS-485-Schnittstelle konfigurieren und aktivieren. Die Schnittstelle wird über zwei serielle Geräte bereitgestellt: `/dev/ttySC0` und `/dev/ttySC1`. Davon dient `/dev/ttySC0` dem Empfangen und `/dev/ttySC1` dem Senden von Daten. Beide lassen sich in den Datenverbindungen von Signal K oder in jeder anderen NMEA-0183-Anwendung Ihrer Wahl konfigurieren.

Wenn Sie eine manuelle Installation durchführen möchten, finden Sie Einzelheiten auf der [Waveshare-Wiki-Seite](https://www.waveshare.com/wiki/2-CH_RS485_HAT).
