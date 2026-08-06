---
title: Inleiding
translated_from: 0ec24a83f9a21c842e78cd792ae3510e89df0e34
---

# Inleiding

!!! info
    Zoekt u de oude documentatie van de Sailor Hat for Raspberry Pi v1.0.0? Die is beschikbaar op [docs.hatlabs.fi/sh-rpi-v1](https://docs.hatlabs.fi/sh-rpi-v1/).

De Sailor Hat for Raspberry Pi (SH-RPi) is een veelzijdige kaart voor energiebeheer, ontworpen voor de Raspberry Pi en vergelijkbare singleboardcomputers. Met de SH-RPi aangesloten kunt u sterk geïntegreerde servers bouwen die veilig afsluiten wanneer de voeding wordt uitgeschakeld en automatisch opstarten zodra de voeding terugkeert.

De SH-RPi ondersteunt alle Raspberry Pi-modellen met een 40-pins GPIO-pinheader (elk model sinds de Pi 1 Model B+). Daarnaast is de kaart compatibel met Raspberry Pi Compute Module 4-kaarten en andere singleboardcomputers met een 40-pins GPIO-pinheader die compatibel is met de Raspberry Pi, of met een externe I2C-interface met een 5 V-voedingsingang.

<figure markdown="span">
![](shrpi_v2.0.0_top_render_ortho.jpg){ width="60%" }
<figcaption>Sailor Hat for Raspberry Pi v2.0.0.</figcaption>
</figure>

## Belangrijkste kenmerken

- **Breed ingangsspanningsbereik**: voed uw Raspberry Pi veilig vanaf een 12 V- of 24 V-systeem zoals dat gebruikelijk is in voertuigen en boten. De SH-RPi heeft een ingangsbereik van 10–32 V met extra filtering en overspanningsbeveiliging.
- **Hoge uitgangsstroom**: 3 A continue uitgangsstroom bij 5 V (afhankelijk van de omgevingstemperatuur), met piekstromen tot 5 A. Met actieve koeling is 4 A continue uitgangsstroom mogelijk. De SH-RPi kan zelfs de meest veeleisende Raspberry Pi-opstellingen voeden.
- **Bestand tegen spanningsstoringen**: ingebouwde supercondensatoren zorgen ervoor dat kortstondige stroomuitval genegeerd wordt, zodat uw server tijdens spanningsdippen en spanningsstoringen blijft draaien.
- **Compatibel met de NMEA 2000-bus**: voed uw Raspberry Pi rechtstreeks vanaf de NMEA 2000-bus. De SH-RPi bevat een stroombegrenzer die de maximale ingangsstroom tot ongeveer 0,8 A beperkt. De supercondensatoren leveren piekvermogen voor stroomvretende apparaten zoals schermen en SSD's.
- **Veilig afsluiten**: de Raspberry Pi krijgt bericht van stroomuitval en sluit veilig af op de supercondensatoren. Dat sluit het risico op beschadigde SD-kaarten uit.
- **Realtimeklok**: houd uw Raspberry Pi gelijk met de ingebouwde realtimeklok en backupbatterij.
- **Watchdogtimer**: herstart uw Raspberry Pi automatisch na een crash met de ingebouwde watchdogtimer.
- **Stapelbaar**: voeg functionaliteit toe door andere Raspberry Pi-HAT's erop te stapelen, zoals GPS, NMEA 2000 of NMEA 0183.

Sailor Hat for Raspberry Pi is open hardware, uitgebracht onder de Creative Commons Attribution-ShareAlike 4.0 International-licentie.

## De hardware aanschaffen

SH-RPi-kaarten koopt u bij [Hat Labs Oy](https://shop.hatlabs.fi/products/sh-rpi). Alle ontwerpbestanden zijn ook beschikbaar in de [GitHub-repository van de SH-RPi-hardware](https://github.com/hatlabs/sh-rpi-hardware/).
