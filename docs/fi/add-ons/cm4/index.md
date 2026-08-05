---
title: Compute Module 4
translated_from: f89a90c51f25ee5de82bd29c9a81e54641af9ea1
---

# Compute Module 4

[Compute Module 4](https://www.raspberrypi.org/products/compute-module-4/) on pienikokoinen tietokonemoduuli, joka kiinnitetään emolevyyn. CM4:n suorituskyky vastaa Raspberry Pi 4B:tä, ja se on tehokas, joustava ja edullinen ratkaisu sulautettuihin sovelluksiin. Sulautettuja tietokoneita rakennettaessa CM4:llä on useita etuja Raspberry Pi 4B:hen verrattuna:

- Sisäänrakennettu eMMC-flash-muisti: CM4-korteissa on mallista riippuen jopa 32 Gt eMMC-flash-muistia. Tämä muisti on sekä luotettavampi että nopeampi kuin Raspberry Pi 4B:n SD-kortti.
- Mahdollisuus ulkoiseen WiFi-antenniin: CM4:ssä on oma liitin ulkoiselle WiFi-antennille. Tämä on hyödyllistä, jos sisäisen WiFi-antennin signaali ei riitä.
- M.2-liitin: monissa emolevyissä on M.2-liitin, johon voi kytkeä M.2-SSD:n tai M.2-WiFi-moduulin.
- Pienempi virrankulutus: epävirallisissa testeissä olemme havainneet, että CM4 ja emolevy kuluttavat yli 20 % vähemmän virtaa kuin Raspberry Pi 4B.

Haittapuolena useimmissa CM4-emolevyissä ei ole USB 3.0 -hubia, joten USB-portit rajoittuvat USB 2.0 -nopeuksiin. Lisäksi eMMC:n flashaus on hieman monimutkaisempaa kuin SD-kortin. Prosessi kuvataan alla.

## CM4:n eMMC-muistin flashaus

Ensin on ladattava sopiva levykuva. Käytämme esimerkkinä [OpenPlotterin](https://openplotter.readthedocs.io/en/3.x.x/getting_started/downloading.html) Headless-levykuvaa, mutta prosessi on sama muillekin levykuville. **Huomaa:** käytä aina 64-bittistä levykuvaa! Jotkin ohjelmistokomponentit toimivat huonosti 32-bittisessä järjestelmässä (erityisesti InfluxDB).

eMMC-muistin voi flashata samalla levykuvalla kuin Raspberry Pi 4B:n. Flashausprosessissa on kaksi ylimääräistä vaihetta. Ensin CM4 on kytkettävä erityiseen BOOT-tilaan, joka itse asiassa *estää* laitetta käynnistymästä ja mahdollistaa eMMC:n flashauksen. Toiseksi flashaukseen käytettävälle tietokoneelle on asennettava pieni `rpiboot`-apuohjelma ja ajettava se, jotta eMMC-muisti voidaan liittää tietokoneeseen. Kun nämä vaiheet on tehty, flashaus on täsmälleen samanlainen kuin Raspberry Pi 4B:llä.

Windowsille `rpiboot` on saatavilla valmiiksi käännettynä ohjelmana, mutta Linuxille ja macOS:lle se on käännettävä lähdekoodista. Kunkin alustan prosessi kuvataan alla olevissa luvuissa.

Huomioita asennusprosessista:

1. eMMC:n flashaamiseksi emolevy on kytkettävä BOOT-tilaan. Waveshare CM4-IO-BASE -korteissa HDMI0-liittimen vieressä oleva pieni BOOT-kytkin on käännettävä ON-asentoon.
2. Emolevy on kytkettävä ulkoiseen virtalähteeseen flashauksen ajaksi. Käytä siihen SH-RPi-korttia!

### Windows

1. Aseta flashaustila isäntätietokoneelle noudattamalla [Raspberry Pi:n dokumentaation](https://www.raspberrypi.com/documentation/computers/compute-module.html#flashing-the-compute-module-emmc) ohjeita.
2. Seuraa [OpenPlotterin asennusohjeita](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html).
3. **Huomaa:** älä käynnistä järjestelmää vielä! Muutamia asetuksia on säädettävä ensin, kuten alla olevassa CM4:n asetukset -osiossa kuvataan.
4. Kun asetukset on muutettu, käännä BOOT-kytkin takaisin OFF-asentoon ja käynnistä järjestelmä uudelleen. Sen jälkeen voit jatkaa OpenPlotterin ohjeiden mukaan.

### Mac

Macilla `rpiboot`-apuohjelma on käännettävä lähdekoodista.

1. Kääntämiseen tarvitaan [Homebrew](https://brew.sh/). Asenna se ensin.
2. Seuraa sitten [`usbboot`-repositorion ohjeita](https://github.com/raspberrypi/usbboot#macos). Kun ajat komennon `sudo ./rpiboot`, CM4-emolevyn tulee olla kytkettynä tietokoneeseesi ja saada käyttöjännite SH-RPi:ltä. Jos saat virheilmoituksen, tarkista USB-kaapeli ja emolevyn BOOT-kytkin.
3. Seuraa [OpenPlotterin asennusohjeita](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html). **Huomaa:** älä käynnistä järjestelmää vielä! Muutamia asetuksia on säädettävä ensin, kuten alla olevassa CM4:n asetukset -osiossa kuvataan.
4. Kun asetukset on muutettu, käännä BOOT-kytkin takaisin OFF-asentoon ja käynnistä järjestelmä uudelleen. Sen jälkeen voit jatkaa OpenPlotterin ohjeiden mukaan.

### Linux

Kuten Macilla, myös Linuxilla `rpiboot`-apuohjelma on käännettävä lähdekoodista.

1. Kääntämiseen tarvitaan [Homebrew](https://brew.sh/). Asenna se ensin.
2. Seuraa sitten [`usbboot`-repositorion ohjeita](https://github.com/raspberrypi/usbboot#linux--cygwin--wsl). Kun ajat komennon `sudo ./rpiboot`, CM4-emolevyn tulee olla kytkettynä tietokoneeseesi ja saada käyttöjännite SH-RPi:ltä. Jos saat virheilmoituksen, tarkista USB-kaapeli ja emolevyn BOOT-kytkin.
3. Seuraa [OpenPlotterin asennusohjeita](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html). **Huomaa:** älä käynnistä järjestelmää vielä! Muutamia asetuksia on säädettävä ensin, kuten alla olevassa CM4:n asetukset -osiossa kuvataan.
4. Kun asetukset on muutettu, käännä BOOT-kytkin takaisin OFF-asentoon ja käynnistä järjestelmä uudelleen. Sen jälkeen voit jatkaa OpenPlotterin ohjeiden mukaan.

## CM4:n asetukset

### USB-porttien käyttöönotto

Ennen kuin käynnistät järjestelmän ensimmäisen kerran, asetuksiin on tehtävä muutamia muutoksia. CM4:ssä USB-portit ovat oletuksena pois käytöstä. Tämä voi luonnollisesti olla merkittävä ongelma, jos haluat käyttää järjestelmää näppäimistön ja hiiren kanssa. USB-porttien käyttöönotto edellyttää `config.txt`-tiedoston muokkaamista eMMC-muistissa. Boot-osion pitäisi olla jo liitettynä tietokoneeseesi USB-asemana. Avaa asema ja muokkaa `config.txt`-tiedostoa. Lisää tiedoston loppuun seuraava rivi:

    dtoverlay=dwc2,dr_mode=host

Tallenna tiedosto ja sulje se.

### Ulkoisen WiFi-antennin käyttöönotto

Jos sinulla on ulkoinen WiFi-antenni, `config.txt`-tiedostoa on muokattava uudelleen. Lisää tiedoston loppuun seuraava rivi:

    dtparam=ant2

Muut mahdolliset arvot ovat `ant1` piirilevyantennille ja `noant`, joka poistaa molemmat antennit käytöstä. Oletusarvo on `ant1`.
