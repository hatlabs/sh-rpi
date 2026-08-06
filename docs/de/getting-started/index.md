---
title: Erste Schritte
translated_from: 46b4add9db5ebdedd9ae7e3eba99744cd34a074c
---

# Erste Schritte

## Hardware-Montage

Der SH-RPi wird vollständig montiert geliefert. Die Schritte der Hardwareinstallation sind:

1. Stecken Sie die 40-polige Durchsteck-Stiftleiste von der Unterseite her durch die Buchse in den SH-RPi, die Pins nach oben.
2. Stecken Sie den SH-RPi auf die GPIO-Stiftleiste des Raspberry Pi (wahlweise unter Verwendung der Sechskant-Abstandsbolzen).
3. Bringen Sie passende Stromleitungen an den Klemmensteckern an. Die Klemmenstecker werden mit angezogenen Schrauben geliefert; lösen Sie diese daher, bevor Sie die Leitungen einführen.

<figure markdown="span">
![](shrpi_v2_hardware_assembly.jpg){ width="50%" }
<figcaption>Montageschema der Hardware für den SH-RPi v2.0.0.</figcaption>
</figure>

### Anschluss der Stromversorgung

!!! warning
    Schließen Sie die Spannungsversorgung niemals an den 5-V-Ausgangsanschluss an! Das beschädigt den Raspberry Pi und den SH-RPi dauerhaft.

Schließen Sie eine Spannungsquelle mit 10–32 V an den Eingangsanschluss des SH-RPi an, wie in der folgenden Abbildung gezeigt.

<figure markdown="span">
![](shrpi_power_input.jpg){ width="50%" }
<figcaption>Schließen Sie die Spannungsquelle an den grün umkreisten Anschluss an.</figcaption>
</figure>

Die Spannungsquelle muss bei der angegebenen Ausgangsspannung für mindestens 1,0 A ausgelegt sein.
Bei sonst gleichen Bedingungen arbeitet das Gerät mit einem Netzteil höherer Ausgangsspannung, etwa 24 V, etwas effizienter.
Ansonsten eignen sich 12-V-Bordnetze auf Booten und in Fahrzeugen ebenso wie andere Gleichspannungsquellen gut.

## Softwareinstallation

Das Raspberry Pi OS benötigt zusätzliche Software, um den Systemdienst auszuführen, der bei einem Spannungsausfall automatisch das Herunterfahren einleitet.
Ein automatisches Installationsskript vereinfacht die Installation.

### Automatische Installation

Es steht ein automatisches Installationsskript zur Verfügung. Das Skript ist auf einem frisch geflashten Raspberry Pi OS getestet und kann auf stark veränderten Systemen fehlschlagen.
Auf anderen Betriebssystemen wurde die Installation nicht getestet.

Um das automatische Installationsskript auszuführen, kopieren Sie den folgenden Befehl und fügen Sie ihn in die Eingabeaufforderung des Raspberry Pi ein:

    curl -L \
        https://raw.githubusercontent.com/hatlabs/SH-RPi-daemon/main/install-online.sh \
        | sudo bash

Der Befehl erstreckt sich über drei Zeilen, und beim Einfügen in das Terminalfenster können Zeilenfortsetzungszeichen erscheinen. Das ist in Ordnung. Drücken Sie „Enter“, um den Befehl auszuführen.

<figure markdown="span">
![](automated-installation-screenshot.png){ width="80%" }
<figcaption>Der Installationsbefehl im Terminal</figcaption>
</figure>

Der Befehl lädt das Installationsskript herunter und führt es automatisch aus.

Das automatische Installationsskript:

- aktiviert die I2C-Schnittstelle, die der SH-RPi für die Kommunikation mit dem Raspberry Pi benötigt
- wenn die Unterstützung für die Zusatzplatine mit NMEA-2000-Schnittstelle ausgewählt wurde
  - aktiviert es die SPI-Schnittstelle und ein Device-Tree-Overlay
  - richtet es die CAN-Netzwerkschnittstelle ein
- wenn die Unterstützung für die Zusatzplatine mit NMEA-0183-Schnittstelle ausgewählt wurde
  - aktiviert es die SPI-Schnittstelle und ein Device-Tree-Overlay
- aktiviert das Device-Tree-Overlay für die Echtzeituhr
- wenn die Unterstützung für das MAX-M8Q GNSS HAT ausgewählt wurde
  - aktiviert es die serielle UART-Schnittstelle
  - deaktiviert es die serielle Konsole
  - deaktiviert es Bluetooth, da es mit der seriellen UART-Schnittstelle in Konflikt steht
- installiert die Dienstsoftware des SH-RPi

## Gehäuse

Wenn Sie Ihren Raspberry Pi und den SH-RPi im Freien, in einem Fahrzeug oder auf einem Boot oder in stark kondensierenden Umgebungen einsetzen möchten, bauen Sie das Gerät immer in ein wasserdichtes Gehäuse ein!
Hat Labs
bietet eine Auswahl an [wasserdichten Gehäusen](https://shop.hatlabs.fi/collections/accessories-enclosures) an.

Die mittleren und großen Gehäuse werden mit einer perforierten Grundplatte und mit Montageadaptern geliefert, mit denen sich der Raspberry Pi, weitere HATs und andere Komponenten befestigen lassen.
Die übrigen Gehäuse werden mit 3D-gedruckten Klebehalterungen geliefert.

### Aufbau des mittelgroßen Gehäuses

Das mittelgroße Gehäuse ist so ausgelegt, dass der Raspberry Pi 4 Model B, der SH-RPi und mehrere HATs in vertikaler Ausrichtung hineinpassen. Der Einbau wird im Folgenden beschrieben.

#### Montage

Ausgangspunkt ist ein leeres Gehäuse, wie in der folgenden Abbildung gezeigt.

<figure markdown="span">
![](01_bare_box.jpg){ width="50%" }
<figcaption>Gehäuse ohne jede Komponente.</figcaption>
</figure>

Bauen Sie zuerst alle benötigten Einbaustecker ein. Vor dem Einbau müssen unter Umständen Leitungen an sie angelötet werden. Eine Lötanleitung für Lötkelche finden Sie in diesem YouTube-Video:

<iframe width="560" height="315" src="https://www.youtube.com/embed/_GLeCt_u3U8" frameborder="0" allowfullscreen></iframe>

Für die Pinbelegung der Stromstecker gibt es keinen wirklichen Standard; empfehlenswert ist jedoch, GND stets an Pin 1 und +12 V/24 V an Pin 2 zu legen. Die folgende Abbildung zeigt den eingebauten Stromstecker.

Setzen Sie die Stecker anschließend in das Gehäuse ein. Die folgende Abbildung zeigt die eingebauten Stecker.

<figure markdown="span">
![](02_conx.jpg){ width="50%" }
<figcaption>Eingebaute Stecker.</figcaption>
</figure>

Wenn das Gehäuse in einer kondensierenden Umgebung wie auf einem Boot oder im Freien eingesetzt wird, verschließen Sie die verbleibenden Löcher mit Kabelverschraubungen samt Blindstopfen. Die folgende Abbildung zeigt, wie der Stopfen in die Kabelverschraubung eingesetzt wird.

<figure markdown="span">
![](03_gland_plug.jpg){ width="50%" }
<figcaption>Blindstopfen für die Kabelverschraubung.</figcaption>
</figure>

Und die folgende Abbildung zeigt die eingebauten Kabelverschraubungen. Damit ist das Gehäuse wasserdicht.

<figure markdown="span">
![](04_conx_plugs.jpg){ width="50%" }
<figcaption>Eingebaute Kabelverschraubungen.</figcaption>
</figure>

Nehmen Sie als Nächstes die Teile, die in das Gehäuse eingebaut werden sollen, und legen Sie sie auf die Grundplatte. Die folgende Abbildung zeigt die einzubauenden Teile. Die schwarzen Kunststoffteile sind die Vertikalhalterungen, die den Platinenstapel an seinem Platz halten.

<figure markdown="span">
![](05_ingredients.jpg){ width="50%" }
<figcaption>Die Zutaten.</figcaption>
</figure>

Zuerst werden die 6-mm-Sechskant-Abstandsbolzen in die Vertikalhalterungen geschraubt. Nur handfest anziehen!

Die folgende Abbildung zeigt die Vertikalhalterungen mit montierten Abstandsbolzen.

<figure markdown="span">
![](06_vertical_mounts.jpg){ width="50%" }
<figcaption>Vertikalhalterungen mit Sechskant-Abstandsbolzen.</figcaption>
</figure>

Anschließend können Sie die Halterungen am Raspberry Pi oder an der Trägerplatine befestigen. Verwenden Sie die M2,5-Schrauben, um die Platine neben den GPIO-Pins zu befestigen, und die M2,5-Sechskant-Abstandsbolzen mit 16 mm auf der gegenüberliegenden Seite.

Setzen Sie nun die Durchsteck-Stiftleiste in den SH-RPi ein. Drücken Sie behutsam und gleichmäßig, damit sich die Pins nicht verbiegen. Die optimale Höhe der Stiftleiste hängt von der Reihenfolge der HATs ab. Wenn Sie den SH-RPi direkt auf den Raspberry Pi setzen, entfernen Sie den Abstandshalter von der Durchsteck-Stiftleiste. Wird der SH-RPi dagegen auf ein anderes Schnittstellen-HAT gesetzt, ist der Abstandshalter erforderlich.

<figure markdown="span">
![](07_stack_thru_conx.jpg){ width="50%" }
<figcaption>Einsetzen der Durchsteck-Stiftleiste.</figcaption>
</figure>

Die nächste Abbildung zeigt den auf der Trägerplatine montierten SH-RPi.

<figure markdown="span">
![](08_shrpi_mounted.jpg){ width="50%" }
<figcaption>SH-RPi auf der Trägerplatine montiert.</figcaption>
</figure>

#### Stromverkabelung

In dieser Anleitung wird zusätzlich ein CAN HAT für die NMEA-2000-Anbindung eingebaut. Die folgende Abbildung zeigt das auf dem SH-RPi montierte CAN HAT.

<figure markdown="span">
![](09_can_mounted.jpg){ width="50%" }
<figcaption>CAN HAT auf dem SH-RPi montiert.</figcaption>
</figure>

Als Nächstes wird der Platinenstapel auf der Grundplatte montiert. Befestigen Sie den Stapel mit den mitgelieferten M3-Schrauben. Ziehen Sie die Schrauben nicht zu fest an.

<figure markdown="span">
![](10_on_base_mount.jpg){ width="50%" }
<figcaption>Platinenstapel auf der Grundplatte montiert.</figcaption>
</figure>

Isolieren Sie als Nächstes die Anschlussleitungen ab. Wenn ein separater Stromstecker verwendet wird, sollte die rote NMEA-2000-Leitung unabisoliert bleiben oder ganz abgeschnitten werden. Die folgende Abbildung zeigt die abisolierten Leitungen.

<figure markdown="span">
![](13_stripped_wires.jpg){ width="50%" }
<figcaption>Abisolierte Strom- und CAN-Leitungen.</figcaption>
</figure>

Im nächsten Schritt werden die Leitungen an die Anschlüsse der Platine angeschlossen. Der Stromanschluss wird wie in der folgenden Abbildung gezeigt an den Klemmenstecker angeschlossen.

Achten Sie beim Einstecken des Klemmensteckers _sehr_ genau darauf, dass Sie ihn in den Eingangsanschluss des SH-RPi stecken. Stecken Sie ihn in den 5-V-Ausgangsanschluss, können Sie alle Geräte im Stapel beschädigen!

<figure markdown="span">
![](14_power_conx.jpg){ width="50%" }
<figcaption>Belegung des Klemmensteckers für den Stromanschluss.</figcaption>
</figure>

Anschließend werden die CAN-Leitungen wie unten gezeigt an den Anschluss CAN0 des CAN HAT angeschlossen. Schwarz ist Masse, Weiß ist CAN High (H) und Blau ist CAN Low (L).

<figure markdown="span">
![](15_wires_plugged.jpg){ width="50%" }
<figcaption>Endgültige Verkabelung.</figcaption>
</figure>

#### Versorgung aus dem NMEA-2000-Netzwerk

Beim Einsatz auf einem Boot lässt sich das System auch aus dem NMEA-2000-Netzwerk versorgen. In diesem Fall werden alle Leitungen des NMEA-2000-Steckers genutzt.

<figure markdown="span">
![](18_alt_can_wires.jpg){ width="50%" }
<figcaption>Wird das Gerät aus dem NMEA-2000-Netzwerk versorgt, werden alle Leitungen des NMEA-2000-Steckers genutzt.</figcaption>
</figure>

Die schwarze und die rote Leitung werden an den Klemmenstecker für die Stromversorgung angeschlossen, wobei ein kurzes Stück schwarze Leitung wie in der folgenden Abbildung gezeigt an die GND-Klemme angespleißt wird. Die kurze schwarze Leitung führt zur GND-Klemme des Anschlusses CAN0 am CAN HAT.

<figure markdown="span">
![](19_spliced_gnd.jpg){ width="50%" }
<figcaption>Verbinden Sie die GND-Leitung des NMEA-2000-Steckers sowohl mit dem Klemmenstecker für die Stromversorgung als auch mit dem Anschluss CAN0 des CAN HAT.</figcaption>
</figure>

Die nächste Abbildung zeigt die endgültige Verkabelung bei Versorgung des Geräts aus dem NMEA-2000-Netzwerk.

<figure markdown="span">
![](20_can_power_wiring.jpg){ width="50%" }
<figcaption>Endgültige Verkabelung bei Versorgung des Geräts aus dem NMEA-2000-Netzwerk.</figcaption>
</figure>

#### Sichern des Stapels

Zum Schluss lässt sich das lose Ende des Stapels mit kleinen Kabelbindern an der Grundplatte sichern — eine einfache und bequem zu handhabende Lösung. Die folgenden zwei Abbildungen zeigen die Montage der Kabelbinder.

<figure markdown="span">
![](11_tie_wraps.jpg){ width="50%" }
<figcaption>Kabelbinder eingesetzt.</figcaption>
</figure>

<figure markdown="span">
![](12_tie_wraps_2.jpg){ width="50%" }
<figcaption>Fertig montierte Kabelbinder.</figcaption>
</figure>

#### Abschluss der Montage

An dieser Stelle kann die Grundplatte in das Gehäuse eingesetzt werden.

<figure markdown="span">
![](16_in_place.jpg){ width="50%" }
<figcaption>Grundplatte an ihrem Platz.</figcaption>
</figure>

Befestigen Sie die Grundplatte mit den mitgelieferten Schrauben im Gehäuse.

<figure markdown="span">
![](17_screw_base_mount.jpg){ width="50%" }
<figcaption>Verschrauben der Grundplatte mit dem Gehäuse.</figcaption>
</figure>

Damit ist die Montage abgeschlossen. Die Abbildung unten zeigt den Aufbau, wie er munter im Gehäuse vor sich hin blinkt.

<figure markdown="span">
![](21_all_done.jpg){ width="50%" }
<figcaption>Der fertige Aufbau.</figcaption>
</figure>

Das Gehäuse lässt sich über die in der Abbildung unten gezeigten Ecklöcher an einer Wand oder einem Schott befestigen.

<figure markdown="span">
![](22_mounting.jpg){ width="50%" }
<figcaption>Lage der Befestigungslöcher.</figcaption>
</figure>


### Löcher bohren

Wenn Sie ein Gehäuse ohne vorgebohrte Löcher verwenden, müssen Sie die Löcher selbst bohren.

Mindestens benötigen Sie ein Loch für die Spannungsversorgung und, bei einem Metallgehäuse, ein weiteres für eine WLAN-Antenne oder einen kabelgebundenen Ethernet-Anschluss.

Planen Sie die Platzierung von Löchern und Steckern passend zum vorgesehenen Einbauort.
Wenn Sie eine Wandmontage des Gehäuses planen, richten Sie die Stecker nach unten aus, damit möglichst kein Wasser eindringen kann.

Sowohl Aluminium als auch Polycarbonat sind verhältnismäßig weich und lassen sich mit einem Stufenbohrer bohren (dem Bohrer, der aussieht wie ein kleiner Weihnachtsbaum aus Metall).
Beim Bohren von Kunststoff verhaken sich herkömmliche Metallbohrer leicht zu stark und reißen die Wand ein.

<figure markdown="span">
![](step_drill_bit.jpg){ width="50%" }
<figcaption>Ein Beispiel für Stufenbohrer.</figcaption>
</figure>

Geeignete Lochgrößen für die verschiedenen Stecker:

- SMA (WLAN-Antenne): 6,5–7 mm oder 1/4"
- PG7-Kabelverschraubung und M12-Einbaustecker (NMEA 2000): 12,5 mm oder 1/2"
- SP13-Einbaustecker (blau-schwarze Kunststoffstecker): 13 mm.
- PG9-Kabelverschraubung: 16 mm oder 5/8"
- RJ45-Einbaubuchse: 21–22 mm
- USB-Typ-A-Einbaubuchse: 21–22 mm

### Montage des Raspberry Pi

Die von Hat Labs gelieferten Gehäuse enthalten Montageadapter, mit denen sich der Raspberry Pi befestigen lässt.

### Löten der Einbaustecker

Verwenden Sie beim Anlöten der internen Leitungen an die Einbaustecker immer Schrumpfschlauch auf den einzelnen Leitungen.
Denken Sie stets daran, den Schrumpfschlauch _vor_ dem Löten auf die Leitung zu schieben …
Meist können Sie zuerst Lot in den Lötkelch des Steckerpins geben, das Lot anschließend erneut aufschmelzen und die Leitung einführen.

### Anschluss eines Lüfters

Ein Lüfter im Gehäuse ist empfehlenswert, weil er die Luftzirkulation und die Wärmeabgabe über die Gehäuseflächen verbessert.
Ein kleiner 40-mm-Lüfter lässt sich mit doppelseitigem Klebeband oder Heißkleber im Gehäuse befestigen.

Der Lüfter wird an den allgemeinen 5-V-Ausgangsanschluss des SH-RPi angeschlossen:

<figure markdown="span">
![](shrpi_5v_output.jpg){ width="50%" }
<figcaption>Schließen Sie den Lüfter an den mit dem roten Pfeil markierten Anschluss an.</figcaption>
</figure>

### Abschluss des Einbaus

Wenn Sie die Löcher gebohrt, den Raspberry Pi montiert, die Einbaustecker gelötet und den Lüfter angeschlossen haben, schließen Sie das Gehäuse, um Ihren SH-RPi und den Raspberry Pi vor Witterungseinflüssen zu schützen. Stellen Sie sicher, dass alle Verbindungen fest sitzen und das Gehäuse dicht verschlossen ist, damit kein Wasser eindringt.

### Test des Systems

Schalten Sie nach Abschluss des Einbaus Ihr System aus Raspberry Pi und SH-RPi ein, um sicherzugehen, dass alles korrekt funktioniert. Prüfen Sie, ob der Raspberry Pi startet, der Lüfter läuft und der SH-RPi mit dem Raspberry Pi kommuniziert. Wenn Sie sich davon überzeugt haben, dass alles funktioniert, können Sie mit der Konfiguration Ihrer Software und der Einbindung des Systems in die vorgesehene Umgebung fortfahren.

Herzlichen Glückwunsch! Sie haben die Hardware-Montage und den Gehäuseaufbau für Ihr System aus SH-RPi und Raspberry Pi erfolgreich abgeschlossen.
