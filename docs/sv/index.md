---
title: Introduktion
translated_from: 0ec24a83f9a21c842e78cd792ae3510e89df0e34
---

# Introduktion

!!! info
    Letar du efter den gamla dokumentationen för Sailor Hat for Raspberry Pi v1.0.0? Den finns på [docs.hatlabs.fi/sh-rpi-v1](https://docs.hatlabs.fi/sh-rpi-v1/).

Sailor Hat for Raspberry Pi (SH-RPi) är ett mångsidigt strömhanteringskort för Raspberry Pi och liknande enkortsdatorer. Med SH-RPi:n ansluten kan du bygga djupt integrerade servrar som stängs av säkert när strömmen slås av och vaknar automatiskt när strömmen kommer tillbaka.

SH-RPi stöder alla Raspberry Pi-modeller med en 40-polig GPIO-stiftlist (alla modeller från och med Pi 1 Model B+). Dessutom är kortet kompatibelt med Raspberry Pi Compute Module 4-kort och andra enkortsdatorer som har en 40-polig Raspberry Pi-kompatibel GPIO-stiftlist eller ett externt I2C-gränssnitt med 5 V matningsingång.

<figure markdown="span">
![](shrpi_v2.0.0_top_render_ortho.jpg){ width="60%" }
<figcaption>Sailor Hat for Raspberry Pi v2.0.0.</figcaption>
</figure>

## Viktiga egenskaper

- **Brett inspänningsområde**: Driv din Raspberry Pi säkert från ett 12 V- eller 24 V-system av den typ som är vanlig i fordon och båtar. SH-RPi:n har ett inspänningsområde på 10–32 V med extra filtrering och överspänningsskydd.
- **Hög utströmskapacitet**: 3 A kontinuerlig utström vid 5 V (beroende på omgivningstemperaturen), med toppströmmar upp till 5 A. Med aktiv kylning är 4 A kontinuerlig utström möjlig. SH-RPi:n klarar att driva även de mest krävande Raspberry Pi-uppsättningarna.
- **Tålighet mot strömstörningar**: Inbyggda superkondensatorer gör att tillfälliga strömavbrott passerar obemärkta, så att servern fortsätter köra under spänningsdippar och strömstörningar.
- **Kompatibilitet med NMEA 2000-bussen**: Driv din Raspberry Pi direkt från NMEA 2000-bussen. SH-RPi har en krets för strömbegränsning som begränsar den maximala inströmmen till ungefär 0,8 A. Superkondensatorerna ger toppeffekt åt strömtörstiga enheter som skärmar och SSD-diskar.
- **Säker avstängning**: Raspberry Pi:n får besked om strömavbrott och stängs av säkert, med ström från superkondensatorerna. Det eliminerar risken för korrupta SD-kort.
- **Realtidsklocka**: Håll din Raspberry Pi tidssynkroniserad med den inbyggda realtidsklockan och backupbatteriet.
- **Watchdog-timer**: Återställ din Raspberry Pi automatiskt vid en krasch med den inbyggda watchdog-timern.
- **Stapelbar**: Lägg till mer funktionalitet genom att stapla andra HAT-kort för Raspberry Pi, till exempel för GPS, NMEA 2000 eller NMEA 0183.

Sailor Hat for Raspberry Pi är öppen hårdvara, licensierad under licensen Creative Commons Attribution-ShareAlike 4.0 International.

## Så får du tag i hårdvaran

Du kan köpa SH-RPi-kort från [Hat Labs Oy](https://shop.hatlabs.fi/products/sh-rpi). Alla konstruktionsfiler finns dessutom i [GitHub-repositoriet för SH-RPi-hårdvaran](https://github.com/hatlabs/sh-rpi-hardware/).
