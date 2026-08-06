---
title: Innledning
translated_from: 0ec24a83f9a21c842e78cd792ae3510e89df0e34
---

# Innledning

!!! info
    Leter du etter den gamle dokumentasjonen for Sailor Hat for Raspberry Pi v1.0.0? Den finnes på [docs.hatlabs.fi/sh-rpi-v1](https://docs.hatlabs.fi/sh-rpi-v1/).

Sailor Hat for Raspberry Pi (SH-RPi) er et allsidig strømstyringskort utviklet for Raspberry Pi og lignende enkortsdatamaskiner. Med SH-RPi tilkoblet kan du bygge tett integrerte servere som stenger ned trygt når strømmen slås av, og som våkner automatisk når strømmen kommer tilbake.

SH-RPi støtter alle Raspberry Pi-modeller med en 40-pinners GPIO-pinneliste (alle modeller siden Pi 1 Model B+). I tillegg er kortet kompatibelt med Raspberry Pi Compute Module 4-kort og andre enkortsdatamaskiner som har en 40-pinners Raspberry Pi-kompatibel GPIO-pinneliste eller et eksternt I2C-grensesnitt med 5 V strøminngang.

<figure markdown="span">
![](shrpi_v2.0.0_top_render_ortho.jpg){ width="60%" }
<figcaption>Sailor Hat for Raspberry Pi v2.0.0.</figcaption>
</figure>

## Viktigste egenskaper

- **Bredt inngangsspenningsområde**: Forsyn Raspberry Pi-en trygt fra et 12 V- eller 24 V-anlegg av den typen som er vanlig i kjøretøy og båter. SH-RPi har et inngangsområde på 10–32 V med ekstra filtrering og overspenningsvern.
- **Høy utgangsstrømkapasitet**: 3 A kontinuerlig utgangsstrøm ved 5 V (avhengig av omgivelsestemperaturen), med toppstrømmer opptil 5 A. Med aktiv kjøling er 4 A kontinuerlig utgangsstrøm mulig. SH-RPi kan forsyne selv de mest krevende Raspberry Pi-oppsettene.
- **Motstandsdyktig mot kortvarige strømbortfall**: Innebygde superkondensatorer sørger for at strømbrudd av og til ikke merkes, og holder serveren i gang under spenningsdipp og kortvarige strømbortfall.
- **Kompatibelt med NMEA 2000-bussen**: Forsyn Raspberry Pi-en direkte fra NMEA 2000-bussen. SH-RPi har en strømbegrensningskrets som begrenser den maksimale inngangsstrømmen til omtrent 0,8 A. Superkondensatorene gir toppeffekt til strømkrevende enheter som skjermer og SSD-disker.
- **Trygg nedstenging**: Raspberry Pi-en får beskjed om strømbortfall og stenger ned trygt, drevet av superkondensatorene. Det fjerner risikoen for ødelagte SD-kort.
- **Sanntidsklokke**: Hold Raspberry Pi-en synkronisert med den innebygde sanntidsklokken og reservebatteriet.
- **Watchdog-timer**: Tilbakestill Raspberry Pi-en automatisk ved en krasj, med den innebygde watchdog-timeren.
- **Stablebart**: Legg til mer funksjonalitet ved å stable andre Raspberry Pi-HAT-kort oppå, for eksempel GPS, NMEA 2000 eller NMEA 0183.

Sailor Hat for Raspberry Pi er åpen maskinvare, lisensiert under lisensen Creative Commons Navngivelse-DelPåSammeVilkår 4.0 Internasjonal.

## Slik skaffer du maskinvaren

Du kan kjøpe SH-RPi-kort fra [Hat Labs Oy](https://shop.hatlabs.fi/products/sh-rpi). Alle designfilene er også tilgjengelige i [GitHub-repositoriet for SH-RPi-maskinvare](https://github.com/hatlabs/sh-rpi-hardware/).
