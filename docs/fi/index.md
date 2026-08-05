---
title: Johdanto
translated_from: 0ec24a83f9a21c842e78cd792ae3510e89df0e34
---

# Johdanto

!!! info
    Etsitkö vanhaa Sailor Hat for Raspberry Pi v1.0.0 -dokumentaatiota? Se löytyy osoitteesta [docs.hatlabs.fi/sh-rpi-v1](https://docs.hatlabs.fi/sh-rpi-v1/).

Sailor Hat for Raspberry Pi (SH-RPi) on monipuolinen virranhallintakortti Raspberry Pi:lle ja vastaaville yhden piirilevyn tietokoneille. Kun SH-RPi on kytkettynä, voit rakentaa tiiviisti integroituja palvelimia, jotka sammuvat turvallisesti virran katketessa ja käynnistyvät automaattisesti, kun virta palaa.

SH-RPi tukee kaikkia Raspberry Pi -malleja, joissa on 40-nastainen GPIO-liitin (kaikki mallit Pi 1 Model B+:sta lähtien). Lisäksi se on yhteensopiva Raspberry Pi Compute Module 4 -korttien ja muiden yhden piirilevyn tietokoneiden kanssa, joissa on Raspberry Pi:n kanssa yhteensopiva 40-nastainen GPIO-liitin tai ulkoinen I2C-liitäntä ja 5 V:n käyttöjännitetulo.

<figure markdown="span">
![](shrpi_v2.0.0_top_render_ortho.jpg){ width="60%" }
<figcaption>Sailor Hat for Raspberry Pi v2.0.0.</figcaption>
</figure>

## Tärkeimmät ominaisuudet

- **Laaja käyttöjännitealue**: syötä Raspberry Pi:tä turvallisesti ajoneuvoissa ja veneissä yleisestä 12 V:n tai 24 V:n järjestelmästä. SH-RPi:n tuloalue on 10–32 V, ja siinä on lisäsuodatus ja ylijännitesuojaus.
- **Suuri lähtövirta**: 3 A jatkuvaa lähtövirtaa 5 V:n jännitteellä (ympäristön lämpötilasta riippuen), huippuvirrat aina 5 A:iin asti. Aktiivisella jäähdytyksellä 4 A:n jatkuva lähtövirta on mahdollinen. SH-RPi riittää vaativimmillekin Raspberry Pi -kokoonpanoille.
- **Häiriönsieto**: sisäänrakennetut superkondensaattorit varmistavat, että hetkelliset sähkökatkot eivät haittaa, ja pitävät palvelimen käynnissä jännitekuoppien ja häiriöiden aikana.
- **NMEA 2000 -väyläyhteensopivuus**: syötä Raspberry Pi:tä suoraan NMEA 2000 -väylästä. SH-RPi:ssä on virranrajoituspiiri, joka rajaa suurimman tulovirran noin 0,8 A:iin. Superkondensaattorit tuottavat huipputehon virtaa vaativille laitteille, kuten näytöille ja SSD-asemille.
- **Turvallinen sammutus**: Raspberry Pi saa tiedon sähkökatkosta ja sammuu turvallisesti superkondensaattorien varassa. Tämä poistaa SD-korttien vioittumisen riskin.
- **Reaaliaikakello**: pidä Raspberry Pi:n kello ajassa sisäänrakennetun reaaliaikakellon ja varapariston avulla.
- **Watchdog-ajastin**: käynnistä Raspberry Pi automaattisesti uudelleen kaatumisen jälkeen sisäänrakennetulla watchdog-ajastimella.
- **Pinottava**: lisää toiminnallisuutta pinoamalla muita Raspberry Pi -HAT-kortteja, kuten GPS-, NMEA 2000- tai NMEA 0183 -kortteja.

Sailor Hat for Raspberry Pi on avointa laitteistoa, lisensoitu Creative Commons Nimeä-JaaSamoin 4.0 Kansainvälinen -lisenssillä.

## Laitteiston hankkiminen

SH-RPi-kortteja voi ostaa [Hat Labs Oy:ltä](https://shop.hatlabs.fi/products/sh-rpi). Kaikki suunnittelutiedostot ovat myös saatavilla [SH-RPi:n laitteistorepositoriossa GitHubissa](https://github.com/hatlabs/sh-rpi-hardware/).
