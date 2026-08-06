---
title: Waveshare 2-Channel Isolated CAN HAT
translated_from: 91112523c75ae01ec3e4cdcdabdcff0fe5fdbd78
---

# CAN HAT

Waveshare 2-Channel Isolated CAN HAT ger två isolerade CAN-gränssnitt för Raspberry Pi. CAN HAT-kortet bygger på CAN-styrkretsen MCP2515 och CAN-transceiverna SI65HVD230/SN65HVD230. Kortet kan användas för att bygga ett enda standardenligt NMEA 2000-gränssnitt eller två andra CAN-gränssnitt. När det används som NMEA 2000-gränssnitt ska den andra kanalen lämnas oanvänd på grund av isolationskraven i NMEA 2000.

HAT-kortet har en inbyggd isolerad DC/DC-omvandlare och behöver ingen extern matning.

Den här sidan beskriver installation och konfiguration av CAN HAT-kortet när det används tillsammans med Sailor Hat for Raspberry Pi. Mer information om CAN HAT-kortet finns på [Waveshares wikisida](https://www.waveshare.com/wiki/2-CH_CAN_HAT).

## Bygelkonfiguration

!!! warning
    Kontrollera bygelpositionerna innan du ansluter HAT-kortet!

CAN HAT-kortet har två byglar för termineringsmotstånden för CAN-bussen på kortet. Vid normal drift måste de stå i läget `OFF`!

Dessutom har CAN HAT-kortet en bygel för spänningsval. Den måste stå i läget `3V3` när kortet används med en Raspberry Pi, annars kan Raspberry Pi:n skadas.

## Ansluta HAT-kortet

Sätt försiktigt i den genomgående stiftlisten i CAN HAT-kortets GPIO-kontakt. Anslut sedan
HAT-kortet till den 40-poliga GPIO-stiftlisten på Raspberry Pi:n eller Sailor Hat. Kontaktkanten ska fästas mot kortet under med sexkantsdistanserna.

När HAT-kortet används med ett NMEA 2000-gränssnitt ska endast gränssnittet CAN0 användas. Gränssnittet CAN1 ska lämnas oanslutet. Bilden nedan visar kabeldragningen för NMEA 2000-gränssnittet.

<figure markdown="span">
![](can_hat_wiring.jpg){ width="50%" }
<figcaption>Kabeldragning för NMEA 2000-gränssnittet. Den röda ledaren lämnas oansluten.</figcaption>
</figure>

## Programvarukonfiguration

Sailor Hats installationsskript kan användas för att konfigurera och aktivera CAN-gränssnittet. Om du vill göra installationen manuellt hittar du detaljerna på [Waveshares wikisida](https://www.waveshare.com/wiki/2-CH_CAN_HAT).

## Driva SH-RPi:n via NMEA 2000-gränssnittet

Det går att driva Raspberry Pi:n via NMEA 2000-gränssnittet. Då ska matnings- och jordledarna från NMEA 2000-nätverket anslutas till SH-RPi:ns strömingång, medan H- och L-ledarna ska gå till CAN0-stiftlisten på CAN HAT-kortet. Dessutom ska en jordförbindelse göras mellan SH-RPi:n och CAN HAT-kortet enligt bilden nedan.

<figure markdown="span">
![](can_hat_n2k_power.jpg){ width="50%" }
<figcaption>Kabeldragning för att driva SH-RPi:n via NMEA 2000-gränssnittet.</figcaption>
</figure>
