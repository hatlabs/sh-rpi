---
title: Waveshare 2-Channel Isolated RS485 HAT
translated_from: 7f4b38c33361ca8118a3f68c596e0fb1633d6f5e
---

# RS485 HAT

De Waveshare 2-Channel Isolated RS485 HAT biedt de Raspberry Pi twee galvanisch gescheiden RS-485-interfaces. Ermee kunt u een bidirectionele NMEA 0183-interface realiseren of twee algemene bidirectionele RS-485-interfaces. Bij gebruik als NMEA 0183-interface dient het ene kanaal voor het ontvangen en het andere voor het verzenden van gegevens.

De HAT heeft een geïntegreerde, galvanisch gescheiden DC/DC-omvormer en heeft geen externe voeding nodig.

De RS485 HAT kan tegelijk met de SH-RPi en de CAN HAT worden gebruikt.

Op deze pagina worden de installatie en de configuratie van de RS485 HAT beschreven bij gebruik samen met de Sailor Hat for Raspberry Pi. Meer informatie over de RS485 HAT vindt u op de [wikipagina van Waveshare](https://www.waveshare.com/wiki/2-CH_RS485_HAT).


## Jumperinstellingen

!!! warning
    Controleer de standen van de jumpers voordat u de HAT aansluit!

De RS485 HAT heeft twee jumpers voor de afsluitweerstanden van de RS-485-bus op de kaart. NMEA 0183 gebruikt geen afsluitweerstanden, dus de jumpers moeten in de stand `OFF` staan!

## De HAT aansluiten

Steek de doorsteekpinheader voorzichtig in de GPIO-connector van de RS485 HAT. Plaats de HAT
vervolgens op de 40-pins GPIO-pinheader van de Raspberry Pi of van de Sailor Hat. Zet de rand met de connector met de zeskantafstandsbussen vast op de kaart eronder.

Bij gebruik van de HAT als NMEA 0183-interface dient kanaal 1 voor het ontvangen van gegevens (RX) en kanaal 2 voor het verzenden van gegevens (TX). De aders TX A en B (of TX+ en TX-) van het zendende apparaat worden aangesloten op de klemmen A en B van kanaal 1 van de HAT, en de aders RX A en B (of RX+ en RX-) van het ontvangende apparaat op de klemmen A en B van kanaal 2 van de HAT. De afbeelding hieronder toont de bedrading voor de NMEA 0183-interface.

<figure markdown="span">
![](nmea0183_wiring.jpg){ width="50%" }
<figcaption>Bedrading voor de NMEA 0183-interface. De kleuren van de aders kunnen per apparaat verschillen.</figcaption>
</figure>

## Softwareconfiguratie

Met het installatiescript van de Sailor Hat kunt u de RS-485-interface configureren en inschakelen. De interface bestaat uit twee seriële apparaten: `/dev/ttySC0` en `/dev/ttySC1`. Daarvan wordt `/dev/ttySC0` gebruikt voor het ontvangen en `/dev/ttySC1` voor het verzenden van gegevens. Deze kunt u instellen bij de dataverbindingen van Signal K of in elke andere NMEA 0183-toepassing van uw keuze.

Wilt u de installatie handmatig uitvoeren, raadpleeg dan de [wikipagina van Waveshare](https://www.waveshare.com/wiki/2-CH_RS485_HAT) voor details.
