---
title: Waveshare 2-Channel Isolated CAN HAT
translated_from: 91112523c75ae01ec3e4cdcdabdcff0fe5fdbd78
---

# CAN HAT

De Waveshare 2-Channel Isolated CAN HAT biedt de Raspberry Pi twee galvanisch gescheiden CAN-interfaces. De CAN HAT is gebaseerd op de MCP2515-CAN-controller en de CAN-transceivers SI65HVD230/SN65HVD230. Met de HAT kunt u één NMEA 2000-conforme interface realiseren of twee andere CAN-interfaces. Bij gebruik als NMEA 2000-interface moet het tweede kanaal ongebruikt blijven vanwege de isolatie-eisen van NMEA 2000.

De HAT heeft een geïntegreerde, galvanisch gescheiden DC/DC-omvormer en heeft geen externe voeding nodig.

Op deze pagina worden de installatie en de configuratie van de CAN HAT beschreven bij gebruik samen met de Sailor Hat for Raspberry Pi. Meer informatie over de CAN HAT vindt u op de [wikipagina van Waveshare](https://www.waveshare.com/wiki/2-CH_CAN_HAT).

## Jumperinstellingen

!!! warning
    Controleer de standen van de jumpers voordat u de HAT aansluit!

De CAN HAT heeft twee jumpers voor de afsluitweerstanden van de CAN-bus op de kaart. Voor normaal gebruik moeten die in de stand `OFF` staan!

Daarnaast heeft de CAN HAT een jumper voor de spanningskeuze. Die moet bij gebruik met een Raspberry Pi op `3V3` staan, anders kan de Raspberry Pi beschadigd raken.

## De HAT aansluiten

Steek de doorsteekpinheader voorzichtig in de GPIO-connector van de CAN HAT. Plaats de HAT
vervolgens op de 40-pins GPIO-pinheader van de Raspberry Pi of van de Sailor Hat. Zet de rand met de connector met de zeskantafstandsbussen vast op de kaart eronder.

Bij gebruik van de HAT met een NMEA 2000-interface mag alleen de interface CAN0 worden gebruikt. De interface CAN1 blijft onaangesloten. De afbeelding hieronder toont de bedrading voor de NMEA 2000-interface.

<figure markdown="span">
![](can_hat_wiring.jpg){ width="50%" }
<figcaption>Bedrading voor de NMEA 2000-interface. De rode ader blijft onaangesloten.</figcaption>
</figure>

## Softwareconfiguratie

Met het installatiescript van de Sailor Hat kunt u de CAN-interface configureren en inschakelen. Wilt u de installatie handmatig uitvoeren, raadpleeg dan de [wikipagina van Waveshare](https://www.waveshare.com/wiki/2-CH_CAN_HAT) voor details.

## De SH-RPi voeden via de NMEA 2000-interface

Het is mogelijk de Raspberry Pi via de NMEA 2000-interface te voeden. Sluit daarvoor de voedings- en massa-aders van NMEA 2000 aan op de voedingsingang van de SH-RPi, en de aders H en L op de header CAN0 van de CAN HAT. Maak daarnaast een massaverbinding tussen de SH-RPi en de CAN HAT, zoals de afbeelding hieronder laat zien.

<figure markdown="span">
![](can_hat_n2k_power.jpg){ width="50%" }
<figcaption>Bedrading om de SH-RPi via de NMEA 2000-interface te voeden.</figcaption>
</figure>
