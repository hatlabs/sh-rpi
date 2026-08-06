---
title: Waveshare 2-Channel Isolated RS485 HAT
translated_from: 7f4b38c33361ca8118a3f68c596e0fb1633d6f5e
---

# RS485 HAT

Waveshare 2-Channel Isolated RS485 HAT gir Raspberry Pi to galvanisk skilte RS-485-grensesnitt. Kortet kan brukes til å lage ett toveis NMEA 0183-grensesnitt eller to generelle toveis RS-485-grensesnitt. Når kortet brukes som NMEA 0183-grensesnitt, brukes den ene kanalen til å motta og den andre til å sende data.

Kortet har en integrert galvanisk skilt DC/DC-omformer og trenger ingen ekstern strømtilførsel.

RS485 HAT-kortet kan brukes samtidig med SH-RPi og CAN HAT-kortet.

Denne siden beskriver installasjon og konfigurasjon av RS485 HAT-kortet når det brukes sammen med Sailor Hat for Raspberry Pi. Du finner flere detaljer om RS485 HAT-kortet på [wiki-siden til Waveshare](https://www.waveshare.com/wiki/2-CH_RS485_HAT).


## Jumperkonfigurasjon

!!! warning
    Kontroller jumperposisjonene før du kobler til HAT-kortet!

RS485 HAT-kortet har to jumpere for termineringsmotstander for RS-485-bussen på kortet. NMEA 0183 bruker ikke terminering, og begge må stå i posisjonen `OFF`!

## Koble til HAT-kortet

Sett den gjennomgående pinnelisten (stack-through) forsiktig inn i GPIO-kontakten på RS-485 HAT-kortet. Plugg deretter
HAT-kortet på den 40-pinners GPIO-pinnelisten på Raspberry Pi-en eller Sailor Hat-kortet. Kontaktkanten bør festes til kortet under med de sekskantede avstandsboltene.

Når HAT-kortet brukes som NMEA 0183-grensesnitt, brukes kanal 1 til å motta data (RX) og kanal 2 til å sende data (TX). A- og B-ledningene for TX på den sendende enheten (eller TX+ og TX-) skal kobles til klemmene A og B på kanal 1 på HAT-kortet, mens A- og B-ledningene for RX på den mottakende enheten (eller RX+ og RX-) skal kobles til klemmene A og B på kanal 2. Figuren nedenfor viser kablingen for NMEA 0183-grensesnittet.

<figure markdown="span">
![](nmea0183_wiring.jpg){ width="50%" }
<figcaption>Kabling for NMEA 0183-grensesnittet. Ledningsfargene kan variere fra enhet til enhet.</figcaption>
</figure>

## Programvarekonfigurasjon

Installasjonsskriptet for Sailor Hat kan brukes til å konfigurere og aktivere RS-485-grensesnittet. Grensesnittet leveres som to serielle enheter: `/dev/ttySC0` og `/dev/ttySC1`. Av disse brukes `/dev/ttySC0` til å motta data og `/dev/ttySC1` til å sende data. Disse kan settes opp i datatilkoblingene i Signal K eller i et hvilket som helst annet NMEA 0183-program du velger.

Hvis du vil gjøre installasjonen manuelt, finner du detaljer på [wiki-siden til Waveshare](https://www.waveshare.com/wiki/2-CH_RS485_HAT).
