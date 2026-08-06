---
title: Waveshare 2-Channel Isolated CAN HAT
translated_from: 91112523c75ae01ec3e4cdcdabdcff0fe5fdbd78
---

# CAN HAT

Waveshare 2-Channel Isolated CAN HAT giver Raspberry Pi'en to isolerede CAN-grænseflader. CAN HAT'en er baseret på MCP2515 CAN-controlleren og CAN-transceiverne SI65HVD230/SN65HVD230. HAT'en kan bruges til at implementere én standardkonform NMEA 2000-grænseflade eller to andre CAN-grænseflader. Når den bruges som NMEA 2000-grænseflade, bør den anden kanal stå ubenyttet på grund af NMEA 2000-kravene til galvanisk adskillelse.

HAT'en har en integreret isoleret DC/DC-transformer og kræver ikke ekstern strømforsyning.

Denne side beskriver installation og konfiguration af CAN HAT'en, når den bruges sammen med Sailor Hat for Raspberry Pi. Yderligere oplysninger om CAN HAT'en findes på [Waveshare-wikisiden](https://www.waveshare.com/wiki/2-CH_CAN_HAT).

## Jumperkonfiguration

!!! warning
    Kontrollér jumpernes placering, før du tilslutter HAT'en!

CAN HAT'en har to jumpere til termineringsmodstandene for CAN-bussen på kortet. Ved normal drift skal de stå i positionen `OFF`!

Desuden har CAN HAT'en en jumper til valg af spænding. Den skal stå på `3V3`, når den bruges sammen med en Raspberry Pi, ellers kan Raspberry Pi'en tage skade.

## Tilslutning af HAT'en

Sæt forsigtigt stabelstiklisten i CAN HAT'ens GPIO-stik. Sæt derefter
HAT'en på Raspberry Pi'ens eller Sailor Hats 40-benede GPIO-stikliste. Kanten ved stikket skal fastgøres til kortet nedenunder med de sekskantede afstandsbolte.

Når HAT'en bruges med en NMEA 2000-grænseflade, må kun CAN0-grænsefladen bruges. CAN1-grænsefladen skal stå uforbundet. Figuren nedenfor viser ledningsføringen til NMEA 2000-grænsefladen.

<figure markdown="span">
![](can_hat_wiring.jpg){ width="50%" }
<figcaption>Ledningsføring til NMEA 2000-grænsefladen. Den røde ledning står uforbundet.</figcaption>
</figure>

## Softwarekonfiguration

Sailor Hats installationsscript kan bruges til at konfigurere og aktivere CAN-grænsefladen. Hvis du vil foretage en manuel installation, kan du finde detaljerne på [Waveshare-wikisiden](https://www.waveshare.com/wiki/2-CH_CAN_HAT).

## Strømforsyning af SH-RPi'en via NMEA 2000-grænsefladen

Det er muligt at forsyne Raspberry Pi'en via NMEA 2000-grænsefladen. Til det skal NMEA 2000-strøm- og jordledningerne forbindes til SH-RPi'ens strømindgang, mens H- og L-ledningerne skal føres til CAN0-stiklisten på CAN HAT'en. Desuden skal der laves en jordforbindelse mellem SH-RPi'en og CAN HAT'en som vist på figuren nedenfor.

<figure markdown="span">
![](can_hat_n2k_power.jpg){ width="50%" }
<figcaption>Ledningsføring til strømforsyning af SH-RPi'en via NMEA 2000-grænsefladen.</figcaption>
</figure>
