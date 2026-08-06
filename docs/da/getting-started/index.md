---
title: Kom godt i gang
translated_from: 46b4add9db5ebdedd9ae7e3eba99744cd34a074c
---

# Kom godt i gang

## Samling af hardwaren

SH-RPi leveres færdigsamlet. Trinnene i hardwareinstallationen er:

1. Sæt den 40-benede stabelstikliste ind i SH-RPi'en gennem den gennemgående GPIO-stikliste på undersiden, med benene opad.
2. Sæt SH-RPi'en på Raspberry Pi'ens GPIO-stikliste (eventuelt med de sekskantede afstandsbolte).
3. Monter passende strømledninger i skrueklemmerne. Skrueklemmerne leveres med skruerne spændt, så husk at løsne dem, før du sætter ledningerne i.

<figure markdown="span">
![](shrpi_v2_hardware_assembly.jpg){ width="50%" }
<figcaption>Samlingsdiagram for SH-RPi v2.0.0.</figcaption>
</figure>

### Strømtilslutning

!!! warning
    Forbind aldrig strømindgangen med 5 V-udgangsstikket! Det ødelægger Raspberry Pi'en og SH-RPi'en permanent.

Tilslut en 10–32 V-strømkilde til SH-RPi'ens strømindgangsstik som vist på følgende figur.

<figure markdown="span">
![](shrpi_power_input.jpg){ width="50%" }
<figcaption>Tilslut strømkilden til det stik, der er markeret med en grøn cirkel.</figcaption>
</figure>

Strømkilden skal kunne levere mindst 1,0 A ved den angivne udgangsspænding.
Alt andet lige giver en strømforsyning med højere udgangsspænding, f.eks. 24 V, en lidt mere effektiv drift.
Ellers fungerer 12 V-anlæg i både og køretøjer eller DC-strømkilder fint.

## Softwareinstallation

Raspberry Pi OS kræver ekstra software for at kunne køre den systemtjeneste, der automatisk starter nedlukningen, når strømmen afbrydes.
Der findes et automatiseret installationsscript, som forenkler installationen.

### Automatiseret installation

Der findes et automatiseret installationsscript. Scriptet er testet på et nyligt flashet Raspberry Pi OS og kan fejle på kraftigt modificerede systemer.
Installationen er ikke testet på andre styresystemer.

Kør det automatiserede installationsscript ved at kopiere og indsætte følgende kommando i Raspberry Pi'ens kommandoprompt:

    curl -L \
        https://raw.githubusercontent.com/hatlabs/SH-RPi-daemon/main/install-online.sh \
        | sudo bash

Kommandoen fylder tre linjer, og når du indsætter den i dit terminalvindue, kan den vise linjefortsættelsestegn. Det er helt fint. Tryk på »Enter« for at køre kommandoen.

<figure markdown="span">
![](automated-installation-screenshot.png){ width="80%" }
<figcaption>Installationskommandoen i terminalen</figcaption>
</figure>

Kommandoen henter installationsscriptet og kører det automatisk.

Det automatiserede installationsscript vil:

- aktivere I2C-grænsefladen, som SH-RPi'en skal bruge for at kommunikere med Raspberry Pi'en
- hvis understøttelse af udvidelseskortet til NMEA 2000-grænsefladen er valgt
  - aktivere SPI-grænsefladen og et device tree-overlay
  - definere CAN-netværksgrænsefladen
- hvis understøttelse af udvidelseskortet til NMEA 0183-grænsefladen er valgt
  - aktivere SPI-grænsefladen og et device tree-overlay
- aktivere device tree-overlayet til realtidsuret
- hvis understøttelse af MAX-M8Q GNSS HAT er valgt
  - aktivere den serielle UART-grænseflade
  - deaktivere den serielle konsol
  - deaktivere Bluetooth, da det er i konflikt med den serielle UART-grænseflade
- installere SH-RPi'ens tjenestesoftware

## Kabinetter

Hvis du planlægger at bruge din Raspberry Pi og SH-RPi udendørs, i et køretøj eller på en båd eller i stærkt kondenserende miljøer, skal du altid placere enheden i et vandtæt kabinet!
Hat Labs
tilbyder et udvalg af [vandtætte kabinetter](https://shop.hatlabs.fi/collections/accessories-enclosures).

De mellemstore og store kabinetter leveres med en perforeret bundplade og monteringsadaptere, som kan bruges til at montere Raspberry Pi'en, yderligere HAT'er og andre komponenter.
Andre kabinetter leveres med 3D-printede klæbebeslag.

### Opbygning af det mellemstore kabinet

Det mellemstore kabinet er designet til at rumme en Raspberry Pi 4 Model B, SH-RPi'en og flere HAT'er i lodret orientering. Installationen er beskrevet nedenfor.

#### Samling

Vi starter med et tomt kabinet, som vist på følgende figur.

<figure markdown="span">
![](01_bare_box.jpg){ width="50%" }
<figcaption>Kabinet uden nogen af komponenterne.</figcaption>
</figure>

Monter først alle de stik, du har brug for. Før du monterer stikkene, skal du muligvis lodde ledninger på dem. Loddevejledning til loddekopper findes i denne YouTube-video:

<iframe width="560" height="315" src="https://www.youtube.com/embed/_GLeCt_u3U8" frameborder="0" allowfullscreen></iframe>

Der findes ingen egentlig standard for strømstikkenes benforbindelser, men vi anbefaler altid at forbinde GND til ben 1 og +12 V/24 V til ben 2. Følgende figur viser strømstikket monteret.

Sæt derefter stikkene i kabinettet. Følgende figur viser de monterede stik.

<figure markdown="span">
![](02_conx.jpg){ width="50%" }
<figcaption>Monterede stik.</figcaption>
</figure>

Hvis kabinettet skal bruges i et kondenserende miljø, f.eks. på en båd eller udendørs, skal du forsegle de resterende huller med kabelforskruninger med blindprop. Følgende figur viser, hvordan proppen skal monteres i kabelforskruningerne.

<figure markdown="span">
![](03_gland_plug.jpg){ width="50%" }
<figcaption>Blindprop til kabelforskruning.</figcaption>
</figure>

Og følgende figur viser de monterede kabelforskruninger. Det gør kabinettet vandtæt.

<figure markdown="span">
![](04_conx_plugs.jpg){ width="50%" }
<figcaption>Monterede kabelforskruninger.</figcaption>
</figure>

Derefter tager vi de dele, vi vil montere i kabinettet, og lægger dem på bundpladen. Følgende figur viser de dele, vi skal montere. De sorte plastdele er de lodrette holdere, der holder kortstakken på plads.

<figure markdown="span">
![](05_ingredients.jpg){ width="50%" }
<figcaption>Ingredienser.</figcaption>
</figure>

Først skrues de sekskantede afstandsbolte på 6 mm i de lodrette holdere. Spænd kun med håndkraft!

Følgende figur viser de lodrette holdere med afstandsboltene monteret.

<figure markdown="span">
![](06_vertical_mounts.jpg){ width="50%" }
<figcaption>Lodrette holdere med sekskantede afstandsbolte.</figcaption>
</figure>

Derefter kan du montere holderne på Raspberry Pi'en eller bærekortet. Brug M2,5-skruerne til at fastgøre kortet ved siden af GPIO-benene og de sekskantede M2,5-afstandsbolte på 16 mm i den modsatte side.

Derefter monterer vi stabelstiklisten på SH-RPi'en. Tryk forsigtigt og jævnt for at undgå at bøje benene. Den optimale højde på stiklisten afhænger af HAT'ernes rækkefølge. Hvis du sætter SH-RPi'en direkte oven på Raspberry Pi'en, skal du fjerne afstandsstykket fra stabelstiklisten. Afstandsstykket er derimod nødvendigt, hvis du monterer SH-RPi'en oven på en anden grænseflade-HAT.

<figure markdown="span">
![](07_stack_thru_conx.jpg){ width="50%" }
<figcaption>Montering af stabelstiklisten.</figcaption>
</figure>

Næste figur viser SH-RPi'en monteret på bærekortet.

<figure markdown="span">
![](08_shrpi_mounted.jpg){ width="50%" }
<figcaption>SH-RPi monteret på bærekortet.</figcaption>
</figure>

#### Strømledningsføring

I denne gennemgang monterer vi også en ekstra CAN HAT til NMEA 2000-forbindelse. Følgende figur viser CAN HAT'en monteret på SH-RPi'en.

<figure markdown="span">
![](09_can_mounted.jpg){ width="50%" }
<figcaption>CAN HAT monteret på SH-RPi'en.</figcaption>
</figure>

Næste trin er at montere kortstakken på bundpladen. Brug de medfølgende M3-skruer til at fastgøre stakken. Undgå at overspænde skruerne.

<figure markdown="span">
![](10_on_base_mount.jpg){ width="50%" }
<figcaption>Kortstakken monteret på bundpladen.</figcaption>
</figure>

Afisoler derefter stikkenes ledninger. Hvis der bruges et separat strømstik, skal den røde NMEA 2000-ledning enten forblive uafisoleret eller klippes helt af. Følgende figur viser de afisolerede ledninger.

<figure markdown="span">
![](13_stripped_wires.jpg){ width="50%" }
<figcaption>Afisolerede strøm- og CAN-ledninger.</figcaption>
</figure>

Næste trin er at forbinde ledningerne til stikkene på printet. Strømstikket skal forbindes til skrueklemmen som vist på følgende figur.

Når du sætter skrueklemmen i, skal du være _meget_ omhyggelig med at sætte den i indgangsstikket på SH-RPi'en. Du kan ødelægge alle enheder i stakken, hvis du sætter den i 5 V-udgangsstikket!

<figure markdown="span">
![](14_power_conx.jpg){ width="50%" }
<figcaption>Ledningsplacering i strømstikkets skrueklemme.</figcaption>
</figure>

Derefter skal CAN-ledningerne forbindes til CAN HAT'ens CAN0-stik som vist nedenfor. Sort er jord, hvid er CAN high (H) og blå er CAN low (L).

<figure markdown="span">
![](15_wires_plugged.jpg){ width="50%" }
<figcaption>Den endelige ledningsføring.</figcaption>
</figure>

#### Strømforsyning fra NMEA 2000

Ved brug på en båd kan du også forsyne systemet med strøm fra NMEA 2000-netværket. I så fald bruges alle ledninger fra NMEA 2000-stikket.

<figure markdown="span">
![](18_alt_can_wires.jpg){ width="50%" }
<figcaption>Når enheden forsynes fra NMEA 2000-netværket, bruges alle ledninger fra NMEA 2000-stikket.</figcaption>
</figure>

Den sorte og den røde ledning forbindes til strømskrueklemmen, og et kort stykke sort ledning splejses på GND-klemmen som vist på følgende figur. Den korte sorte ledning forbindes til GND-klemmen på CAN HAT'ens CAN0-stik.

<figure markdown="span">
![](19_spliced_gnd.jpg){ width="50%" }
<figcaption>Forbind NMEA 2000-GND-ledningen til både strømskrueklemmen og CAN HAT'ens CAN0-stik.</figcaption>
</figure>

Næste figur viser den endelige ledningsføring, når enheden forsynes fra NMEA 2000-netværket.

<figure markdown="span">
![](20_can_power_wiring.jpg){ width="50%" }
<figcaption>Den endelige ledningsføring, når enheden forsynes fra NMEA 2000-netværket.</figcaption>
</figure>

#### Fastgørelse af stakken

Til sidst kan den løse ende af stakken fastgøres til bundpladen med små kabelbindere, som er en enkel og letanvendelig løsning. De følgende to figurer viser monteringen af kabelbinderne.

<figure markdown="span">
![](11_tie_wraps.jpg){ width="50%" }
<figcaption>Kabelbindere sat i.</figcaption>
</figure>

<figure markdown="span">
![](12_tie_wraps_2.jpg){ width="50%" }
<figcaption>Færdig montering af kabelbindere.</figcaption>
</figure>

#### Færdiggørelse af samlingen

Nu kan bundpladen sættes ind i kabinettet.

<figure markdown="span">
![](16_in_place.jpg){ width="50%" }
<figcaption>Bundpladen på plads.</figcaption>
</figure>

Fastgør bundpladen til kabinettet med de medfølgende skruer.

<figure markdown="span">
![](17_screw_base_mount.jpg){ width="50%" }
<figcaption>Bundpladen skrues fast i kabinettet.</figcaption>
</figure>

Så er samlingen færdig. Figuren nedenfor viser opstillingen, der blinker lystigt i kabinettet.

<figure markdown="span">
![](21_all_done.jpg){ width="50%" }
<figcaption>Den færdige opstilling.</figcaption>
</figure>

Kabinettet kan monteres på en væg eller et skot gennem hjørnehullerne, der vises på figuren nedenfor.

<figure markdown="span">
![](22_mounting.jpg){ width="50%" }
<figcaption>Monteringshullernes placering.</figcaption>
</figure>


### Boring af huller

Hvis du bruger et kabinet uden forborede huller, skal du selv bore hullerne.

Som minimum skal du bruge ét hul til strømindgangen og, i ethvert metalkabinet, endnu et til en Wi-Fi-antenne eller et kablet Ethernet-stik.

Planlæg placeringen af huller og stik, så den passer til det sted, hvor du vil installere enheden.
Hvis du planlægger at vægmontere kabinettet, skal du placere stikkene nedadvendt for at mindske risikoen for vandindtrængning.

Både aluminium og polykarbonat er forholdsvis bløde og kan bores med et trinbor (et af dem, der ligner et lille juletræ af metal).
Når du borer i plast, kan almindelige metalbor let bide for hårdt og få væggen til at revne.

<figure markdown="span">
![](step_drill_bit.jpg){ width="50%" }
<figcaption>Et eksempel på trinbor.</figcaption>
</figure>

Passende hulstørrelser til forskellige stik:

- SMA (Wi-Fi-antenne): 6,5–7 mm eller 1/4"
- PG7-kabelforskruning og M12-panelstik (NMEA 2000): 12,5 mm eller 1/2"
- SP13-panelstik (blåsorte plaststik): 13 mm.
- PG9-kabelforskruning: 16 mm eller 5/8"
- RJ45-panelstik: 21–22 mm
- USB type A-panelstik: 21–22 mm

### Montering af Raspberry Pi'en

Kabinetterne fra Hat Labs indeholder monteringsadaptere, som kan bruges til at montere Raspberry Pi'en.

### Lodning af panelstikkene

Når du lodder de indvendige ledninger på panelstikkene, skal du altid bruge krympeflex på de enkelte ledninger.
Husk altid at trække krympeflexen ind på ledningerne _før_ lodningen...
Som regel kan du først komme loddetin i loddekoppen på stikbenet og derefter smelte tinnet om og føre ledningen ind.

### Tilslutning af en blæser

Det anbefales at placere en blæser inde i kabinettet for at forbedre luftcirkulationen og varmeoverførslen gennem kabinettets flader.
En lille 40 mm-blæser kan monteres i kabinettet med dobbeltklæbende tape eller smeltelim.

Blæseren skal forbindes til det generelle 5 V-udgangsstik på SH-RPi'en:

<figure markdown="span">
![](shrpi_5v_output.jpg){ width="50%" }
<figcaption>Forbind blæseren til det stik, som den røde pil peger på.</figcaption>
</figure>

### Færdiggørelse af installationen

Når du har boret hullerne, monteret Raspberry Pi'en, loddet panelstikkene og tilsluttet blæseren, skal du lukke kabinettet for at beskytte din SH-RPi og Raspberry Pi mod vejr og vind. Kontrollér, at alle forbindelser sidder fast, og at kabinettet er tæt lukket, så der ikke trænger vand ind.

### Test af systemet

Når installationen er færdig, skal du tænde for dit Raspberry Pi- og SH-RPi-system for at sikre, at alt fungerer korrekt. Kontrollér, at Raspberry Pi'en starter, at blæseren kører, og at SH-RPi'en kommunikerer med Raspberry Pi'en. Når du har konstateret, at alt virker, kan du gå videre med at konfigurere softwaren og integrere systemet i det miljø, du har planlagt.

Tillykke! Du har gennemført samlingen af hardwaren og opbygningen af kabinettet til dit SH-RPi- og Raspberry Pi-system.
