---
title: OpenPlotter-server installeren
translated_from: 3eb95fa3d5c4e946a6ee74c23585b9b432d39c4e
---

!!! warning
    Dit gedeelte is nog niet bijgewerkt voor de wijzigingen in de v2-hardware.

<div style="-moz-filter: opacity(30%); -webkit-filter: opacity(30%); filter: opacity(30%);">

## Inleiding

In deze handleiding bouwen we een OpenPlotter-server met [Sailor Hat for Raspberry Pi](https://docs.hatlabs.fi/sh-rpi/) ([koopkoppeling](https://hatlabs.fi/product/sh-rpi-enclosure-kit/)) en de OpenPlotter-software.
De server is compact en waterdicht en wordt eenvoudig gevoed vanuit het 12/24 V-systeem van de boot.
Hij is ook makkelijk te koppelen aan de bestaande elektronica aan boord.

De meegeleverde software legt al het wezenlijke NMEA 2000-verkeer aan boord vast en laat u het gedrag van verschillende waarden zowel in realtime als achteraf bekijken, met behulp van ingebouwde instrumentenpanelen en Grafana-dashboards.
Daarnaast kan de server informatie uit andere bronnen ontvangen en verwerken, bijvoorbeeld van [SH-ESP32-sensorapparaten](https://docs.hatlabs.fi/sh-esp32/) of van diverse internetdiensten.

Enkele voorbeelden van visualisaties:

<figure markdown="span">
![](assets/screenshots/001_examples.jpg){ width="75%" }
<figcaption>Voorbeelden van visualisaties.</figcaption>
</figure>

## Benodigde onderdelen

Voor deze handleiding hebt u de volgende onderdelen nodig:

- [SH-RPi-behuizingsset](https://hatlabs.fi/product/sh-rpi-enclosure-kit/)

  De SH-RPi is het geheime ingrediënt dat de Raspberry Pi de hardware-interfaces geeft die de systemen van de boot vragen. De print heeft een geïntegreerde, beveiligde 12/24 V-voeding met veilige afsluiting en een galvanisch gescheiden, NMEA 2000-compatibele CAN-interface.

  In deze handleiding gebruiken we de kunststof behuizing en voeden we de Pi via een NMEA 2000-paneelconnector. Daarnaast wordt een USB type A-paneelconnector gebruikt om zo nodig makkelijker te kunnen aansluiten, en een koelventilator zorgt voor betere warmteafvoer. Pas uw eigen opstelling gerust aan.

  We gebruiken ook een extra usb-wifi-adapter, omdat dat de installatie eenvoudiger maakt (de extra netwerkinterface kan aan boord ook van pas komen). Wilt u de usb-wifi-adapter niet, dan kunt u de Pi in plaats daarvan op bekabeld ethernet aansluiten met hetzelfde resultaat.

- Een Raspberry Pi 4B

  Een model met 4 GB geheugen volstaat. Amazon heeft vaak onverslaanbare prijzen, of u kunt de dealerlijst op de website van Raspberry Pi bekijken:

    * [amazon.com](https://www.amazon.com/Raspberry-Model-2019-Quad-Bluetooth/dp/B07TC2BK1X/)
    * [amazon.de](https://www.amazon.de/-/en/Raspberry-ARM-Cortex-A72-WLAN-ac-Bluetooth-Micro-HDMI-Single/dp/B07TC2BK1X/)
    * [amazon.co.uk](https://www.amazon.co.uk/Raspberry-Pi-ARM-Cortex-A72-Bluetooth-Micro-HDMI/dp/B07TC2BK1X/)
    * [Dealerlijst van Raspberry Pi](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/?variant=raspberry-pi-4-model-b-4gb)

- MicroSD-geheugenkaart

  Op de MicroSD-kaart staan het besturingssysteem en de databestanden van de Raspberry Pi. Met Samsung Evo Plus-kaarten heb ik goede ervaringen. Geheugenkaarten zijn goedkoop en grotere kaarten zijn betrouwbaarder bij gebruik in een Raspberry Pi, dus neem er minstens een van 64 GB:

  * [amazon.com](https://www.amazon.com/Samsung-MicroSDXC-Memory-Adapter-MB-MC64GA/dp/B06XFWPXYD/)
  * [amazon.de](https://www.amazon.de/-/en/Samsung-Flash-Memory-MicroSDXC-Class/dp/B08BKCB4JW/)
  * [amazon.co.uk](https://www.amazon.co.uk/Samsung-MicroSDXC-Class-UHS-I-Memory/dp/B08BKCB4JW/)

- Dubbelzijdig plakband of hete lijm

  Een kort stukje dubbelzijdig plakband of een klodder hete lijm is nodig om de koelventilator te bevestigen.

- Krimpkous, 3 mm binnendiameter

  Strikt noodzakelijk is het niet, maar krimpkous met 3 mm binnendiameter is handig om de gesoldeerde draden van de paneelconnector te ontlasten.

- [NMEA 2000-koppelcontrastekker](https://hatlabs.fi/product/nmea-2000-cable-plug/)

  Doet u de eerste installatie thuis, dan is een extra NMEA 2000 micro-stekker handig om voedingsspanning naar het apparaat te brengen.

## De hardware monteren

### Gaten boren voor de connectoren

Zoals altijd bij het boren van gaten in een gave behuizing: plan het zeer zorgvuldig vooraf. De paneelconnectoren nemen verrassend veel ruimte in, en een gat laat zich niet zomaar dichten, laat staan verplaatsen.

Zelf meet ik de behuizing het liefst op en maak ik een boormal in een vectortekenprogramma. Een tekening helpt u de maximale afmetingen te zien die de connector en de moer nodig hebben.

Weet u niet welk programma u moet gebruiken, dan is [Inkscape](https://inkscape.org) een goed allroundgereedschap. Bent u technischer aangelegd, dan kan cad-software als [LibreCAD](https://librecad.org) ook werken.

Ik wilde drie gaten op de korte zijde van de kunststof behuizing. Dit is de mal die ik daarvoor maakte:

<figure markdown="span">
![](assets/plastic-enclosure-end-template.svg){ width="50%" }
<figcaption><a href="assets/plastic-enclosure-end-template.svg">Voorbeeld van een boormal.</a></figcaption>
</figure>

De [mal](assets/plastic-enclosure-end-template.svg) is een SVG-bestand, dus vectorgrafiek, zodat u hem kunt opslaan en naar wens aanpassen.
Weet u niet welke software u moet gebruiken, probeer dan bijvoorbeeld het hierboven genoemde [Inkscape](https://inkscape.org). Zelf gebruik ik Affinity Designer, een goedkoop commercieel ontwerpprogramma voor MacOS.

Lukt het openen van het SVG-bestand niet, dan is de mal ook als [PDF-versie](assets/plastic-enclosure-end-template.pdf) beschikbaar.

Als de mal klaar is, markeert u het middelpunt op de behuizing en plakt u de mal zo vast dat de middelpunten samenvallen.

<figure markdown="span">
![](assets/photos/01_drill-template.jpg){ width="50%" }
<figcaption>Boormal op de doos.</figcaption>
</figure>


Om nauwkeurig te boren helpt het de hartlijnen van de gaten met een centerpons te markeren (een scherpe spijker en een lichte hamertik voldoen ook).

Boor voorgaten met een kleine boor (ongeveer 3 mm). Boor daarna de definitieve gaten met een trapboor. Neem de tijd en houd het toerental laag. Kleinere gaten met afwijkende maten, zoals dat van 6,5 mm, werkt u af met een metaalboor van de bijbehorende maat.

Boren in kunststof laat veel bramen rond de gaten achter. Die haalt u weg met een scherp mes.

Ten slotte kunnen de aangegoten afstandsbussen in de kunststof behuizing de geboorde gaten blokkeren. Ik moest er een verwijderen. Ik gebruikte een Dremel, maar een stevige tang werkt waarschijnlijk ook.

Zo ziet het eindresultaat er in mijn geval uit.

<figure markdown="span">
![](assets/photos/02_drilled_holes.jpg){ width="50%" }
<figcaption>Geboorde gaten.</figcaption>
</figure>


### Draden aansluiten op de NMEA 2000-paneelconnector

Nu solderen we de JST XH-draadbomen aan de NMEA 2000-paneelconnector. Dezelfde aanpak werkt ook voor het solderen van de SP13-voedingsconnectoren als u daar liever een van gebruikt.
We beginnen met het vullen van de soldeerkelken van de connector met tin.

<figure markdown="span">
![](assets/photos/021_soldered_cups.jpg){ width="50%" }
<figcaption>Gesoldeerde kelken.</figcaption>
</figure>


We willen zowel de print zelf als de CAN-interface via de NMEA 2000-connector voeden. Er is meer dan één manier om dat te doen, maar laten we de voor de hand liggende methode nemen en beide draadbomen op de NMEA-paneelconnector aansluiten.

Strip een kort stukje van de rode en de zwarte draad en draai ze in elkaar.

<figure markdown="span">
![](assets/photos/022_spliced_wires.jpg){ width="50%" }
<figcaption>In elkaar gedraaide draden.</figcaption>
</figure>


Het is aan te raden krimpkous te gebruiken om de connectorpinnen te isoleren en de soldeerverbindingen mechanisch te ontlasten. Knip korte stukjes krimpkous en schuif ze over de draden. (Raad eens wie dit stapje _weer_ vergat tijdens het fotograferen voor deze handleiding.)

Soldeer de draden aan de connector, zowel de afzonderlijke signaaldraden als de in elkaar gedraaide voedingsdraden.

Het onderstaande schema toont de juiste pinbezetting. Ja, het is een stekker, maar omdat we naar de verkeerde kant van de connector kijken, gebruiken we het schema van het andere geslacht. (Ja, dat is een beetje verwarrend.)

<figure markdown="span">
![](assets/nmea_2000_female_pinout.png){ width="50%" }
<figcaption>Pinbezetting van de NMEA 2000 micro C-contrastekker.</figcaption>
</figure>


Soldeer eerst de middelste pin. Dat gaat nu makkelijker, nu de andere draden nog niet in de weg zitten. De standaardkleur van de CAN_L-draad is blauw, maar in onze draadboom is die geel.

<figure markdown="span">
![](assets/photos/023_soldered_L.jpg){ width="50%" }
<figcaption>Middelste pin gesoldeerd.</figcaption>
</figure>


Soldeer daarna de drie overige draden vast. De afscherming blijft onaangesloten.

Zo hoort uw connector er in dit stadium uit te zien:

<figure markdown="span">
![](assets/photos/024_all_soldered.jpg){ width="50%" }
<figcaption>Alles gesoldeerd.</figcaption>
</figure>


Ik ga er stoutmoedig van uit dat u eraan dacht de stukjes krimpkous erop te schuiven vóór het solderen. Nu is het tijd ze over de soldeerverbindingen te schuiven en te krimpen met een heteluchtpistool (of de vlam van een aansteker). Het eindresultaat hoort er ongeveer zo uit te zien:

<figure markdown="span">
![](assets/photos/025_heat_shrink.jpg){ width="50%" }
<figcaption>Krimpkous aangebracht.</figcaption>
</figure>


Schroef de afgewerkte NMEA 2000-paneelconnector in de behuizing.

Nog een foto van een afgewerkte connector en de pinbezetting:

<figure markdown="span">
![](assets/photos/n2k_connector_wiring_photo.jpg){ width="50%" }
<figcaption>Afgewerkte connector.</figcaption>
</figure>


### De overige paneelconnectoren aansluiten

Nu het lastige deel achter de rug is, kunnen de andere connectoren worden vastgeschroefd. Om de wifi-antenneconnector waterdichter te maken kunt u er een kleine O-ring of pakking omheen leggen voordat u hem monteert.

Uiteindelijk hoort u dit te hebben:

<figure markdown="span">
![](assets/photos/03_connectors_in_place.jpg){ width="50%" }
<figcaption>Connectoren op hun plaats.</figcaption>
</figure>


### De SH-RPi monteren

Nu gaan we de Raspberry Pi in de behuizing monteren.
We gebruiken de kunststof behuizing en de montageadapters die bij de behuizing geleverd horen te zijn.

Eerst bevestigen we de korte afstandsbussen met de M2.5-moeren aan de montageadapters. Draai ze goed vast.

<figure markdown="span">
![](assets/photos/04_adapters_with_standoffs.jpg){ width="50%" }
<figcaption>Adapters met afstandsbussen.</figcaption>
</figure>


Zodra de afstandsbussen op hun plaats zitten, kunnen de adapters zelf met de zelftappende schroeven in de behuizing worden gemonteerd.

<figure markdown="span">
![](assets/photos/05_adapters_in_place.jpg){ width="50%" }
<figcaption>Adapters gemonteerd.</figcaption>
</figure>


De Raspberry Pi komt op de afstandsbussen. Zet de bovenste afstandsbussen vast met de M2.5-schroeven en de onderste met twee zeskantige afstandsbussen van 16 mm.

<figure markdown="span">
![](assets/photos/06_rpi_mounted.jpg){ width="50%" }
<figcaption>Raspberry Pi gemonteerd.</figcaption>
</figure>


Daarna volgt de Sailor Hat. Druk hem op de GPIO-pinheader van de Raspberry Pi. Zet hem vast met twee M2.5-schroeven.

**LET OP**: Als u de HAT ooit moet verwijderen, bent u geneigd hem zijwaarts heen en weer te wiebelen. Dat werkt goed, maar er is ook een klein risico dat u de pinnen aan weerszijden van de header van de Pi verbuigt. Wiebel de HAT in plaats daarvan op en neer terwijl u voorzichtig omhoog trekt. Dat gaat wat langzamer, maar de HAT laat los met veel minder kans op verbogen pinnen.

In dit stadium kunt u ook alle usb-apparaten aansluiten en de voedings- en CAN-kabels van de SH-RPi verbinden. Gebruikt u een koelventilator, monteer die dan ook. Zet hem met dubbelzijdig plakband of een klodder hete lijm naast de Raspberry Pi vast, met de stickerzijde naar de Pi toe.

Zo ziet de voltooide opbouw eruit:

<figure markdown="span">
![](assets/photos/07_sh-rpi_mounted.jpg){ width="50%" }
<figcaption>Sailor Hat gemonteerd.</figcaption>
</figure>


Sluit het deksel nog niet. U moet nog de geheugenkaart in de Pi steken.

## Software

In dit gedeelte installeren we de OpenPlotter-software op de Raspberry Pi. OpenPlotter is een gespecialiseerde maritieme softwaredistributie op basis van Raspberry Pi OS. Er zijn verschillende smaken; in deze handleiding gebruiken we een versie zonder beeldscherm (headless), dat wil zeggen zonder rechtstreeks op de Raspberry Pi aangesloten scherm. Voor weergave gebruiken we in plaats daarvan browsers of verbindingen met extern bureaublad, waardoor de server en de schermen veiliger en handiger geplaatst kunnen worden.

### OpenPlotter installeren

OpenPlotter wordt geïnstalleerd door een systeemimage naar een MicroSD-kaart te schrijven en die kaart in de Raspberry Pi te steken.

Download eerst de [Raspberry Pi Imager](https://www.raspberrypi.org/software/). De Imager is een eenvoudig te bedienen programma waarmee het gedownloade imagebestand naar de geheugenkaart wordt geschreven.

**LET OP:** De Imager is alleen te downloaden voor macOS, Windows en Ubuntu Linux. Gebruikt u een ander besturingssysteem of een andere Linux-distributie, dan hebt u mogelijk andere software nodig om de kaart te flashen (maar dan ga ik ervan uit dat u prima weet hoe dat moet).

Installeer de Imager na het downloaden.

Download vervolgens het [OpenPlotter-image](https://openplotter.readthedocs.io/en/latest/getting_started/downloading.html). Ik gebruik in deze handleiding het Headless-image. Wilt u liever een scherm op de Pi aansluiten, dan kunt u ook het Starting-image nemen. Nadat het image is gedownload, moet u het misschien uitpakken voordat u kunt flashen. Het systeemimage is behoorlijk groot, dus u hebt beter een paar gigabyte vrije ruimte op uw schijf.

Flash het image naar de MicroSD-kaart. Steek de kaart eerst in een lezer die op uw computer is aangesloten. Veel laptops hebben ook een ingebouwde SD-kaartlezer. Gebruik daarvoor de SD-adapter die bij de kaart geleverd is. Open daarna de Imager. Kies in het besturingssysteemmenu onderaan de lijst “Use custom” en selecteer vervolgens het gedownloade imagebestand.

[![](assets/screenshots/01_imager.jpg){ width="50%" }](assets/screenshots/01_imager.jpg)

Kies daarna de juiste MicroSD-kaart met de knop Storage. Om kostbare vergissingen te voorkomen raad ik aan alle andere verwisselbare media van uw computer los te koppelen. Klik op Write. Mogelijk moet u hier uw wachtwoord invoeren zodat de Imager naar de MicroSD-kaart mag schrijven.

[![](assets/screenshots/02_imager_in_progress.jpg){ width="50%" }](assets/screenshots/02_imager_in_progress.jpg)

Het schrijven en verifiëren van de MicroSD-kaart duurt even. Die tijd kunnen we gebruiken om [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/) te downloaden en te installeren. VNC Viewer is software voor extern bureaublad waarmee we OpenPlotter in de volgende gedeelten benaderen.

Als de MicroSD-kaart klaar is, steekt u hem in de MicroSD-kaartsleuf van de Raspberry Pi. Daarvoor moet u de HAT misschien tijdelijk losnemen. (Ja, sorry, de handleiding is niet 100 % consistent.)

Zet het apparaat ten slotte aan. Het is weliswaar mogelijk een 5 V USB-C-kabel in de Raspberry Pi te steken, maar dat levert problemen op zodra u verderop in deze handleiding de SH-RPi-daemon installeert. Gebruik dus een 12 V-voeding (alles tussen 10–32 V mag eigenlijk) en bedraad die naar een NMEA 2000-stekker. U kunt ook korte vrouwelijke jumperdraden rechtstreeks in de JST XH-connectoren steken en de draden met kleine krokodillenklemmen op een voeding aansluiten. Gebruik uw fantasie!

### Eerste configuratie van OpenPlotter

Op dit punt hebt u een apparaat met veel knipperende lampjes, maar geen manier om ermee te communiceren. Gelukkig is er een weg naar binnen. Kijkt u naar de beschikbare wifi-netwerken om u heen, dan hoort u een netwerk met de naam “openplotter” te zien:

[![](assets/screenshots/03_select_wifi.jpg){ width="50%" }](assets/screenshots/03_select_wifi.jpg)

Maak verbinding met dat netwerk (het wachtwoord is `12345678`).

Nu bent u binnen bereik van de Pi. Om hem te benaderen gebruiken we VNC Viewer, dat we eerder hebben geïnstalleerd.

[![](assets/screenshots/04_vnc_viewer.jpg){ width="50%" }](assets/screenshots/04_vnc_viewer.jpg)

Typ op het startscherm `openplotter.local` in de adresbalk (werkt dat niet, probeer dan het IP-adres `10.10.10.1`). Is de server gevonden, dan verschijnt een scherm voor uw inloggegevens:

[![](assets/screenshots/05_vnc_credentials.jpg){ width="50%" }](assets/screenshots/05_vnc_credentials.jpg)

Voer de gebruikersnaam `pi` en het wachtwoord `raspberry` in.

Als alles is gelukt, verschijnt een ongerept OpenPlotter-bureaublad:

[![](assets/screenshots/06_vnc_connected.jpg){ width="50%" }](assets/screenshots/06_vnc_connected.jpg)

Prima! Loop de welkomstwizard van de Pi door. U moet eerst een nieuw wachtwoord invoeren en land, taal en andere basisinstellingen kiezen.

Hebt u een geschikte usb-wifi-adapter aangesloten, dan moet u een wifi-netwerk kiezen om verbinding mee te maken. Dat is heel handig, want daarmee komt u op internet om updates en dergelijke te downloaden.

[![](assets/screenshots/07_pick_raspi_wifi.jpg){ width="50%" }](assets/screenshots/07_pick_raspi_wifi.jpg)

Let op: hebt u geen wifi-adapter aangesloten, dan kan de eerste installatie iets afwijken van wat hieronder wordt beschreven.

Tijdens de eerste installatie werkt de Pi de systeemsoftware bij. Dat duurt even, dus haal een kop koffie of speel met uw partner, kinderen of huisdieren.

[![](assets/screenshots/08_update.jpg){ width="50%" }](assets/screenshots/08_update.jpg)

Als de installatie klaar is, start u de Pi opnieuw op. U was verbonden met het wifi-accesspoint van de Pi, dus de netwerkverbinding van uw computer keert nu terug naar uw gewone wifi. Hebt u de usb-wifi-adapter en hebt u de Pi op hetzelfde netwerk ingesteld, dan bereikt u hem nog steeds op hetzelfde adres, `openplotter.local`. Ziet u nu waarom ik die extra wifi-adapter aanraadde? Anders moet u opnieuw verbinding maken met het netwerk “openplotter” zodra dat weer beschikbaar is.

[![](assets/screenshots/09_basic_setup_complete.jpg){ width="50%" }](assets/screenshots/09_basic_setup_complete.jpg)

Hoe dan ook. Ga terug naar VNC Viewer en maak verbinding met `openplotter.local`. U hebt het wachtwoord van gebruiker `pi` tijdens de eerste configuratie gewijzigd, dus voer het nieuwe wachtwoord in VNC Viewer in.

Zodra u weer binnen bent, passen we de netwerkinstellingen van de OpenPlotter-installatie aan. Kies in het Raspberry-menu OpenPlotter -> Network.

(Bij het openen van de Network-app klaagt die er mogelijk over dat hij uw systeem opnieuw wil configureren. Laat hem begaan en open de app opnieuw als hij klaar is.)

[![](assets/screenshots/11_open_openplotter_network.jpg){ width="50%" }](assets/screenshots/11_open_openplotter_network.jpg)

In het netwerkpaneel ziet u links de beschikbare netwerkapparaten en rechts de instellingen van het accesspoint.

Wilt u geen accesspoint, kies dan “none” in het menu links. Wilt u het accesspoint behouden (en dat raad ik aan, want het geeft u een reserveweg naar de Pi), dan is het belangrijk het netwerkwachtwoord te wijzigen:

[![](assets/screenshots/14_openplotter_network_password.jpg){ width="50%" }](assets/screenshots/14_openplotter_network_password.jpg)

De instellingen van de wifi-client vindt u onder het wifi-symbool rechtsboven op het OpenPlotter-bureaublad. Daar configureert u aanvullende netwerken, zoals het wifi-accesspoint van uw boot.

[![](assets/screenshots/16_wifi_client_settings.jpg){ width="50%" }](assets/screenshots/16_wifi_client_settings.jpg)

Start OpenPlotter opnieuw op nadat u de netwerkinstellingen hebt gewijzigd.

### De SH-RPi-daemon installeren

Nu het dringendste achter de rug is, is het tijd om de SH-RPi-daemon te installeren. ([Daemonen](https://en.wikipedia.org/wiki/Daemon_(computing)#Etymology) zijn welwillende geesten die het karakter of de persoonlijkheid van een mens mede vormgeven. Of in dit geval achtergronddiensten voor besturingssystemen uit de UNIX-familie.) We zouden daarvoor VNC Viewer kunnen gebruiken door in het Raspberry-menu Accessories -> Terminal te openen, en dat raad ik Windows-gebruikers aan, maar Mac- en Linux-gebruikers laat ik zien hoe u het OpenPlotter-apparaat via SSH benadert.

Eerst een kleine zijstap. In plaats van meteen met ssh in te loggen, kopiëren we eerst met `ssh-copy-id` onze openbare SSH-sleutel naar het apparaat. Daarna kunt u zich zonder wachtwoord aanmelden.

Mac-gebruikers moeten `ssh-copy-id` misschien eerst installeren. Het is beschikbaar via [Homebrew](https://brew.sh/) — hebt u dat nog niet geïnstalleerd, doe dat dan! Het is uitstekend! Daarna voert u uit:

    brew install ssh-copy-id

Linux-gebruikers zijn daarentegen verwend en hebben `ssh-copy-id` al voorgeïnstalleerd.

Kopieer vervolgens de openbare sleutel:

    ssh-copy-id pi@openplotter.local

Dat is alles! Nu kunt u zich zonder wachtwoord op de Pi aanmelden. Ik raad deze methode aan op alle systemen die u op afstand benadert — ze is veiliger dan wachtwoorden.

[![](assets/screenshots/18_ssh.jpg){ width="50%" }](assets/screenshots/18_ssh.jpg)

Zodra u zich met `ssh pi@openplotter.local` hebt aangemeld, plakt u de installatieopdracht in de opdrachtprompt:

    curl -L \
    https://raw.githubusercontent.com/hatlabs/SH-RPi-daemon/main/install.sh \
    | sudo bash

Hebt u een tamelijk ongewijzigd systeem, dan brengt deze opdracht de nodige configuratiewijzigingen aan en installeert ze de daemonsoftware automatisch. Het duurt maar een paar seconden. U hoeft alleen handmatig opnieuw op te starten zodra de installatie klaar is:

    sudo reboot

Let tijdens het opnieuw opstarten op de leds van de SH-RPi. De RX-led brandde continu groen en de status-led continu rood, maar na het opnieuw opstarten flikkert de RX-led vrolijk (aangenomen dat er verkeer op de NMEA 2000-bus is), en brandt de status-led rood maar knippert elke seconde kort. Die veranderingen geven aan dat de CAN-interface en de watchdog van de daemon actief zijn. Mooi.

Als u na het opnieuw opstarten verbinding maakt met VNC, ziet u de volgende melding:

[![](assets/screenshots/20_after_reboot.jpg){ width="50%" }](assets/screenshots/20_after_reboot.jpg)

Dit geeft aan dat we nu een actieve CAN-interface hebben, maar dat die nog niet in [Signal K](https://signalk.org) is geconfigureerd. Dat doen we in het volgende gedeelte.

### Signal K configureren om NMEA 2000-verkeer te ontvangen

Om de NMEA 2000-gegevens te verwerken moeten we Signal K configureren om ze te ontvangen. Open het Signal K-dashboard op [http://openplotter.local:3000/](http://openplotter.local:3000/).

Om iets op de server te kunnen doen, moet u beveiliging inschakelen en een beheerdersaccount aanmaken. Klik rechtsboven op de knop “Login”:

[![](assets/screenshots/21_sk_server_dashboard.jpg){ width="50%" }](assets/screenshots/21_sk_server_dashboard.jpg)

U wordt gevraagd een nieuwe beheerder aan te maken. Zelf gebruik ik het liefst `admin` als gebruikersnaam en daarbij een passend wachtwoord dat makkelijk te onthouden en te typen is. Dit is alleen vanaf uw interne netwerk bereikbaar.

Daarna wilt u de SK-server misschien bijwerken:

[![](assets/screenshots/23_update_server.jpg){ width="50%" }](assets/screenshots/23_update_server.jpg)

Als dat gedaan is, kunnen we ter zake komen en `can0` op de server inschakelen. Ga naar Data Connections en klik op de knop Add:

[![](assets/screenshots/26_data_connections_add.jpg){ width="50%" }](assets/screenshots/26_data_connections_add.jpg)

Configureer de verbinding daarna als volgt, scrol omlaag en klik op Submit:

[![](assets/screenshots/28_correct_settings.jpg){ width="50%" }](assets/screenshots/28_correct_settings.jpg)

Nadat u de dataverbinding hebt toegevoegd, start u de server opnieuw op. Nu hoort het dashboard wat verbindingsactiviteit te tonen:

[![](assets/screenshots/30_can0_activity.jpg){ width="50%" }](assets/screenshots/30_can0_activity.jpg)

Mooi. Tijd om uzelf te feliciteren. U bent al ver gekomen!

Wilt u, dan kunt u ook links in het menu de Data Browser openen en zien welke gegevens u ontvangt.

### Instrumentenpanelen maken

Ontvangt u gegevens, dan kunt u ze al visualiseren door het SK Instrument Panel te openen:

[![](assets/screenshots/301_sk_plugins.jpg){ width="50%" }](assets/screenshots/301_sk_plugins.jpg)

Met de knop met de moersleutel kunt u enkele paden configureren. De grootte en de positie van de panelen past u aan door op de knop met het slot te klikken.

Mijn testlab ligt vlak onder een metalen dak zonder enige gps-ontvangst, en de enige interessante gegevens in mijn netwerk komen van de [1-Wire-temperatuursensor](https://docs.hatlabs.fi/sh-esp32/pages/tutorials/onewire-temperature/). Mijn instrumentenpaneel bestaat daarom nu uit drie temperatuurwaarden:

[![](assets/screenshots/302_sk_instrument_panel.jpg){ width="50%" }](assets/screenshots/302_sk_instrument_panel.jpg)

Een beetje treurig, maar tegelijk spannend!

Naast het standaard Instrument Panel zijn er veel heel mooie dashboardtoepassingen voor Signal K. Probeer bijvoorbeeld [KIP](https://github.com/mxtommy/Kip) (te vinden in de appstore van de SK-server) of [Wilhelm SK](https://www.wilhelmsk.com/) (alleen voor iOS-apparaten, verkrijgbaar in de App Store).

### InfluxDB en Grafana installeren

In de laatste stappen van deze handleiding installeren en configureren we InfluxDB en Grafana om een historisch logboek en visualisaties van de bootgegevens te maken. Het zijn nog een paar stappen en enkele drukogende schermen, maar die kleine moeite is het waard!

InfluxDB is een tijdreeksdatabase waarin we de gegevens opslaan. Grafana is een visualisatiegereedschap dat vaak wordt gebruikt om de gezondheid van IT-systemen te bewaken, maar dat dankzij zijn veelzijdigheid ook prima geschikt is voor onze maritieme gegevens.

Om InfluxDB en Grafana te installeren gaat u terug naar VNC Viewer en opent u in het Raspberry-menu OpenPlotter -> Dashboards:

[![](assets/screenshots/31_openplotter_dashboards.jpg){ width="50%" }](assets/screenshots/31_openplotter_dashboards.jpg)

Kies InfluxDB en klik op Install. Dat duurt even, maar als het klaar is, gaat u terug naar het tabblad Apps, kiest u Grafana en klikt u op Install. Dat is alles.

[![](assets/screenshots/32_install.jpg){ width="50%" }](assets/screenshots/32_install.jpg)

Daarna moeten we een nieuwe database in InfluxDB aanmaken. Open Chronograf, de webinterface van InfluxDB, in uw browser: [http://openplotter.local:8889/](http://openplotter.local:8889/).

[![](assets/screenshots/34_open_chronograf.jpg){ width="50%" }](assets/screenshots/34_open_chronograf.jpg)


Klik de eerste configuratie door. De InfluxDB-verbinding van Chronograf gebruikt de gebruikersnaam `admin` en het wachtwoord `admin`. Het aanmaken van dashboards en de configuratie van Kapacitor kunt u overslaan.

Maak vervolgens de nieuwe database aan in het scherm InfluxDB Admin:

[![](assets/screenshots/37_create_signalk_db.jpg){ width="50%" }](assets/screenshots/37_create_signalk_db.jpg)

Geef de database de naam `signalk` en klik verder gewoon door. Klaar.

Nu de database op ons wacht, gaan we hem van gegevens voorzien. Ga terug naar het Signal K-dashboard om de InfluxDB-schrijfplug-in te configureren:

[![](assets/screenshots/39_sk_plugin_config.jpg){ width="50%" }](assets/screenshots/39_sk_plugin_config.jpg)

Laat gebruikersnaam en wachtwoord leeg. Onze database heette `signalk`. Wilt u, dan kunt u het schrijfinterval voor batchschrijfacties en de gegevensresolutie aanpassen. Het interval is standaard 10 seconden, maar wilt u de gegevens dichter bij realtime zien, voer dan 2 in. De resolutie bepaalt hoe vaak een enkele meting naar de database wordt geschreven. De standaardwaarde van 200 ms is waarschijnlijk prima, maar ik wilde nog meer en koos 100 ms. Vink ook de vakjes aan zoals hieronder getoond.

[![](assets/screenshots/40_settings.jpg){ width="50%" }](assets/screenshots/40_settings.jpg)

Scrol omlaag en klik op Submit om de configuratie toe te passen. Nu horen er metingen de database in te stromen. Laten we dat controleren. Ga terug naar Chronograf en kies de weergave Explore. Onderaan hoort een bron met de naam `signalk.autogen` te staan. Kies die, dan horen de namen van de afzonderlijke metingen te verschijnen. Prima.

[![](assets/screenshots/41_verify_data.jpg){ width="50%" }](assets/screenshots/41_verify_data.jpg)

Rest alleen nog de historische gegevens te visualiseren.

### Een Grafana-voorbeelddashboard maken

We gebruiken Grafana om een paar fraaie grafieken te tonen. Open Grafana in uw browser: [http://openplotter.local:3001](http://openplotter.local:3001).

[![](assets/screenshots/42_open_grafana.jpg){ width="50%" }](assets/screenshots/42_open_grafana.jpg)

Grafana vraagt om een nieuw wachtwoord, dus voer dat in. Zodra u op het startscherm komt, configureert u de InfluxDB-gegevensbron:

[![](assets/screenshots/44_grafana_data_sources.jpg){ width="50%" }](assets/screenshots/44_grafana_data_sources.jpg)

In de configuratie wordt de standaard-URL in donkergrijs getoond, maar ik merkte dat ik hem uitdrukkelijk moest intypen. Verder is het weer dezelfde `signalk`-database en een lege gebruikersnaam en een leeg wachtwoord. Klik op “Save and Test” om te controleren of uw gegevensbron werkt.

[![](assets/screenshots/46_config_data_source.jpg){ width="50%" }](assets/screenshots/46_config_data_source.jpg)

Laten we op dit punt samenvatten wat we hebben. Signal K ontvangt de gegevens van NMEA 2000, InfluxDB slaat die gegevens op, en Grafana is met InfluxDB verbonden. Ten slotte kunnen we een Grafana-dashboard maken en er nieuwe gegevenspanelen aan toevoegen.

De paneeleditor oogt wat druk, maar de basisstappen zijn eenvoudig.

[![](assets/screenshots/54_panel_title.jpg){ width="50%" }](assets/screenshots/54_panel_title.jpg)

Bewerk de query. Kies eerst een meting op de regel FROM. Ten tweede moet u een rekenkundige bewerking toevoegen om de meeteenheden om te rekenen (Grafana kent eenheden nauwelijks, dus standaard toont het de gegevens altijd in de SI-eenheden waarin ze zijn opgeslagen). Om bijvoorbeeld van kelvin naar graden Celsius te komen, moet u -273.15 aftrekken. Of om van m/s naar kn te gaan, vermenigvuldigt u met 3600 en deelt u door 1852.

Rond het paneel af door het een titel te geven en de wijzigingen toe te passen.

Nu hoort u in uw dashboard één paneel te hebben met een beetje tijdreeksgegevens erin. Voeg met de knop Add Panel nog een paar panelen toe. U kunt de panelen verplaatsen en hun grootte aanpassen door aan de titels en de hoeken te slepen. Ten slotte kunt u in de bovenste balk een geschikt tijdsbereik kiezen en het dashboard opslaan.

Zo ziet mijn uiteindelijke dashboard voor de motortemperatuur eruit:

[![](assets/screenshots/56_two_more_panels.jpg){ width="50%" }](assets/screenshots/56_two_more_panels.jpg)

Dat was het. Ga fantastische dashboards maken en laat ze zien aan uw vrienden in de haven en bij de watersportvereniging! Deel ze ter inspiratie ook op het [discussieforum van Hat Labs](https://github.com/hatlabs/discussions/discussions)!


</div>
