---
title: Aan de slag
translated_from: 46b4add9db5ebdedd9ae7e3eba99744cd34a074c
---

# Aan de slag

## Hardwaremontage

De SH-RPi wordt volledig gemonteerd geleverd. De stappen voor de hardware-installatie zijn:

1. Steek de 40-pins doorsteekpinheader via de aansluiting aan de onderzijde in de SH-RPi, met de pinnen naar boven.
2. Plaats de SH-RPi op de GPIO-pinheader van de Raspberry Pi (eventueel met de zeskantafstandsbussen).
3. Sluit passende voedingsaders op de klemmenstekkers aan. De klemmenstekkers worden geleverd met vastgedraaide schroeven; draai deze los voordat u de aders erin steekt.

<figure markdown="span">
![](shrpi_v2_hardware_assembly.jpg){ width="50%" }
<figcaption>Montageschema van de hardware voor de SH-RPi v2.0.0.</figcaption>
</figure>

### Voedingsaansluiting

!!! warning
    Sluit de voedingsingang nooit aan op de 5 V-uitgangsconnector! Dat beschadigt de Raspberry Pi en de SH-RPi blijvend.

Sluit een voedingsbron van 10–32 V aan op de voedingsingang van de SH-RPi, zoals in de volgende afbeelding is weergegeven.

<figure markdown="span">
![](shrpi_power_input.jpg){ width="50%" }
<figcaption>Sluit de voedingsbron aan op de connector die groen omcirkeld is.</figcaption>
</figure>

De voedingsbron moet bij de opgegeven uitgangsspanning ten minste 1,0 A kunnen leveren.
Als al het overige gelijk blijft, werkt het geheel iets efficiënter met een voeding met een hogere uitgangsspanning, bijvoorbeeld 24 V.
Verder voldoen 12 V-voedingssystemen op boten en in voertuigen, of gelijkspanningsbronnen, prima.

## Software-installatie

Raspberry Pi OS heeft extra software nodig om de systeemservice te draaien die het systeem automatisch afsluit wanneer de voeding wegvalt.
Om de installatie te vereenvoudigen is er een geautomatiseerd installatiescript.

### Geautomatiseerde installatie

Er is een geautomatiseerd installatiescript beschikbaar. Het script is getest op een vers geflasht Raspberry Pi OS en kan mislukken op sterk gewijzigde systemen.
De installatie is niet getest op andere besturingssystemen.

Kopieer en plak de volgende opdracht in de opdrachtprompt van de Raspberry Pi om het geautomatiseerde installatiescript uit te voeren:

    curl -L \
        https://raw.githubusercontent.com/hatlabs/SH-RPi-daemon/main/install-online.sh \
        | sudo bash

De opdracht beslaat drie regels en kan bij het plakken in het terminalvenster regelvervolgtekens tonen. Dat is normaal. Druk op “Enter” om de opdracht uit te voeren.

<figure markdown="span">
![](automated-installation-screenshot.png){ width="80%" }
<figcaption>Installatieopdracht in de terminal</figcaption>
</figure>

De opdracht haalt het installatiescript op en voert het automatisch uit.

Het geautomatiseerde installatiescript:

- schakelt de I2C-interface in, die de SH-RPi nodig heeft om met de Raspberry Pi te communiceren
- als ondersteuning voor de uitbreidingsprint met NMEA 2000-interface is gekozen
  - schakelt het de SPI-interface en een device overlay in
  - definieert het de CAN-netwerkinterface
- als ondersteuning voor de uitbreidingsprint met NMEA 0183-interface is gekozen
  - schakelt het de SPI-interface en een device overlay in
- schakelt de device overlay voor de realtimeklok in
- als ondersteuning voor de MAX-M8Q GNSS HAT is gekozen
  - schakelt het de seriële UART-interface in
  - schakelt het de seriële console uit
  - schakelt het Bluetooth uit, omdat dit conflicteert met de seriële UART-interface
- installeert de servicesoftware van de SH-RPi

## Behuizingen

Plaats het apparaat altijd in een waterdichte behuizing als u de Raspberry Pi en de SH-RPi buiten, in een voertuig of op een boot, of in sterk condenserende omgevingen wilt gebruiken!
Hat Labs
biedt verschillende [waterdichte behuizingen](https://shop.hatlabs.fi/collections/accessories-enclosures) aan.

Bij de middelgrote en de grote behuizing worden een geperforeerde grondplaat en montageadapters geleverd waarmee de Raspberry Pi, extra HAT's en andere componenten kunnen worden bevestigd.
Bij de overige behuizingen worden 3D-geprinte zelfklevende houders geleverd.

### Opbouw van de middelgrote behuizing

De middelgrote behuizing is zo ontworpen dat de Raspberry Pi 4 Model B, de SH-RPi en meerdere HAT's er in verticale stand in passen. De installatie wordt hieronder beschreven.

#### Montage

We beginnen met een lege behuizing, te zien in de volgende afbeelding.

<figure markdown="span">
![](01_bare_box.jpg){ width="50%" }
<figcaption>De behuizing zonder componenten.</figcaption>
</figure>

Monteer eerst alle connectoren die u nodig hebt. Voordat u de connectoren monteert, moet u er mogelijk aders aan solderen. Soldeerinstructies voor soldeercups vindt u in deze YouTube-video:

<iframe width="560" height="315" src="https://www.youtube.com/embed/_GLeCt_u3U8" frameborder="0" allowfullscreen></iframe>

Er is geen echte standaard voor de pinbezetting van voedingsconnectoren, maar wij raden aan `GND` altijd op pin 1 aan te sluiten en +12 V/24 V op pin 2. De volgende afbeelding toont de gemonteerde voedingsconnector.

Steek de connectoren vervolgens in de behuizing. De volgende afbeelding toont de gemonteerde connectoren.

<figure markdown="span">
![](02_conx.jpg){ width="50%" }
<figcaption>Gemonteerde connectoren.</figcaption>
</figure>

Als de behuizing in een condenserende omgeving wordt gebruikt, bijvoorbeeld op een boot of buiten, dicht de resterende gaten dan af met kabelwartels met blindplug. De volgende afbeelding laat zien hoe de plug in de kabelwartel wordt geplaatst.

<figure markdown="span">
![](03_gland_plug.jpg){ width="50%" }
<figcaption>Blindplug voor de kabelwartel.</figcaption>
</figure>

En de volgende afbeelding toont de gemonteerde kabelwartels. Daarmee is de behuizing waterdicht.

<figure markdown="span">
![](04_conx_plugs.jpg){ width="50%" }
<figcaption>Gemonteerde kabelwartels.</figcaption>
</figure>

Vervolgens nemen we de onderdelen die we in de behuizing willen monteren en leggen we ze op de grondplaat. De volgende afbeelding toont de te monteren onderdelen. De zwarte kunststof delen zijn de verticale houders die de printstapel op zijn plaats houden.

<figure markdown="span">
![](05_ingredients.jpg){ width="50%" }
<figcaption>Ingrediënten.</figcaption>
</figure>

Eerst worden de zeskantafstandsbussen van 6 mm in de verticale houders geschroefd. Alleen handvast aandraaien!

De volgende afbeelding toont de verticale houders met de gemonteerde afstandsbussen.

<figure markdown="span">
![](06_vertical_mounts.jpg){ width="50%" }
<figcaption>Verticale houders met zeskantafstandsbussen.</figcaption>
</figure>

Daarna kunt u de houders aan de Raspberry Pi of de onderste print bevestigen. Gebruik de M2,5-schroeven om de print naast de GPIO-pinnen te bevestigen en de M2,5-zeskantafstandsbussen van 16 mm aan de andere zijde.

Vervolgens plaatsen we de doorsteekpinheader op de SH-RPi. Druk voorzichtig en gelijkmatig om verbogen pinnen te voorkomen. De optimale hoogte van de header hangt af van de volgorde van de HAT's. Plaatst u de SH-RPi direct op de Raspberry Pi, verwijder dan het afstandsplaatje van de doorsteekpinheader. Het afstandsplaatje is juist wél nodig als u de SH-RPi op een andere interface-HAT monteert.

<figure markdown="span">
![](07_stack_thru_conx.jpg){ width="50%" }
<figcaption>De doorsteekpinheader plaatsen.</figcaption>
</figure>

De volgende afbeelding toont de SH-RPi gemonteerd op de onderste print.

<figure markdown="span">
![](08_shrpi_mounted.jpg){ width="50%" }
<figcaption>SH-RPi gemonteerd op de onderste print.</figcaption>
</figure>

#### Voedingsbedrading

In dit stappenplan monteren we ook een extra CAN HAT voor NMEA 2000-connectiviteit. De volgende afbeelding toont de CAN HAT gemonteerd op de SH-RPi.

<figure markdown="span">
![](09_can_mounted.jpg){ width="50%" }
<figcaption>CAN HAT gemonteerd op de SH-RPi.</figcaption>
</figure>

De volgende stap is het monteren van de printstapel op de grondplaat. Zet de stapel vast met de meegeleverde M3-schroeven. Draai de schroeven niet te vast aan.

<figure markdown="span">
![](10_on_base_mount.jpg){ width="50%" }
<figcaption>Printstapel gemonteerd op de grondplaat.</figcaption>
</figure>

Strip vervolgens de aders van de connectoren. Als een aparte voedingsconnector wordt gebruikt, laat u de rode ader van NMEA 2000 ongestript of knipt u die helemaal af. De volgende afbeelding toont de gestripte aders.

<figure markdown="span">
![](13_stripped_wires.jpg){ width="50%" }
<figcaption>Gestripte voedings- en CAN-aders.</figcaption>
</figure>

De volgende stap is het aansluiten van de aders op de connectoren op de print. De voedingsconnector wordt op de klemmenstekker aangesloten zoals in de volgende afbeelding.

Let er bij het insteken van de klemmenstekker _heel_ goed op dat u die in de ingangsconnector van de SH-RPi steekt. Steekt u hem in de 5 V-uitgangsconnector, dan kunt u alle apparaten in de stapel beschadigen!

<figure markdown="span">
![](14_power_conx.jpg){ width="50%" }
<figcaption>Aansluiting van de klemmenstekker van de voedingsconnector.</figcaption>
</figure>

Sluit daarna de CAN-aders aan op connector `CAN0` van de CAN HAT, zoals hieronder weergegeven. Zwart is massa, wit is CAN high (H) en blauw is CAN low (L).

<figure markdown="span">
![](15_wires_plugged.jpg){ width="50%" }
<figcaption>Definitieve bedrading.</figcaption>
</figure>

#### Voeding vanuit NMEA 2000

Aan boord van een boot kunt u het systeem ook vanuit het NMEA 2000-netwerk voeden. In dat geval worden alle aders van de NMEA 2000-connector gebruikt.

<figure markdown="span">
![](18_alt_can_wires.jpg){ width="50%" }
<figcaption>Wanneer het apparaat vanuit het NMEA 2000-netwerk wordt gevoed, worden alle aders van de NMEA 2000-connector gebruikt.</figcaption>
</figure>

De zwarte en de rode ader worden op de klemmenstekker van de voeding aangesloten, waarbij een kort stukje zwarte ader op de `GND`-klem wordt meegenomen, zoals in de volgende afbeelding. Die korte zwarte ader gaat naar de `GND`-klem van de `CAN0`-connector van de CAN HAT.

<figure markdown="span">
![](19_spliced_gnd.jpg){ width="50%" }
<figcaption>Sluit de `GND`-ader van NMEA 2000 aan op zowel de klemmenstekker van de voeding als de `CAN0`-connector van de CAN HAT.</figcaption>
</figure>

De volgende afbeelding toont de definitieve bedrading wanneer het apparaat vanuit het NMEA 2000-netwerk wordt gevoed.

<figure markdown="span">
![](20_can_power_wiring.jpg){ width="50%" }
<figcaption>Definitieve bedrading wanneer het apparaat vanuit het NMEA 2000-netwerk wordt gevoed.</figcaption>
</figure>

#### De stapel vastzetten

Tot slot kan het losse uiteinde van de stapel met kleine kabelbinders op de grondplaat worden vastgezet; eenvoudige kabelbinders zijn daarvoor een simpel en gebruiksvriendelijk alternatief. De volgende twee afbeeldingen tonen de montage van de kabelbinders.

<figure markdown="span">
![](11_tie_wraps.jpg){ width="50%" }
<figcaption>Kabelbinders aangebracht.</figcaption>
</figure>

<figure markdown="span">
![](12_tie_wraps_2.jpg){ width="50%" }
<figcaption>Voltooide montage van de kabelbinders.</figcaption>
</figure>

#### De montage afronden

Op dit punt kan de grondplaat in de behuizing worden geplaatst.

<figure markdown="span">
![](16_in_place.jpg){ width="50%" }
<figcaption>De grondplaat op zijn plaats.</figcaption>
</figure>

Zet de grondplaat met de meegeleverde schroeven vast in de behuizing.

<figure markdown="span">
![](17_screw_base_mount.jpg){ width="50%" }
<figcaption>De grondplaat in de behuizing schroeven.</figcaption>
</figure>

Daarmee is de montage klaar. De afbeelding hieronder toont de opstelling vrolijk knipperend in de behuizing.

<figure markdown="span">
![](21_all_done.jpg){ width="50%" }
<figcaption>De voltooide opstelling.</figcaption>
</figure>

De behuizing kan via de hoekgaten in de afbeelding hieronder aan een wand of een schot worden bevestigd.

<figure markdown="span">
![](22_mounting.jpg){ width="50%" }
<figcaption>Posities van de bevestigingsgaten.</figcaption>
</figure>


### Gaten boren

Gebruikt u een behuizing zonder voorgeboorde gaten, dan moet u de gaten zelf boren.

Er is minimaal één gat nodig voor de voedingsingang en, bij een metalen behuizing, nog een voor een wifi-antenne of een bekabelde ethernetaansluiting.

Plan de plaatsing van de gaten en connectoren op de beoogde installatielocatie.
Wilt u de behuizing aan de wand monteren, plaats de connectoren dan naar beneden gericht om de kans op binnendringend water zo klein mogelijk te maken.

Zowel aluminium als polycarbonaat is betrekkelijk zacht en kan met een trapboor worden geboord (een boor die eruitziet als een klein metalen kerstboompje).
Bij het boren in kunststof happen gewone metaalboren gemakkelijk te veel en kan de wand scheuren.

<figure markdown="span">
![](step_drill_bit.jpg){ width="50%" }
<figcaption>Een voorbeeld van trapboren.</figcaption>
</figure>

Geschikte gatmaten voor verschillende connectoren:

- SMA (wifi-antenne): 6,5–7 mm of 1/4"
- PG7-kabelwartel en M12-paneelconnector (NMEA 2000): 12,5 mm of 1/2"
- SP13-paneelconnectoren (blauwzwarte kunststof connectoren): 13 mm.
- PG9-kabelwartel: 16 mm of 5/8"
- RJ45-paneelconnector: 21–22 mm
- USB type A-paneelconnector: 21–22 mm

### De Raspberry Pi bevestigen

Bij de behuizingen van Hat Labs worden montageadapters geleverd waarmee de Raspberry Pi kan worden bevestigd.

### De paneelconnectoren solderen

Gebruik bij het solderen van de interne aders aan de paneelconnectoren altijd krimpkous om de afzonderlijke aders.
Denk eraan de krimpkous _vóór_ het solderen over de ader te schuiven...
Meestal kunt u eerst soldeer in de holte van de connectorpin aanbrengen en het soldeer daarna opnieuw smelten en de ader erin steken.

### Een ventilator aansluiten

Het is aan te raden een ventilator in de behuizing te plaatsen om de luchtcirculatie en de warmteafvoer via de wanden van de behuizing te verbeteren.
Een kleine ventilator van 40 mm kan met dubbelzijdige tape of smeltlijm in de behuizing worden bevestigd.

De ventilator wordt aangesloten op de algemene 5 V-uitgangsconnector van de SH-RPi:

<figure markdown="span">
![](shrpi_5v_output.jpg){ width="50%" }
<figcaption>Sluit de ventilator aan op de connector waar de rode pijl naar wijst.</figcaption>
</figure>

### De installatie afronden

Sluit de behuizing zodra u de gaten hebt geboord, de Raspberry Pi hebt bevestigd, de paneelconnectoren hebt gesoldeerd en de ventilator hebt aangesloten, zodat de SH-RPi en de Raspberry Pi tegen weer en wind beschermd zijn. Controleer of alle verbindingen goed vastzitten en de behuizing goed is afgedicht, zodat er geen water kan binnendringen.

### Het systeem testen

Schakel na afloop van de installatie het Raspberry Pi- en SH-RPi-systeem in om te controleren of alles goed werkt. Controleer of de Raspberry Pi opstart, of de ventilator draait en of de SH-RPi met de Raspberry Pi communiceert. Zodra u hebt vastgesteld dat alles werkt, kunt u verdergaan met het configureren van de software en het inpassen van het systeem in de beoogde omgeving.

Gefeliciteerd! U hebt de hardwaremontage en de opbouw van de behuizing voor uw SH-RPi- en Raspberry Pi-systeem met succes afgerond.
