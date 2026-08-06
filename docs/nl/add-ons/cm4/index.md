---
title: Compute Module 4
translated_from: 2769961d8eba6a0a776d8bf6566816716c7c9cac
---

# Compute Module 4

De [Compute Module 4](https://www.raspberrypi.org/products/compute-module-4/) is een compacte computermodule die op een carrierboard wordt geplaatst. Met dezelfde processorprestaties als de Raspberry Pi 4B is de CM4 een krachtige, flexibele en goedkope oplossing voor embedded toepassingen. Bij het bouwen van embedded computers heeft de CM4 verschillende voordelen ten opzichte van de Raspberry Pi 4B:

- Ingebouwd eMMC-flashgeheugen: de CM4-kaarten hebben, afhankelijk van het model, tot 32 GB eMMC-flashgeheugen. Dat geheugen is zowel betrouwbaarder als sneller dan de SD-kaart van de Raspberry Pi 4B.
- Mogelijkheid van een externe wifi-antenne: de CM4 heeft een aparte connector voor een externe wifi-antenne. Dat is handig als de signaalsterkte van de interne wifi-antenne niet voldoende is.
- M.2-connector: veel carrierboards hebben een M.2-connector waarop een M.2-SSD of een M.2-wifimodule kan worden aangesloten.
- Lager stroomverbruik: in informele tests bleken een CM4 met carrierboard ruim 20 % minder te verbruiken dan een Raspberry Pi 4B.

Nadeel is dat de meeste CM4-carrierboards geen USB 3.0-hub bevatten, waardoor de USB-poorten beperkt blijven tot USB 2.0-snelheden. Ook is het flashen van de eMMC iets ingewikkelder dan het flashen van een SD-kaart. Het proces wordt hieronder beschreven.

## Het eMMC-geheugen op de CM4 flashen

Eerst moet u een geschikte systeemimage downloaden. Wij gebruiken de Headless-image van [OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/downloading.html) als voorbeeld, maar het proces is voor andere systeemimages hetzelfde. **Let op:** gebruik altijd een 64-bits systeemimage! Sommige softwarecomponenten werken niet goed op een 32-bits systeem (met name InfluxDB).

Het eMMC-geheugen kan met dezelfde systeemimage worden geflasht als de Raspberry Pi 4B. Het flashen kent twee extra stappen. Ten eerste moet de CM4 in een speciale BOOT-modus worden gezet, die het apparaat juist *belet* op te starten en het flashen van de eMMC mogelijk maakt. Ten tweede moet op de computer waarmee wordt geflasht het kleine gereedschap `rpiboot` worden geïnstalleerd en uitgevoerd, zodat het eMMC-geheugen op uw computer kan worden aangekoppeld. Zijn die stappen eenmaal gezet, dan verloopt het flashen precies zoals bij de Raspberry Pi 4B.

Voor Windows is `rpiboot` beschikbaar als kant-en-klaar programma, maar voor Linux en macOS moet u het uit de broncode compileren. Het proces voor elk platform wordt in de onderstaande hoofdstukken beschreven.

Opmerkingen over het installatieproces:

1. Om de eMMC te flashen moet het carrierboard in de BOOT-modus worden gezet. Op de Waveshare CM4-IO-BASE-kaarten zet u daarvoor het kleine BOOT-schakelaartje naast de HDMI0-connector in de stand ON.
2. Het carrierboard moet tijdens het flashen op een externe voedingsbron zijn aangesloten. Gebruik daarvoor de SH-RPi-kaart!

### Windows

1. Volg de instructies in de [Raspberry Pi-documentatie](https://www.raspberrypi.com/documentation/computers/compute-module.html#flashing-the-compute-module-emmc) om de flashmodus op de hostcomputer in te stellen.
2. Volg de [installatie-instructies voor OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html).
3. **Let op:** start het systeem nog niet op! Er moeten eerst enkele instellingen worden aangepast, zoals beschreven in het onderdeel CM4-configuratie hieronder.
4. Zet de BOOT-schakelaar na het wijzigen van de configuratie terug in de stand OFF en start het systeem opnieuw op. Daarna kunt u verder met de instructies van OpenPlotter.

### Mac

Op een Mac moet u het gereedschap `rpiboot` uit de broncode compileren.

1. Om het gereedschap te compileren moet [Homebrew](https://brew.sh/) geïnstalleerd zijn. Doe dat eerst.
2. Volg vervolgens de [stappen uit de repository `usbboot`](https://github.com/raspberrypi/usbboot#macos). Wanneer u `sudo ./rpiboot` uitvoert, moet het CM4-carrierboard op uw computer aangesloten zijn en via de SH-RPi van voeding zijn voorzien. Krijgt u een foutmelding, controleer dan de USB-kabel en de BOOT-schakelaar op het carrierboard.
3. Volg de [installatie-instructies voor OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html). **Let op:** start het systeem nog niet op! Er moeten eerst enkele instellingen worden aangepast, zoals beschreven in het onderdeel CM4-configuratie hieronder.
4. Zet de BOOT-schakelaar na het wijzigen van de configuratie terug in de stand OFF en start het systeem opnieuw op. Daarna kunt u verder met de instructies van OpenPlotter.

### Linux

Net als op een Mac moet u het gereedschap `rpiboot` op Linux uit de broncode compileren.

1. Om het gereedschap te compileren moet [Homebrew](https://brew.sh/) geïnstalleerd zijn. Doe dat eerst.
2. Volg vervolgens de [stappen uit de repository `usbboot`](https://github.com/raspberrypi/usbboot#linux--cygwin--wsl). Wanneer u `sudo ./rpiboot` uitvoert, moet het CM4-carrierboard op uw computer aangesloten zijn en via de SH-RPi van voeding zijn voorzien. Krijgt u een foutmelding, controleer dan de USB-kabel en de BOOT-schakelaar op het carrierboard.
3. Volg de [installatie-instructies voor OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html). **Let op:** start het systeem nog niet op! Er moeten eerst enkele instellingen worden aangepast, zoals beschreven in het onderdeel CM4-configuratie hieronder.
4. Zet de BOOT-schakelaar na het wijzigen van de configuratie terug in de stand OFF en start het systeem opnieuw op. Daarna kunt u verder met de instructies van OpenPlotter.

## CM4-configuratie

### USB-poorten inschakelen

Voordat het systeem voor het eerst wordt opgestart, moeten er een paar dingen in de configuratie worden gewijzigd. Standaard zijn de USB-poorten op de CM4 uitgeschakeld. Dat is uiteraard een groot probleem als u het systeem met een toetsenbord en muis wilt gebruiken. Om de USB-poorten in te schakelen bewerkt u het bestand `config.txt` op het eMMC-geheugen. De partitie Boot is op uw computer waarschijnlijk al als USB-station aangekoppeld. Open dat station en bewerk het bestand `config.txt`. Voeg de volgende regel toe aan het einde van het bestand:

    dtoverlay=dwc2,dr_mode=host

Sla het bestand op en sluit het.

### Externe wifi-antenne inschakelen

Hebt u een externe wifi-antenne, dan moet u het bestand `config.txt` opnieuw bewerken. Voeg de volgende regel toe aan het einde van het bestand:

    dtparam=ant2

Andere mogelijke waarden zijn `ant1` voor de antenne op de print en `noant` om beide antennes uit te schakelen. De standaardwaarde is `ant1`.
