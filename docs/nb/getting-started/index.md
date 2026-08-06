---
title: Kom i gang
translated_from: 46b4add9db5ebdedd9ae7e3eba99744cd34a074c
---

# Kom i gang

## Montering av maskinvaren

SH-RPi leveres ferdig montert. Trinnene i maskinvareinstallasjonen er:

1. Sett den 40-pinners gjennomgående pinnelisten (stack-through) inn i SH-RPi gjennom kontakten på undersiden, med pinnene vendt oppover.
2. Sett SH-RPi på GPIO-pinnelisten på Raspberry Pi (eventuelt med de sekskantede avstandsboltene).
3. Fest passende strømledninger til skruepluggene. Skruepluggene leveres med skruene strammet, så husk å løsne dem før du setter inn ledningene.

<figure markdown="span">
![](shrpi_v2_hardware_assembly.jpg){ width="50%" }
<figcaption>Monteringsskjema for maskinvaren til SH-RPi v2.0.0.</figcaption>
</figure>

### Strømtilkobling

!!! warning
    Koble aldri strøminngangen til 5 V-utgangskontakten! Det vil ødelegge Raspberry Pi-en og SH-RPi-kortet permanent.

Koble en strømkilde på 10–32 V til inngangskontakten for strøm på SH-RPi, som vist i figuren nedenfor.

<figure markdown="span">
![](shrpi_power_input.jpg){ width="50%" }
<figcaption>Koble strømkilden til kontakten som er ringet inn i grønt.</figcaption>
</figure>

Strømkilden må tåle minst 1,0 A ved den angitte utgangsspenningen.
Alt annet likt gir en strømforsyning med høyere utgangsspenning, for eksempel 24 V, litt mer effektiv drift.
Ellers fungerer 12 V-anlegg i båter og kjøretøy, eller likestrømskilder, godt.

## Installasjon av programvaren

Raspberry Pi OS trenger tilleggsprogramvare for å kjøre systemtjenesten som automatisk starter nedstenging av systemet når strømmen forsvinner.
Et automatisert installasjonsskript er tilgjengelig for å forenkle installasjonen.

### Automatisk installasjon

Et automatisert installasjonsskript er tilgjengelig. Skriptet er testet på et nyflashet Raspberry Pi OS og kan mislykkes på sterkt modifiserte systemer.
Installasjonen er ikke testet på andre operativsystemer.

Kjør det automatiserte installasjonsskriptet ved å kopiere og lime inn følgende kommando i ledeteksten på Raspberry Pi-en:

    curl -L \
        https://raw.githubusercontent.com/hatlabs/SH-RPi-daemon/main/install-online.sh \
        | sudo bash

Kommandoen går over tre linjer, og når du limer den inn i terminalvinduet, kan det dukke opp linjefortsettelsestegn. Det gjør ikke noe. Trykk «Enter» for å kjøre kommandoen.

<figure markdown="span">
![](automated-installation-screenshot.png){ width="80%" }
<figcaption>Installasjonskommandoen i terminalen</figcaption>
</figure>

Kommandoen henter installasjonsskriptet og kjører det automatisk.

Det automatiserte installasjonsskriptet vil:

- aktivere I2C-grensesnittet, som SH-RPi trenger for å kommunisere med Raspberry Pi
- hvis støtte for tilleggskortet for NMEA 2000-grensesnitt er valgt
  - aktivere SPI-grensesnittet og en device tree-overlay
  - definere CAN-nettverksgrensesnittet
- hvis støtte for tilleggskortet for NMEA 0183-grensesnitt er valgt
  - aktivere SPI-grensesnittet og en device tree-overlay
- aktivere device tree-overlayen for sanntidsklokken (RTC)
- hvis støtte for MAX-M8Q GNSS HAT er valgt
  - aktivere det serielle UART-grensesnittet
  - deaktivere seriekonsollen
  - deaktivere Bluetooth, siden det er i konflikt med det serielle UART-grensesnittet
- installere tjenesteprogramvaren for SH-RPi

## Kabinetter

Hvis du planlegger å bruke Raspberry Pi-en og SH-RPi utendørs, i et kjøretøy eller på en båt, eller i sterkt kondenserende miljøer, må du alltid plassere enheten i et vanntett kabinett!
Hat Labs
tilbyr et utvalg av [vanntette kabinetter](https://shop.hatlabs.fi/collections/accessories-enclosures).

Det mellomstore og det store kabinettet leveres med en perforert bunnplate og monteringsadaptere som kan brukes til å montere Raspberry Pi-en, ekstra HAT-kort og andre komponenter.
Andre kabinetter leveres med 3D-printede selvklebende fester.

### Bygging av det mellomstore kabinettet

Det mellomstore kabinettet er laget for å romme en Raspberry Pi 4 Model B, SH-RPi og flere HAT-kort i stående orientering. Installasjonen er beskrevet nedenfor.

#### Montering

Vi starter med et tomt kabinett, vist i figuren nedenfor.

<figure markdown="span">
![](01_bare_box.jpg){ width="50%" }
<figcaption>Kabinett uten noen av komponentene.</figcaption>
</figure>

Monter først alle kontaktene du trenger. Før du monterer kontaktene, kan det være nødvendig å lodde ledninger til dem. Loddeanvisning for loddekopper finner du i denne YouTube-videoen:

<iframe width="560" height="315" src="https://www.youtube.com/embed/_GLeCt_u3U8" frameborder="0" allowfullscreen></iframe>

Det finnes ingen egentlig standard for pinnebelegget på strømkontakter, men vi anbefaler at du alltid kobler GND til pinne 1 og +12 V / 24 V til pinne 2. Figuren nedenfor viser strømkontakten montert.

Sett deretter kontaktene inn i kabinettet. Figuren nedenfor viser de monterte kontaktene.

<figure markdown="span">
![](02_conx.jpg){ width="50%" }
<figcaption>Kontaktene montert.</figcaption>
</figure>

Hvis kabinettet skal brukes i et kondenserende miljø, for eksempel på en båt eller utendørs, tetter du de gjenværende hullene med kabelgjennomføringer med blindplugg. Figuren nedenfor viser hvordan pluggen skal settes inn i kabelgjennomføringene.

<figure markdown="span">
![](03_gland_plug.jpg){ width="50%" }
<figcaption>Blindplugg for kabelgjennomføring.</figcaption>
</figure>

Og figuren nedenfor viser de monterte kabelgjennomføringene. Dette gjør kabinettet vanntett.

<figure markdown="span">
![](04_conx_plugs.jpg){ width="50%" }
<figcaption>Kabelgjennomføringene montert.</figcaption>
</figure>

Deretter tar vi delene vi vil montere i kabinettet, og legger dem på bunnplaten. Figuren nedenfor viser delene vi skal montere. De svarte plastdelene er vertikalfestene som holder kortstabelen på plass.

<figure markdown="span">
![](05_ingredients.jpg){ width="50%" }
<figcaption>Ingredienser.</figcaption>
</figure>

Først skrus de sekskantede 6 mm-avstandsboltene inn i vertikalfestene. Bare stram til for hånd!

Figuren nedenfor viser vertikalfestene med avstandsboltene montert.

<figure markdown="span">
![](06_vertical_mounts.jpg){ width="50%" }
<figcaption>Vertikalfester med sekskantede avstandsbolter.</figcaption>
</figure>

Deretter kan du feste vertikalfestene til Raspberry Pi-en eller kortet under. Bruk M2.5-skruene til å feste kortet ved siden av GPIO-pinnene, og de sekskantede M2.5 16 mm-avstandsboltene på motsatt side.

Så monterer vi den gjennomgående pinnelisten på SH-RPi. Trykk forsiktig og jevnt, slik at pinnene ikke bøyes. Den beste høyden på pinnelisten avhenger av rekkefølgen på HAT-kortene. Hvis du setter SH-RPi rett oppå Raspberry Pi-en, fjerner du avstandsstykket fra den gjennomgående pinnelisten. Avstandsstykket trengs derimot hvis du monterer SH-RPi oppå et annet grensesnitt-HAT.

<figure markdown="span">
![](07_stack_thru_conx.jpg){ width="50%" }
<figcaption>Innsetting av den gjennomgående pinnelisten.</figcaption>
</figure>

Figuren nedenfor viser SH-RPi montert på kortet under.

<figure markdown="span">
![](08_shrpi_mounted.jpg){ width="50%" }
<figcaption>SH-RPi montert på kortet under.</figcaption>
</figure>

#### Strømkabling

I denne gjennomgangen monterer vi også et ekstra CAN HAT for NMEA 2000-tilkobling. Figuren nedenfor viser CAN HAT-kortet montert på SH-RPi.

<figure markdown="span">
![](09_can_mounted.jpg){ width="50%" }
<figcaption>CAN HAT montert på SH-RPi.</figcaption>
</figure>

Neste steg er å montere kortstabelen på bunnplaten. Bruk de medfølgende M3-skruene til å feste stabelen. Ikke stram skruene for hardt.

<figure markdown="span">
![](10_on_base_mount.jpg){ width="50%" }
<figcaption>Kortstabelen montert på bunnplaten.</figcaption>
</figure>

Avisoler deretter ledningene til kontaktene. Hvis det brukes en egen strømkontakt, skal den røde NMEA 2000-ledningen enten forbli uavisolert eller kuttes helt av. Figuren nedenfor viser de avisolerte ledningene.

<figure markdown="span">
![](13_stripped_wires.jpg){ width="50%" }
<figcaption>Avisolerte strøm- og CAN-ledninger.</figcaption>
</figure>

Neste steg er å koble ledningene til kontaktene på kortet. Strømkontakten kobles til skruepluggen som vist i figuren nedenfor.

Når du setter inn skruepluggen, må du være _svært_ nøye med å sette den i inngangskontakten på SH-RPi. Du kan skade alle enhetene i stabelen hvis du setter den i 5 V-utgangskontakten!

<figure markdown="span">
![](14_power_conx.jpg){ width="50%" }
<figcaption>Kobling av skruepluggen for strømkontakten.</figcaption>
</figure>

Deretter kobles CAN-ledningene til CAN0-kontakten på CAN HAT-kortet som vist nedenfor. Svart er jord, hvit er CAN high (H) og blå er CAN low (L).

<figure markdown="span">
![](15_wires_plugged.jpg){ width="50%" }
<figcaption>Ferdig kabling.</figcaption>
</figure>

#### Strømforsyning fra NMEA 2000

Ved bruk på båt kan du også forsyne systemet med strøm fra NMEA 2000-nettverket. Da brukes alle ledningene fra NMEA 2000-kontakten.

<figure markdown="span">
![](18_alt_can_wires.jpg){ width="50%" }
<figcaption>Når enheten forsynes fra NMEA 2000-nettverket, brukes alle ledningene fra NMEA 2000-kontakten.</figcaption>
</figure>

Den svarte og den røde ledningen kobles til skruepluggen for strøm, med en kort bit svart ledning skjøtt til GND-klemmen som vist i figuren nedenfor. Den korte svarte ledningen går til GND-klemmen på CAN0-kontakten på CAN HAT-kortet.

<figure markdown="span">
![](19_spliced_gnd.jpg){ width="50%" }
<figcaption>Koble GND-ledningen fra NMEA 2000 både til skruepluggen for strøm og til CAN0-kontakten på CAN HAT-kortet.</figcaption>
</figure>

Figuren nedenfor viser den ferdige kablingen når enheten forsynes fra NMEA 2000-nettverket.

<figure markdown="span">
![](20_can_power_wiring.jpg){ width="50%" }
<figcaption>Ferdig kabling når enheten forsynes fra NMEA 2000-nettverket.</figcaption>
</figure>

#### Festing av stabelen

Til slutt kan den løse enden av stabelen festes til bunnplaten med små kabelstrips, men som alternativ er enkle kabelstrips en enkel og lettvint løsning. De to neste figurene viser monteringen av kabelstripsene.

<figure markdown="span">
![](11_tie_wraps.jpg){ width="50%" }
<figcaption>Kabelstrips satt inn.</figcaption>
</figure>

<figure markdown="span">
![](12_tie_wraps_2.jpg){ width="50%" }
<figcaption>Ferdig montering av kabelstrips.</figcaption>
</figure>

#### Fullføring av monteringen

Nå kan bunnplaten settes inn i kabinettet.

<figure markdown="span">
![](16_in_place.jpg){ width="50%" }
<figcaption>Bunnplaten på plass.</figcaption>
</figure>

Fest bunnplaten til kabinettet med de medfølgende skruene.

<figure markdown="span">
![](17_screw_base_mount.jpg){ width="50%" }
<figcaption>Bunnplaten skrus fast i kabinettet.</figcaption>
</figure>

Da er monteringen ferdig. Figuren nedenfor viser oppsettet som blinker fornøyd i kabinettet.

<figure markdown="span">
![](21_all_done.jpg){ width="50%" }
<figcaption>Det ferdige oppsettet.</figcaption>
</figure>

Kabinettet kan monteres på en vegg eller et skott gjennom hjørnehullene som vises i figuren nedenfor.

<figure markdown="span">
![](22_mounting.jpg){ width="50%" }
<figcaption>Plassering av monteringshullene.</figcaption>
</figure>


### Boring av hull

Hvis du bruker et kabinett uten ferdigborede hull, må du bore hullene selv.

Som et minimum trenger du ett hull for strøminngangen, og i et metallkabinett ett hull til for en Wi-Fi-antenne eller en kablet Ethernet-kontakt.

Planlegg plasseringen av hull og kontakter etter installasjonsstedet du har tenkt deg.
Hvis du planlegger å veggmontere kabinettet, plasserer du kontaktene vendt nedover for å redusere faren for vanninntrengning.

Både aluminium og polykarbonat er relativt myke og kan bores med et trinnbor (et bor som ser ut som et lite juletre i metall).
Ved boring i plast kan vanlige metallbor lett bite for hardt og sprekke opp veggen.

<figure markdown="span">
![](step_drill_bit.jpg){ width="50%" }
<figcaption>Et eksempel på trinnbor.</figcaption>
</figure>

Passende hullstørrelser for ulike kontakter:

- SMA (Wi-Fi-antenne): 6,5–7 mm eller 1/4"
- PG7-kabelgjennomføring og M12-panelkontakt (NMEA 2000): 12,5 mm eller 1/2"
- SP13-panelkontakter (blåsvarte plastkontakter): 13 mm.
- PG9-kabelgjennomføring: 16 mm eller 5/8"
- RJ45-panelkontakt: 21–22 mm
- USB type A-panelkontakt: 21–22 mm

### Montering av Raspberry Pi-en

Kabinettene fra Hat Labs inneholder monteringsadaptere som kan brukes til å montere Raspberry Pi-en.

### Lodding av panelkontaktene

Når du lodder de interne ledningene til panelkontaktene, skal du alltid bruke krympestrømpe på hver enkelt ledning.
Husk alltid å tre krympestrømpen inn på ledningen _før_ du lodder ...
Vanligvis kan du først fylle loddetinn i pinnekoppen på kontakten, og deretter smelte tinnet på nytt og føre inn ledningen.

### Tilkobling av vifte

Det anbefales å plassere en vifte inne i kabinettet for å bedre luftsirkulasjonen og varmeoverføringen gjennom kabinettflatene.
En liten 40 mm-vifte kan festes i kabinettet med dobbeltsidig tape eller varmlim.

Viften kobles til den generelle 5 V-utgangskontakten på SH-RPi:

<figure markdown="span">
![](shrpi_5v_output.jpg){ width="50%" }
<figcaption>Koble viften til kontakten som den røde pilen peker på.</figcaption>
</figure>

### Fullføring av installasjonen

Når du har boret hullene, montert Raspberry Pi-en, loddet panelkontaktene og koblet til viften, lukker du kabinettet for å beskytte SH-RPi og Raspberry Pi-en mot vær og vind. Kontroller at alle tilkoblinger sitter godt, og at kabinettet er tett forseglet, slik at vann ikke trenger inn.

### Testing av systemet

Når installasjonen er ferdig, slår du på Raspberry Pi- og SH-RPi-systemet for å kontrollere at alt fungerer som det skal. Sjekk at Raspberry Pi-en starter opp, at viften går, og at SH-RPi kommuniserer med Raspberry Pi-en. Når du har bekreftet at alt virker, kan du gå videre med å konfigurere programvaren og integrere systemet i miljøet det er tiltenkt.

Gratulerer! Du har fullført maskinvaremonteringen og kabinettoppsettet for SH-RPi- og Raspberry Pi-systemet ditt.
