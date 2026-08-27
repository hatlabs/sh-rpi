---
title: Installation af OpenPlotter-server
translated_from: 3eb95fa3d5c4e946a6ee74c23585b9b432d39c4e
---

!!! warning
    Dette afsnit er endnu ikke opdateret til ændringerne i v2-hardwaren.

<div style="-moz-filter: opacity(30%); -webkit-filter: opacity(30%); filter: opacity(30%);">

## Introduktion

I denne vejledning bygger vi en OpenPlotter-server med [Sailor Hat for Raspberry Pi](https://docs.hatlabs.fi/sh-rpi/) ([købslink](https://hatlabs.fi/product/sh-rpi-enclosure-kit/)) og OpenPlotter-softwaren.
Serveren er kompakt og vandtæt og forsynes nemt fra bådens 12/24 V-anlæg.
Den lader sig også let integrere med bådens eksisterende elektronik.

Den medfølgende software logger al væsentlig NMEA 2000-trafik om bord og giver dig mulighed for at se forskellige værdier både i realtid og historisk, ved hjælp af indbyggede instrumentpaneler og Grafana-dashboards.
Serveren kan desuden modtage og behandle oplysninger fra andre kilder, for eksempel [SH-ESP32-sensorenheder](https://docs.hatlabs.fi/sh-esp32/) eller forskellige internettjenester.

Nogle eksempler på visualiseringer:

<figure markdown="span">
![](assets/screenshots/001_examples.jpg){ width="75%" }
<figcaption>Eksempler på visualiseringer.</figcaption>
</figure>

## Nødvendige dele

For at gennemføre denne vejledning skal du bruge følgende dele:

- [SH-RPi kabinetsæt](https://hatlabs.fi/product/sh-rpi-enclosure-kit/)

  SH-RPi er den hemmelige ingrediens, der giver Raspberry Pi'en de hardwaregrænseflader, bådens systemer kræver. Kortet har en indbygget, beskyttet 12/24 V-strømforsyning med sikker nedlukning samt en galvanisk adskilt NMEA 2000-kompatibel CAN-grænseflade.

  I denne vejledning bruger vi plastkabinettet og forsyner Pi'en gennem et NMEA 2000-panelstik. Derudover bruges et USB type A-panelstik, så tilslutning bliver lettere efter behov, og en køleventilator tilføjes for bedre varmeafledning. Du må gerne tilpasse din egen opsætning.

  Vi bruger også en ekstra USB-WiFi-adapter, fordi det gør installationen lettere (den ekstra netværksgrænseflade kan også være nyttig om bord). Hvis du ikke ønsker USB-WiFi-adapteren, kan du i stedet tilslutte Pi'en til kablet ethernet med samme resultat.

- En Raspberry Pi 4B

  En model med 4 GB hukommelse er fin. Amazon har ofte uslåelige priser, eller du kan se forhandlerlisten på Raspberry Pi's websted:

    * [amazon.com](https://www.amazon.com/Raspberry-Model-2019-Quad-Bluetooth/dp/B07TC2BK1X/)
    * [amazon.de](https://www.amazon.de/-/en/Raspberry-ARM-Cortex-A72-WLAN-ac-Bluetooth-Micro-HDMI-Single/dp/B07TC2BK1X/)
    * [amazon.co.uk](https://www.amazon.co.uk/Raspberry-Pi-ARM-Cortex-A72-Bluetooth-Micro-HDMI/dp/B07TC2BK1X/)
    * [Raspberry Pi's forhandlerliste](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/?variant=raspberry-pi-4-model-b-4gb)

- MicroSD-hukommelseskort

  På MicroSD-kortet ligger Raspberry Pi'ens styresystem og datafiler. Jeg har haft gode erfaringer med Samsung Evo Plus-kort. Hukommelseskort er billige, og større kort er mere pålidelige i Raspberry Pi-brug, så køb mindst et på 64 GB:

  * [amazon.com](https://www.amazon.com/Samsung-MicroSDXC-Memory-Adapter-MB-MC64GA/dp/B06XFWPXYD/)
  * [amazon.de](https://www.amazon.de/-/en/Samsung-Flash-Memory-MicroSDXC-Class/dp/B08BKCB4JW/)
  * [amazon.co.uk](https://www.amazon.co.uk/Samsung-MicroSDXC-Class-UHS-I-Memory/dp/B08BKCB4JW/)

- Dobbeltklæbende tape eller smeltelim

  Et kort stykke dobbeltklæbende tape eller en klat smeltelim er nødvendig for at montere køleventilatoren.

- Krympeflex, 3 mm indvendig diameter

  Krympeflex med 3 mm indvendig diameter er ikke strengt nødvendigt, men det er nyttigt til at sikre de loddede ledninger til panelstikket.

- [NMEA 2000-hunstik](https://hatlabs.fi/product/nmea-2000-cable-plug/)

  Hvis du laver den første installation hjemme, er et ekstra NMEA 2000 micro-stik praktisk til at føre forsyningsspænding til enheden.

## Montering af hardwaren

### Boring af huller til stikkene

Som altid når man borer huller i et fejlfrit kabinet: planlæg meget omhyggeligt på forhånd. Panelstikkene fylder overraskende meget, og et hul kan ikke uden videre lappes, endsige flyttes.

Selv foretrækker jeg at måle kabinettet op og lave en boreskabelon i et vektortegneprogram. En tegning hjælper dig med at se de største mål, stikket og møtrikken kræver.

Hvis du ikke ved, hvilket program du skal bruge, er [Inkscape](https://inkscape.org) et godt alsidigt værktøj. Er du mere teknisk anlagt, kan CAD-software som [LibreCAD](https://librecad.org) også fungere.

Jeg ville have tre huller på plastkabinettets korte side. Her er den skabelon, jeg lavede:

<figure markdown="span">
![](assets/plastic-enclosure-end-template.svg){ width="50%" }
<figcaption><a href="assets/plastic-enclosure-end-template.svg">Eksempel på boreskabelon.</a></figcaption>
</figure>

[Skabelonen](assets/plastic-enclosure-end-template.svg) er en SVG-fil, altså vektorgrafik, så du kan gemme den og ændre den, som du vil.
Hvis du ikke ved, hvilket program du skal bruge, kan du prøve for eksempel [Inkscape](https://inkscape.org), som er nævnt ovenfor. Selv bruger jeg Affinity Designer, et billigt kommercielt designprogram til MacOS.

Har du problemer med at åbne SVG-filen, findes skabelonen også som [PDF](assets/plastic-enclosure-end-template.pdf).

Når skabelonen er færdig, markerer du centrum på kabinettet og taper skabelonen fast, så centrumpunkterne flugter.

<figure markdown="span">
![](assets/photos/01_drill-template.jpg){ width="50%" }
<figcaption>Boreskabelon på kassen.</figcaption>
</figure>


For at bore præcist hjælper det at markere hullernes centrum med en kørner (et skarpt søm og et let slag med hammeren går også an).

Bor styrehuller med et lille bor (omkring 3 mm). Brug derefter et trinbor til de endelige huller. Tag dig god tid, og hold lav hastighed. Mindre huller med skæve mål, som det på 6,5 mm, bør efterbehandles med et metalbor i tilsvarende størrelse.

Boring i plast efterlader mange grater omkring hullerne. Graterne fjerner du med en skarp kniv.

Til sidst kan de indbyggede afstandsbolte i plastkabinettet sidde i vejen for de huller, du har boret. Jeg måtte fjerne en af dem. Jeg brugte et Dremel-værktøj, men en kraftig tang virker sandsynligvis også.

Sådan ser slutresultatet ud i mit tilfælde.

<figure markdown="span">
![](assets/photos/02_drilled_holes.jpg){ width="50%" }
<figcaption>Borede huller.</figcaption>
</figure>


### Tilslutning af ledninger til NMEA 2000-panelstikket

Nu lodder vi JST XH-ledningssættene til NMEA 2000-panelstikket. Samme fremgangsmåde virker også til lodning af SP13-strømstik, hvis du vælger et af dem i stedet.
Vi begynder med at fylde stikkets loddekopper med tin.

<figure markdown="span">
![](assets/photos/021_soldered_cups.jpg){ width="50%" }
<figcaption>Loddede kopper.</figcaption>
</figure>


Vi vil forsyne både selve kortet og CAN-grænsefladen gennem NMEA 2000-stikket. Der er mere end én måde at gøre det på, men lad os tage den oplagte metode og forbinde begge ledningssæt til NMEA-panelstikket.

Afisoler et kort stykke af den røde og den sorte ledning, og sno dem sammen.

<figure markdown="span">
![](assets/photos/022_spliced_wires.jpg){ width="50%" }
<figcaption>Sammensnoede ledninger.</figcaption>
</figure>


Det anbefales at bruge krympeflex til at isolere stikbenene og give loddesamlingerne mekanisk støtte. Klip korte stykker krympeflex, og træk dem ind på ledningerne. (Gæt, hvem der glemte dette trin _igen_, mens billederne til vejledningen blev taget.)

Lod ledningerne fast i stikket, både de enkelte signalledninger og de sammensnoede forsyningsledninger.

Diagrammet nedenfor viser den rigtige benkonfiguration. Ja, det er et hanstik, men fordi vi kigger på stikket fra den forkerte ende, bruger vi diagrammet for det modsatte køn. (Ja, det er lidt forvirrende.)

<figure markdown="span">
![](assets/nmea_2000_female_pinout.png){ width="50%" }
<figcaption>Benkonfiguration for NMEA 2000 micro C-hunstik.</figcaption>
</figure>


Begynd med at lodde midterbenet. Det er lettere nu, hvor de andre ledninger endnu ikke flagrer omkring. Standardfarven for CAN_L-ledningen er blå, men i vores ledningssæt er den gul.

<figure markdown="span">
![](assets/photos/023_soldered_L.jpg){ width="50%" }
<figcaption>Midterbenet loddet.</figcaption>
</figure>


Lod derefter de tre øvrige ledninger fast. Skærmen forbindes ikke.

Sådan bør dit stik se ud på dette tidspunkt:

<figure markdown="span">
![](assets/photos/024_all_soldered.jpg){ width="50%" }
<figcaption>Alt loddet.</figcaption>
</figure>


Jeg går frimodigt ud fra, at du huskede at trække krympeflexstykkerne på, før du loddede ledningerne. Nu er det tid til at skubbe dem hen over loddesamlingerne og krympe dem med en varmepistol (eller flammen fra en lighter). Slutresultatet bør se nogenlunde sådan ud:

<figure markdown="span">
![](assets/photos/025_heat_shrink.jpg){ width="50%" }
<figcaption>Krympeflex påført.</figcaption>
</figure>


Skru det færdige NMEA 2000-panelstik fast i kabinettet.

Endnu et billede af et færdigt stik og benkonfigurationen:

<figure markdown="span">
![](assets/photos/n2k_connector_wiring_photo.jpg){ width="50%" }
<figcaption>Færdigt stik.</figcaption>
</figure>


### Tilslutning af de øvrige panelstik

Nu hvor den svære del er overstået, kan de andre stik skrues fast. For at gøre WiFi-antennestikket mere vandtæt kan du lægge en lille O-ring eller pakning omkring stikket, før du monterer det.

Til sidst bør du have dette:

<figure markdown="span">
![](assets/photos/03_connectors_in_place.jpg){ width="50%" }
<figcaption>Stikkene på plads.</figcaption>
</figure>


### Montering af SH-RPi

Nu skal Raspberry Pi'en monteres i kabinettet.
Vi bruger plastkabinettet og de monteringsadaptere, der bør være fulgt med kabinettet.

Først fastgør vi de korte afstandsbolte til monteringsadapterne med M2.5-møtrikkerne. Spænd dem godt til.

<figure markdown="span">
![](assets/photos/04_adapters_with_standoffs.jpg){ width="50%" }
<figcaption>Adaptere med afstandsbolte.</figcaption>
</figure>


Når afstandsboltene sidder på plads, kan adapterne monteres i kabinettet med de selvskærende skruer.

<figure markdown="span">
![](assets/photos/05_adapters_in_place.jpg){ width="50%" }
<figcaption>Adapterne monteret.</figcaption>
</figure>


Raspberry Pi'en placeres på afstandsboltene. Fastgør de øverste afstandsbolte med M2.5-skruerne og de nederste med to 16 mm sekskantede afstandsbolte.

<figure markdown="span">
![](assets/photos/06_rpi_mounted.jpg){ width="50%" }
<figcaption>Raspberry Pi monteret.</figcaption>
</figure>


Derefter kommer Sailor Hat. Tryk kortet ned på Raspberry Pi'ens GPIO-stikliste. Fastgør det med to M2.5-skruer.

**BEMÆRK**: Når du en dag skal tage HAT'en af, er det fristende at vippe den fra side til side. Det virker fint, men der er også en lille risiko for at bøje benene i hver ende af Pi'ens stikliste. Vip i stedet kortet op og ned, mens du forsigtigt trækker opad. Det går lidt langsommere, men kortet slipper med langt mindre risiko for bøjede ben.

På dette tidspunkt kan du også tilslutte alle USB-enheder og forbinde SH-RPi'ens strøm- og CAN-kabler. Bruger du en køleventilator, monterer du også den. Fastgør den med dobbeltklæbende tape eller en klat smeltelim ved siden af Raspberry Pi'en, med mærkatsiden vendt mod Pi'en.

Sådan ser den færdige montering ud:

<figure markdown="span">
![](assets/photos/07_sh-rpi_mounted.jpg){ width="50%" }
<figcaption>Sailor Hat monteret.</figcaption>
</figure>


Luk ikke låget endnu. Du skal stadig sætte hukommelseskortet i Pi'en.

## Software

I dette afsnit installerer vi OpenPlotter-softwaren på Raspberry Pi'en. OpenPlotter er en specialiseret maritim softwaredistribution, der bygger på Raspberry Pi OS. Den findes i mange varianter; i denne vejledning bruges en version uden skærm (headless), altså uden en skærm tilsluttet Raspberry Pi'en direkte. Til visning bruges i stedet browsere eller fjernskrivebordsforbindelser, hvilket giver en sikrere placering af serveren og skærme, hvor du har brug for dem.

### Installation af OpenPlotter

OpenPlotter installeres ved at skrive et styresystemimage til et MicroSD-kort og sætte kortet i Raspberry Pi'en.

Hent først [Raspberry Pi Imager](https://www.raspberrypi.org/software/). Imager er et letanvendeligt program, der skriver den hentede imagefil til hukommelseskortet.

**BEMÆRK:** Imager kan kun hentes til macOS, Windows og Ubuntu Linux. Bruger du et andet styresystem eller en anden Linux-distribution, skal du bruge et andet program til at flashe kortet (men så går jeg ud fra, at du udmærket ved, hvordan det gøres).

Installer Imager, når den er hentet.

Hent derefter [OpenPlotter-imaget](https://openplotter.readthedocs.io/en/latest/getting_started/downloading.html). Jeg bruger Headless-imaget i denne vejledning. Vil du hellere tilslutte en skærm til Pi'en, kan du tage Starting-imaget. Når imaget er hentet, skal det måske pakkes ud før flashning. Styresystemimaget er ret stort, så du bør have et par gigabyte fri plads på drevet.

Flash imaget til MicroSD-kortet. Sæt først kortet i en kortlæser, der er forbundet til computeren. Mange bærbare har også indbyggede SD-kortlæsere. Til dem bruger du den SD-adapter, der fulgte med kortet. Åbn derefter Imager. I styresystemmenuen vælger du »Use custom« nederst på listen og derefter den hentede imagefil.

[![](assets/screenshots/01_imager.jpg){ width="50%" }](assets/screenshots/01_imager.jpg)

Vælg så det rigtige MicroSD-kort med knappen Storage. For at undgå dyre fejl anbefaler jeg, at du fjerner alle andre flytbare medier fra computeren. Klik på Write. Her skal du måske indtaste din adgangskode, så Imager får lov til at skrive til MicroSD-kortet.

[![](assets/screenshots/02_imager_in_progress.jpg){ width="50%" }](assets/screenshots/02_imager_in_progress.jpg)

At skrive og verificere MicroSD-kortet tager lidt tid. Den tid kan vi bruge på at hente og installere [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/). VNC Viewer er et fjernskrivebordsprogram, som vi bruger til at tilgå OpenPlotter i de følgende afsnit.

Når MicroSD-kortet er færdigt, sætter du det i Raspberry Pi'ens MicroSD-kortplads. Du skal måske tage HAT'en af midlertidigt for at gøre det. (Ja, beklager, vejledningen er ikke 100 % konsekvent.)

Tænd til sidst for enheden. Det er ganske vist muligt at sætte et 5 V USB-C-kabel i Raspberry Pi'en, men det giver problemer, når du senere i vejledningen installerer SH-RPi-dæmonen. Brug derfor en 12 V-strømforsyning (alt mellem 10–32 V går faktisk an), og forbind den til et NMEA 2000-stik. Du kan også stikke korte hun-jumperledninger direkte i JST XH-stikkene og forbinde ledningerne til en strømforsyning med små krokodillenæb. Brug fantasien!

### Første konfiguration af OpenPlotter

På dette tidspunkt bør du have en enhed med masser af blinkende lys, men ingen måde at kommunikere med den på. Heldigvis findes der en vej ind. Ser du på de tilgængelige Wi-Fi-netværk omkring dig, bør du se et netværk med navnet »openplotter«:

[![](assets/screenshots/03_select_wifi.jpg){ width="50%" }](assets/screenshots/03_select_wifi.jpg)

Opret forbindelse til det netværk (adgangskoden er `12345678`).

Nu er du inden for Pi'ens rækkevidde. For at tilgå den bruger vi VNC Viewer, som vi installerede tidligere.

[![](assets/screenshots/04_vnc_viewer.jpg){ width="50%" }](assets/screenshots/04_vnc_viewer.jpg)

Skriv `openplotter.local` i adressefeltet på startskærmen (virker det ikke, så prøv IP-adressen `10.10.10.1`). Blev serveren fundet, mødes du af et billede til loginoplysninger:

[![](assets/screenshots/05_vnc_credentials.jpg){ width="50%" }](assets/screenshots/05_vnc_credentials.jpg)

Indtast brugernavnet `pi` og adgangskoden `raspberry`.

Gik alt godt, mødes du af et uberørt OpenPlotter-skrivebord:

[![](assets/screenshots/06_vnc_connected.jpg){ width="50%" }](assets/screenshots/06_vnc_connected.jpg)

Fremragende! Gå Pi'ens velkomstguide igennem. Du skal først indtaste en ny adgangskode og vælge land, sprog og andre grundindstillinger.

Har du tilsluttet en kompatibel USB-WiFi-dongle, skal du vælge et WiFi-netværk at forbinde til. Det er meget praktisk, for så kommer du på internettet og kan hente opdateringer og andet.

[![](assets/screenshots/07_pick_raspi_wifi.jpg){ width="50%" }](assets/screenshots/07_pick_raspi_wifi.jpg)

Bemærk, at hvis du ikke har en WiFi-adapter tilsluttet, kan den første opsætning afvige lidt fra beskrivelsen nedenfor.

Under den første opsætning opdaterer Pi'en systemsoftwaren. Det tager et stykke tid, så hent en kop kaffe, eller leg med din partner, dine børn eller dine kæledyr.

[![](assets/screenshots/08_update.jpg){ width="50%" }](assets/screenshots/08_update.jpg)

Når opsætningen er færdig, genstarter du Pi'en. Du var forbundet til Pi'ens WiFi-adgangspunkt, så computerens netværksforbindelse skifter nu tilbage til dit almindelige WiFi. Har du USB-WiFi-adapteren og satte Pi'en op til samme netværk, kan du stadig tilgå den på samme adresse, `openplotter.local`. Kan du se, hvorfor jeg anbefalede den ekstra WiFi-adapter? Ellers skal du forbinde til »openplotter«-netværket igen, så snart det dukker op.

[![](assets/screenshots/09_basic_setup_complete.jpg){ width="50%" }](assets/screenshots/09_basic_setup_complete.jpg)

Nå. Gå tilbage til VNC Viewer, og opret forbindelse til `openplotter.local`. Du ændrede adgangskoden for brugeren `pi` under den første konfiguration, så du skal indtaste den nye adgangskode i VNC Viewer.

Når du er inde igen, ændrer vi netværksindstillingerne i OpenPlotter-installationen. Vælg OpenPlotter -> Network i Raspberry-menuen.

(Når du åbner Network-appen, klager den måske over, at den vil konfigurere systemet om. Lad den gøre det, og åbn appen igen, når den er færdig.)

[![](assets/screenshots/11_open_openplotter_network.jpg){ width="50%" }](assets/screenshots/11_open_openplotter_network.jpg)

I netværkspanelet ser du de tilgængelige netværksenheder til venstre og indstillingerne for adgangspunktet til højre.

Vil du ikke have et adgangspunkt, vælger du »none« i menuen til venstre. Vil du beholde adgangspunktet (og det anbefaler jeg, for det giver dig en reservevej ind i Pi'en), er det vigtigt at ændre netværkets adgangskode:

[![](assets/screenshots/14_openplotter_network_password.jpg){ width="50%" }](assets/screenshots/14_openplotter_network_password.jpg)

Indstillingerne for WiFi-klienten finder du under WiFi-symbolet i øverste højre hjørne af OpenPlotter-skrivebordet. Der konfigurerer du yderligere netværk, for eksempel bådens WiFi-adgangspunkt.

[![](assets/screenshots/16_wifi_client_settings.jpg){ width="50%" }](assets/screenshots/16_wifi_client_settings.jpg)

Genstart OpenPlotter, når du har ændret netværksindstillingerne.

### Installation af SH-RPi-dæmonen

Nu hvor det mest presserende er overstået, er det tid til at installere SH-RPi-dæmonen. ([Dæmoner](https://en.wikipedia.org/wiki/Daemon_(computing)#Etymology) er velvillige ånder, der er med til at forme et menneskes karakter eller personlighed. Eller i dette tilfælde baggrundstjenester i UNIX-beslægtede styresystemer.) Vi kunne bruge VNC Viewer til det ved at åbne Accessories -> Terminal i Raspberry-menuen, og det anbefaler jeg Windows-brugere at gøre, men for Mac- og Linux-brugere viser jeg, hvordan man tilgår OpenPlotter-enheden over SSH.

Først en lille afstikker. I stedet for bare at logge ind med ssh kopierer vi først vores offentlige SSH-nøgle til enheden med `ssh-copy-id`. Så kan efterfølgende logins ske uden adgangskode.

Mac-brugere skal måske installere `ssh-copy-id` først. Det findes via [Homebrew](https://brew.sh/) — har du ikke installeret det endnu, så gør det! Det er glimrende! Når du har det, kører du:

    brew install ssh-copy-id

Linux-brugere er derimod forkælede og har allerede `ssh-copy-id` forudinstalleret.

Kopier derefter den offentlige nøgle:

    ssh-copy-id pi@openplotter.local

Så er det klaret! Nu kan du logge ind på Pi'en uden adgangskode. Jeg anbefaler denne metode på alle systemer, du tilgår eksternt — den er sikrere end adgangskoder.

[![](assets/screenshots/18_ssh.jpg){ width="50%" }](assets/screenshots/18_ssh.jpg)

Når du er logget ind med `ssh pi@openplotter.local`, indsætter du installationskommandoen i kommandoprompten:

    curl -L \
    https://raw.githubusercontent.com/hatlabs/SH-RPi-daemon/main/install.sh \
    | sudo bash

Har du et relativt urørt system, foretager denne kommando de nødvendige konfigurationsændringer og installerer dæmonsoftwaren automatisk. Det tager kun få sekunder. Alt, hvad du skal gøre, er at genstarte manuelt, når installationen er færdig:

    sudo reboot

Hold øje med SH-RPi'ens lysdioder under genstarten. RX-lysdioden har lyst konstant grønt og statuslysdioden konstant rødt, men efter genstarten blinker RX-lysdioden lystigt (forudsat at der er trafik på NMEA 2000-bussen), og statuslysdioden lyser rødt, men blinker kort hvert sekund. Ændringerne viser, at CAN-grænsefladen og dæmonens watchdog er aktive. Sådan.

Når du forbinder til VNC efter genstarten, ser du følgende meddelelse:

[![](assets/screenshots/20_after_reboot.jpg){ width="50%" }](assets/screenshots/20_after_reboot.jpg)

Det betyder, at vi nu har en aktiv CAN-grænseflade, men at den endnu ikke er konfigureret i [Signal K](https://signalk.org). Det gør vi i næste afsnit.

### Konfiguration af Signal K til at modtage NMEA 2000-trafik

For at kunne behandle NMEA 2000-data skal Signal K konfigureres til at modtage dem. Åbn Signal K-dashboardet på [http://openplotter.local:3000/](http://openplotter.local:3000/).

For at kunne gøre noget som helst på serveren skal du aktivere sikkerhed og oprette en administratorbruger. Klik på knappen »Login« øverst til højre:

[![](assets/screenshots/21_sk_server_dashboard.jpg){ width="50%" }](assets/screenshots/21_sk_server_dashboard.jpg)

Du bliver bedt om at oprette en ny administratorbruger. Jeg foretrækker `admin` som brugernavn og derefter en passende, letforståelig og letskrevet adgangskode. Dette er kun tilgængeligt fra dit interne netværk.

Derefter vil du måske opgradere SK-serveren:

[![](assets/screenshots/23_update_server.jpg){ width="50%" }](assets/screenshots/23_update_server.jpg)

Når det er gjort, kan vi komme til sagen og aktivere `can0` på serveren. Gå til Data Connections, og klik på knappen Add:

[![](assets/screenshots/26_data_connections_add.jpg){ width="50%" }](assets/screenshots/26_data_connections_add.jpg)

Konfigurer derefter forbindelsen som nedenfor, rul ned, og klik på Submit:

[![](assets/screenshots/28_correct_settings.jpg){ width="50%" }](assets/screenshots/28_correct_settings.jpg)

Når du har tilføjet dataforbindelsen, genstarter du serveren igen. Nu bør dashboardet vise lidt forbindelsesaktivitet:

[![](assets/screenshots/30_can0_activity.jpg){ width="50%" }](assets/screenshots/30_can0_activity.jpg)

Sådan. Tid til at lykønske dig selv. Du er nået langt!

Vil du, kan du også åbne Data Browser i menuen til venstre og se, hvilke data du modtager.

### Oprettelse af instrumentpaneler

Modtager du data, kan du allerede visualisere dem ved at åbne SK Instrument Panel:

[![](assets/screenshots/301_sk_plugins.jpg){ width="50%" }](assets/screenshots/301_sk_plugins.jpg)

Du kan konfigurere stier med skruenøgleknappen. Panelernes størrelse og placering justerer du ved at klikke på låseknappen.

Mit testlaboratorium ligger lige under et bliktag helt uden GPS-dækning, og de eneste interessante data på mit netværk kommer fra [1-Wire-temperatursensoren](https://docs.hatlabs.fi/sh-esp32/pages/tutorials/onewire-temperature/). Mit instrumentpanel består derfor nu af tre temperaturværdier:

[![](assets/screenshots/302_sk_instrument_panel.jpg){ width="50%" }](assets/screenshots/302_sk_instrument_panel.jpg)

Lidt trist, men samtidig spændende!

Ud over den almindelige Instrument Panel findes der mange rigtig gode dashboardapplikationer til Signal K. Du kan prøve [KIP](https://github.com/mxtommy/Kip) (findes i SK-serverens appbutik) eller [Wilhelm SK](https://www.wilhelmsk.com/) (kun til iOS-enheder, findes i App Store).

### Installation af InfluxDB og Grafana

I vejledningens sidste trin installerer og konfigurerer vi InfluxDB og Grafana for at skabe en historisk log og visualiseringer af bådens data. Det er et par trin mere og nogle skærmbilleder, der ser travle ud, men den lille indsats er det værd!

InfluxDB er en tidsseriedatabase, som vi bruger til at gemme data. Grafana er et visualiseringsværktøj, der ofte bruges til at overvåge IT-systemers tilstand, men som takket være sin alsidighed også kan bruges til vores maritime data.

For at installere InfluxDB og Grafana går du tilbage til VNC Viewer og åbner OpenPlotter -> Dashboards i Raspberry-menuen:

[![](assets/screenshots/31_openplotter_dashboards.jpg){ width="50%" }](assets/screenshots/31_openplotter_dashboards.jpg)

Vælg InfluxDB, og klik på Install. Det tager et stykke tid, men når det er færdigt, går du tilbage til fanen Apps, vælger Grafana og klikker på Install. Så er det klaret.

[![](assets/screenshots/32_install.jpg){ width="50%" }](assets/screenshots/32_install.jpg)

Derefter skal vi oprette en ny database i InfluxDB. Åbn Chronograf, InfluxDB's webgrænseflade, i browseren: [http://openplotter.local:8889/](http://openplotter.local:8889/).

[![](assets/screenshots/34_open_chronograf.jpg){ width="50%" }](assets/screenshots/34_open_chronograf.jpg)


Klik dig gennem den første konfiguration. Chronografs InfluxDB-forbindelse bruger brugernavnet `admin` og adgangskoden `admin`. Du kan springe oprettelsen af dashboards og konfigurationen af Kapacitor over.

Opret derefter den nye database på skærmbilledet InfluxDB Admin:

[![](assets/screenshots/37_create_signalk_db.jpg){ width="50%" }](assets/screenshots/37_create_signalk_db.jpg)

Giv databasen navnet `signalk`, og klik dig ellers bare igennem. Færdig.

Nu hvor databasen venter på os, skal vi fodre den med data. Gå tilbage til Signal K-dashboardet for at konfigurere InfluxDB-skrivepluginnet:

[![](assets/screenshots/39_sk_plugin_config.jpg){ width="50%" }](assets/screenshots/39_sk_plugin_config.jpg)

Lad brugernavn og adgangskode stå tomme. Vores database hed `signalk`. Vil du, kan du ændre skriveintervallet for batchskrivninger og dataopløsningen. Intervallet er som standard 10 sekunder, men vil du have data vist tættere på realtid, indtaster du 2. Opløsningen bestemmer, hvor ofte en enkelt måling skrives til databasen. Standardværdien på 200 ms er sandsynligvis fin, men jeg ville have endnu mere og valgte 100 ms. Sæt også flueben som vist nedenfor.

[![](assets/screenshots/40_settings.jpg){ width="50%" }](assets/screenshots/40_settings.jpg)

Rul ned, og klik på Submit for at anvende konfigurationen. Nu bør der strømme målinger ind i databasen. Lad os kontrollere det. Gå tilbage til Chronograf, og vælg visningen Explore. Nederst bør du have en kilde ved navn `signalk.autogen`. Vælg den, hvorefter navnene på de enkelte målinger bør dukke op. Fremragende.

[![](assets/screenshots/41_verify_data.jpg){ width="50%" }](assets/screenshots/41_verify_data.jpg)

Det eneste, der mangler, er at visualisere de historiske data.

### Oprettelse af et Grafana-eksempeldashboard

Vi bruger Grafana til at vise nogle flotte grafer. Åbn Grafana i browseren: [http://openplotter.local:3001](http://openplotter.local:3001).

[![](assets/screenshots/42_open_grafana.jpg){ width="50%" }](assets/screenshots/42_open_grafana.jpg)

Grafana kræver, at der indtastes en ny adgangskode, så gør det. Når du kommer til startskærmen, konfigurerer du InfluxDB som datakilde:

[![](assets/screenshots/44_grafana_data_sources.jpg){ width="50%" }](assets/screenshots/44_grafana_data_sources.jpg)

I konfigurationen vises standardadressen i mørkegråt, men jeg oplevede, at jeg var nødt til at skrive den ind manuelt. Ellers er det igen den samme `signalk`-database og tomt brugernavn og adgangskode. Klik på »Save and Test« for at kontrollere, at din datakilde virker.

[![](assets/screenshots/46_config_data_source.jpg){ width="50%" }](assets/screenshots/46_config_data_source.jpg)

Lad os på dette tidspunkt opsummere, hvad vi har. Signal K modtager data fra NMEA 2000, InfluxDB gemmer dem, og Grafana er forbundet til InfluxDB. Til sidst kan vi oprette et Grafana-dashboard og tilføje nye datapaneler.

Paneleditoren ser lidt travl ud, men grundtrinnene er ligetil.

[![](assets/screenshots/54_panel_title.jpg){ width="50%" }](assets/screenshots/54_panel_title.jpg)

Rediger forespørgslen. Vælg først en måling i rækken FROM. Dernæst skal du tilføje en matematisk modifikator for at omregne måleenhederne (Grafana kender ikke rigtig til enheder, så som standard vises data altid i de SI-enheder, de er gemt i). For at komme fra kelvin til grader Celsius trækker du for eksempel -273.15 fra. Eller for at gå fra m/s til knob ganger du med 3600 og dividerer med 1852.

Afslut panelet ved at give det en titel og anvende ændringerne.

Nu bør du have et enkelt panel med lidt tidsdata synligt i dit dashboard. Tilføj et par paneler mere med knappen Add Panel. Du kan flytte panelerne og ændre deres størrelse ved at trække i titler og hjørner. Til sidst kan du vælge et passende tidsinterval i den øverste bjælke og gemme dashboardet.

Sådan ser mit færdige dashboard over motortemperatur ud:

[![](assets/screenshots/56_two_more_panels.jpg){ width="50%" }](assets/screenshots/56_two_more_panels.jpg)

Det var det. Gå ud og lav fantastiske dashboards, og vis dem til vennerne i havnen og sejlklubben! Del dem også gerne på [Hat Labs' diskussionsforum](https://github.com/hatlabs/discussions/discussions) til inspiration!


</div>
