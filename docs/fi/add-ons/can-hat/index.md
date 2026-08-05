---
title: Waveshare 2-Channel Isolated CAN HAT
translated_from: 91112523c75ae01ec3e4cdcdabdcff0fe5fdbd78
---

# CAN HAT

Waveshare 2-Channel Isolated CAN HAT tarjoaa Raspberry Pi:lle kaksi erotettua CAN-liitäntää. CAN HAT perustuu MCP2515-CAN-ohjaimeen ja SI65HVD230/SN65HVD230-CAN-lähetinvastaanottimiin. Kortilla voi toteuttaa joko yhden standardinmukaisen NMEA 2000 -liitännän tai kaksi muuta CAN-liitäntää. NMEA 2000 -liitäntänä käytettäessä toinen kanava on jätettävä käyttämättä NMEA 2000:n erotusvaatimusten vuoksi.

Kortissa on integroitu erotettu DC/DC-muunnin, eikä se tarvitse ulkoista käyttöjännitettä.

Tällä sivulla kuvataan CAN HATin asennus ja asetukset, kun sitä käytetään yhdessä Sailor Hat for Raspberry Pi:n kanssa. Lisätietoja CAN HATista löytyy [Waveshare-wikisivulta](https://www.waveshare.com/wiki/2-CH_CAN_HAT).

## Hyppyjen asetukset

!!! warning
    Tarkista hyppyjen asennot ennen kortin kytkemistä!

CAN HATissa on kaksi hyppyä kortin omille CAN-väylän päätevastuksille. Normaalikäytössä niiden on oltava `OFF`-asennossa!

Lisäksi CAN HATissa on jännitteenvalintahyppy. Sen on oltava asennossa `3V3`, kun korttia käytetään Raspberry Pi:n kanssa, muuten Raspberry Pi voi vaurioitua.

## Kortin kytkeminen

Työnnä pinoamisliitin varovasti CAN HATin GPIO-liittimeen. Kytke sitten kortti Raspberry Pi:n tai Sailor Hatin 40-nastaiseen GPIO-liittimeen. Liittimen puoleinen reuna kiinnitetään alla olevaan korttiin kuusiokantaisilla välikkeillä.

Kun korttia käytetään NMEA 2000 -liitäntänä, vain CAN0-liitäntää tulee käyttää. CAN1-liitäntä jätetään kytkemättä. Alla oleva kuva näyttää NMEA 2000 -liitännän kytkennän.

<figure markdown="span">
![](can_hat_wiring.jpg){ width="50%" }
<figcaption>NMEA 2000 -liitännän kytkentä. Punainen johdin jätetään kytkemättä.</figcaption>
</figure>

## Ohjelmiston asetukset

Sailor Hatin asennusskriptillä voi määrittää ja ottaa käyttöön CAN-liitännän. Jos haluat tehdä asennuksen käsin, katso ohjeet [Waveshare-wikisivulta](https://www.waveshare.com/wiki/2-CH_CAN_HAT).

## SH-RPi:n syöttäminen NMEA 2000 -liitännän kautta

Raspberry Pi:tä voi syöttää NMEA 2000 -liitännän kautta. Tällöin NMEA 2000:n käyttöjännite- ja maajohtimet kytketään SH-RPi:n jännitetuloon, kun taas H- ja L-johtimet menevät CAN HATin CAN0-liittimeen. Lisäksi SH-RPi:n ja CAN HATin välille on tehtävä maayhteys alla olevan kuvan mukaisesti.

<figure markdown="span">
![](can_hat_n2k_power.jpg){ width="50%" }
<figcaption>Kytkentä, jolla SH-RPi:tä syötetään NMEA 2000 -liitännän kautta.</figcaption>
</figure>
