---
title: Installasjon av OpenPlotter-server
translated_from: 3eb95fa3d5c4e946a6ee74c23585b9b432d39c4e
---

!!! warning
    Denne delen er ennå ikke oppdatert til endringene i v2-maskinvaren.

<div style="-moz-filter: opacity(30%); -webkit-filter: opacity(30%); filter: opacity(30%);">

## Innledning

I denne veiledningen bygger vi en OpenPlotter-server med [Sailor Hat for Raspberry Pi](https://docs.hatlabs.fi/sh-rpi/) ([kjøpslenke](https://hatlabs.fi/product/sh-rpi-enclosure-kit/)) og OpenPlotter-programvaren.
Serveren er kompakt og vanntett og forsynes enkelt fra båtens 12/24 V-anlegg.
Den lar seg også lett integrere med båtens eksisterende elektronikk.

Programvaren som følger med, logger all vesentlig NMEA 2000-trafikk om bord, og lar deg se hvordan ulike verdier oppfører seg både i sanntid og historisk, ved hjelp av innebygde instrumentpaneler og Grafana-dashbord.
Serveren kan dessuten motta og behandle informasjon fra andre kilder, for eksempel [SH-ESP32-sensorenheter](https://docs.hatlabs.fi/sh-esp32/) eller ulike internettjenester.

Noen eksempler på visualiseringer:

<figure markdown="span">
![](assets/screenshots/001_examples.jpg){ width="75%" }
<figcaption>Eksempler på visualiseringer.</figcaption>
</figure>

## Deler du trenger

For å gjennomføre denne veiledningen trenger du følgende deler:

- [SH-RPi kabinettsett](https://hatlabs.fi/product/sh-rpi-enclosure-kit/)

  SH-RPi er den hemmelige ingrediensen som gir Raspberry Pi-en maskinvaregrensesnittene båtens systemer krever. Kortet har en innebygd, beskyttet 12/24 V-strømforsyning med sikker nedstenging, og et galvanisk skilt NMEA 2000-kompatibelt CAN-grensesnitt.

  I denne veiledningen bruker vi plastkabinettet og forsyner Pi-en gjennom en NMEA 2000-panelkontakt. I tillegg brukes en USB type A-panelkontakt for enklere tilkobling ved behov, og en kjølevifte legges til for bedre varmeavledning. Du står fritt til å tilpasse ditt eget oppsett.

  Vi bruker også en ekstra USB-WiFi-adapter, fordi det gjør installasjonen enklere (det ekstra nettverksgrensesnittet kan komme godt med om bord også). Vil du ikke ha USB-WiFi-adapteren, kan du i stedet koble Pi-en til kablet ethernet med samme resultat.

- En Raspberry Pi 4B

  En modell med 4 GB minne holder fint. Amazon har ofte uslåelige priser, eller du kan se forhandlerlisten på nettstedet til Raspberry Pi:

    * [amazon.com](https://www.amazon.com/Raspberry-Model-2019-Quad-Bluetooth/dp/B07TC2BK1X/)
    * [amazon.de](https://www.amazon.de/-/en/Raspberry-ARM-Cortex-A72-WLAN-ac-Bluetooth-Micro-HDMI-Single/dp/B07TC2BK1X/)
    * [amazon.co.uk](https://www.amazon.co.uk/Raspberry-Pi-ARM-Cortex-A72-Bluetooth-Micro-HDMI/dp/B07TC2BK1X/)
    * [Forhandlerlisten til Raspberry Pi](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/?variant=raspberry-pi-4-model-b-4gb)

- MicroSD-minnekort

  På MicroSD-kortet ligger operativsystemet og datafilene til Raspberry Pi-en. Jeg har hatt gode erfaringer med Samsung Evo Plus-kort. Minnekort er billige, og større kort er mer pålitelige i Raspberry Pi-bruk, så skaff deg minst ett på 64 GB:

  * [amazon.com](https://www.amazon.com/Samsung-MicroSDXC-Memory-Adapter-MB-MC64GA/dp/B06XFWPXYD/)
  * [amazon.de](https://www.amazon.de/-/en/Samsung-Flash-Memory-MicroSDXC-Class/dp/B08BKCB4JW/)
  * [amazon.co.uk](https://www.amazon.co.uk/Samsung-MicroSDXC-Class-UHS-I-Memory/dp/B08BKCB4JW/)

- Dobbeltsidig teip eller smeltelim

  En kort bit dobbeltsidig teip eller en klatt smeltelim trengs for å montere kjøleviften.

- Krympestrømpe, 3 mm innvendig diameter

  Krympestrømpe med 3 mm innvendig diameter er ikke strengt nødvendig, men den er nyttig for å sikre de loddede lederne til panelkontakten.

- [NMEA 2000-hunnkontakt](https://hatlabs.fi/product/nmea-2000-cable-plug/)

  Gjør du den første installasjonen hjemme, er en ekstra NMEA 2000 micro-kontakt praktisk for å føre forsyningsspenning til enheten.

## Montering av maskinvaren

### Boring av hull til kontaktene

Som alltid når man borer hull i et feilfritt kabinett: planlegg svært nøye på forhånd. Panelkontaktene tar overraskende mye plass, og et hull kan ikke uten videre tettes, langt mindre flyttes.

Selv foretrekker jeg å måle opp kabinettet og lage en boremal i et vektortegneprogram. En tegning hjelper deg å se de største målene kontakten og mutteren krever.

Vet du ikke hvilket program du skal bruke, er [Inkscape](https://inkscape.org) et godt allsidig verktøy. Er du mer teknisk anlagt, kan CAD-programvare som [LibreCAD](https://librecad.org) også fungere.

Jeg ville ha tre hull på kortsiden av plastkabinettet. Her er malen jeg laget:

<figure markdown="span">
![](assets/plastic-enclosure-end-template.svg){ width="50%" }
<figcaption><a href="assets/plastic-enclosure-end-template.svg">Eksempel på boremal.</a></figcaption>
</figure>

[Malen](assets/plastic-enclosure-end-template.svg) er en SVG-fil, altså vektorgrafikk, så du kan lagre den og endre den slik du vil.
Vet du ikke hvilket program du skal bruke, kan du prøve for eksempel [Inkscape](https://inkscape.org), som er nevnt ovenfor. Selv bruker jeg Affinity Designer, et rimelig kommersielt designprogram for MacOS.

Har du problemer med å åpne SVG-filen, finnes malen også som [PDF](assets/plastic-enclosure-end-template.pdf).

Når malen er ferdig, merker du av midtpunktet på kabinettet og teiper malen fast slik at midtpunktene faller sammen.

<figure markdown="span">
![](assets/photos/01_drill-template.jpg){ width="50%" }
<figcaption>Boremal på boksen.</figcaption>
</figure>


For å bore nøyaktig hjelper det å merke av hullsentrene med en kjørner (en skarp spiker og et lett slag med hammeren går også bra).

Bor styrehull med et lite bor (omtrent 3 mm). Bruk deretter et trinnbor til de endelige hullene. Ta deg god tid, og hold lav hastighet. Mindre hull med skjeve mål, som det på 6,5 mm, bør etterbehandles med et metallbor i tilsvarende størrelse.

Boring i plast etterlater mye grader rundt hullene. Gradene fjerner du med en skarp kniv.

Til slutt kan de innebygde avstandsboltene i plastkabinettet stå i veien for hullene du har boret. Jeg måtte fjerne en av dem. Jeg brukte et Dremel-verktøy, men en kraftig tang fungerer nok også.

Slik ser sluttresultatet ut i mitt tilfelle.

<figure markdown="span">
![](assets/photos/02_drilled_holes.jpg){ width="50%" }
<figcaption>Borede hull.</figcaption>
</figure>


### Tilkobling av ledere til NMEA 2000-panelkontakten

Nå lodder vi JST XH-ledningssettene til NMEA 2000-panelkontakten. Samme framgangsmåte fungerer også for lodding av SP13-strømkontakter dersom du velger en slik i stedet.
Vi begynner med å fylle loddekoppene i kontakten med tinn.

<figure markdown="span">
![](assets/photos/021_soldered_cups.jpg){ width="50%" }
<figcaption>Loddede kopper.</figcaption>
</figure>


Vi vil forsyne både selve kortet og CAN-grensesnittet gjennom NMEA 2000-kontakten. Det finnes mer enn én måte å gjøre det på, men la oss ta den åpenbare metoden og koble begge ledningssettene til NMEA-panelkontakten.

Avisoler en kort bit av den røde og den svarte lederen, og tvinn dem sammen.

<figure markdown="span">
![](assets/photos/022_spliced_wires.jpg){ width="50%" }
<figcaption>Sammentvinnede ledere.</figcaption>
</figure>


Det anbefales å bruke krympestrømpe for å isolere kontaktpinnene og gi loddeskjøtene mekanisk støtte. Klipp korte biter krympestrømpe, og træ dem inn på lederne. (Gjett hvem som glemte dette trinnet _igjen_ mens bildene til veiledningen ble tatt.)

Lodd lederne fast i kontakten, både de enkelte signallederne og de sammentvinnede forsyningslederne.

Diagrammet nedenfor viser riktig pinnekonfigurasjon. Ja, det er en hannkontakt, men fordi vi ser på kontakten fra feil ende, bruker vi diagrammet for det motsatte kjønnet. (Ja, det er litt forvirrende.)

<figure markdown="span">
![](assets/nmea_2000_female_pinout.png){ width="50%" }
<figcaption>Pinnekonfigurasjon for NMEA 2000 micro C-hunnkontakt.</figcaption>
</figure>


Begynn med å lodde midtpinnen. Det er lettere nå som de andre lederne ennå ikke er i veien. Standardfargen for CAN_L-lederen er blå, men i vårt ledningssett er den gul.

<figure markdown="span">
![](assets/photos/023_soldered_L.jpg){ width="50%" }
<figcaption>Midtpinnen loddet.</figcaption>
</figure>


Lodd deretter de tre andre lederne på plass. Skjermen kobles ikke til.

Slik bør kontakten din se ut på dette tidspunktet:

<figure markdown="span">
![](assets/photos/024_all_soldered.jpg){ width="50%" }
<figcaption>Alt loddet.</figcaption>
</figure>


Jeg går frimodig ut fra at du husket å træ på krympestrømpebitene før du loddet lederne. Nå er det på tide å skyve dem over loddeskjøtene og krympe dem med en varmepistol (eller flammen fra en lighter). Sluttresultatet bør se omtrent slik ut:

<figure markdown="span">
![](assets/photos/025_heat_shrink.jpg){ width="50%" }
<figcaption>Krympestrømpe påført.</figcaption>
</figure>


Skru den ferdige NMEA 2000-panelkontakten fast i kabinettet.

Enda et bilde av en ferdig kontakt og pinnekonfigurasjonen:

<figure markdown="span">
![](assets/photos/n2k_connector_wiring_photo.jpg){ width="50%" }
<figcaption>Ferdig kontakt.</figcaption>
</figure>


### Tilkobling av de andre panelkontaktene

Nå som den vanskelige delen er unnagjort, kan de andre kontaktene skrus fast. For å gjøre WiFi-antennekontakten mer vanntett kan du legge en liten O-ring eller pakning rundt kontakten før du monterer den.

Til slutt bør du ha dette:

<figure markdown="span">
![](assets/photos/03_connectors_in_place.jpg){ width="50%" }
<figcaption>Kontaktene på plass.</figcaption>
</figure>


### Montering av SH-RPi

Nå skal Raspberry Pi-en monteres i kabinettet.
Vi bruker plastkabinettet og monteringsadapterne som skal ha fulgt med kabinettet.

Først fester vi de korte avstandsboltene til monteringsadapterne med M2.5-mutterne. Trekk dem godt til.

<figure markdown="span">
![](assets/photos/04_adapters_with_standoffs.jpg){ width="50%" }
<figcaption>Adaptere med avstandsbolter.</figcaption>
</figure>


Når avstandsboltene sitter på plass, kan adapterne monteres i kabinettet med de selvskjærende skruene.

<figure markdown="span">
![](assets/photos/05_adapters_in_place.jpg){ width="50%" }
<figcaption>Adapterne montert.</figcaption>
</figure>


Raspberry Pi-en plasseres på avstandsboltene. Fest de øverste avstandsboltene med M2.5-skruene og de nederste med to 16 mm sekskantede avstandsbolter.

<figure markdown="span">
![](assets/photos/06_rpi_mounted.jpg){ width="50%" }
<figcaption>Raspberry Pi montert.</figcaption>
</figure>


Deretter kommer Sailor Hat. Trykk kortet ned på GPIO-pinnelisten til Raspberry Pi-en. Fest det med to M2.5-skruer.

**MERK**: Når du en gang skal ta av HAT-kortet, er det fristende å vrikke det sidelengs. Det fungerer godt, men det er også en liten risiko for å bøye pinnene i hver ende av pinnelisten på Pi-en. Vrikk i stedet kortet opp og ned mens du forsiktig drar oppover. Det går litt saktere, men kortet løsner med langt mindre risiko for bøyde pinner.

På dette tidspunktet kan du også koble til alle USB-enhetene og strøm- og CAN-kablene til SH-RPi. Bruker du en kjølevifte, monterer du den også. Fest den med dobbeltsidig teip eller en klatt smeltelim ved siden av Raspberry Pi-en, med klistremerkesiden vendt mot Pi-en.

Slik ser den ferdige monteringen ut:

<figure markdown="span">
![](assets/photos/07_sh-rpi_mounted.jpg){ width="50%" }
<figcaption>Sailor Hat montert.</figcaption>
</figure>


Ikke lukk lokket ennå. Du må fortsatt sette minnekortet i Pi-en.

## Programvare

I denne delen installerer vi OpenPlotter-programvaren på Raspberry Pi-en. OpenPlotter er en spesialisert maritim programvaredistribusjon som bygger på Raspberry Pi OS. Den finnes i mange varianter; i denne veiledningen brukes en versjon uten skjerm (headless), altså uten en skjerm koblet direkte til Raspberry Pi-en. Til visning brukes i stedet nettlesere eller eksterne skrivebordstilkoblinger, noe som gir sikrere plassering av serveren og skjermer der du trenger dem.

### Installasjon av OpenPlotter

OpenPlotter installeres ved å skrive et systembilde til et MicroSD-kort og sette kortet i Raspberry Pi-en.

Last først ned [Raspberry Pi Imager](https://www.raspberrypi.org/software/). Imager er et lettbrukt program som skriver den nedlastede bildefilen til minnekortet.

**MERK:** Imager kan bare lastes ned for macOS, Windows og Ubuntu Linux. Bruker du et annet operativsystem eller en annen Linux-distribusjon, må du bruke et annet program for å flashe kortet (men da går jeg ut fra at du godt vet hvordan det gjøres).

Installer Imager når den er lastet ned.

Last deretter ned [OpenPlotter-systembildet](https://openplotter.readthedocs.io/en/latest/getting_started/downloading.html). Jeg bruker Headless-bildet i denne veiledningen. Vil du heller koble en skjerm til Pi-en, kan du ta Starting-bildet. Når bildet er lastet ned, må det kanskje pakkes ut før flashing. Systembildet er ganske stort, så du bør ha noen gigabyte ledig plass på disken.

Flash bildet til MicroSD-kortet. Sett først kortet i en kortleser som er koblet til datamaskinen. Mange bærbare har også innebygde SD-kortlesere. Til dem bruker du SD-adapteren som fulgte med kortet. Åpne deretter Imager. I operativsystemmenyen velger du «Use custom» nederst i listen, og deretter den nedlastede bildefilen.

[![](assets/screenshots/01_imager.jpg){ width="50%" }](assets/screenshots/01_imager.jpg)

Velg så riktig MicroSD-kort med knappen Storage. For å unngå kostbare feil anbefaler jeg at du kobler fra alle andre flyttbare medier på datamaskinen. Klikk på Write. Her må du kanskje oppgi passordet ditt for at Imager skal få skrive til MicroSD-kortet.

[![](assets/screenshots/02_imager_in_progress.jpg){ width="50%" }](assets/screenshots/02_imager_in_progress.jpg)

Å skrive og verifisere MicroSD-kortet tar litt tid. Den tiden kan vi bruke til å laste ned og installere [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/). VNC Viewer er et program for eksternt skrivebord som vi bruker for å nå OpenPlotter i de neste delene.

Når MicroSD-kortet er ferdig, setter du det i MicroSD-kortsporet på Raspberry Pi-en. Du må kanskje ta av HAT-kortet midlertidig for å få gjort det. (Ja, beklager, veiledningen er ikke 100 % konsekvent.)

Slå til slutt på enheten. Det er riktignok mulig å sette en 5 V USB-C-kabel i Raspberry Pi-en, men det gir problemer når du senere i veiledningen installerer SH-RPi-daemonen. Bruk derfor en 12 V-strømforsyning (alt mellom 10–32 V går faktisk bra), og koble den til en NMEA 2000-kontakt. Du kan også sette korte hunn-koblingsledninger rett i JST XH-kontaktene og koble lederne til en strømforsyning med små krokodilleklemmer. Bruk fantasien!

### Første konfigurasjon av OpenPlotter

På dette tidspunktet bør du ha en enhet med mange blinkende lys, men ingen måte å kommunisere med den på. Heldigvis finnes det en vei inn. Ser du på de tilgjengelige Wi-Fi-nettverkene rundt deg, bør du se et nettverk som heter «openplotter»:

[![](assets/screenshots/03_select_wifi.jpg){ width="50%" }](assets/screenshots/03_select_wifi.jpg)

Koble til det nettverket (passordet er `12345678`).

Nå er du innenfor rekkevidden til Pi-en. For å nå den bruker vi VNC Viewer, som vi installerte tidligere.

[![](assets/screenshots/04_vnc_viewer.jpg){ width="50%" }](assets/screenshots/04_vnc_viewer.jpg)

Skriv `openplotter.local` i adressefeltet på startskjermen (virker ikke det, kan du prøve IP-adressen `10.10.10.1`). Ble serveren funnet, møtes du av et bilde for påloggingsinformasjon:

[![](assets/screenshots/05_vnc_credentials.jpg){ width="50%" }](assets/screenshots/05_vnc_credentials.jpg)

Skriv inn brukernavnet `pi` og passordet `raspberry`.

Gikk alt bra, møtes du av et urørt OpenPlotter-skrivebord:

[![](assets/screenshots/06_vnc_connected.jpg){ width="50%" }](assets/screenshots/06_vnc_connected.jpg)

Utmerket! Gå gjennom velkomstveiviseren til Pi-en. Du må først skrive inn et nytt passord og velge land, språk og andre grunninnstillinger.

Har du koblet til en kompatibel USB-WiFi-adapter, må du velge et WiFi-nettverk å koble til. Det er svært praktisk, for da kommer du på internett og kan laste ned oppdateringer og annet.

[![](assets/screenshots/07_pick_raspi_wifi.jpg){ width="50%" }](assets/screenshots/07_pick_raspi_wifi.jpg)

Merk at dersom du ikke har en WiFi-adapter tilkoblet, kan det første oppsettet avvike litt fra beskrivelsen nedenfor.

Under det første oppsettet oppdaterer Pi-en systemprogramvaren. Det tar en stund, så hent deg en kopp kaffe, eller lek med partneren, barna eller kjæledyrene dine.

[![](assets/screenshots/08_update.jpg){ width="50%" }](assets/screenshots/08_update.jpg)

Når oppsettet er ferdig, starter du Pi-en på nytt. Du var koblet til WiFi-aksesspunktet på Pi-en, så nettverkstilkoblingen på datamaskinen går nå tilbake til det vanlige WiFi-nettverket ditt. Har du USB-WiFi-adapteren og satte opp Pi-en på samme nettverk, når du den fortsatt på den samme adressen, `openplotter.local`. Skjønner du nå hvorfor jeg anbefalte den ekstra WiFi-adapteren? Ellers må du koble deg til «openplotter»-nettverket på nytt så snart det dukker opp igjen.

[![](assets/screenshots/09_basic_setup_complete.jpg){ width="50%" }](assets/screenshots/09_basic_setup_complete.jpg)

Uansett. Gå tilbake til VNC Viewer, og koble til `openplotter.local`. Du endret passordet til brukeren `pi` under den første konfigurasjonen, så du må skrive inn det nye passordet i VNC Viewer.

Når du er inne igjen, endrer vi nettverksinnstillingene i OpenPlotter-installasjonen. Velg OpenPlotter -> Network i Raspberry-menyen.

(Når du åpner Network-appen, klager den kanskje på at den vil konfigurere systemet på nytt. La den gjøre det, og åpne appen igjen når den er ferdig.)

[![](assets/screenshots/11_open_openplotter_network.jpg){ width="50%" }](assets/screenshots/11_open_openplotter_network.jpg)

I nettverkspanelet ser du de tilgjengelige nettverksenhetene til venstre og innstillingene for aksesspunktet til høyre.

Vil du ikke ha et aksesspunkt, velger du «none» i menyen til venstre. Vil du beholde aksesspunktet (og det anbefaler jeg, siden det gir deg en reservevei inn i Pi-en), er det viktig å endre nettverkspassordet:

[![](assets/screenshots/14_openplotter_network_password.jpg){ width="50%" }](assets/screenshots/14_openplotter_network_password.jpg)

Innstillingene for WiFi-klienten finner du under WiFi-symbolet øverst til høyre på OpenPlotter-skrivebordet. Der konfigurerer du flere nettverk, for eksempel WiFi-aksesspunktet på båten.

[![](assets/screenshots/16_wifi_client_settings.jpg){ width="50%" }](assets/screenshots/16_wifi_client_settings.jpg)

Start OpenPlotter på nytt etter at du har endret nettverksinnstillingene.

### Installasjon av SH-RPi-daemonen

Nå som det mest presserende er unnagjort, er det på tide å installere SH-RPi-daemonen. ([Daemoner](https://en.wikipedia.org/wiki/Daemon_(computing)#Etymology) er velvillige ånder som er med på å forme et menneskes karakter eller personlighet. Eller i dette tilfellet bakgrunnstjenester i UNIX-beslektede operativsystemer.) Vi kunne brukt VNC Viewer til det ved å åpne Accessories -> Terminal i Raspberry-menyen, og det anbefaler jeg Windows-brukere å gjøre, men for Mac- og Linux-brukere viser jeg hvordan man når OpenPlotter-enheten over SSH.

Først en liten avstikker. I stedet for bare å logge inn med ssh kopierer vi først den offentlige SSH-nøkkelen vår til enheten med `ssh-copy-id`. Da kan senere pålogginger skje uten passord.

Mac-brukere må kanskje installere `ssh-copy-id` først. Det er tilgjengelig via [Homebrew](https://brew.sh/) — har du ikke installert det ennå, så gjør det! Det er utmerket! Når du har det, kjører du:

    brew install ssh-copy-id

Linux-brukere er derimot bortskjemte og har allerede `ssh-copy-id` forhåndsinstallert.

Kopier deretter den offentlige nøkkelen:

    ssh-copy-id pi@openplotter.local

Så var det gjort! Nå kan du logge inn på Pi-en uten passord. Jeg anbefaler denne metoden på alle systemer du når eksternt — den er sikrere enn passord.

[![](assets/screenshots/18_ssh.jpg){ width="50%" }](assets/screenshots/18_ssh.jpg)

Når du har logget inn med `ssh pi@openplotter.local`, limer du installasjonskommandoen inn i ledeteksten:

    curl -L \
    https://raw.githubusercontent.com/hatlabs/SH-RPi-daemon/main/install.sh \
    | sudo bash

Har du et relativt urørt system, gjør denne kommandoen de nødvendige konfigurasjonsendringene og installerer daemon-programvaren automatisk. Det tar bare noen sekunder. Alt du trenger å gjøre, er å starte på nytt manuelt når installasjonen er ferdig:

    sudo reboot

Følg med på lysdiodene til SH-RPi under omstarten. RX-lysdioden har lyst fast grønt og statuslysdioden lyser fast rødt, men etter omstarten flimrer RX-lysdioden lystig (forutsatt at det er trafikk på NMEA 2000-bussen), og statuslysdioden lyser rødt, men blinker kort hvert sekund. Endringene viser at CAN-grensesnittet og watchdogen til daemonen er aktive. Flott.

Når du kobler til VNC etter omstarten, ser du følgende melding:

[![](assets/screenshots/20_after_reboot.jpg){ width="50%" }](assets/screenshots/20_after_reboot.jpg)

Det betyr at vi nå har et aktivt CAN-grensesnitt, men at det ennå ikke er konfigurert i [Signal K](https://signalk.org). Det gjør vi i neste del.

### Konfigurasjon av Signal K for å motta NMEA 2000-trafikk

For å kunne behandle NMEA 2000-dataene må Signal K konfigureres til å motta dem. Åpne Signal K-dashbordet på [http://openplotter.local:3000/](http://openplotter.local:3000/).

For å kunne gjøre noe som helst på serveren må du slå på sikkerhet og opprette en administratorbruker. Klikk på knappen «Login» øverst til høyre:

[![](assets/screenshots/21_sk_server_dashboard.jpg){ width="50%" }](assets/screenshots/21_sk_server_dashboard.jpg)

Du blir bedt om å opprette en ny administratorbruker. Jeg foretrekker `admin` som brukernavn, og deretter et passende passord som er lett å huske og lett å skrive. Dette er bare tilgjengelig fra det interne nettverket ditt.

Deretter vil du kanskje oppgradere SK-serveren:

[![](assets/screenshots/23_update_server.jpg){ width="50%" }](assets/screenshots/23_update_server.jpg)

Når det er gjort, kan vi komme til saken og slå på `can0` på serveren. Gå til Data Connections, og klikk på knappen Add:

[![](assets/screenshots/26_data_connections_add.jpg){ width="50%" }](assets/screenshots/26_data_connections_add.jpg)

Konfigurer deretter tilkoblingen slik som nedenfor, bla ned, og klikk på Submit:

[![](assets/screenshots/28_correct_settings.jpg){ width="50%" }](assets/screenshots/28_correct_settings.jpg)

Når du har lagt til datatilkoblingen, starter du serveren på nytt igjen. Nå bør dashbordet vise litt tilkoblingsaktivitet:

[![](assets/screenshots/30_can0_activity.jpg){ width="50%" }](assets/screenshots/30_can0_activity.jpg)

Flott. På tide å gratulere deg selv. Du har kommet langt!

Vil du, kan du også åpne Data Browser i menyen til venstre og se hvilke data du mottar.

### Opprettelse av instrumentpaneler

Mottar du data, kan du allerede visualisere dem ved å åpne SK Instrument Panel:

[![](assets/screenshots/301_sk_plugins.jpg){ width="50%" }](assets/screenshots/301_sk_plugins.jpg)

Du kan konfigurere stier med skiftenøkkelknappen. Størrelsen og plasseringen til panelene justerer du ved å klikke på låseknappen.

Testlaboratoriet mitt ligger rett under et blikktak helt uten GPS-dekning, og de eneste interessante dataene i nettverket mitt kommer fra [1-Wire-temperatursensoren](https://docs.hatlabs.fi/sh-esp32/pages/tutorials/onewire-temperature/). Instrumentpanelet mitt består derfor nå av tre temperaturverdier:

[![](assets/screenshots/302_sk_instrument_panel.jpg){ width="50%" }](assets/screenshots/302_sk_instrument_panel.jpg)

Litt trist, men samtidig spennende!

I tillegg til den vanlige Instrument Panel finnes det mange svært gode dashbordapplikasjoner for Signal K. Du kan prøve [KIP](https://github.com/mxtommy/Kip) (finnes i appbutikken til SK-serveren) eller [Wilhelm SK](https://www.wilhelmsk.com/) (bare for iOS-enheter, tilgjengelig i App Store).

### Installasjon av InfluxDB og Grafana

I de siste trinnene i denne veiledningen installerer og konfigurerer vi InfluxDB og Grafana for å lage en historisk logg og visualiseringer av båtdataene. Det er noen trinn til og noen skjermbilder som ser travle ut, men den lille innsatsen er vel verdt det!

InfluxDB er en tidsseriedatabase som vi bruker til å lagre dataene. Grafana er et visualiseringsverktøy som ofte brukes til å overvåke tilstanden i IT-systemer, men som takket være allsidigheten også kan brukes til våre maritime data.

For å installere InfluxDB og Grafana går du tilbake til VNC Viewer og åpner OpenPlotter -> Dashboards i Raspberry-menyen:

[![](assets/screenshots/31_openplotter_dashboards.jpg){ width="50%" }](assets/screenshots/31_openplotter_dashboards.jpg)

Velg InfluxDB, og klikk på Install. Det tar en stund, men når det er ferdig, går du tilbake til fanen Apps, velger Grafana og klikker på Install. Så var det gjort.

[![](assets/screenshots/32_install.jpg){ width="50%" }](assets/screenshots/32_install.jpg)

Deretter må vi opprette en ny database i InfluxDB. Åpne Chronograf, webgrensesnittet til InfluxDB, i nettleseren: [http://openplotter.local:8889/](http://openplotter.local:8889/).

[![](assets/screenshots/34_open_chronograf.jpg){ width="50%" }](assets/screenshots/34_open_chronograf.jpg)


Klikk deg gjennom den første konfigurasjonen. InfluxDB-tilkoblingen i Chronograf bruker brukernavnet `admin` og passordet `admin`. Du kan hoppe over opprettelsen av dashbord og konfigurasjonen av Kapacitor.

Opprett deretter den nye databasen i skjermbildet InfluxDB Admin:

[![](assets/screenshots/37_create_signalk_db.jpg){ width="50%" }](assets/screenshots/37_create_signalk_db.jpg)

Gi databasen navnet `signalk`, og klikk deg ellers bare gjennom. Ferdig.

Nå som databasen venter på oss, skal vi mate den med data. Gå tilbake til Signal K-dashbordet for å konfigurere InfluxDB-skrivetillegget:

[![](assets/screenshots/39_sk_plugin_config.jpg){ width="50%" }](assets/screenshots/39_sk_plugin_config.jpg)

La brukernavn og passord stå tomme. Databasen vår het `signalk`. Vil du, kan du endre skriveintervallet for satsvise skrivinger og dataoppløsningen. Intervallet er 10 sekunder som standard, men vil du se dataene nærmere sanntid, skriver du inn 2. Oppløsningen bestemmer hvor ofte en enkelt måling skrives til databasen. Standardverdien på 200 ms holder sannsynligvis, men jeg ville ha enda mer og valgte 100 ms. Kryss også av i boksene som vist nedenfor.

[![](assets/screenshots/40_settings.jpg){ width="50%" }](assets/screenshots/40_settings.jpg)

Bla ned, og klikk på Submit for å ta konfigurasjonen i bruk. Nå bør det strømme målinger inn i databasen. La oss kontrollere det. Gå tilbake til Chronograf, og velg visningen Explore. Nederst bør du ha en kilde som heter `signalk.autogen`. Velg den, så bør navnene på de enkelte målingene dukke opp. Utmerket.

[![](assets/screenshots/41_verify_data.jpg){ width="50%" }](assets/screenshots/41_verify_data.jpg)

Det eneste som gjenstår, er å visualisere de historiske dataene.

### Opprettelse av et Grafana-eksempeldashbord

Vi bruker Grafana til å vise noen flotte grafer. Åpne Grafana i nettleseren: [http://openplotter.local:3001](http://openplotter.local:3001).

[![](assets/screenshots/42_open_grafana.jpg){ width="50%" }](assets/screenshots/42_open_grafana.jpg)

Grafana krever at det skrives inn et nytt passord, så gjør det. Når du kommer til startskjermen, konfigurerer du InfluxDB som datakilde:

[![](assets/screenshots/44_grafana_data_sources.jpg){ width="50%" }](assets/screenshots/44_grafana_data_sources.jpg)

I konfigurasjonen vises standardadressen i mørkegrått, men jeg opplevde at jeg måtte skrive den inn selv. Ellers er det igjen den samme `signalk`-databasen og tomt brukernavn og passord. Klikk på «Save and Test» for å kontrollere at datakilden virker.

[![](assets/screenshots/46_config_data_source.jpg){ width="50%" }](assets/screenshots/46_config_data_source.jpg)

La oss oppsummere hva vi har på dette tidspunktet. Signal K mottar dataene fra NMEA 2000, InfluxDB lagrer dem, og Grafana er koblet til InfluxDB. Til slutt kan vi opprette et Grafana-dashbord og legge til nye datapaneler.

Panelredigereren ser litt travel ut, men grunntrinnene er greie.

[![](assets/screenshots/54_panel_title.jpg){ width="50%" }](assets/screenshots/54_panel_title.jpg)

Rediger spørringen. Velg først en måling i raden FROM. Deretter må du legge til en matematisk modifikator for å regne om måleenhetene (Grafana kjenner ikke særlig til enheter, så som standard vises dataene alltid i de SI-enhetene de er lagret i). For å komme fra kelvin til grader Celsius trekker du for eksempel fra -273.15. Eller for å gå fra m/s til knop ganger du med 3600 og deler på 1852.

Fullfør panelet ved å gi det en tittel og ta endringene i bruk.

Nå bør du ha ett enkelt panel med litt tidsdata synlig i dashbordet. Legg til et par paneler til med knappen Add Panel. Du kan flytte panelene og endre størrelsen på dem ved å dra i titlene og hjørnene. Til slutt kan du velge et passende tidsintervall i den øverste linjen og lagre dashbordet.

Slik ser mitt ferdige dashbord over motortemperatur ut:

[![](assets/screenshots/56_two_more_panels.jpg){ width="50%" }](assets/screenshots/56_two_more_panels.jpg)

Det var det. Gå og lag fantastiske dashbord, og vis dem til vennene i havna og seilforeningen! Del dem gjerne også på [diskusjonsforumet til Hat Labs](https://github.com/hatlabs/discussions/discussions) til inspirasjon!


</div>
