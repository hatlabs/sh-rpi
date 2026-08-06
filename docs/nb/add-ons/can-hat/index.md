---
title: Waveshare 2-Channel Isolated CAN HAT
translated_from: 91112523c75ae01ec3e4cdcdabdcff0fe5fdbd78
---

# CAN HAT

Waveshare 2-Channel Isolated CAN HAT gir Raspberry Pi to galvanisk skilte CAN-grensesnitt. CAN HAT-kortet bygger på CAN-kontrolleren MCP2515 og CAN-transceivere av typen SI65HVD230/SN65HVD230. Kortet kan brukes til å lage ett standardkompatibelt NMEA 2000-grensesnitt eller to andre CAN-grensesnitt. Når kortet brukes som NMEA 2000-grensesnitt, bør den andre kanalen stå ubrukt på grunn av kravene til galvanisk skille i NMEA 2000.

Kortet har en integrert galvanisk skilt DC/DC-omformer og trenger ingen ekstern strømtilførsel.

Denne siden beskriver installasjon og konfigurasjon av CAN HAT-kortet når det brukes sammen med Sailor Hat for Raspberry Pi. Du finner flere detaljer om CAN HAT-kortet på [wiki-siden til Waveshare](https://www.waveshare.com/wiki/2-CH_CAN_HAT).

## Jumperkonfigurasjon

!!! warning
    Kontroller jumperposisjonene før du kobler til HAT-kortet!

CAN HAT-kortet har to jumpere for termineringsmotstander for CAN-bussen på kortet. Ved normal drift må de stå i posisjonen `OFF`!

I tillegg har CAN HAT-kortet en jumper for spenningsvalg. Den må settes til `3V3` når kortet brukes med en Raspberry Pi, ellers kan Raspberry Pi-en bli skadet.

## Koble til HAT-kortet

Sett den gjennomgående pinnelisten (stack-through) forsiktig inn i GPIO-kontakten på CAN HAT-kortet. Plugg deretter
HAT-kortet på den 40-pinners GPIO-pinnelisten på Raspberry Pi-en eller Sailor Hat-kortet. Kontaktkanten bør festes til kortet under med de sekskantede avstandsboltene.

Når HAT-kortet brukes med et NMEA 2000-grensesnitt, skal bare CAN0-grensesnittet brukes. CAN1-grensesnittet skal stå ukoblet. Figuren nedenfor viser kablingen for NMEA 2000-grensesnittet.

<figure markdown="span">
![](can_hat_wiring.jpg){ width="50%" }
<figcaption>Kabling for NMEA 2000-grensesnittet. Den røde ledningen er ikke tilkoblet.</figcaption>
</figure>

## Programvarekonfigurasjon

Installasjonsskriptet for Sailor Hat kan brukes til å konfigurere og aktivere CAN-grensesnittet. Hvis du vil gjøre installasjonen manuelt, finner du detaljer på [wiki-siden til Waveshare](https://www.waveshare.com/wiki/2-CH_CAN_HAT).

## Forsyne SH-RPi fra NMEA 2000-grensesnittet

Det er mulig å forsyne Raspberry Pi-en fra NMEA 2000-grensesnittet. Da skal strøm- og jordledningene fra NMEA 2000 kobles til strøminngangen på SH-RPi, mens H- og L-ledningene skal gå til CAN0-pinnelisten på CAN HAT-kortet. I tillegg må det lages en jordforbindelse mellom SH-RPi og CAN HAT-kortet, slik figuren nedenfor viser.

<figure markdown="span">
![](can_hat_n2k_power.jpg){ width="50%" }
<figcaption>Kablingsoppsett for å forsyne SH-RPi fra NMEA 2000-grensesnittet.</figcaption>
</figure>
