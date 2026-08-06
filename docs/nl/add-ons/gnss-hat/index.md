---
title: Waveshare MAX-M8Q GNSS HAT
translated_from: 94d29c50a654fad026d00f597a18d7b0d3625d85
---

# GNSS HAT

De Waveshare MAX-M8Q GNSS HAT biedt de Raspberry Pi een hoogwaardige GNSS-ontvanger op basis van de U-blox MAX-M8Q-module. De MAX-M8Q bevat een GNSS-ontvanger voor meerdere satellietconstellaties met een hoge gevoeligheid van −167 dBm. Hij ondersteunt GPS, GLONASS, BeiDou en Galileo en kan van drie daarvan tegelijk ontvangen. Daarnaast worden verschillende correctiesystemen zoals SBAS, QZSS, IMES en D-GPS ondersteund.

Op deze pagina worden de installatie en de configuratie van de GNSS HAT beschreven bij gebruik samen met de Sailor Hat for Raspberry Pi. Meer informatie over de GNSS HAT vindt u op de [wikipagina van Waveshare](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT).

## De HAT aansluiten

Steek de doorsteekpinheader in de GPIO-connector van de GNSS HAT. Plaats de HAT vervolgens op de 40-pins GPIO-pinheader van de Raspberry Pi. De GNSS HAT kan bovenop andere HAT's worden gestapeld.

### De GNSS HAT samen met de RS485 HAT gebruiken

De MAX-M8Q GNSS HAT beschikt over een TIMEPULSE-functie (PPS) die de Raspberry Pi een zeer
nauwkeurige GNSS-tijdreferentie levert. Helaas is die tijdpuls verbonden met een GPIO-pin die ook door de RS485 HAT wordt gebruikt. Worden beide apparaten samen gebruikt, dan moet de conflicterende GPIO-pin fysiek worden losgekoppeld. Dat doet u het eenvoudigst
door de betreffende pin op de doorsteekpinheader door te knippen. De afbeelding hieronder markeert de pin die moet worden doorgeknipt.

<figure markdown="span">
![](pps_pin.jpg){ width="50%" }
<figcaption>De pin die moet worden doorgeknipt wanneer de GNSS HAT samen met de RS485 HAT wordt gebruikt.</figcaption>
</figure>

Om zeker te zijn dat de juiste pin wordt doorgeknipt, steekt u de doorsteekpinheader gedeeltelijk in de GPIO-connector van de GNSS HAT. Knip vervolgens de bovenkant af van de pin die in de afbeelding hierboven is gemarkeerd. Neem de doorsteekpinheader los en knip de pin daarna bij de voet van de connector door.

## Softwareconfiguratie

De software-installatie van de GNSS HAT wordt geautomatiseerd met het installatiescript van de Sailor Hat.
Voorlopig moet u de GNSS HAT handmatig configureren volgens de instructies op de [wikipagina van de Waveshare MAX-M8Q GNSS HAT](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT). De stappen na de configuratie van `gpsd` hebt u niet nodig.

Afhankelijk van de configuratie biedt de GNSS HAT een serieel apparaat `/dev/ttyAMA0` of `/dev/ttyS0` met NMEA 0183-gegevens. OpenPlotter heeft een handig gereedschap voor het instellen van seriële apparaten, waarmee de GNSS HAT kan worden geconfigureerd en met Signal K verbonden.

## Backupbatterij

De GNSS HAT heeft een connector voor een backupbatterij. De backupbatterij bewaart de efemeridegegevens wanneer de Raspberry Pi is uitgeschakeld. De backupbatterij is niet verplicht, maar verkort de tijd tot de eerste GNSS-fix nadat de Raspberry Pi is ingeschakeld.

Het type backupbatterij is ML1220. Dit is een oplaadbare lithiumcel en mag **niet** worden vervangen door een niet-oplaadbare batterij. Dat levert gevaar op voor explosie en brand! Gevorderde gebruikers kunnen, op eigen risico, weerstand R3 verwijderen om de laadfunctie uit te schakelen en zo een niet-oplaadbare CR1220-batterij te gebruiken. De schema's en de printlayout staan op de [wikipagina van Waveshare](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT).
