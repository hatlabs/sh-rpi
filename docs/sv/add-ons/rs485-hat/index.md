---
title: Waveshare 2-Channel Isolated RS485 HAT
translated_from: 7f4b38c33361ca8118a3f68c596e0fb1633d6f5e
---

# RS485 HAT

Waveshare 2-Channel Isolated RS485 HAT ger två isolerade RS-485-gränssnitt för Raspberry Pi. Kortet kan användas för att bygga ett dubbelriktat NMEA 0183-gränssnitt eller två allmänna dubbelriktade RS-485-gränssnitt. När det används som NMEA 0183-gränssnitt används den ena kanalen för att ta emot och den andra för att sända data.

HAT-kortet har en inbyggd isolerad DC/DC-omvandlare och behöver ingen extern matning.

RS485 HAT-kortet kan användas samtidigt med SH-RPi:n och CAN HAT-kortet.

Den här sidan beskriver installation och konfiguration av RS485 HAT-kortet när det används tillsammans med Sailor Hat for Raspberry Pi. Mer information om RS485 HAT-kortet finns på [Waveshares wikisida](https://www.waveshare.com/wiki/2-CH_RS485_HAT).


## Bygelkonfiguration

!!! warning
    Kontrollera bygelpositionerna innan du ansluter HAT-kortet!

RS485 HAT-kortet har två byglar för termineringsmotstånden för RS-485-bussen på kortet. NMEA 0183 använder inga termineringsmotstånd, och byglarna måste stå i läget `OFF`!

## Ansluta HAT-kortet

Sätt försiktigt i den genomgående stiftlisten i RS-485 HAT-kortets GPIO-kontakt. Anslut sedan
HAT-kortet till den 40-poliga GPIO-stiftlisten på Raspberry Pi:n eller Sailor Hat. Kontaktkanten ska fästas mot kortet under med sexkantsdistanserna.

När HAT-kortet används som NMEA 0183-gränssnitt används kanal 1 för att ta emot data (RX) och kanal 2 för att sända data (TX). Den sändande enhetens TX A- och B-ledare (eller TX+ och TX-) ska anslutas till terminalerna A och B på HAT-kortets kanal 1, medan den mottagande enhetens RX A- och B-ledare (eller RX+ och RX-) ska anslutas till terminalerna A och B på HAT-kortets kanal 2. Bilden nedan visar kabeldragningen för NMEA 0183-gränssnittet.

<figure markdown="span">
![](nmea0183_wiring.jpg){ width="50%" }
<figcaption>Kabeldragning för NMEA 0183-gränssnittet. Ledarfärgerna kan variera beroende på enhet.</figcaption>
</figure>

## Programvarukonfiguration

Sailor Hats installationsskript kan användas för att konfigurera och aktivera RS-485-gränssnittet. Gränssnittet tillhandahålls av två serieenheter: `/dev/ttySC0` och `/dev/ttySC1`. Av dessa används `/dev/ttySC0` för att ta emot data och `/dev/ttySC1` för att sända data. De kan konfigureras i Signal K-dataanslutningarna eller i vilken annan NMEA 0183-applikation du vill.

Om du vill göra installationen manuellt hittar du detaljerna på [Waveshares wikisida](https://www.waveshare.com/wiki/2-CH_RS485_HAT).
