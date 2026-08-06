---
title: Waveshare MAX-M8Q GNSS HAT
translated_from: 94d29c50a654fad026d00f597a18d7b0d3625d85
---

# GNSS HAT

Waveshare MAX-M8Q GNSS HAT ger en högkvalitativ GNSS-mottagare för Raspberry Pi, baserad på modulen U-blox MAX-M8Q. MAX-M8Q har en GNSS-mottagare för flera satellitsystem med en hög känslighet på −167 dBm. Den stöder GPS, GLONASS, BeiDou och Galileo och kan ta emot från tre av dem samtidigt. Dessutom stöds flera förstärkningssystem som SBAS, QZSS, IMES och D-GPS.

Den här sidan beskriver installation och konfiguration av GNSS HAT-kortet när det används tillsammans med Sailor Hat for Raspberry Pi. Mer information om GNSS HAT-kortet finns på [Waveshares wikisida](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT).

## Ansluta HAT-kortet

Sätt i den genomgående stiftlisten i GNSS HAT-kortets GPIO-kontakt. Anslut sedan HAT-kortet till den 40-poliga GPIO-stiftlisten på Raspberry Pi:n. GNSS HAT-kortet kan staplas ovanpå andra HAT-kort.

### Använda GNSS HAT-kortet tillsammans med RS485 HAT-kortet

MAX-M8Q GNSS HAT har en TIMEPULSE-funktion (PPS) som ger Raspberry Pi:n en mycket
noggrann tidsreferens från GNSS. Tyvärr är den funktionen kopplad till ett GPIO-stift som också används av RS485 HAT-kortet. Om de två enheterna används tillsammans måste det GPIO-stift som krockar kopplas bort fysiskt. Det enklaste sättet
är att klippa av motsvarande stift på den genomgående stiftlisten. Bilden nedan visar vilket stift som ska klippas av.

<figure markdown="span">
![](pps_pin.jpg){ width="50%" }
<figcaption>Stiftet som ska klippas av när GNSS HAT-kortet används tillsammans med RS485 HAT-kortet.</figcaption>
</figure>

För att vara säker på att rätt stift klipps av sätter du i den genomgående stiftlisten en bit i GNSS HAT-kortets GPIO-kontakt. Klipp sedan av toppen på det stift som är markerat i bilden ovan. Ta loss den genomgående stiftlisten och klipp sedan av stiftet vid kontaktens bas.

## Programvarukonfiguration

Programvaruinstallationen för GNSS HAT-kortet kommer att automatiseras i Sailor Hats installationsskript.
Tills vidare måste du konfigurera GNSS HAT-kortet manuellt enligt anvisningarna på [wikisidan för Waveshare MAX-M8Q GNSS HAT](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT). Du behöver inte stegen efter konfigurationen av `gpsd`.

Beroende på konfigurationen ger GNSS HAT-kortet en serieenhet, `/dev/ttyAMA0` eller `/dev/ttyS0`, för NMEA 0183-data. OpenPlotter har ett behändigt verktyg för konfiguration av serieenheter som kan användas för att ställa in GNSS HAT-kortet och koppla det till Signal K.

## Backupbatteri

GNSS HAT-kortet har en kontakt för backupbatteri. Backupbatteriet används för att bevara efemeridinformation när Raspberry Pi:n är strömlös. Backupbatteriet är inte obligatoriskt, men det förkortar tiden det tar att få en GNSS-position efter att Raspberry Pi:n har startats.

Backupbatteriet är av typen ML1220. Det är ett uppladdningsbart litiumbatteri och får **inte** ersättas med ett ej uppladdningsbart batteri (engångsbatteri). Om du gör det uppstår risk för explosion och brand! Avancerade användare kan på egen risk ta bort motståndet R3 för att avaktivera laddningsfunktionen och använda ett ej uppladdningsbart CR1220-batteri. Kopplingsschema och mönsterkortslayout finns på [Waveshares wikisida](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT).
