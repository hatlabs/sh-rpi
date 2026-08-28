---
title: Installation des OpenPlotter-Servers
translated_from: 69cd214b5911c56a3544b6ab748a0ad149ba04e9
---

!!! warning
    Dieser Abschnitt wurde noch nicht an die Änderungen der v2-Hardware angepasst.

<div style="-moz-filter: opacity(30%); -webkit-filter: opacity(30%); filter: opacity(30%);">

## Einführung

In dieser Anleitung bauen wir einen OpenPlotter-Server mit [Sailor Hat for Raspberry Pi](https://docs.hatlabs.fi/sh-rpi/) ([Kauflink](https://hatlabs.fi/product/sh-rpi-enclosure-kit/)) und der OpenPlotter-Software.
Der Server ist kompakt und wasserdicht und wird bequem aus dem 12/24-V-Bordnetz versorgt.
Er lässt sich außerdem leicht in die vorhandene Bordelektronik einbinden.

Die mitgelieferte Software zeichnet den gesamten wesentlichen NMEA-2000-Verkehr an Bord auf und erlaubt es, das Verhalten verschiedener Werte in Echtzeit und im Rückblick darzustellen — über integrierte Instrumententafeln ebenso wie über Grafana-Dashboards.
Darüber hinaus kann der Server Informationen aus anderen Quellen empfangen und verarbeiten, etwa von [SH-ESP32-Sensorgeräten](https://docs.hatlabs.fi/sh-esp32/) oder aus verschiedenen Internetdiensten.

Einige Beispiele für Visualisierungen:

<figure markdown="span">
![](assets/screenshots/001_examples.jpg){ width="75%" }
<figcaption>Beispiele für Visualisierungen.</figcaption>
</figure>

## Benötigte Teile

Für diese Anleitung benötigen Sie die folgenden Teile:

- [SH-RPi-Gehäuseset](https://hatlabs.fi/product/sh-rpi-enclosure-kit/)

  Der SH-RPi ist die geheime Zutat, die dem Raspberry Pi die Hardwareschnittstellen zu den Bordsystemen verschafft. Die Platine enthält eine integrierte, geschützte 12/24-V-Stromversorgung mit sicherer Abschaltung sowie eine galvanisch getrennte, NMEA-2000-kompatible CAN-Schnittstelle.

  In dieser Anleitung verwenden wir das Kunststoffgehäuse und versorgen den Pi über einen NMEA-2000-Frontplattenanschluss. Zusätzlich kommt ein USB-Typ-A-Frontplattenanschluss zum Einsatz, der die Verbindung bei Bedarf erleichtert, und ein Lüfter verbessert die Wärmeabfuhr. Passen Sie Ihre eigene Konfiguration aber gern an.

  Wir verwenden außerdem einen zusätzlichen USB-WLAN-Adapter, weil das die Installation erleichtert (die zusätzliche Netzwerkschnittstelle kann an Bord ebenfalls nützlich sein). Wenn Sie den USB-WLAN-Adapter nicht möchten, können Sie den Pi stattdessen mit kabelgebundenem Ethernet verbinden und erhalten dasselbe Ergebnis.

- Einen Raspberry Pi 4B

  Ein Modell mit 4 GB Arbeitsspeicher genügt. Amazon hat oft unschlagbare Preise, oder Sie sehen sich die Händlerliste auf der Raspberry-Pi-Website an:

    * [amazon.com](https://www.amazon.com/Raspberry-Model-2019-Quad-Bluetooth/dp/B07TC2BK1X/)
    * [amazon.de](https://www.amazon.de/-/en/Raspberry-ARM-Cortex-A72-WLAN-ac-Bluetooth-Micro-HDMI-Single/dp/B07TC2BK1X/)
    * [amazon.co.uk](https://www.amazon.co.uk/Raspberry-Pi-ARM-Cortex-A72-Bluetooth-Micro-HDMI/dp/B07TC2BK1X/)
    * [Händlerliste von Raspberry Pi](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/?variant=raspberry-pi-4-model-b-4gb)

- MicroSD-Speicherkarte

  Auf der MicroSD-Karte liegen das Betriebssystem und die Datendateien des Raspberry Pi. Mit Samsung-Evo-Plus-Karten habe ich gute Erfahrungen gemacht. Speicherkarten sind günstig, und größere Karten sind im Raspberry-Pi-Einsatz zuverlässiger — nehmen Sie also mindestens eine mit 64 GB:

  * [amazon.com](https://www.amazon.com/Samsung-MicroSDXC-Memory-Adapter-MB-MC64GA/dp/B06XFWPXYD/)
  * [amazon.de](https://www.amazon.de/-/en/Samsung-Flash-Memory-MicroSDXC-Class/dp/B08BKCB4JW/)
  * [amazon.co.uk](https://www.amazon.co.uk/Samsung-MicroSDXC-Class-UHS-I-Memory/dp/B08BKCB4JW/)

- Doppelseitiges Klebeband oder Heißkleber

  Ein kurzes Stück doppelseitiges Klebeband oder ein Klecks Heißkleber wird benötigt, um den Lüfter zu befestigen.

- Schrumpfschlauch, 3 mm Innendurchmesser

  Zwingend nötig ist er nicht, aber Schrumpfschlauch mit 3 mm Innendurchmesser eignet sich gut, um die angelöteten Leitungen des Frontplattenanschlusses zu sichern.

- [NMEA-2000-Buchse](https://hatlabs.fi/product/nmea-2000-cable-plug/)

  Wenn Sie die Erstinstallation zu Hause vornehmen, ist ein zusätzlicher NMEA-2000-Micro-Stecker praktisch, um das Gerät mit Eingangsspannung zu versorgen.

## Aufbau der Hardware

### Bohren der Löcher für die Anschlüsse

Wie immer, wenn Löcher in ein tadelloses Gehäuse gebohrt werden: planen Sie sehr sorgfältig vor. Die Frontplattenanschlüsse brauchen überraschend viel Platz, und ein Loch lässt sich nicht einfach verschließen, geschweige denn versetzen.

Ich messe das Gehäuse am liebsten aus und erstelle eine Bohrschablone in einem Vektorzeichenprogramm. Eine Zeichnung hilft dabei, die maximalen Abmessungen zu erkennen, die Anschluss und Mutter benötigen.

Wenn Sie nicht wissen, welches Programm Sie nehmen sollen: [Inkscape](https://inkscape.org) ist ein gutes Allroundwerkzeug. Wenn Sie technischer veranlagt sind, kann auch CAD-Software wie [LibreCAD](https://librecad.org) funktionieren.

Ich wollte drei Löcher an der Schmalseite des Kunststoffgehäuses. Das ist die Schablone, die ich dafür gezeichnet habe:

<figure markdown="span">
![](assets/plastic-enclosure-end-template.svg){ width="50%" }
<figcaption><a href="assets/plastic-enclosure-end-template.svg">Beispiel für eine Bohrschablone.</a></figcaption>
</figure>

Die [Schablone](assets/plastic-enclosure-end-template.svg) ist eine SVG-Datei, also eine Vektordatei, die Sie speichern und nach Belieben ändern können.
Wenn Sie nicht wissen, welche Software Sie verwenden sollen, probieren Sie zum Beispiel das oben erwähnte [Inkscape](https://inkscape.org). Ich selbst nutze Affinity Designer, eine günstige kommerzielle Designsoftware für MacOS.

Falls sich die SVG-Datei nicht öffnen lässt, gibt es die Schablone auch als [PDF-Version](assets/plastic-enclosure-end-template.pdf).

Wenn die Schablone fertig ist, markieren Sie den Mittelpunkt auf dem Gehäuse und kleben die Schablone so auf, dass die Mittelpunkte übereinstimmen.

<figure markdown="span">
![](assets/photos/01_drill-template.jpg){ width="50%" }
<figcaption>Bohrschablone auf dem Gehäuse.</figcaption>
</figure>


Für genaues Bohren hilft es, die Lochmitten mit einem Körner zu markieren (ein spitzer Nagel und ein leichter Hammerschlag tun es auch).

Bohren Sie mit einem kleinen Bohrer (etwa 3 mm) vor. Bohren Sie die endgültigen Löcher dann mit einem Stufenbohrer. Lassen Sie sich Zeit und arbeiten Sie mit niedriger Drehzahl. Kleinere Löcher mit ungewöhnlichen Maßen wie das mit 6,5 mm sollten Sie mit einem Metallbohrer der entsprechenden Größe fertigstellen.

Beim Bohren in Kunststoff entsteht rund um die Löcher viel Grat. Er lässt sich mit einem scharfen Messer entfernen.

Zuletzt können die im Kunststoffgehäuse angeformten Abstandsbolzen die gebohrten Löcher verdecken. Ich musste einen davon entfernen. Ich habe ein Dremel-Werkzeug benutzt, eine kräftige Zange dürfte aber ebenfalls gehen.

So sieht das Ergebnis in meinem Fall aus.

<figure markdown="span">
![](assets/photos/02_drilled_holes.jpg){ width="50%" }
<figcaption>Gebohrte Löcher.</figcaption>
</figure>


### Anschließen der Leitungen an den NMEA-2000-Frontplattenanschluss

Als Nächstes löten wir die JST-XH-Kabelsätze an den NMEA-2000-Frontplattenanschluss. Dasselbe Vorgehen funktioniert auch für das Anlöten der SP13-Stromanschlüsse, falls Sie sich stattdessen für einen davon entscheiden.
Wir beginnen damit, die Lötkelche des Anschlusses mit Lot zu füllen.

<figure markdown="span">
![](assets/photos/021_soldered_cups.jpg){ width="50%" }
<figcaption>Verzinnte Lötkelche.</figcaption>
</figure>


Wir wollen sowohl die Platine selbst als auch die CAN-Schnittstelle über den NMEA-2000-Anschluss versorgen. Dafür gibt es mehr als einen Weg, aber nehmen wir den naheliegenden und verbinden beide Kabelsätze mit dem NMEA-Frontplattenanschluss.

Isolieren Sie ein kurzes Stück der roten und der schwarzen Leitung ab und verdrillen Sie sie miteinander.

<figure markdown="span">
![](assets/photos/022_spliced_wires.jpg){ width="50%" }
<figcaption>Verdrillte Leitungen.</figcaption>
</figure>


Es empfiehlt sich, Schrumpfschlauch zu verwenden, um die Anschlusspins zu isolieren und den Lötstellen mechanischen Halt zu geben. Schneiden Sie kurze Stücke Schrumpfschlauch ab und schieben Sie sie auf die Leitungen. (Raten Sie, wer das beim Fotografieren für diese Anleitung _schon wieder_ vergessen hat.)

Löten Sie die Leitungen an den Anschluss — sowohl die einzelnen Signalleitungen als auch die verdrillten Versorgungsleitungen.

Das folgende Diagramm zeigt die richtige Pinbelegung. Ja, es ist ein Stecker, aber weil wir von der falschen Seite auf ihn schauen, verwenden wir das Diagramm des jeweils anderen Geschlechts. (Ja, das ist etwas verwirrend.)

<figure markdown="span">
![](assets/nmea_2000_female_pinout.png){ width="50%" }
<figcaption>Pinbelegung der NMEA-2000-Micro-C-Buchse.</figcaption>
</figure>


Löten Sie zuerst den mittleren Pin. Das ist jetzt einfacher, solange die anderen Leitungen noch nicht im Weg hängen. Die Standardfarbe der CAN_L-Leitung ist Blau, in unserem Kabelsatz ist sie jedoch Gelb.

<figure markdown="span">
![](assets/photos/023_soldered_L.jpg){ width="50%" }
<figcaption>Mittlerer Pin gelötet.</figcaption>
</figure>


Löten Sie anschließend die drei übrigen Leitungen an. Der Schirm bleibt unbeschaltet.

So sollte Ihr Anschluss an dieser Stelle aussehen:

<figure markdown="span">
![](assets/photos/024_all_soldered.jpg){ width="50%" }
<figcaption>Alles gelötet.</figcaption>
</figure>


Ich gehe kühn davon aus, dass Sie daran gedacht haben, die Schrumpfschlauchstücke vor dem Löten aufzuschieben. Jetzt ist es Zeit, sie über die Lötstellen zu schieben und mit einer Heißluftpistole (oder der Flamme eines Feuerzeugs) zu schrumpfen. Das Ergebnis sollte ungefähr so aussehen:

<figure markdown="span">
![](assets/photos/025_heat_shrink.jpg){ width="50%" }
<figcaption>Schrumpfschlauch aufgeschrumpft.</figcaption>
</figure>


Schrauben Sie den fertigen NMEA-2000-Frontplattenanschluss in das Gehäuse.

Noch ein Foto eines fertigen Anschlusses und der Pinbelegung:

<figure markdown="span">
![](assets/photos/n2k_connector_wiring_photo.jpg){ width="50%" }
<figcaption>Fertiger Anschluss.</figcaption>
</figure>


### Anschließen der übrigen Frontplattenanschlüsse

Nachdem der schwierige Teil erledigt ist, können die anderen Anschlüsse eingeschraubt werden. Um die WLAN-Antennenbuchse dichter zu bekommen, können Sie vor der Montage einen kleinen O-Ring oder eine Dichtung um den Anschluss legen.

Am Ende sollten Sie das hier haben:

<figure markdown="span">
![](assets/photos/03_connectors_in_place.jpg){ width="50%" }
<figcaption>Anschlüsse eingebaut.</figcaption>
</figure>


### Montage des SH-RPi

Jetzt soll der Raspberry Pi im Gehäuse befestigt werden.
Wir verwenden das Kunststoffgehäuse und die Montageadapter, die dem Gehäuse beigelegen haben sollten.

Zuerst befestigen wir die kurzen Abstandsbolzen mit den M2.5-Muttern an den Montageadaptern. Ziehen Sie sie gut fest.

<figure markdown="span">
![](assets/photos/04_adapters_with_standoffs.jpg){ width="50%" }
<figcaption>Adapter mit Abstandsbolzen.</figcaption>
</figure>


Sobald die Abstandsbolzen sitzen, können die Adapter selbst mit den selbstschneidenden Schrauben im Gehäuse befestigt werden.

<figure markdown="span">
![](assets/photos/05_adapters_in_place.jpg){ width="50%" }
<figcaption>Adapter montiert.</figcaption>
</figure>


Der Raspberry Pi kommt auf die Abstandsbolzen. Befestigen Sie die oberen Abstandsbolzen mit den M2.5-Schrauben und die unteren mit zwei 16 mm langen Sechskant-Abstandsbolzen.

<figure markdown="span">
![](assets/photos/06_rpi_mounted.jpg){ width="50%" }
<figcaption>Raspberry Pi montiert.</figcaption>
</figure>


Als Nächstes folgt der Sailor Hat. Drücken Sie ihn auf die GPIO-Stiftleiste des Raspberry Pi. Sichern Sie ihn mit zwei M2.5-Schrauben.

**HINWEIS**: Wenn Sie den HAT einmal abnehmen müssen, ist man versucht, ihn seitlich hin und her zu wackeln. Das funktioniert zwar gut, birgt aber ein kleines Risiko, die Pins der Pi-Stiftleiste an den beiden Enden zu verbiegen. Wackeln Sie den HAT stattdessen auf und ab, während Sie ihn vorsichtig nach oben ziehen. Das dauert etwas länger, aber der HAT löst sich mit deutlich geringerem Risiko verbogener Pins.

An dieser Stelle können Sie auch alle USB-Geräte anschließen und die Strom- und CAN-Kabel des SH-RPi verbinden. Wenn Sie einen Lüfter verwenden, montieren Sie ihn ebenfalls. Befestigen Sie ihn mit doppelseitigem Klebeband oder etwas Heißkleber neben dem Raspberry Pi, mit der Aufkleberseite zum Pi hin.

So sieht der fertige Aufbau aus:

<figure markdown="span">
![](assets/photos/07_sh-rpi_mounted.jpg){ width="50%" }
<figcaption>Sailor Hat montiert.</figcaption>
</figure>


Schließen Sie den Deckel noch nicht. Sie müssen noch die Speicherkarte in den Pi einsetzen.

## Software

In diesem Abschnitt installieren wir die OpenPlotter-Software auf dem Raspberry Pi. OpenPlotter ist eine spezialisierte Software-Distribution für den maritimen Einsatz auf Basis von Raspberry Pi OS. Es gibt sie in mehreren Varianten; in dieser Anleitung wird eine Version ohne Bildschirm (headless) verwendet, das heißt, an den Raspberry Pi ist kein Bildschirm direkt angeschlossen. Zur Anzeige dienen stattdessen Browser oder Remote-Desktop-Verbindungen, wodurch sich Server und Bildschirme sicherer und bedarfsgerechter platzieren lassen.

### Installation von OpenPlotter

OpenPlotter wird installiert, indem ein Systemabbild auf eine MicroSD-Karte geschrieben und diese Karte in den Raspberry Pi gesteckt wird.

Laden Sie zuerst den [Raspberry Pi Imager](https://www.raspberrypi.org/software/) herunter. Der Imager ist ein einfach zu bedienendes Programm, mit dem die heruntergeladene Abbilddatei auf die Speicherkarte geschrieben wird.

**HINWEIS:** Der Imager steht nur für macOS, Windows und Ubuntu Linux zum Download bereit. Wenn Sie ein anderes Betriebssystem oder eine andere Linux-Distribution verwenden, brauchen Sie eventuell andere Software, um die Karte zu flashen (dann gehe ich allerdings davon aus, dass Ihnen das Verfahren geläufig ist).

Installieren Sie den Imager nach dem Herunterladen.

Laden Sie als Nächstes das [OpenPlotter-Abbild](https://openplotter.readthedocs.io/en/latest/getting_started/downloading.html) herunter. Ich verwende in dieser Anleitung das Headless-Abbild. Wenn Sie lieber einen Bildschirm an den Pi anschließen möchten, können Sie auch das Starting-Abbild nehmen. Nach dem Herunterladen muss das Abbild zum Flashen unter Umständen entpackt werden. Das Systemabbild ist recht groß, Sie sollten also einige Gigabyte freien Speicherplatz auf dem Laufwerk haben.

Flashen Sie das Abbild auf die MicroSD-Karte. Stecken Sie die Karte zuerst in ein Lesegerät am Computer. Viele Notebooks haben auch integrierte SD-Kartenleser. Für diese verwenden Sie den SD-Adapter, der der Karte beilag. Öffnen Sie dann den Imager. Wählen Sie im Betriebssystemmenü ganz unten in der Liste „Use custom“ und anschließend die heruntergeladene Abbilddatei.

[![](assets/screenshots/01_imager.jpg){ width="50%" }](assets/screenshots/01_imager.jpg)

Wählen Sie dann mit der Schaltfläche Storage die richtige MicroSD-Karte. Um teure Fehler zu vermeiden, empfehle ich, alle anderen Wechselmedien vom Computer zu trennen. Klicken Sie auf Write. Eventuell müssen Sie an dieser Stelle Ihr Passwort eingeben, damit der Imager auf die MicroSD-Karte schreiben darf.

[![](assets/screenshots/02_imager_in_progress.jpg){ width="50%" }](assets/screenshots/02_imager_in_progress.jpg)

Das Schreiben und Prüfen der MicroSD-Karte dauert eine Weile. Diese Zeit können wir nutzen, um [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/) herunterzuladen und zu installieren. VNC Viewer ist eine Remote-Desktop-Software, mit der wir in den folgenden Abschnitten auf OpenPlotter zugreifen.

Wenn die MicroSD-Karte fertig ist, stecken Sie sie in den MicroSD-Kartenschacht des Raspberry Pi. Dafür müssen Sie den HAT möglicherweise kurz abnehmen. (Ja, entschuldigen Sie, die Anleitung ist nicht zu 100 % konsistent.)

Schalten Sie das Gerät zum Schluss ein. Zwar lässt sich ein 5-V-USB-C-Kabel am Raspberry Pi anschließen, doch das führt zu Problemen, sobald Sie später in dieser Anleitung den SH-RPi-Daemon installieren. Verwenden Sie also ein 12-V-Netzteil (tatsächlich geht alles zwischen 10–32 V) und verdrahten Sie es an einen NMEA-2000-Stecker. Sie können auch kurze Buchsen-Jumperkabel direkt in die JST-XH-Anschlüsse stecken und die Leitungen mit kleinen Krokodilklemmen an ein Netzteil klemmen. Nutzen Sie Ihre Fantasie!

### Erstkonfiguration von OpenPlotter

An diesem Punkt haben Sie ein Gerät mit vielen blinkenden Lämpchen, aber keine Möglichkeit, mit ihm zu kommunizieren. Zum Glück gibt es einen Weg. Wenn Sie sich die verfügbaren WLAN-Netzwerke in Ihrer Umgebung ansehen, sollte ein Netzwerk namens „openplotter“ auftauchen:

[![](assets/screenshots/03_select_wifi.jpg){ width="50%" }](assets/screenshots/03_select_wifi.jpg)

Verbinden Sie sich mit diesem Netzwerk (das Passwort lautet `12345678`).

Jetzt sind Sie in Reichweite des Pi. Für den Zugriff verwenden wir den zuvor installierten VNC Viewer.

[![](assets/screenshots/04_vnc_viewer.jpg){ width="50%" }](assets/screenshots/04_vnc_viewer.jpg)

Geben Sie im Startbildschirm `openplotter.local` in die Adresszeile ein (funktioniert das nicht, versuchen Sie die IP-Adresse `10.10.10.1`). Wurde der Server gefunden, begrüßt Sie ein Bildschirm für die Zugangsdaten:

[![](assets/screenshots/05_vnc_credentials.jpg){ width="50%" }](assets/screenshots/05_vnc_credentials.jpg)

Geben Sie den Benutzernamen `pi` und das Passwort `raspberry` ein.

Wenn alles geklappt hat, begrüßt Sie ein unberührter OpenPlotter-Desktop:

[![](assets/screenshots/06_vnc_connected.jpg){ width="50%" }](assets/screenshots/06_vnc_connected.jpg)

Sehr gut! Gehen Sie den Willkommensassistenten des Pi durch. Sie müssen zuerst ein neues Passwort eingeben und Land, Sprache und weitere Grundeinstellungen wählen.

Wenn Sie einen kompatiblen USB-WLAN-Stick angeschlossen haben, müssen Sie ein WLAN-Netzwerk zum Verbinden auswählen. Das ist sehr praktisch, denn damit kommen Sie ins Internet und können Aktualisierungen und anderes herunterladen.

[![](assets/screenshots/07_pick_raspi_wifi.jpg){ width="50%" }](assets/screenshots/07_pick_raspi_wifi.jpg)

Beachten Sie: Ohne angeschlossenen WLAN-Adapter kann die Ersteinrichtung etwas von der folgenden Beschreibung abweichen.

Während der Ersteinrichtung aktualisiert der Pi die Systemsoftware. Das dauert eine Weile — holen Sie sich einen Kaffee oder spielen Sie mit Partner, Kindern oder Haustieren.

[![](assets/screenshots/08_update.jpg){ width="50%" }](assets/screenshots/08_update.jpg)

Wenn die Einrichtung abgeschlossen ist, starten Sie den Pi neu. Sie waren mit dem WLAN-Access-Point des Pi verbunden, daher wechselt die Netzwerkverbindung Ihres Computers jetzt zurück auf Ihr normales WLAN. Wenn Sie den USB-WLAN-Adapter haben und den Pi auf dasselbe Netzwerk eingestellt haben, erreichen Sie ihn weiterhin unter derselben Adresse `openplotter.local`. Verstehen Sie jetzt, warum ich den zusätzlichen WLAN-Adapter empfohlen habe? Andernfalls müssen Sie sich erneut mit dem Netzwerk „openplotter“ verbinden, sobald es wieder auftaucht.

[![](assets/screenshots/09_basic_setup_complete.jpg){ width="50%" }](assets/screenshots/09_basic_setup_complete.jpg)

Wie dem auch sei. Gehen Sie zurück zum VNC Viewer und verbinden Sie sich mit `openplotter.local`. Sie haben das Passwort des Benutzers `pi` bei der Erstkonfiguration geändert, geben Sie also das neue Passwort im VNC Viewer ein.

Sobald Sie wieder drin sind, ändern wir die Netzwerkeinstellungen der OpenPlotter-Installation. Wählen Sie im Raspberry-Menü OpenPlotter -> Network.

(Beim Öffnen der Network-App beschwert sie sich unter Umständen, dass sie Ihr System neu konfigurieren möchte. Lassen Sie sie gewähren und öffnen Sie die App danach erneut.)

[![](assets/screenshots/11_open_openplotter_network.jpg){ width="50%" }](assets/screenshots/11_open_openplotter_network.jpg)

Im Netzwerkfenster sehen Sie links die verfügbaren Netzwerkgeräte und rechts die Einstellungen des Access Points.

Wenn Sie keinen Access Point möchten, wählen Sie links im Menü „none“. Wenn Sie ihn behalten möchten (und das empfehle ich, weil er Ihnen einen zweiten Weg zum Pi offenhält), ist es wichtig, das Netzwerkpasswort zu ändern:

[![](assets/screenshots/14_openplotter_network_password.jpg){ width="50%" }](assets/screenshots/14_openplotter_network_password.jpg)

Die WLAN-Client-Einstellungen finden Sie über das WLAN-Symbol oben rechts auf dem OpenPlotter-Desktop. Dort konfigurieren Sie weitere Netzwerke, etwa den WLAN-Access-Point Ihres Bootes.

[![](assets/screenshots/16_wifi_client_settings.jpg){ width="50%" }](assets/screenshots/16_wifi_client_settings.jpg)

Starten Sie OpenPlotter neu, nachdem Sie die Netzwerkeinstellungen geändert haben.

### Installation des SH-RPi-Daemons

Nachdem das Dringendste erledigt ist, wird es Zeit, den SH-RPi-Daemon zu installieren. ([Daemonen](https://en.wikipedia.org/wiki/Daemon_(computing)#Etymology) sind wohlwollende Geister, die den Charakter oder die Persönlichkeit eines Menschen mitprägen. Oder in diesem Fall Hintergrunddienste für UNIX-verwandte Betriebssysteme.) Wir könnten dafür den VNC Viewer nutzen und im Raspberry-Menü Accessories -> Terminal öffnen — das empfehle ich Windows-Nutzern —, aber Mac- und Linux-Nutzern zeige ich, wie man das OpenPlotter-Gerät per SSH erreicht.

Zunächst ein kleiner Umweg. Statt einfach draufloszuloggen kopieren wir zuerst mit `ssh-copy-id` unseren öffentlichen SSH-Schlüssel auf das Gerät. Dann sind spätere Anmeldungen ohne Passwort möglich.

Mac-Nutzer müssen `ssh-copy-id` eventuell erst installieren. Es ist über [Homebrew](https://brew.sh/) verfügbar — falls Sie es noch nicht installiert haben, tun Sie es! Es ist großartig! Danach führen Sie aus:

    brew install ssh-copy-id

Linux-Nutzer sind dagegen verwöhnt und haben `ssh-copy-id` bereits vorinstalliert.

Kopieren Sie als Nächstes den öffentlichen Schlüssel:

    ssh-copy-id pi@openplotter.local

Das war's! Jetzt können Sie sich ohne Passwort am Pi anmelden. Ich empfehle diese Methode für alle Systeme, auf die Sie aus der Ferne zugreifen — sie ist sicherer als Passwörter.

[![](assets/screenshots/18_ssh.jpg){ width="50%" }](assets/screenshots/18_ssh.jpg)

Sobald Sie sich mit `ssh pi@openplotter.local` angemeldet haben, kopieren Sie den Installationsbefehl in die Eingabeaufforderung:

    curl -L \
    https://raw.githubusercontent.com/hatlabs/SH-RPi-daemon/main/install.sh \
    | sudo bash

Bei einem weitgehend unveränderten System nimmt dieser Befehl die nötigen Konfigurationsänderungen vor und installiert die Daemon-Software automatisch. Das dauert nur wenige Sekunden. Sie müssen nach Abschluss der Installation lediglich von Hand neu starten:

    sudo reboot

Achten Sie beim Neustart auf die LEDs des SH-RPi. Die RX-LED leuchtete durchgehend grün und die Status-LED durchgehend rot; nach dem Neustart flackert die RX-LED munter (sofern Verkehr auf dem NMEA-2000-Bus liegt), und die Status-LED leuchtet rot, blinkt aber jede Sekunde kurz auf. Diese Änderungen zeigen, dass die CAN-Schnittstelle und der Watchdog des Daemons aktiv sind. Sehr schön.

Wenn Sie sich nach dem Neustart per VNC verbinden, sehen Sie die folgende Meldung:

[![](assets/screenshots/20_after_reboot.jpg){ width="50%" }](assets/screenshots/20_after_reboot.jpg)

Das bedeutet, dass wir jetzt eine aktive CAN-Schnittstelle haben, sie aber in [Signal K](https://signalk.org) noch nicht konfiguriert ist. Das holen wir im nächsten Abschnitt nach.

### Signal K für den Empfang von NMEA-2000-Verkehr konfigurieren

Um die NMEA-2000-Daten zu verarbeiten, müssen wir Signal K für ihren Empfang konfigurieren. Öffnen Sie das Signal-K-Dashboard unter [http://openplotter.local:3000/](http://openplotter.local:3000/).

Damit sich am Server überhaupt etwas machen lässt, müssen Sie die Sicherheit aktivieren und einen Administrator anlegen. Klicken Sie oben rechts auf die Schaltfläche „Login“:

[![](assets/screenshots/21_sk_server_dashboard.jpg){ width="50%" }](assets/screenshots/21_sk_server_dashboard.jpg)

Sie werden aufgefordert, einen neuen Administrator anzulegen. Ich nehme als Benutzernamen am liebsten `admin` und dazu ein passendes, leicht zu merkendes und leicht zu tippendes Passwort. Der Zugriff ist ohnehin nur aus Ihrem internen Netz möglich.

Als Nächstes bietet es sich an, den SK-Server zu aktualisieren:

[![](assets/screenshots/23_update_server.jpg){ width="50%" }](assets/screenshots/23_update_server.jpg)

Danach können wir zur Sache kommen und `can0` auf dem Server aktivieren. Gehen Sie zu Data Connections und klicken Sie auf die Schaltfläche Add:

[![](assets/screenshots/26_data_connections_add.jpg){ width="50%" }](assets/screenshots/26_data_connections_add.jpg)

Konfigurieren Sie die Verbindung dann wie folgt, scrollen Sie nach unten und klicken Sie auf Submit:

[![](assets/screenshots/28_correct_settings.jpg){ width="50%" }](assets/screenshots/28_correct_settings.jpg)

Nachdem Sie die Datenverbindung hinzugefügt haben, starten Sie den Server erneut neu. Jetzt sollte das Dashboard etwas Verbindungsaktivität anzeigen:

[![](assets/screenshots/30_can0_activity.jpg){ width="50%" }](assets/screenshots/30_can0_activity.jpg)

Sehr schön. Zeit, sich selbst zu gratulieren. Sie sind weit gekommen!

Wenn Sie möchten, können Sie auch im linken Menü den Data Browser öffnen und sehen, welche Daten Sie empfangen.

### Instrumententafeln anlegen

Wenn Daten eintreffen, können Sie sie bereits darstellen, indem Sie das SK Instrument Panel öffnen:

[![](assets/screenshots/301_sk_plugins.jpg){ width="50%" }](assets/screenshots/301_sk_plugins.jpg)

Über die Schaltfläche mit dem Schraubenschlüssel lassen sich einige Pfade konfigurieren. Größe und Position der Anzeigen passen Sie über die Schaltfläche mit dem Schloss an.

Mein Testlabor liegt direkt unter einem Blechdach ganz ohne GPS-Empfang, und die einzigen interessanten Daten in meinem Netz kommen vom [1-Wire-Temperatursensor](https://docs.hatlabs.fi/sh-esp32/pages/tutorials/onewire-temperature/). Meine Instrumententafel besteht daher derzeit aus drei Temperaturwerten:

[![](assets/screenshots/302_sk_instrument_panel.jpg){ width="50%" }](assets/screenshots/302_sk_instrument_panel.jpg)

Ein wenig traurig, aber gleichzeitig spannend!

Neben dem Standard-Instrument-Panel gibt es viele sehr schöne Dashboard-Anwendungen für Signal K. Probieren Sie zum Beispiel [KIP](https://github.com/mxtommy/Kip) (im App-Store des SK-Servers zu finden) oder [Wilhelm SK](https://www.wilhelmsk.com/) (nur für iOS-Geräte, im App Store erhältlich).

### Installation von InfluxDB und Grafana

In den letzten Schritten dieser Anleitung installieren und konfigurieren wir InfluxDB und Grafana, um ein Langzeitprotokoll und Visualisierungen der Bootsdaten zu erstellen. Es sind noch ein paar Schritte und einige unübersichtlich wirkende Bildschirme, aber der kleine Aufwand lohnt sich!

InfluxDB ist eine Zeitreihendatenbank, in der wir die Daten speichern. Grafana ist ein Visualisierungswerkzeug, das häufig zur Überwachung von IT-Systemen eingesetzt wird, sich aufgrund seiner Vielseitigkeit aber ebenso gut für unsere maritimen Daten eignet.

Um InfluxDB und Grafana zu installieren, gehen Sie zurück zum VNC Viewer und öffnen im Raspberry-Menü OpenPlotter -> Dashboards:

[![](assets/screenshots/31_openplotter_dashboards.jpg){ width="50%" }](assets/screenshots/31_openplotter_dashboards.jpg)

Wählen Sie InfluxDB und klicken Sie auf Install. Das dauert eine Weile; sobald es fertig ist, gehen Sie zurück auf den Reiter Apps, wählen Grafana und klicken auf Install. Das war es schon.

[![](assets/screenshots/32_install.jpg){ width="50%" }](assets/screenshots/32_install.jpg)

Anschließend müssen wir in InfluxDB eine neue Datenbank anlegen. Öffnen Sie Chronograf, die Weboberfläche von InfluxDB, im Browser: [http://openplotter.local:8889/](http://openplotter.local:8889/).

[![](assets/screenshots/34_open_chronograf.jpg){ width="50%" }](assets/screenshots/34_open_chronograf.jpg)


Klicken Sie sich durch die Erstkonfiguration. Die InfluxDB-Verbindung von Chronograf verwendet den Benutzernamen `admin` und das Passwort `admin`. Das Anlegen von Dashboards und die Kapacitor-Konfiguration können Sie überspringen.

Legen Sie danach im Bildschirm InfluxDB Admin die neue Datenbank an:

[![](assets/screenshots/37_create_signalk_db.jpg){ width="50%" }](assets/screenshots/37_create_signalk_db.jpg)

Geben Sie der Datenbank den Namen `signalk` und klicken Sie sich ansonsten einfach durch. Fertig.

Jetzt, da die Datenbank auf uns wartet, füttern wir sie mit Daten. Gehen Sie zurück zum Signal-K-Dashboard, um das InfluxDB-Writer-Plugin zu konfigurieren:

[![](assets/screenshots/39_sk_plugin_config.jpg){ width="50%" }](assets/screenshots/39_sk_plugin_config.jpg)

Lassen Sie Benutzername und Passwort leer. Unsere Datenbank hieß `signalk`. Wenn Sie möchten, ändern Sie das Schreibintervall für Stapelschreibvorgänge und die Datenauflösung. Das Intervall beträgt standardmäßig 10 Sekunden; wenn Sie die Daten näher an Echtzeit sehen möchten, geben Sie 2 ein. Die Auflösung bestimmt, wie oft ein einzelner Messwert in die Datenbank geschrieben wird. Der Standardwert von 200 ms dürfte genügen, ich wollte aber noch mehr und habe 100 ms gewählt. Setzen Sie außerdem die Häkchen wie unten gezeigt.

[![](assets/screenshots/40_settings.jpg){ width="50%" }](assets/screenshots/40_settings.jpg)

Scrollen Sie nach unten und klicken Sie auf Submit, um die Konfiguration zu übernehmen. Jetzt sollten Messwerte in die Datenbank fließen. Prüfen wir das. Gehen Sie zurück zu Chronograf und wählen Sie die Ansicht Explore. Ganz unten sollte eine Quelle namens `signalk.autogen` stehen. Wählen Sie sie aus, dann sollten die einzelnen Messwertnamen erscheinen. Sehr gut.

[![](assets/screenshots/41_verify_data.jpg){ width="50%" }](assets/screenshots/41_verify_data.jpg)

Es bleibt nur noch, die historischen Daten zu visualisieren.

### Ein Grafana-Beispiel-Dashboard erstellen

Wir nutzen Grafana, um ein paar schicke Diagramme zu zeigen. Öffnen Sie Grafana im Browser: [http://openplotter.local:3001](http://openplotter.local:3001).

[![](assets/screenshots/42_open_grafana.jpg){ width="50%" }](assets/screenshots/42_open_grafana.jpg)

Grafana verlangt die Eingabe eines neuen Passworts — tun Sie das. Sobald Sie den Startbildschirm erreichen, konfigurieren Sie die InfluxDB-Datenquelle:

[![](assets/screenshots/44_grafana_data_sources.jpg){ width="50%" }](assets/screenshots/44_grafana_data_sources.jpg)

In der Konfiguration wird die Standard-URL in Dunkelgrau angezeigt, ich musste sie aber ausdrücklich eintippen. Ansonsten gilt wieder dieselbe `signalk`-Datenbank und leerer Benutzername und leeres Passwort. Klicken Sie auf „Save and Test“, um zu prüfen, ob Ihre Datenquelle funktioniert.

[![](assets/screenshots/46_config_data_source.jpg){ width="50%" }](assets/screenshots/46_config_data_source.jpg)

Fassen wir an dieser Stelle zusammen, was wir haben. Signal K empfängt die Daten von NMEA 2000, InfluxDB speichert diese Daten, und Grafana ist mit InfluxDB verbunden. Zum Schluss können wir ein Grafana-Dashboard anlegen und neue Datenanzeigen hinzufügen.

Der Panel-Editor wirkt etwas unübersichtlich, die grundlegenden Schritte sind aber unkompliziert.

[![](assets/screenshots/54_panel_title.jpg){ width="50%" }](assets/screenshots/54_panel_title.jpg)

Bearbeiten Sie die Abfrage. Wählen Sie zuerst in der Zeile FROM einen Messwert. Zweitens müssen Sie einen Rechenoperator hinzufügen, um die Messeinheiten umzurechnen (Grafana kennt Einheiten kaum, zeigt die Daten also standardmäßig immer in den SI-Einheiten an, in denen sie gespeichert sind). Um zum Beispiel von Kelvin auf Grad Celsius zu kommen, müssen Sie 273,15 abziehen. Oder um von m/s auf kn zu kommen, multiplizieren Sie mit 3600 und teilen durch 1852.

Vollenden Sie die Anzeige, indem Sie ihr einen Titel geben und die Änderungen übernehmen.

Jetzt sollten Sie in Ihrem Dashboard eine einzelne Anzeige mit ein wenig Zeitverlauf sehen. Fügen Sie über die Schaltfläche Add Panel noch ein paar Anzeigen hinzu. Sie können die Anzeigen positionieren und ihre Größe ändern, indem Sie an Titeln und Ecken ziehen. Zum Schluss wählen Sie in der oberen Leiste einen passenden Zeitraum und speichern das Dashboard.

So sieht mein fertiges Dashboard für die Motortemperatur aus:

[![](assets/screenshots/56_two_more_panels.jpg){ width="50%" }](assets/screenshots/56_two_more_panels.jpg)

Das war's. Legen Sie großartige Dashboards an und zeigen Sie sie Ihren Freunden im Hafen und im Segelclub! Teilen Sie sie zur Inspiration auch im [Diskussionsforum von Hat Labs](https://github.com/hatlabs/discussions/discussions)!


</div>
