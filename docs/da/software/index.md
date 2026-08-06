---
title: Software
translated_from: fde8306627421de6b86970b1032ab7a63699a495
---

# Software

## Introduktion

Sailor Hat for Raspberry Pi kræver ekstra software på Raspberry Pi-styresystemet, for at enhedens funktioner kan udnyttes fuldt ud. Der findes et installationsscript, som automatisk installerer al nødvendig software på en ny Raspberry Pi OS-installation. Brugen af installationsscriptet er beskrevet i [afsnittet Kom godt i gang](../getting-started/index.md). Du behøver kun at følge vejledningen til manuel installation, hvis du ikke ønsker, at automatiske scripts ændrer din systemkonfiguration, eller hvis du skal fejlfinde din installation.

Ved manuel installation skal du hente koden på [github.com/hatlabs/SH-RPi-daemon](https://github.com/hatlabs/SH-RPi-daemon). Den nødvendige software og de nødvendige konfigurationsændringer samt detaljerne om firmwaren er beskrevet nedenfor.

### Aktivering af I2C og SPI

I2C- og SPI-grænsefladerne skal aktiveres. Det kan enten gøres ved at køre `raspi-config` eller ved at redigere `/boot/firmware/config.txt` direkte.

Hvis du bruger `raspi-config`, kan du springe frem til slutningen af dette underafsnit.

```bash
sudo nano /boot/firmware/config.txt
```

Find følgende linje:

```ini
#dtparam=i2c_arm=on
```

og rediger den ved at fjerne kommentartegnet i begyndelsen:

```ini
dtparam=i2c_arm=on
```

### Aktivering af de nye grænseflader

Rediger igen `/boot/firmware/config.txt`:

    sudo nano /boot/firmware/config.txt

Rul ned til afsnittet `[all]`.

Der skal tilføjes tre nye linjer. Aktivér først RTC'en (hvis din enhed har en):

    dtoverlay=i2c-rtc,pcf8563

Konfigurer derefter kernen til at give Sailor Hat besked ved slukning:

    dtoverlay=gpio-poweroff,gpiopin=2,input,active_low=17

Skriv igen filen ved at trykke Ctrl-O, og afslut Nano ved at trykke Ctrl-X.

## Raspberry Pi-dæmon

For at Raspberry Pi OS kan kende strømtilstanden, skal der installeres en dæmon (baggrundstjeneste).

Hvis du har klonet SH-RPi-daemon-repositoriet, kan du installere dæmonen med følgende kommandoer:

```bash
sudo apt install -y python3-pip
sudo pip3 install .
```

Derefter skal du installere tjenestens definitionsfil og aktivere tjenesten:

```bash
sudo install -o root shrpid.service /lib/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable shrpid
```

Så er det gjort! Efter en genstart starter dæmonen automatisk.

*Bemærk: Det automatiserede installationsscript, der er beskrevet i [afsnittet Kom godt i gang](../getting-started/index.md), udfører alle de ovenstående trin i softwareinstallationen automatisk.*

### Dæmonens konfigurationsfil

Du kan ændre dæmonens indstillinger ved at oprette og redigere konfigurationsfilen `/etc/shrpid.conf`.
Filen bruger YAML-formatering.
Følgende indstillinger er tilgængelige:

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

Du kan oprette en ny konfigurationsfil ved at køre `nano /etc/shrpid.conf` og indsætte ovenstående indhold i filen.
Kommentér de linjer ud, du ikke vil ændre.
Gem filen ved at trykke Ctrl-O, og afslut Nano ved at trykke Ctrl-X.

## Kommandolinjegrænseflade

Kommandolinjegrænsefladen er et Python-script, som kan bruges til at styre Sailor Hat for Raspberry Pi fra Raspberry Pi'ens kommandolinje. Det installeres af installationsscriptet, der er beskrevet i [afsnittet Kom godt i gang](../getting-started/index.md).

Scriptet `shrpi` kan køres med tilvalget `--help` for at få vejledning i de forskellige kommandoer. Nogle af de vigtigste anvendelser er beskrevet nedenfor.

```bash
shrpi print
```

Udskriver den aktuelle status og konfiguration for Sailor Hat for Raspberry Pi.

```bash
shrpi set <option> <value>
```

Sætter forskellige konfigurationsværdier. For eksempel

```bash
shrpi set led 50
```

sætter LED-lysstyrken til 50 %.

```bash
shrpi sleep 3600
```

Lukker Raspberry Pi'en ned og tænder den igen efter 3600 sekunder (1 time).

```bash
shrpi sleep 15:00
```

Lukker Raspberry Pi'en ned og tænder den igen kl. 15:00.

```bash
shrpi sleep 15:00:00
```

## REST-API

`shrpid` implementerer et REST-API, der kan bruges til at forespørge om den aktuelle status og konfiguration for Sailor Hat for Raspberry Pi og til at sætte konfigurationsværdier.
API'et er tilgængeligt på en filsocket på `/var/run/shrpid.sock`. Nedenfor er et eksempel på en forespørgsel med `curl`:

    curl --unix-socket /var/run/shrpid.sock http://localhost/state

Du kan finde flere oplysninger om de tilgængelige kommandoer i [kildekoden til SH-RPi-daemon](https://github.com/hatlabs/SH-RPi-daemon/).

## Firmware

Den programkode, der kører på den indbyggede ATtiny1616-mikrocontroller, kaldes SH-RPi-firmwaren.

Firmwarens repositorium ligger på [https://github.com/hatlabs/SH-RPi-firmware](https://github.com/hatlabs/SH-RPi-firmware).

De følgende underafsnit beskriver, hvordan du opdaterer firmwaren for at få nye funktioner, eller hvis du selv vil pille ved den.

### Opdatering af firmwaren

Det er muligt at opdatere SH-RPi'ens firmware med Raspberry Pi'en selv.
Det kræver et par jumpere og lidt softwarekonfiguration.

Flashningen foregår via ATtiny'ens UPDI-grænseflade med [`avrdude`](https://github.com/SpenceKonde/AVR-Guidance/blob/master/UPDI/jtag2updi.md).

#### Hardwarekonfiguration

Sæt jumpere på alle ben på PROG-stiklisten som vist med rødt på figuren nedenfor. Det forbinder mikrocontrollerens programmeringskredsløb og den serielle fejlfindingsgrænseflade til Raspberry Pi'en. Desuden tvinges buckcontrollerens 5 V-udgang tændt, så Raspberry Pi'en ikke slukker sig selv, når flashningen startes.

<figure markdown="span">
![](SH-RPi-2.0.0-prog-conx.jpg){ width="50%" }
<figcaption>Sæt de røde jumpere for at aktivere selvflashning.</figcaption>
</figure>

Bemærk! For at alt fungerer korrekt bagefter, er det afgørende, at du fjerner mindst den tredje jumper fra PROG-stiklisten. Ellers kan Raspberry Pi'en ikke slukke sig selv.

#### Ændringer i Raspberry Pi'ens konfiguration

Næste trin er at aktivere de serielle UART'er på Raspberry Pi'en. De bruges både til UPDI-grænsefladen og til den serielle fejlfindingsgrænseflade.
På Pi-modeller med Bluetooth er UART'en normalt reserveret af det indbyggede Bluetooth-kredsløb. Så lad os deaktivere Bluetooth.

Tilføj følgende linjer i slutningen af `/boot/firmware/config.txt`:

```ini
dtoverlay=disable-bt
dtoverlay=uart5
```

Den første deaktiverer Bluetooth-modemmet. Den anden aktiverer UART5-grænsefladen på GPIO 12 og 13 på ben 32 og 33. Det er den serielle grænseflade, som SH-RPi-firmwaren bruger til fejlfinding.

Vi skal også deaktivere den systemtjeneste, der initialiserer Bluetooth-modemmet:

```bash
sudo systemctl disable hciuart
```

Forhindr til sidst systemets serielle konsol i at koble sig på den serielle port. Fjern delen `console=serial0,115200` fra begyndelsen af `/boot/cmdline.txt`.

Genstart, så ændringerne træder i kraft.

#### Installation af flashningssoftwaren

Takket være frameworket [PlatformIO](https://platformio.org/) kan alle nødvendige værktøjer hentes og installeres automatisk. Vi skal blot først have fat i
firmwarens kildekode. Lad os installere versionsstyringssystemet `git` og klone firmwarens repositorium:

```bash
sudo apt update
sudo apt -y install git
git clone git@github.com:hatlabs/SH-RPi-firmware.git
```

Nu kan vi installere PlatformIO-frameworket:

```bash
sudo pip3 install -U platformio
```

Rediger filen `platformio.ini`, og ret `upload_port` til `/dev/ttyAMA0`:

```ini
[env]
...
upload_port = /dev/ttyAMA0
monitor_port = /dev/ttyAMA1
```

#### Flashning

Til sidst kan vi bygge og uploade firmwaren. Første gang du kører denne kommando, henter og installerer den de nødvendige værktøjer. Det kan tage et stykke tid.

```bash
cd SH-RPi-firmware
pio run -t upload
```

De hvide status-LED'er slukker under flashningen. Efter et par sekunder tænder de igen, og flashningen er færdig. Fjern nu jumperne fra PROG-stiklisten.

#### Gendannelse af Bluetooth

Hvis du vil blive ved med at bruge Bluetooth, skal du huske at fortryde de trin, du udførte tidligere. Det gør du ved at omgøre ændringerne i `/boot/firmware/config.txt` og `/boot/cmdline.txt` og aktivere tjenesten `hciuart` igen:

1. Fjern følgende linjer fra `/boot/firmware/config.txt`:

```ini
dtoverlay=disable-bt
dtoverlay=uart5
```

2. Tilføj `console=serial0,115200` igen i begyndelsen af `/boot/cmdline.txt`.

3. Aktivér tjenesten `hciuart` igen ved at køre:

```bash
sudo systemctl enable hciuart
```

4. Genstart din Raspberry Pi, så ændringerne træder i kraft.

Så er det gjort! Du har opdateret firmwaren på din Sailor Hat for Raspberry Pi og gendannet Bluetooth-funktionaliteten, hvis du ønskede det.
