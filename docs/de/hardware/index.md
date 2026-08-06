---
title: Hardwarebeschreibung
translated_from: 257eeaa16d90da32404917c6093ffa709b5400f8
---

# Hardwarebeschreibung

## Rundgang über die Platine

Im Folgenden werden die verschiedenen Funktionsblöcke des Sailor Hat for Raspberry Pi beschrieben.

<figure markdown="span">
![](SH-RPi-2.0.0-func.jpg){ width="60%" }
<figcaption>Funktionsblöcke des SH-RPi.</figcaption>
</figure>

1. Spannungseingang und Schutzbeschaltung.
   Die Spannung wird über einen Phoenix-MC-kompatiblen Steckverbinder mit 3,81 mm (0,15") Rastermaß zugeführt.
   Der zulässige Spannungsbereich beträgt 9–32 V.
   Zur Schutzbeschaltung am Spannungseingang gehören:
   - SMD-Sicherung mit 4 A
   - TVS-Diode (Überspannungsschutz) für 33 V mit 5000 W Spitzenimpulsleistung
   - Verpolungsschutzdiode
   - Eine Drossel und ein Pi-Filter zur Begrenzung leitungsgebundener elektromagnetischer Störungen
2. Abwärtswandler (Buck) der ersten Stufe mit Strombegrenzung.
   Der Abwärtswandler wandelt die Eingangsspannung in ein Potential von 8,8 V um, das die Superkondensatorbank verträgt.
   Die Schaltung des Abwärtswandlers enthält außerdem einen separaten Strombegrenzer, der den Eingangsstrom auf 0,8 A drosselt (in der Standardeinstellung).
3. Drei Superkondensatoren mit 20 F und 3,0 V.
   Die Superkondensatorbank dient dem Raspberry Pi als Energiespeicher.
   Sie kann einen Raspberry Pi 4B bis zu 70 Sekunden lang versorgen (abhängig natürlich von der Menge zusätzlicher Peripheriegeräte) und Modelle mit geringerer Leistungsaufnahme deutlich länger.
   Die Superkondensatoren machen es außerdem möglich, den Raspberry Pi über eine leistungsschwache Schnittstelle wie den NMEA-2000-Bus zu versorgen, der den Strom eines einzelnen Knotens auf maximal 1,0 A begrenzt.
4. Mikrocontroller.
   Der Betrieb des SH-RPi wird von einem ATtiny1616-Mikrocontroller gesteuert.
   Der Mikrocontroller übernimmt die folgenden Funktionen:
   - Misst die Eingangsspannung
   - Misst den Eingangsstrom
   - Misst die Spannung der Superkondensatoren
   - Steuert die Status-LED-Reihe
   - Steuert den 5-V-Ausgang
   - Empfängt die Interrupt-Informationen der Echtzeituhr
   - Übermittelt den Status des SH-RPi über I2C an den Dienst auf dem Raspberry Pi
5. Abwärtswandler der zweiten Stufe.
   Der Abwärtswandler wandelt das Potential der Superkondensatorbank in die 5-V-Eingangsspannung des Raspberry Pi um. Der maximale momentane Ausgangsstrom beträgt 5 A, wobei ohne aktive Kühlung mindestens 3 A als Dauerstrom erreichbar sind.
   Der Mikrocontroller steuert den Betrieb des Abwärtswandlers. Der Mikrocontroller aktiviert den Aufwärtswandler, wenn die Spannung der Superkondensatoren über 8,0 V gestiegen ist.
   Beim Herunterfahren des Systems oder bei einem Watchdog-Neustart deaktiviert der Mikrocontroller den Aufwärtswandler, um die Eingangsspannung des Raspberry Pi abzuschalten.
6. Status-LED-Reihe.
   Die vier Status-LEDs zeigen den Betriebszustand der Platine an, wie im Abschnitt [Status-LEDs](#status-leds) beschrieben.
7. Echtzeituhr.
   Auf der Platine sitzt eine PCF8563-Echtzeituhr (RTC), die auch ohne Internet- oder GPS-Verbindung genau die Zeit hält.
   Die RTC kommuniziert über I2C mit dem Raspberry Pi.

## Anschlüsse

<div class="row">
  <div class="col-sm-6">

<figure markdown="span">
![](SH-RPi-2.0.0-conx.jpg){ width="100%" }
<figcaption>Anschlüsse des SH-RPi, Oberseite.</figcaption>
</figure>

   </div>
   <div class="col-sm-6">

<figure markdown="span">
![](SH-RPi-2.0.0-conx-back.jpg){ width="100%" }
<figcaption>Anschlüsse des SH-RPi, Unterseite.</figcaption>
</figure>

   </div>
</div>

1. Eingangsanschluss für die Spannungsversorgung.

   Der Anschluss ist ein Phoenix-MC-kompatibler Steckverbinder mit 3,81 mm (0,15") Rastermaß.
   Die Verkaufsverpackung enthält einen passenden Klemmenstecker mit Schraubanschluss.
2. 5-V-Ausgangsanschluss.
   An diesen Anschluss lassen sich externe 5-V-Peripheriegeräte anschließen. Auch der 5-V-Ausgangsanschluss ist ein Phoenix-MC-kompatibler Steckverbinder mit 3,81 mm (0,15") Rastermaß.
3. Durchgeschleifte Raspberry-Pi-GPIO-Stiftleiste.
   Dies ist eine standardmäßige 2×20-polige Raspberry-Pi-GPIO-Stiftleiste. Die mitgelieferte Durchsteck-Stiftleiste muss eingesetzt werden, um den SH-RPi mit einem Raspberry Pi zu verbinden.
   Weitere HATs lassen sich auf den Sailor Hat stapeln.
4. Programmier- und Debug-Stiftleiste für den ATtiny1616.
   Über die Stiftleiste lässt sich der Mikrocontroller mit einem externen Programmiergerät programmieren oder die Programmierung auf der Platine freischalten.
5. Strombegrenzer-Stiftleiste.
   Auf der Strombegrenzer-Stiftleiste lassen sich Jumper setzen, um die Stromgrenze auf 1,8 A oder 2,8 A zu ändern (Standard ist 0,8 A).
   Setzen Sie einen Jumper waagerecht auf die obere Reihe (Beschriftung 2A), um die Stromgrenze auf 1,8 A zu setzen. Setzen Sie einen Jumper waagerecht auf die untere Reihe (Beschriftung 3A), um die Stromgrenze auf 2,8 A zu setzen.
6. Stiftleiste für externe Interrupts. In der Hardware v2.0.0 ohne Funktion.
7. CR1220-Batterieanschluss für die Echtzeituhr (auf der Unterseite).
   Die Echtzeituhr benötigt eine CR1220-Pufferbatterie, um die Zeit zu halten, wenn das System abgeschaltet ist.
   Die Batterie muss mit der positiven (flacheren) Seite von der Platine weg eingesetzt werden.
8. Lötbrücke RTC Enable.
   Die Echtzeituhr ist standardmäßig aktiviert.
   Um die RTC zu deaktivieren, trennen Sie die Leiterbahnen zwischen den Pads der Lötbrücke mit einem scharfen Messer auf.
   Achten Sie darauf, keine benachbarten Leiterbahnen zu durchtrennen.
9. GPIO4 Enable. Verbinden Sie die Pads, um GPIO4 des Raspberry Pi mit dem Port PB5 des Mikrocontrollers auf der Platine zu verbinden.
   Damit das nützlich ist, wird eine angepasste Firmware-Funktion benötigt.

## Stromversorgung

Der SH-RPi enthält ein integriertes Stromversorgungssystem, das den Raspberry Pi aus einer gestörten Quelle wie einem ungeregelten Netzteil oder der „Verbraucherbatterie“ eines Bootes sauber versorgt. Die Stromversorgung lässt Eingangsspannungen von 9–32 V zu, wobei eine Spannung unter 10 V als Unterspannung gewertet wird, um typische Bleiakkus vor Schäden durch Tiefentladung zu schützen.

Das Funktionsdiagramm des Stromversorgungssystems ist im Bild unten dargestellt.

Der maximale Eingangsstrom wird begrenzt, um vorgelagerte Stromversorgungen und die Verkabelung zu schützen. Die Stromgrenze beträgt standardmäßig 0,8 A, lässt sich aber durch Setzen von Jumpern auf der Strombegrenzer-Stiftleiste auf 1,8 A oder 2,8 A erhöhen.

Der Abwärtswandler der ersten Stufe setzt die Eingangsspannung herab und lädt die Superkondensatorbank auf eine Spannung von 8,8 V. Die Superkondensatoren dienen dem Raspberry Pi als Energiespeicher, sowohl bei kurzzeitigen Störungen als auch als letzte Reserve während des Herunterfahrens des Systems.

Der Abwärtswandler der zweiten Stufe wandelt die Spannung der Superkondensatoren in die 5-V-Eingangsspannung des Raspberry Pi um. Der Mikrocontroller aktiviert den 5-V-Ausgang, wenn die Spannung der Superkondensatoren über 8,0 V liegt, und deaktiviert ihn, wenn sie unter 5,0 V fällt. Diese Grenzwerte können vom Benutzer konfiguriert werden.

Der maximale Spitzenausgangsstrom zum Raspberry Pi beträgt 5 A. Der maximale mittlere Ausgangsstrom hängt von der Einstellung des Eingangsstrombegrenzers und der Umgebungstemperatur ab. Bei einer Eingangsstromgrenze von 0,8 A beträgt der maximale Dauerausgangsstrom etwa 1,4 A. Bei einer Einstellung von 2,8 A wird der maximale mittlere Ausgangsstrom durch das thermische Verhalten des Systems begrenzt. Im freien Raum bei Zimmertemperatur beträgt der maximale mittlere 5-V-Ausgangsstrom mindestens 3,0 A. Höhere Werte sind mit aktiver Kühlung der SH-RPi-Platine möglich.

Bei 1,4 A Ausgangsstrom beträgt der Gesamtwirkungsgrad der Stromversorgung 79 %.

<figure markdown="span">
![](psu_diagram.svg){ width="70%" }
<figcaption>Funktionsdiagramm der Stromversorgung mit beispielhaften Strom- und Spannungswerten.</figcaption>
</figure>

## Status-LEDs

Die LED-Reihe am linken Rand der SH-RPi-Platine zeigt den Betriebszustand der Platine an.
Die Balkenanzeige gibt den Ladezustand der Superkondensatorbank wieder. Die erste LED beginnt zu leuchten, wenn die Spannung über 5 V liegt; bei 9 V Superkondensatorspannung leuchten alle LEDs voll.

Über die Balkenanzeige gelegt zeigen verschiedene Blinkmuster den Zustand der Platine wie folgt an.

| Muster | Beschreibung |
|--------|--------------|
| Kein Blinken | Laden/Normalbetrieb (1) |
| Kurzes Aussetzen alle 4 s | Watchdog aktiv (2) |
| Lauflicht nach links | Keine Eingangsspannung (3) |
| Zweimaliges Aussetzen mit 1 s Pause | Herunterfahren (4) |
| Zweimaliges Aufleuchten mit 2 s Pause | Schlafmodus (5) |
| Abwechselnd blinkende LEDs | Watchdog-Neustart (6) |
| Schnelles Blinken | Fehler – Hersteller kontaktieren (7) |

Nachfolgend eine ausführliche Beschreibung der Zustände:

1. Die Superkondensatoren werden geladen, und wenn ihre Spannung über 8,0 V liegt, ist der 5-V-Ausgang aktiviert.
   Der Daemon unter Raspberry Pi OS ist nicht aktiv.
2. Der Daemon ist aktiv und der Watchdog ist eingeschaltet. Das Betriebssystem ist gestartet und läuft normal.
3. Die Eingangsspannung ist ausgefallen und die Superkondensatoren entladen sich. Der 5-V-Ausgang ist aktiviert.
4. Der Daemon hat ein Herunterfahren eingeleitet. Der SH-RPi wartet darauf, dass der Raspberry Pi herunterfährt.
5. Der SH-RPi befindet sich im Schlafmodus. Der 5-V-Ausgang ist deaktiviert und die Platine wartet auf einen Alarm der Echtzeituhr, um aufzuwachen.
6. Der SH-RPi hat 10 s lang keinen Heartbeat vom Daemon erhalten, was darauf hindeutet, dass der Pi abgestürzt ist.
   Der Raspberry Pi wird zurückgesetzt, indem die 5 V für zwei Sekunden abgeschaltet werden.
7. Der SH-RPi hat eine Überspannung an den Superkondensatoren erkannt. Wenden Sie sich für weitere Unterstützung an den Hersteller.


## Watchdog-Neustartfunktion

Neben der Stromversorgung enthält der Sailor Hat for Raspberry Pi einen hardwarebasierten Watchdog-Timer, mit dem sich der Raspberry Pi bei einem Software- oder Hardware-Hänger neu starten lässt. Der Watchdog-Timer ist standardmäßig aktiviert und lässt sich bei Bedarf mit dem Befehl `shrpi set watchdog 0` auf der Kommandozeile des Geräts deaktivieren. Ist er aktiviert, startet der Watchdog-Timer den Raspberry Pi neu, sobald er innerhalb eines vorgegebenen Zeitintervalls (typischerweise 10 Sekunden) kein Heartbeat-Signal vom Raspberry Pi empfängt.

Auf dem Raspberry Pi muss ein Dienst laufen, der dem SH-RPi regelmäßig ein Heartbeat-Signal sendet. Der Dienst lässt sich aus dem mitgelieferten Softwarepaket installieren.

Löst der Watchdog-Timer einen Neustart aus, deaktiviert der SH-RPi den 5-V-Ausgang für kurze Zeit, um einen Neustart des Raspberry Pi zu erzwingen. Anschließend aktiviert der SH-RPi den 5-V-Ausgang wieder, damit der Raspberry Pi erneut starten kann.

## Echtzeituhr

Der SH-RPi enthält eine PCF8563-Echtzeituhr (RTC), die auch dann genau die Zeit hält, wenn der Raspberry Pi nicht mit dem Internet verbunden oder kein GPS-Signal verfügbar ist. Die RTC ist über den I2C-Bus mit dem Raspberry Pi verbunden.

Um die RTC zu nutzen, muss auf der Unterseite der Platine eine CR1220-Pufferbatterie eingesetzt werden. Die positive Seite der Batterie (die flachere Seite) muss von der Platine weg zeigen.

Wird die SH-RPi-Platine zusammen mit einem Gerät mit eigener Echtzeituhr verwendet, können die I2C-Adressen der Uhren in Konflikt geraten.
In diesem Fall lässt sich die RTC auf dem SH-RPi deaktivieren, indem die Leiterbahnen zwischen den Pads der Lötbrücke RTC EN aufgetrennt werden.

## Hardware-Konfiguration

Der Sailor Hat for Raspberry Pi lässt sich vom Benutzer an bestimmte Anwendungsfälle anpassen. Zu den Konfigurationsmöglichkeiten gehören:

1. Einstellung des Strombegrenzers.
   Der Eingangsstrombegrenzer lässt sich durch Setzen von Jumpern auf der Strombegrenzer-Stiftleiste auf 0,8 A (Standard), 1,8 A oder 2,8 A einstellen.
2. Aktivierung der Echtzeituhr.
   Die RTC lässt sich über eine Lötbrücke aktivieren oder deaktivieren.
3. Aktivierung von GPIO4.
   Verbinden Sie die Pads, um GPIO4 des Raspberry Pi mit dem Port PB5 des Mikrocontrollers auf der Platine zu verbinden. Damit das nützlich ist, wird eine angepasste Firmware-Funktion benötigt.

## I2C

Der Sailor Hat kommuniziert mit dem Raspberry Pi
über I2C-Bus 1 an den GPIO-Pins 3 und 5 (entsprechend GPIO2 und GPIO3).
Die I2C-Adresse ist 0x6d.

Die PCF8563-Echtzeituhr belegt auf demselben Bus zusätzlich die I2C-Adresse 0x51.
