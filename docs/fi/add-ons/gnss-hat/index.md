---
title: Waveshare MAX-M8Q GNSS HAT
---

# GNSS HAT

Waveshare MAX-M8Q GNSS HAT tarjoaa Raspberry Pi:lle laadukkaan GNSS-vastaanottimen, joka perustuu U-bloxin MAX-M8Q-moduuliin. MAX-M8Q:ssa on usean satelliittijärjestelmän GNSS-vastaanotin, jonka herkkyys on korkea, -167 dBm. Se tukee GPS-, GLONASS-, BeiDou- ja Galileo-järjestelmiä ja voi vastaanottaa samanaikaisesti kolmesta niistä. Lisäksi se tukee useita tarkennusjärjestelmiä, kuten SBAS, QZSS, IMES ja D-GPS.

Tällä sivulla kuvataan GNSS HATin asennus ja asetukset, kun sitä käytetään yhdessä Sailor Hat for Raspberry Pi:n kanssa. Lisätietoja GNSS HATista löytyy [Waveshare-wikisivulta](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT).

## Kortin kytkeminen

Työnnä pinoamisliitin GNSS HATin GPIO-liittimeen. Kytke sitten kortti Raspberry Pi:n 40-nastaiseen GPIO-liittimeen. GNSS HATin voi pinota muiden HAT-korttien päälle.

### GNSS HATin käyttö yhdessä RS485 HATin kanssa

MAX-M8Q GNSS HATissa on TIMEPULSE (PPS) -toiminto, jolla Raspberry Pi:lle tuotetaan hyvin tarkka
GNSS-aikareferenssi. Valitettavasti tämä aikapulssitoiminto on kytketty GPIO-nastaan, jota myös RS485 HAT käyttää. Jos näitä kahta laitetta käytetään yhdessä, ristiriitainen GPIO-nasta on katkaistava fyysisesti. Helpoin tapa
tehdä tämä on katkaista kyseinen nasta pinoamisliittimestä. Alla oleva kuva osoittaa katkaistavan nastan.

<figure markdown="span">
![](pps_pin.jpg){ width="50%" }
<figcaption>Nasta, joka on katkaistava käytettäessä GNSS HATia yhdessä RS485 HATin kanssa.</figcaption>
</figure>

Varmistaaksesi, että katkaiset oikean nastan, työnnä pinoamisliitin osittain GNSS HATin GPIO-liittimeen. Katkaise sitten yllä olevassa kuvassa osoitetun nastan yläpää. Irrota pinoamisliitin ja katkaise nasta vasta sitten liittimen tyvestä.

## Ohjelmiston asetukset

GNSS HATin ohjelmistoasennus automatisoidaan Sailor Hatin asennusskriptiin.
Toistaiseksi GNSS HAT on määritettävä käsin [Waveshare MAX-M8Q GNSS HAT -wikisivun](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT) ohjeiden mukaan. `gpsd`-määrityksen jälkeisiä vaiheita ei tarvita.

Asetuksista riippuen GNSS HAT tuottaa NMEA 0183 -dataa sarjaporttilaitteesta `/dev/ttyAMA0` tai `/dev/ttyS0`. OpenPlotterissa on kätevä sarjaporttien määritystyökalu, jolla GNSS HATin voi asettaa ja kytkeä Signal K:hon.

## Varaparisto

GNSS HATissa on varapariston liitin. Varaparistolla säilytetään satelliittien ratatiedot, kun Raspberry Pi on sammutettuna. Varaparisto ei ole pakollinen, mutta se nopeuttaa GNSS-paikannuksen saamista Raspberry Pi:n käynnistyksen jälkeen.

Varapariston tyyppi on ML1220. Se on ladattava litiumkenno, eikä sitä saa **missään tapauksessa** korvata ei-ladattavalla paristolla. Se aiheuttaisi räjähdys- ja palovaaran! Kokeneet käyttäjät voivat omalla vastuullaan poistaa vastuksen R3, jolloin latauspiiri kytkeytyy pois ja ei-ladattavaa CR1220-paristoa voi käyttää. Kytkentäkaaviot ja piirilevyn layout löytyvät [Waveshare-wikisivulta](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT).
