---
title: Waveshare MAX-M8Q GNSS HAT
translated_from: 94d29c50a654fad026d00f597a18d7b0d3625d85
---

# GNSS HAT

Waveshare MAX-M8Q GNSS HAT gir Raspberry Pi en GNSS-mottaker av høy kvalitet, basert på U-blox-modulen MAX-M8Q. MAX-M8Q har en GNSS-mottaker for flere satellittsystemer med høy følsomhet på -167 dBm. Den støtter GPS, GLONASS, BeiDou og Galileo og kan motta fra tre av dem samtidig. I tillegg støttes flere korreksjonssystemer som SBAS, QZSS, IMES og D-GPS.

Denne siden beskriver installasjon og konfigurasjon av GNSS HAT-kortet når det brukes sammen med Sailor Hat for Raspberry Pi. Du finner flere detaljer om GNSS HAT-kortet på [wiki-siden til Waveshare](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT).

## Koble til HAT-kortet

Sett den gjennomgående pinnelisten (stack-through) inn i GPIO-kontakten på GNSS HAT-kortet. Plugg deretter HAT-kortet på den 40-pinners GPIO-pinnelisten på Raspberry Pi-en. GNSS HAT-kortet kan stables oppå andre HAT-kort.

### Bruke GNSS HAT-kortet sammen med RS485 HAT-kortet

MAX-M8Q GNSS HAT har en TIMEPULSE-funksjon (PPS) som brukes til å gi Raspberry Pi-en en svært
nøyaktig tidsreferanse fra GNSS. Dessverre er denne tidspulsfunksjonen koblet til en GPIO-pinne som RS485 HAT-kortet også bruker. Hvis de to enhetene brukes sammen, må GPIO-pinnen som er i konflikt, kobles fysisk fra. Den enkleste måten
å gjøre det på er å kutte den aktuelle pinnen på den gjennomgående pinnelisten. Figuren nedenfor viser hvilken pinne som må kuttes.

<figure markdown="span">
![](pps_pin.jpg){ width="50%" }
<figcaption>Pinnen som må kuttes når GNSS HAT-kortet brukes sammen med RS485 HAT-kortet.</figcaption>
</figure>

For å være sikker på at riktig pinne blir kuttet, setter du den gjennomgående pinnelisten delvis inn i GPIO-kontakten på GNSS HAT-kortet. Kutt så toppen av pinnen som er markert i figuren over. Ta ut den gjennomgående pinnelisten og kutt deretter pinnen ved foten av kontakten.

## Programvarekonfigurasjon

Programvareinstallasjonen for GNSS HAT-kortet blir automatisert i installasjonsskriptet for Sailor Hat.
Foreløpig må du konfigurere GNSS HAT-kortet manuelt etter instruksjonene på [wiki-siden for Waveshare MAX-M8Q GNSS HAT](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT). Du trenger ikke stegene etter konfigurasjonen av `gpsd`.

Avhengig av konfigurasjonen gir GNSS HAT-kortet en seriell enhet `/dev/ttyAMA0` eller `/dev/ttyS0` for NMEA 0183-data. OpenPlotter har et hendig verktøy for konfigurasjon av serielle enheter som kan brukes til å sette opp GNSS HAT-kortet og koble det til Signal K.

## Reservebatteri

GNSS HAT-kortet har en kontakt for reservebatteri. Reservebatteriet brukes til å lagre efemeridedata i tilfelle Raspberry Pi-en blir slått av. Reservebatteriet er ikke påkrevd, men det korter ned tiden det tar å få GNSS-posisjon etter at Raspberry Pi-en er slått på.

Reservebatteriet er av typen ML1220. Det er en oppladbar litiumcelle, og den må **ikke** erstattes med et ikke-oppladbart batteri. Gjør du det, oppstår det fare for eksplosjon og brann! Erfarne brukere kan på eget ansvar fjerne motstanden R3 for å deaktivere ladefunksjonen og bruke et ikke-oppladbart CR1220-batteri. Koblingsskjema og kretskortlayout er tilgjengelig på [wiki-siden til Waveshare](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT).
