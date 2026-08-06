---
title: Introduktion
translated_from: 0ec24a83f9a21c842e78cd792ae3510e89df0e34
---

# Introduktion

!!! info
    Leder du efter den gamle dokumentation til Sailor Hat for Raspberry Pi v1.0.0? Den findes på [docs.hatlabs.fi/sh-rpi-v1](https://docs.hatlabs.fi/sh-rpi-v1/).

Sailor Hat for Raspberry Pi (SH-RPi) er et alsidigt strømstyringskort til Raspberry Pi og lignende enkeltkortcomputere. Med SH-RPi'en tilsluttet kan du bygge dybt integrerede servere, der lukker sikkert ned, når strømmen slukkes, og vågner automatisk, når strømmen vender tilbage.

SH-RPi understøtter alle Raspberry Pi-modeller med en 40-benet GPIO-stikliste (alle modeller siden Pi 1 Model B+). Desuden er den kompatibel med Raspberry Pi Compute Module 4-kort og andre enkeltkortcomputere, der har en 40-benet Raspberry Pi-kompatibel GPIO-stikliste eller en ekstern I2C-grænseflade med 5 V-strømindgang.

<figure markdown="span">
![](shrpi_v2.0.0_top_render_ortho.jpg){ width="60%" }
<figcaption>Sailor Hat for Raspberry Pi v2.0.0.</figcaption>
</figure>

## Vigtigste funktioner

- **Bredt indgangsspændingsområde**: Forsyn din Raspberry Pi sikkert fra et 12 V- eller 24 V-strømsystem af den slags, der er almindelig i køretøjer og både. SH-RPi'en har et indgangsområde på 10–32 V med ekstra filtrering og overspændingsbeskyttelse.
- **Høj udgangsstrømkapacitet**: 3 A kontinuerlig udgangsstrøm ved 5 V (afhængigt af omgivelsestemperaturen) og spidsstrømme op til 5 A. Med aktiv køling er 4 A kontinuerlig udgangsstrøm mulig. SH-RPi'en kan forsyne selv de mest krævende Raspberry Pi-opsætninger.
- **Robusthed over for korte spændingsudfald**: Indbyggede superkondensatorer sørger for, at kortvarige strømafbrydelser ignoreres, så din server bliver ved med at køre under spændingsdyk og korte spændingsudfald.
- **NMEA 2000-buskompatibilitet**: Forsyn din Raspberry Pi direkte fra NMEA 2000-bussen. SH-RPi'en har et strømbegrænsningskredsløb, som begrænser den maksimale indgangsstrøm til ca. 0,8 A. Superkondensatorerne leverer spidseffekt til strømkrævende enheder som skærme og SSD-drev.
- **Sikker nedlukning**: Raspberry Pi'en får besked om strømafbrydelser og lukker sikkert ned, forsynet af superkondensatorerne. Det fjerner risikoen for ødelagte SD-kort.
- **Realtidsur**: Hold din Raspberry Pi synkroniseret med det indbyggede realtidsur og backupbatteriet.
- **Watchdog-timer**: Nulstil automatisk din Raspberry Pi efter et nedbrud med den indbyggede watchdog-timer.
- **Stabelbar**: Tilføj flere funktioner ved at stable andre Raspberry Pi-HAT'er oven på, f.eks. GPS, NMEA 2000 eller NMEA 0183.

Sailor Hat for Raspberry Pi er åben hardware, licenseret under Creative Commons Attribution-ShareAlike 4.0 International-licensen.

## Sådan får du fat i hardwaren

Du kan købe SH-RPi-kort hos [Hat Labs Oy](https://shop.hatlabs.fi/products/sh-rpi). Alle designfiler er også tilgængelige i [SH-RPi'ens hardwarerepositorium på GitHub](https://github.com/hatlabs/sh-rpi-hardware/).
