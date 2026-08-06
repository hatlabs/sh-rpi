---
title: Software
translated_from: fde8306627421de6b86970b1032ab7a63699a495
---

# Software

## Inleiding

De Sailor Hat for Raspberry Pi heeft extra software op het Raspberry Pi-besturingssysteem nodig om alle functies van het apparaat te kunnen benutten. Er is een installatiescript waarmee alle benodigde software automatisch op een verse Raspberry Pi OS-installatie wordt geïnstalleerd. Het gebruik van het installatiescript wordt beschreven in het [onderdeel Aan de slag](../getting-started/index.md). De handmatige installatie-instructies hoeft u alleen te volgen als u liever niet hebt dat geautomatiseerde scripts uw systeemconfiguratie wijzigen, of als u een installatieprobleem moet oplossen.

Download voor een handmatige installatie de code op [github.com/hatlabs/SH-RPi-daemon](https://github.com/hatlabs/SH-RPi-daemon). De benodigde software en configuratiewijzigingen en de details van de firmware worden hieronder beschreven.

### I2C en SPI inschakelen

De I2C- en SPI-interfaces moeten worden ingeschakeld. Dat kan door `raspi-config` uit te voeren of door `/boot/firmware/config.txt` rechtstreeks te bewerken.

Gebruikt u `raspi-config`, ga dan verder aan het einde van dit onderdeel.

```bash
sudo nano /boot/firmware/config.txt
```

Zoek de volgende regel op:

```ini
#dtparam=i2c_arm=on
```

en bewerk deze door het commentaarteken aan het begin te verwijderen:

```ini
dtparam=i2c_arm=on
```

### De nieuwe interfaces inschakelen

Bewerk opnieuw `/boot/firmware/config.txt`:

    sudo nano /boot/firmware/config.txt

Scrol omlaag naar de sectie `[all]`.

Daar moet u drie nieuwe regels toevoegen. Schakel eerst de RTC in (als uw apparaat er een heeft):

    dtoverlay=i2c-rtc,pcf8563

Configureer daarna de kernel zodat deze de Sailor Hat bij het uitschakelen een signaal geeft:

    dtoverlay=gpio-poweroff,gpiopin=2,input,active_low=17

Sla het bestand weer op met Ctrl-O en sluit Nano af met Ctrl-X.

## Raspberry Pi-daemon

Om Raspberry Pi OS op de hoogte te brengen van de voedingstoestand moet een daemon (servicesoftware) worden geïnstalleerd.

Als u de repository SH-RPi-daemon hebt gekloond, kunt u de daemon installeren met de volgende opdrachten:

```bash
sudo apt install -y python3-pip
sudo pip3 install .
```

Vervolgens moet u het servicebestand installeren en de service inschakelen:

```bash
sudo install -o root shrpid.service /lib/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable shrpid
```

Dat is alles! Na een herstart start de daemon automatisch.

*Let op: het geautomatiseerde installatiescript dat in het [onderdeel Aan de slag](../getting-started/index.md) wordt beschreven, voert alle hierboven beschreven installatiestappen automatisch uit.*

### Configuratiebestand van de daemon

De instellingen van de daemon past u aan door het configuratiebestand `/etc/shrpid.conf` aan te maken en te bewerken.
Het bestand gebruikt YAML-opmaak.
De volgende opties zijn beschikbaar:

```yaml
# I2C bus number. You should never need to change this.
i2c-bus: 1
# I2C address of the SH-RPi. Only change this if you have custom firmware.
i2c-addr: 0x6d
# Maximum allowed blackout duration before shutdown.
blackout-time-limit: 3.0
# Input voltage limit for blackout detection.
blackout-voltage-limit: 9.0
# Socket file for the REST API. You should never need to change this.
socket: /var/run/shrpid.sock
# Group for the socket file. You should never need to change this.
socket-group: adm
# Command used to initiate a shutdown. Replace this with a custom script
# to customize the shutdown behavior.
poweroff: /sbin/poweroff
```

Een nieuw configuratiebestand maakt u aan door `nano /etc/shrpid.conf` uit te voeren en de bovenstaande inhoud in het bestand te plakken.
Zet de regels die u niet wilt wijzigen als commentaar.
Sla het bestand op met Ctrl-O en sluit Nano af met Ctrl-X.

## Opdrachtregelinterface

De opdrachtregelinterface is een Python-script waarmee de Sailor Hat for Raspberry Pi vanaf de opdrachtregel van de Raspberry Pi kan worden bediend. Het wordt geïnstalleerd door het installatiescript dat in het [onderdeel Aan de slag](../getting-started/index.md) wordt beschreven.

Het script `shrpi` kan met de optie `--help` worden uitgevoerd voor uitleg over de verschillende opdrachten. Hieronder staan enkele belangrijke toepassingen.

```bash
shrpi print
```

Toont de huidige status en configuratie van de Sailor Hat for Raspberry Pi.

```bash
shrpi set <option> <value>
```

Stelt verschillende configuratiewaarden in. Bijvoorbeeld:

```bash
shrpi set led 50
```

stelt de helderheid van de leds in op 50%.

```bash
shrpi sleep 3600
```

Sluit de Raspberry Pi af en schakelt hem na 3600 seconden (1 uur) weer in.

```bash
shrpi sleep 15:00
```

Sluit de Raspberry Pi af en schakelt hem om 15:00 uur (3 uur 's middags) weer in.

```bash
shrpi sleep 15:00:00
```

## REST-API

`shrpid` implementeert een REST-API waarmee de huidige status en configuratie van de Sailor Hat for Raspberry Pi kunnen worden opgevraagd en configuratiewaarden kunnen worden ingesteld.
De API is beschikbaar via een bestandssocket op `/var/run/shrpid.sock`. Hieronder staat een voorbeeld van een aanroep met `curl`:

    curl --unix-socket /var/run/shrpid.sock http://localhost/state

Zie voor meer details over de beschikbare opdrachten de [broncode van SH-RPi-daemon](https://github.com/hatlabs/SH-RPi-daemon/).

## Firmware

De programmacode die op de ingebouwde ATtiny1616-microcontroller draait, heet de SH-RPi-firmware.

De firmwarerepository staat op [https://github.com/hatlabs/SH-RPi-firmware](https://github.com/hatlabs/SH-RPi-firmware).

De volgende onderdelen beschrijven hoe u de firmware bijwerkt om nieuwe functies te krijgen, of als u er zelf aan wilt sleutelen.

### De firmware bijwerken

De SH-RPi-firmware kan met de Raspberry Pi zelf worden bijgewerkt.
Daarvoor zijn een paar jumpers en wat softwareconfiguratie nodig.

Het flashen gebeurt via de UPDI-interface van de ATtiny met [`avrdude`](https://github.com/SpenceKonde/AVR-Guidance/blob/master/UPDI/jtag2updi.md).

#### Hardwareconfiguratie

Plaats jumpers op alle pinnen van de `PROG`-header, zoals in het rood aangegeven in de afbeelding hieronder. Daarmee worden de programmeerschakeling van de microcontroller en de seriële debuginterface met de Raspberry Pi verbonden. Bovendien wordt de 5 V-uitgang van de step-downcontroller geforceerd ingeschakeld, zodat de Raspberry Pi zichzelf niet uitschakelt bij het starten van het flashen.

<figure markdown="span">
![](SH-RPi-2.0.0-prog-conx.jpg){ width="50%" }
<figcaption>Plaats de rode jumpers om zelf flashen mogelijk te maken.</figcaption>
</figure>

Let op! Voor een goede werking daarna is het essentieel dat u ten minste de derde jumper van de `PROG`-header verwijdert. Anders kan de Raspberry Pi zichzelf niet uitschakelen.

#### Configuratiewijzigingen op de Raspberry Pi

De volgende stap is het inschakelen van de seriële UART's op de Raspberry Pi. Ze worden gebruikt voor zowel de UPDI- als de seriële debuginterface.
Op Pi's met Bluetooth is de UART normaal gesproken gereserveerd voor de ingebouwde Bluetooth-schakeling. We schakelen Bluetooth dus uit.

Voeg de volgende regels toe aan het einde van `/boot/firmware/config.txt`:

```ini
dtoverlay=disable-bt
dtoverlay=uart5
```

De eerste schakelt de Bluetooth-modem uit. De tweede schakelt de UART5-interface in op GPIO 12 en 13, op pin 32 en 33. Dit is de seriële interface die de SH-RPi-firmware voor debugging gebruikt.

We moeten ook de systeemservice uitschakelen die de Bluetooth-modem initialiseert:

```bash
sudo systemctl disable hciuart
```

Voorkom tot slot dat de seriële systeemconsole zich aan de seriële poort koppelt. Verwijder het deel `console=serial0,115200` aan het begin van `/boot/cmdline.txt`.

Herstart het systeem om de wijzigingen door te voeren.

#### Flashsoftware installeren

Dankzij het framework [PlatformIO](https://platformio.org/) kan al het benodigde gereedschap automatisch worden gedownload en geïnstalleerd. We moeten alleen eerst
de broncode van de firmware ophalen. We installeren het versiebeheersysteem `git` en klonen de firmwarerepository:

```bash
sudo apt update
sudo apt -y install git
git clone git@github.com:hatlabs/SH-RPi-firmware.git
```

Nu kunnen we het PlatformIO-framework installeren:

```bash
sudo pip3 install -U platformio
```

Bewerk het bestand `platformio.ini` en wijzig `upload_port` in `/dev/ttyAMA0`:

```ini
[env]
...
upload_port = /dev/ttyAMA0
monitor_port = /dev/ttyAMA1
```

#### Flashen

Tot slot kunnen we de firmware bouwen en uploaden. De eerste keer dat u deze opdracht uitvoert, wordt het benodigde gereedschap gedownload en geïnstalleerd. Dat kan even duren.

```bash
cd SH-RPi-firmware
pio run -t upload
```

De witte status-leds gaan tijdens het flashen uit. Na een paar seconden gaan ze weer aan en is het flashen klaar. Verwijder op dat moment de jumpers van de `PROG`-header.

#### Bluetooth herstellen

Wilt u Bluetooth blijven gebruiken, denk er dan aan de eerder uitgevoerde stappen ongedaan te maken. Daarvoor draait u de wijzigingen in `/boot/firmware/config.txt` en `/boot/cmdline.txt` terug en schakelt u de service `hciuart` weer in:

1. Verwijder de volgende regels uit `/boot/firmware/config.txt`:

```ini
dtoverlay=disable-bt
dtoverlay=uart5
```

2. Voeg `console=serial0,115200` weer toe aan het begin van `/boot/cmdline.txt`.

3. Schakel de service `hciuart` weer in met:

```bash
sudo systemctl enable hciuart
```

4. Herstart de Raspberry Pi om de wijzigingen door te voeren.

Dat is alles! U hebt de firmware op uw Sailor Hat for Raspberry Pi bijgewerkt en, als u dat wilde, de Bluetooth-functionaliteit hersteld.
