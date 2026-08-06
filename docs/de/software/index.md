---
title: Software
translated_from: fde8306627421de6b86970b1032ab7a63699a495
---

# Software

## Einführung

Der Sailor Hat for Raspberry Pi benötigt zusätzliche Software auf dem Raspberry Pi Operating System, damit sich der volle Funktionsumfang des Geräts nutzen lässt. Ein Installationsskript installiert alle erforderlichen Programme automatisch in einer frischen Raspberry-Pi-OS-Installation. Die Verwendung des Installationsskripts ist im [Abschnitt Erste Schritte](../getting-started/index.md) beschrieben. Der Anleitung zur manuellen Installation müssen Sie nur folgen, wenn Sie nicht möchten, dass automatische Skripte Ihre Systemkonfiguration verändern, oder wenn Sie einen Fehler in Ihrer Installation suchen müssen.

Für die manuelle Installation laden Sie den Code unter [github.com/hatlabs/SH-RPi-daemon](https://github.com/hatlabs/SH-RPi-daemon) herunter. Die benötigte Software und die Konfigurationsänderungen sowie die Einzelheiten zur Firmware sind unten beschrieben.

### Aktivieren von I2C und SPI

Die Schnittstellen I2C und SPI müssen aktiviert werden. Das geht entweder durch Ausführen von `raspi-config` oder durch direktes Bearbeiten von `/boot/firmware/config.txt`.

Wenn Sie `raspi-config` verwenden, springen Sie an das Ende dieses Unterabschnitts.

```bash
sudo nano /boot/firmware/config.txt
```

Suchen Sie die folgende Zeile:

```ini
#dtparam=i2c_arm=on
```

und bearbeiten Sie sie, indem Sie das Kommentarzeichen am Zeilenanfang entfernen:

```ini
dtparam=i2c_arm=on
```

### Aktivieren der neuen Schnittstellen

Bearbeiten Sie erneut `/boot/firmware/config.txt`:

    sudo nano /boot/firmware/config.txt

Scrollen Sie hinunter zum Abschnitt `[all]`.

Dort müssen Sie drei neue Zeilen hinzufügen. Aktivieren Sie zunächst die RTC (sofern Ihr Gerät eine besitzt):

    dtoverlay=i2c-rtc,pcf8563

Konfigurieren Sie dann den Kernel so, dass er dem Sailor Hat die Spannungsabschaltung signalisiert:

    dtoverlay=gpio-poweroff,gpiopin=2,input,active_low=17

Speichern Sie die Datei wieder mit Ctrl-O und beenden Sie Nano mit Ctrl-X.

## Daemon auf dem Raspberry Pi

Damit das Raspberry Pi OS den Energiezustand kennt, muss ein Daemon (Dienstprogramm im Hintergrund) installiert werden.

Wenn Sie das Repository SH-RPi-daemon geklont haben, können Sie den Daemon mit den folgenden Befehlen installieren:

```bash
sudo apt install -y python3-pip
sudo pip3 install .
```

Als Nächstes müssen Sie die Definitionsdatei des Dienstes installieren und den Dienst aktivieren:

```bash
sudo install -o root shrpid.service /lib/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable shrpid
```

Das war's! Nach einem Neustart startet der Daemon automatisch.

*Hinweis: Das im [Abschnitt Erste Schritte](../getting-started/index.md) beschriebene automatische Installationsskript führt alle oben beschriebenen Schritte der Softwareinstallation automatisch aus.*

### Konfigurationsdatei des Daemons

Sie können die Einstellungen des Daemons anpassen, indem Sie die Konfigurationsdatei `/etc/shrpid.conf` anlegen und bearbeiten.
Die Datei verwendet das YAML-Format.
Die folgenden Optionen stehen zur Verfügung:

```yaml
# I2C bus number. You should never need to change this.
i2c-bus: 1
# I2C address of the SH-RPi. Only change this if you have custom firmware.
i2c-addr: 0x6d
# Maximum allowed blackout duration before shutdown.
blackout-time-limit: 3.0
# Input voltage limit for blackout detection.
blackout-voltage-limit: 9.0
# Socket file for the REST API. You should never need to change this.
socket: /var/run/shrpid.sock
# Group for the socket file. You should never need to change this.
socket-group: adm
# Command used to initiate a shutdown. Replace this with a custom script
# to customize the shutdown behavior.
poweroff: /sbin/poweroff
```

Sie können eine neue Konfigurationsdatei anlegen, indem Sie `nano /etc/shrpid.conf` ausführen und den obigen Inhalt in die Datei einfügen.
Kommentieren Sie alle Zeilen aus, die Sie nicht ändern möchten.
Speichern Sie die Datei mit Ctrl-O und beenden Sie Nano mit Ctrl-X.

## Kommandozeilenschnittstelle

Die Kommandozeilenschnittstelle ist ein Python-Skript, mit dem sich der Sailor Hat for Raspberry Pi von der Kommandozeile des Raspberry Pi aus steuern lässt. Sie wird von dem im [Abschnitt Erste Schritte](../getting-started/index.md) beschriebenen Installationsskript installiert.

Das Skript `shrpi` lässt sich mit der Option `--help` aufrufen, um eine Anleitung zu den verschiedenen Befehlen zu erhalten. Einige wichtige Anwendungsfälle sind unten beschrieben.

```bash
shrpi print
```

Gibt den aktuellen Status und die Konfiguration des Sailor Hat for Raspberry Pi aus.

```bash
shrpi set <option> <value>
```

Setzt verschiedene Konfigurationswerte. Zum Beispiel

```bash
shrpi set led 50
```

setzt die LED-Helligkeit auf 50 %.

```bash
shrpi sleep 3600
```

Fährt den Raspberry Pi herunter und schaltet ihn nach 3600 Sekunden (1 Stunde) wieder ein.

```bash
shrpi sleep 15:00
```

Fährt den Raspberry Pi herunter und schaltet ihn um 15:00 Uhr wieder ein.

```bash
shrpi sleep 15:00:00
```

## REST-API

`shrpid` implementiert eine REST-API, mit der sich der aktuelle Status und die Konfiguration des Sailor Hat for Raspberry Pi abfragen und Konfigurationswerte setzen lassen.
Die API ist über einen Datei-Socket unter `/var/run/shrpid.sock` erreichbar. Unten ist eine Beispielabfrage mit `curl` gezeigt:

    curl --unix-socket /var/run/shrpid.sock http://localhost/state

Weitere Einzelheiten zu den verfügbaren Befehlen finden Sie im [Quellcode von SH-RPi-daemon](https://github.com/hatlabs/SH-RPi-daemon/).

## Firmware

Der Programmcode, der auf dem integrierten Mikrocontroller ATtiny1616 läuft, wird als SH-RPi-Firmware bezeichnet.

Das Repository der Firmware liegt unter [https://github.com/hatlabs/SH-RPi-firmware](https://github.com/hatlabs/SH-RPi-firmware).

Die folgenden Unterabschnitte beschreiben, wie Sie die Firmware aktualisieren, um neue Funktionen zu erhalten, oder wenn Sie selbst daran arbeiten möchten.

### Aktualisieren der Firmware

Die SH-RPi-Firmware lässt sich mit dem Raspberry Pi selbst aktualisieren.
Dafür werden einige Jumper und ein wenig Softwarekonfiguration benötigt.

Das Flashen erfolgt über die UPDI-Schnittstelle des ATtiny mit [`avrdude`](https://github.com/SpenceKonde/AVR-Guidance/blob/master/UPDI/jtag2updi.md).

#### Hardware-Konfiguration

Setzen Sie Jumper auf alle Pins der PROG-Stiftleiste, wie in der Abbildung unten rot dargestellt. Damit werden die Programmierschaltung des Mikrocontrollers und die serielle Debug-Schnittstelle mit dem Raspberry Pi verbunden. Zusätzlich wird der 5-V-Ausgang des Abwärtswandlers fest eingeschaltet, damit sich der Raspberry Pi zu Beginn des Flashvorgangs nicht selbst abschaltet.

<figure markdown="span">
![](SH-RPi-2.0.0-prog-conx.jpg){ width="50%" }
<figcaption>Setzen Sie die roten Jumper, um das Selbst-Flashen zu ermöglichen.</figcaption>
</figure>

Achtung! Für den ordnungsgemäßen Betrieb danach ist es unbedingt erforderlich, dass Sie mindestens den dritten Jumper von der PROG-Stiftleiste abziehen. Andernfalls kann sich der Raspberry Pi nicht selbst abschalten.

#### Konfigurationsänderungen am Raspberry Pi

Im nächsten Schritt werden die seriellen UARTs auf dem Raspberry Pi aktiviert. Sie werden sowohl für die UPDI-Schnittstelle als auch für die serielle Debug-Schnittstelle verwendet.
Auf Pis mit Bluetooth ist der UART normalerweise für die integrierte Bluetooth-Schaltung reserviert. Deaktivieren Sie Bluetooth deshalb.

Fügen Sie die folgenden Zeilen am Ende von `/boot/firmware/config.txt` hinzu:

```ini
dtoverlay=disable-bt
dtoverlay=uart5
```

Die erste Zeile deaktiviert das Bluetooth-Modem. Die zweite aktiviert die Schnittstelle UART5 an den GPIOs 12 und 13 auf den Pins 32 und 33. Das ist die serielle Schnittstelle, die die SH-RPi-Firmware zum Debuggen verwendet.

Außerdem muss der Systemdienst deaktiviert werden, der das Bluetooth-Modem initialisiert:

```bash
sudo systemctl disable hciuart
```

Verhindern Sie schließlich, dass sich die serielle Systemkonsole an die serielle Schnittstelle bindet. Entfernen Sie den Teil `console=serial0,115200` am Anfang von `/boot/cmdline.txt`.

Starten Sie neu, damit die Änderungen wirksam werden.

#### Installation der Flash-Software

Dank des Frameworks [PlatformIO](https://platformio.org/) lassen sich alle notwendigen Werkzeuge automatisch herunterladen und installieren. Zunächst wird nur der Quellcode der Firmware benötigt. Installieren Sie das Versionsverwaltungssystem `git` und klonen Sie das Repository der Firmware:

```bash
sudo apt update
sudo apt -y install git
git clone git@github.com:hatlabs/SH-RPi-firmware.git
```

Nun lässt sich das PlatformIO-Framework installieren:

```bash
sudo pip3 install -U platformio
```

Bearbeiten Sie die Datei `platformio.ini` und ändern Sie `upload_port` auf `/dev/ttyAMA0`:

```ini
[env]
...
upload_port = /dev/ttyAMA0
monitor_port = /dev/ttyAMA1
```

#### Flashen

Nun lässt sich die Firmware bauen und hochladen. Beim ersten Ausführen dieses Befehls werden die benötigten Werkzeuge heruntergeladen und installiert. Das kann eine Weile dauern.

```bash
cd SH-RPi-firmware
pio run -t upload
```

Die weißen Status-LEDs erlöschen während des Flashens. Nach einigen Sekunden leuchten sie wieder, und das Flashen ist abgeschlossen. Ziehen Sie an dieser Stelle die Jumper von der PROG-Stiftleiste ab.

#### Bluetooth wiederherstellen

Wenn Sie Bluetooth weiterhin nutzen möchten, machen Sie die zuvor durchgeführten Schritte wieder rückgängig. Dazu müssen Sie die Änderungen an `/boot/firmware/config.txt` und `/boot/cmdline.txt` zurücknehmen und den Dienst `hciuart` wieder aktivieren:

1. Entfernen Sie die folgenden Zeilen aus `/boot/firmware/config.txt`:

```ini
dtoverlay=disable-bt
dtoverlay=uart5
```

2. Fügen Sie `console=serial0,115200` wieder am Anfang von `/boot/cmdline.txt` ein.

3. Aktivieren Sie den Dienst `hciuart` wieder mit:

```bash
sudo systemctl enable hciuart
```

4. Starten Sie Ihren Raspberry Pi neu, damit die Änderungen wirksam werden.

Das war's! Sie haben die Firmware Ihres Sailor Hat for Raspberry Pi erfolgreich aktualisiert und, falls gewünscht, die Bluetooth-Funktion wiederhergestellt.
