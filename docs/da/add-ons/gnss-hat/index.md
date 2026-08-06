---
title: Waveshare MAX-M8Q GNSS HAT
translated_from: 94d29c50a654fad026d00f597a18d7b0d3625d85
---

# GNSS HAT

Waveshare MAX-M8Q GNSS HAT giver Raspberry Pi'en en GNSS-modtager af høj kvalitet, baseret på U-blox MAX-M8Q-modulet. MAX-M8Q har en GNSS-modtager til flere satellitsystemer med en høj følsomhed på −167 dBm. Den understøtter GPS, GLONASS, BeiDou og Galileo og kan modtage fra tre af dem samtidig. Desuden understøttes flere korrektionssystemer såsom SBAS, QZSS, IMES og D-GPS.

Denne side beskriver installation og konfiguration af GNSS HAT'en, når den bruges sammen med Sailor Hat for Raspberry Pi. Yderligere oplysninger om GNSS HAT'en findes på [Waveshare-wikisiden](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT).

## Tilslutning af HAT'en

Sæt stabelstiklisten i GNSS HAT'ens GPIO-stik. Sæt derefter HAT'en på Raspberry Pi'ens 40-benede GPIO-stikliste. GNSS HAT'en kan stables oven på andre HAT'er.

### Brug af GNSS HAT'en sammen med RS485 HAT'en

MAX-M8Q GNSS HAT'en har en TIMEPULSE-funktion (PPS), som bruges til at give Raspberry Pi'en
en meget nøjagtig GNSS-tidsreference. Desværre er denne tidspulsfunktion forbundet til et GPIO-ben, som RS485 HAT'en også bruger. Hvis disse to enheder bruges sammen, skal det GPIO-ben, der er i konflikt, afbrydes fysisk. Den nemmeste måde
at gøre det på er at klippe det pågældende ben af på stabelstiklisten. Figuren nedenfor fremhæver det ben, der skal klippes af.

<figure markdown="span">
![](pps_pin.jpg){ width="50%" }
<figcaption>Det ben, der skal klippes af, når GNSS HAT'en bruges sammen med RS485 HAT'en.</figcaption>
</figure>

For at sikre, at du klipper det rigtige ben af, skal du sætte stabelstiklisten delvist i GNSS HAT'ens GPIO-stik. Klip derefter toppen af det ben, der er fremhævet på figuren ovenfor. Tag stabelstiklisten af, og klip så benet af ved stiklistens bund.

## Softwarekonfiguration

Softwareinstallationen til GNSS HAT'en bliver automatiseret i Sailor Hats installationsscript.
Indtil videre skal du konfigurere GNSS HAT'en manuelt efter vejledningen på [Waveshare MAX-M8Q GNSS HAT-wikisiden](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT). Du har ikke brug for trinnene efter konfigurationen af `gpsd`.

Afhængigt af konfigurationen stiller GNSS HAT'en enten den serielle enhed `/dev/ttyAMA0` eller `/dev/ttyS0` til rådighed for NMEA 0183-data. OpenPlotter har et smart konfigurationsværktøj til serielle enheder, som kan bruges til at opsætte GNSS HAT'en og forbinde den til Signal K.

## Backupbatteri

GNSS HAT'en har et stik til et backupbatteri. Backupbatteriet bruges til at gemme efemeridedata, når Raspberry Pi'en er slukket. Backupbatteriet er ikke obligatorisk, men det gør det hurtigere at få en GNSS-position, efter at Raspberry Pi'en er tændt.

Backupbatteriet er af typen ML1220. Det er en genopladelig lithiumcelle og må **ikke** udskiftes med et ikke-genopladeligt batteri. Det medfører risiko for eksplosion og brand! Erfarne brugere kan på eget ansvar fjerne modstanden R3 for at deaktivere opladningsfunktionen og bruge et ikke-genopladeligt CR1220-batteri. Kredsløbsdiagrammer og print-layout findes på [Waveshare-wikisiden](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT).
