---
title: Compute Module 4
translated_from: 2769961d8eba6a0a776d8bf6566816716c7c9cac
---

# Compute Module 4

Das [Compute Module 4](https://www.raspberrypi.org/products/compute-module-4/) ist ein besonders kompaktes Rechnermodul, das auf eine Trägerplatine gesteckt wird. Bei einer CPU-Leistung, die der des Raspberry Pi 4B entspricht, ist das CM4 eine leistungsfähige, flexible und kostengünstige Lösung für eingebettete Anwendungen. Beim Bau eingebetteter Rechner hat das CM4 mehrere Vorteile gegenüber dem Raspberry Pi 4B:

- Eingebauter eMMC-Flash-Speicher: Die CM4-Platinen haben je nach Modell bis zu 32 GB eMMC-Flash-Speicher. Dieser Speicher ist zuverlässiger und schneller als die im Raspberry Pi 4B verwendete SD-Karte.
- Möglichkeit einer externen WLAN-Antenne: Das CM4 hat einen eigenen Anschluss für eine externe WLAN-Antenne. Das ist nützlich, wenn die Signalstärke der internen WLAN-Antenne nicht ausreicht.
- M.2-Anschluss: Viele Trägerplatinen haben einen M.2-Anschluss, an den sich eine M.2-SSD oder ein M.2-WLAN-Modul anschließen lässt.
- Geringere Leistungsaufnahme: In informellen Tests hat sich gezeigt, dass ein CM4 mit Trägerplatine über 20 % weniger Strom verbraucht als ein Raspberry Pi 4B.

Nachteilig ist, dass die meisten CM4-Trägerplatinen keinen USB-3.0-Hub enthalten, sodass die USB-Anschlüsse auf USB-2.0-Geschwindigkeit beschränkt sind. Außerdem ist das Flashen der eMMC etwas aufwendiger als das Flashen einer SD-Karte. Das Verfahren wird im Folgenden beschrieben.

## Den eMMC-Speicher des CM4 flashen

Zuerst müssen Sie ein passendes Systemabbild herunterladen. Als Beispiel dient hier das [OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/downloading.html)-Headless-Image, das Verfahren ist bei anderen Systemabbildern aber dasselbe. **Hinweis:** Verwenden Sie immer ein 64-Bit-Systemabbild! Einige Softwarekomponenten haben auf einem 32-Bit-System Probleme (insbesondere InfluxDB).

Der eMMC-Speicher lässt sich mit demselben Systemabbild flashen wie der Raspberry Pi 4B. Beim Flashen kommen zwei zusätzliche Schritte hinzu. Erstens muss das CM4 in einen speziellen BOOT-Modus versetzt werden, der das Gerät am Starten *hindert* und das Flashen der eMMC ermöglicht. Zweitens muss auf dem zum Flashen verwendeten Rechner das kleine Hilfsprogramm `rpiboot` installiert und ausgeführt werden, damit sich der eMMC-Speicher auf Ihrem Rechner einhängen lässt. Sind diese Schritte erledigt, verläuft das Flashen genauso wie beim Raspberry Pi 4B.

Für Windows steht `rpiboot` als vorkompilierte ausführbare Datei bereit, für Linux und macOS müssen Sie es dagegen aus dem Quellcode kompilieren. Das Vorgehen für die einzelnen Plattformen wird in den folgenden Abschnitten beschrieben.

Hinweise zum Installationsvorgang:

1. Zum Flashen der eMMC muss die Trägerplatine in den BOOT-Modus versetzt werden. Auf den Waveshare-CM4-IO-BASE-Platinen muss der kleine BOOT-Schalter neben dem HDMI0-Anschluss auf die Stellung ON gebracht werden.
2. Die Trägerplatine muss während des Flashens an eine externe Stromversorgung angeschlossen sein. Verwenden Sie dafür die SH-RPi-Platine!

### Windows

1. Um den Flash-Modus auf dem Host-Rechner einzurichten, folgen Sie der Anleitung in der [Raspberry-Pi-Dokumentation](https://www.raspberrypi.com/documentation/computers/compute-module.html#flashing-the-compute-module-emmc).
2. Folgen Sie der [Installationsanleitung für OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html).
3. **Hinweis:** Starten Sie das System noch nicht! Zunächst müssen einige Einstellungen angepasst werden, wie weiter unten im Abschnitt CM4-Konfiguration beschrieben.
4. Bringen Sie den BOOT-Schalter nach dem Ändern der Konfiguration zurück in die Stellung OFF und starten Sie das System neu. Danach können Sie mit der OpenPlotter-Anleitung fortfahren.

### Mac

Auf einem Mac müssen Sie das Hilfsprogramm `rpiboot` aus dem Quellcode kompilieren.

1. Zum Kompilieren des Programms muss [Homebrew](https://brew.sh/) installiert sein. Erledigen Sie das zuerst.
2. Folgen Sie dann den [Schritten im Repository `usbboot`](https://github.com/raspberrypi/usbboot#macos). Wenn Sie `sudo ./rpiboot` ausführen, sollte die CM4-Trägerplatine mit Ihrem Rechner verbunden und über den SH-RPi mit Strom versorgt sein. Erhalten Sie eine Fehlermeldung, prüfen Sie das USB-Kabel und den BOOT-Schalter auf der Trägerplatine.
3. Folgen Sie der [Installationsanleitung für OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html). **Hinweis:** Starten Sie das System noch nicht! Zunächst müssen einige Einstellungen angepasst werden, wie weiter unten im Abschnitt CM4-Konfiguration beschrieben.
4. Bringen Sie den BOOT-Schalter nach dem Ändern der Konfiguration zurück in die Stellung OFF und starten Sie das System neu. Danach können Sie mit der OpenPlotter-Anleitung fortfahren.

### Linux

Wie auf dem Mac müssen Sie das Hilfsprogramm `rpiboot` auch unter Linux aus dem Quellcode kompilieren.

1. Zum Kompilieren des Programms muss [Homebrew](https://brew.sh/) installiert sein. Erledigen Sie das zuerst.
2. Folgen Sie dann den [Schritten im Repository `usbboot`](https://github.com/raspberrypi/usbboot#linux--cygwin--wsl). Wenn Sie `sudo ./rpiboot` ausführen, sollte die CM4-Trägerplatine mit Ihrem Rechner verbunden und über den SH-RPi mit Strom versorgt sein. Erhalten Sie eine Fehlermeldung, prüfen Sie das USB-Kabel und den BOOT-Schalter auf der Trägerplatine.
3. Folgen Sie der [Installationsanleitung für OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html). **Hinweis:** Starten Sie das System noch nicht! Zunächst müssen einige Einstellungen angepasst werden, wie weiter unten im Abschnitt CM4-Konfiguration beschrieben.
4. Bringen Sie den BOOT-Schalter nach dem Ändern der Konfiguration zurück in die Stellung OFF und starten Sie das System neu. Danach können Sie mit der OpenPlotter-Anleitung fortfahren.

## CM4-Konfiguration

### USB-Anschlüsse aktivieren

Bevor Sie das System zum ersten Mal starten, müssen Sie einige Änderungen an der Konfiguration vornehmen. Standardmäßig sind die USB-Anschlüsse des CM4 deaktiviert. Das kann natürlich ein erhebliches Problem sein, wenn Sie das System mit Tastatur und Maus verwenden möchten. Um die USB-Anschlüsse zu aktivieren, müssen Sie die Datei `config.txt` im eMMC-Speicher bearbeiten. Die Boot-Partition sollte bereits als USB-Laufwerk auf Ihrem Rechner eingehängt sein. Öffnen Sie das Laufwerk und bearbeiten Sie die Datei `config.txt`. Fügen Sie am Ende der Datei die folgende Zeile ein:

    dtoverlay=dwc2,dr_mode=host

Speichern und schließen Sie die Datei.

### Externe WLAN-Antenne aktivieren

Wenn Sie eine externe WLAN-Antenne verwenden, müssen Sie die Datei `config.txt` erneut bearbeiten. Fügen Sie am Ende der Datei die folgende Zeile ein:

    dtparam=ant2

Weitere mögliche Werte sind `ant1` für die Antenne auf der Platine und `noant`, um beide Antennen zu deaktivieren. Der Standardwert ist `ant1`.
