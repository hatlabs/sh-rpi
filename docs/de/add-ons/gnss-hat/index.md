---
title: Waveshare MAX-M8Q GNSS HAT
translated_from: 94d29c50a654fad026d00f597a18d7b0d3625d85
---

# GNSS HAT

Das Waveshare MAX-M8Q GNSS HAT stellt dem Raspberry Pi einen hochwertigen GNSS-Empfänger auf Basis des U-blox-Moduls MAX-M8Q bereit. Der MAX-M8Q ist ein Mehrsystem-GNSS-Empfänger mit einer hohen Empfindlichkeit von −167 dBm. Er unterstützt GPS, GLONASS, BeiDou und Galileo und kann drei davon gleichzeitig empfangen. Zusätzlich werden mehrere Ergänzungssysteme wie SBAS, QZSS, IMES und D-GPS unterstützt.

Diese Seite beschreibt die Installation und Konfiguration des GNSS HAT im Zusammenspiel mit dem Sailor Hat for Raspberry Pi. Weitere Einzelheiten zum GNSS HAT finden Sie auf der [Waveshare-Wiki-Seite](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT).

## Das HAT anschließen

Setzen Sie die Durchsteck-Stiftleiste in den GPIO-Anschluss des GNSS HAT ein. Stecken Sie das HAT dann auf die 40-polige GPIO-Stiftleiste des Raspberry Pi. Das GNSS HAT lässt sich auf andere HATs stapeln.

### Das GNSS HAT zusammen mit dem RS485 HAT verwenden

Das MAX-M8Q GNSS HAT bietet eine TIMEPULSE-Funktion (PPS), die dem Raspberry Pi eine sehr genaue
GNSS-Zeitreferenz liefert. Leider liegt dieser Zeitimpuls an einem GPIO-Pin, den auch das RS485 HAT nutzt. Werden beide Geräte zusammen verwendet, muss der betroffene GPIO-Pin physisch getrennt werden. Am einfachsten geht das,
indem der entsprechende Pin an der Durchsteck-Stiftleiste abgeschnitten wird. Die Abbildung unten hebt den Pin hervor, der abgeschnitten werden muss.

<figure markdown="span">
![](pps_pin.jpg){ width="50%" }
<figcaption>Der Pin, der abgeschnitten werden muss, wenn das GNSS HAT zusammen mit dem RS485 HAT verwendet wird.</figcaption>
</figure>

Damit sicher der richtige Pin abgeschnitten wird, stecken Sie die Durchsteck-Stiftleiste zunächst nur teilweise in den GPIO-Anschluss des GNSS HAT. Schneiden Sie dann die Spitze des in der Abbildung oben hervorgehobenen Pins ab. Ziehen Sie die Durchsteck-Stiftleiste ab und schneiden Sie den Pin anschließend am Fuß der Leiste ab.

## Software-Konfiguration

Die Softwareinstallation für das GNSS HAT wird künftig durch das Installationsskript des Sailor Hat automatisiert.
Derzeit müssen Sie das GNSS HAT von Hand nach der Anleitung auf der [Wiki-Seite zum Waveshare MAX-M8Q GNSS HAT](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT) konfigurieren. Die Schritte nach der Konfiguration von `gpsd` benötigen Sie nicht.

Je nach Konfiguration stellt das GNSS HAT ein serielles Gerät `/dev/ttyAMA0` oder `/dev/ttyS0` für NMEA-0183-Daten bereit. OpenPlotter hat ein praktisches Werkzeug zur Konfiguration serieller Geräte, mit dem sich das GNSS HAT einrichten und mit Signal K verbinden lässt.

## Pufferakku

Das GNSS HAT hat einen Anschluss für einen Pufferakku. Der Pufferakku dient dazu, die Ephemeridendaten zu speichern, wenn der Raspberry Pi abgeschaltet ist. Der Pufferakku ist nicht zwingend erforderlich, verkürzt aber die Zeit bis zum ersten GNSS-Fix nach dem Einschalten des Raspberry Pi.

Der Pufferakku ist vom Typ ML1220. Es handelt sich um einen wiederaufladbaren Lithium-Akku, der **nicht** durch eine nicht wiederaufladbare Batterie ersetzt werden darf. Andernfalls besteht Explosions- und Brandgefahr! Fortgeschrittene Anwender können auf eigene Gefahr den Widerstand R3 entfernen, um die Ladefunktion zu deaktivieren und eine nicht wiederaufladbare CR1220-Batterie zu verwenden. Schaltpläne und Platinenlayout sind auf der [Waveshare-Wiki-Seite](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT) verfügbar.
