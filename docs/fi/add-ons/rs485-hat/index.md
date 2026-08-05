---
title: Waveshare 2-Channel Isolated RS485 HAT
translated_from: 7f4b38c33361ca8118a3f68c596e0fb1633d6f5e
---

# RS485 HAT

Waveshare 2-Channel Isolated RS485 HAT tarjoaa Raspberry Pi:lle kaksi erotettua RS-485-liitäntää. Sillä voi toteuttaa joko kaksisuuntaisen NMEA 0183 -liitännän tai kaksi yleiskäyttöistä kaksisuuntaista RS-485-liitäntää. NMEA 0183 -liitäntänä käytettäessä toista kanavaa käytetään vastaanottoon ja toista lähetykseen.

Kortissa on integroitu erotettu DC/DC-muunnin, eikä se tarvitse ulkoista käyttöjännitettä.

RS485 HATia voi käyttää samanaikaisesti SH-RPi:n ja CAN HATin kanssa.

Tällä sivulla kuvataan RS485 HATin asennus ja asetukset, kun sitä käytetään yhdessä Sailor Hat for Raspberry Pi:n kanssa. Lisätietoja RS485 HATista löytyy [Waveshare-wikisivulta](https://www.waveshare.com/wiki/2-CH_RS485_HAT).


## Hyppyjen asetukset

!!! warning
    Tarkista hyppyjen asennot ennen kortin kytkemistä!

RS485 HATissa on kaksi hyppyä kortin omille RS-485-väylän päätevastuksille. NMEA 0183 ei käytä päätevastuksia, ja hyppyjen on oltava `OFF`-asennossa!

## Kortin kytkeminen

Työnnä pinoamisliitin varovasti RS-485 HATin GPIO-liittimeen. Kytke sitten kortti Raspberry Pi:n tai Sailor Hatin 40-nastaiseen GPIO-liittimeen. Liittimen puoleinen reuna kiinnitetään alla olevaan korttiin kuusiokantaisilla välikkeillä.

Kun korttia käytetään NMEA 0183 -liitäntänä, kanavaa 1 käytetään datan vastaanottoon (RX) ja kanavaa 2 lähetykseen (TX). Lähettävän laitteen TX A- ja B-johtimet (tai TX+ ja TX-) kytketään kortin kanavan 1 A- ja B-napoihin, kun taas vastaanottavan laitteen RX A- ja B-johtimet (tai RX+ ja RX-) kytketään kortin kanavan 2 A- ja B-napoihin. Alla oleva kuva näyttää NMEA 0183 -liitännän kytkennän.

<figure markdown="span">
![](nmea0183_wiring.jpg){ width="50%" }
<figcaption>NMEA 0183 -liitännän kytkentä. Johdinvärit voivat vaihdella laitteesta riippuen.</figcaption>
</figure>

## Ohjelmiston asetukset

Sailor Hatin asennusskriptillä voi määrittää ja ottaa käyttöön RS-485-liitännän. Liitäntä näkyy kahtena sarjaporttilaitteena: `/dev/ttySC0` ja `/dev/ttySC1`. Näistä `/dev/ttySC0` on vastaanottoa ja `/dev/ttySC1` lähetystä varten. Ne voi määrittää Signal K:n datayhteyksiin tai mihin tahansa muuhun valitsemaasi NMEA 0183 -sovellukseen.

Jos haluat tehdä asennuksen käsin, katso ohjeet [Waveshare-wikisivulta](https://www.waveshare.com/wiki/2-CH_RS485_HAT).
