---
title: Waveshare 2-Channel Isolated RS485 HAT
translated_from: 7f4b38c33361ca8118a3f68c596e0fb1633d6f5e
---

# RS485 HAT

Waveshare 2-Channel Isolated RS485 HAT giver Raspberry Pi'en to isolerede RS-485-grænseflader. Den kan bruges til at implementere en tovejs NMEA 0183-grænseflade eller to generiske tovejs RS-485-grænseflader. Når den bruges som NMEA 0183-grænseflade, bruges den ene kanal til at modtage data og den anden til at sende data.

HAT'en har en integreret isoleret DC/DC-transformer og kræver ikke ekstern strømforsyning.

RS485 HAT'en kan bruges samtidig med SH-RPi'en og CAN HAT'en.

Denne side beskriver installation og konfiguration af RS485 HAT'en, når den bruges sammen med Sailor Hat for Raspberry Pi. Yderligere oplysninger om RS485 HAT'en findes på [Waveshare-wikisiden](https://www.waveshare.com/wiki/2-CH_RS485_HAT).


## Jumperkonfiguration

!!! warning
    Kontrollér jumpernes placering, før du tilslutter HAT'en!

RS485 HAT'en har to jumpere til termineringsmodstandene for RS-485-bussen på kortet. NMEA 0183 bruger ikke terminering, og jumperne skal stå i positionen `OFF`!

## Tilslutning af HAT'en

Sæt forsigtigt stabelstiklisten i RS-485 HAT'ens GPIO-stik. Sæt derefter
HAT'en på Raspberry Pi'ens eller Sailor Hats 40-benede GPIO-stikliste. Kanten ved stikket skal fastgøres til kortet nedenunder med de sekskantede afstandsbolte.

Når HAT'en bruges som NMEA 0183-grænseflade, bruges kanal 1 til at modtage data (RX) og kanal 2 til at sende data (TX). Den sendende enheds TX A- og B-ledninger (eller TX+ og TX-) skal forbindes til A- og B-klemmerne på HAT'ens kanal 1, mens den modtagende enheds RX A- og B-ledninger (eller RX+ og RX-) skal forbindes til A- og B-klemmerne på HAT'ens kanal 2. Figuren nedenfor viser ledningsføringen til NMEA 0183-grænsefladen.

<figure markdown="span">
![](nmea0183_wiring.jpg){ width="50%" }
<figcaption>Ledningsføring til NMEA 0183-grænsefladen. Ledningsfarverne kan variere fra enhed til enhed.</figcaption>
</figure>

## Softwarekonfiguration

Sailor Hats installationsscript kan bruges til at konfigurere og aktivere RS-485-grænsefladen. Grænsefladen stilles til rådighed som to serielle enheder: `/dev/ttySC0` og `/dev/ttySC1`. Af disse bruges `/dev/ttySC0` til at modtage data og `/dev/ttySC1` til at sende data. Disse kan konfigureres i Signal K-dataforbindelserne eller i en hvilken som helst anden NMEA 0183-applikation efter eget valg.

Hvis du vil foretage en manuel installation, kan du finde detaljerne på [Waveshare-wikisiden](https://www.waveshare.com/wiki/2-CH_RS485_HAT).
