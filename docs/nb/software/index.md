---
title: Programvare
translated_from: fde8306627421de6b86970b1032ab7a63699a495
---

# Programvare

## Innledning

Sailor Hat for Raspberry Pi krever ekstra programvare i operativsystemet på Raspberry Pi for at enheten skal kunne utnyttes fullt ut. Et installasjonsskript er tilgjengelig og installerer all nødvendig programvare automatisk på en fersk Raspberry Pi OS-installasjon. Bruken av installasjonsskriptet er beskrevet i [avsnittet Kom i gang](../getting-started/index.md). Du trenger bare å følge anvisningene for manuell installasjon hvis du ikke vil at automatiske skript skal endre systemkonfigurasjonen din, eller hvis du må feilsøke installasjonen.

For manuell installasjon laster du ned koden fra [github.com/hatlabs/SH-RPi-daemon](https://github.com/hatlabs/SH-RPi-daemon). Nødvendig programvare og konfigurasjonsendringer, samt detaljene om firmwaren, er beskrevet nedenfor.

### Aktivering av I2C og SPI

I2C- og SPI-grensesnittene må aktiveres. Det kan gjøres enten ved å kjøre `raspi-config` eller ved å redigere `/boot/firmware/config.txt` direkte.

Hvis du bruker `raspi-config`, hopper du til slutten av dette underavsnittet.

```bash
sudo nano /boot/firmware/config.txt
```

Finn følgende linje:

```ini
#dtparam=i2c_arm=on
```

og rediger den ved å fjerne kommentartegnet i begynnelsen:

```ini
dtparam=i2c_arm=on
```

### Aktivering av de nye grensesnittene

Rediger `/boot/firmware/config.txt` på nytt:

    sudo nano /boot/firmware/config.txt

Bla ned til `[all]`-seksjonen.

Der må du legge til tre nye linjer. Aktiver først sanntidsklokken (RTC), hvis enheten din har en:

    dtoverlay=i2c-rtc,pcf8563

Konfigurer deretter kjernen til å varsle Sailor Hat ved strømutkobling:

    dtoverlay=gpio-poweroff,gpiopin=2,input,active_low=17

Skriv filen på nytt ved å trykke Ctrl-O, og avslutt Nano ved å trykke Ctrl-X.

## Daemon for Raspberry Pi

For at Raspberry Pi OS skal kjenne til strømtilstanden, må det installeres en daemon (tjenesteprogramvare).

Hvis du har klonet SH-RPi-daemon-repositoriet, kan du installere daemonen med følgende kommandoer:

```bash
sudo apt install -y python3-pip
sudo pip3 install .
```

Deretter må du installere definisjonsfilen for tjenesten og aktivere tjenesten:

```bash
sudo install -o root shrpid.service /lib/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable shrpid
```

Det var alt! Etter en omstart starter daemonen automatisk.

*Merk: Det automatiserte installasjonsskriptet som er beskrevet i [avsnittet Kom i gang](../getting-started/index.md), utfører alle programvaretrinnene ovenfor automatisk.*

### Konfigurasjonsfil for daemonen

Du kan endre innstillingene for daemonen ved å opprette og redigere konfigurasjonsfilen `/etc/shrpid.conf`.
Filen bruker YAML-formatering.
Følgende innstillinger er tilgjengelige:

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

Du kan opprette en ny konfigurasjonsfil ved å kjøre `nano /etc/shrpid.conf` og lime innholdet ovenfor inn i filen.
Kommenter ut de linjene du ikke vil endre.
Lagre filen ved å trykke Ctrl-O, og avslutt Nano ved å trykke Ctrl-X.

## Kommandolinjegrensesnitt

Kommandolinjegrensesnittet er et Python-skript som kan brukes til å styre Sailor Hat for Raspberry Pi fra kommandolinjen på Raspberry Pi-en. Det installeres av installasjonsskriptet som er beskrevet i [avsnittet Kom i gang](../getting-started/index.md).

Skriptet `shrpi` kan kjøres med valget `--help` for å få informasjon om de ulike kommandoene. Noen av de viktigste bruksområdene er beskrevet nedenfor.

```bash
shrpi print
```

Skriver ut gjeldende status og konfigurasjon for Sailor Hat for Raspberry Pi.

```bash
shrpi set <option> <value>
```

Setter ulike konfigurasjonsverdier. For eksempel

```bash
shrpi set led 50
```

setter lysstyrken på LED-ene til 50 %.

```bash
shrpi sleep 3600
```

Stenger ned Raspberry Pi-en og slår den på igjen etter 3600 sekunder (1 time).

```bash
shrpi sleep 15:00
```

Stenger ned Raspberry Pi-en og slår den på igjen klokken 15:00 (tre om ettermiddagen).

```bash
shrpi sleep 15:00:00
```

## REST-API

`shrpid` implementerer et REST-API som kan brukes til å hente gjeldende status og konfigurasjon for Sailor Hat for Raspberry Pi, og til å sette konfigurasjonsverdier.
API-et er tilgjengelig på en filsocket på `/var/run/shrpid.sock`. Et eksempel på et oppslag med `curl` er vist nedenfor:

    curl --unix-socket /var/run/shrpid.sock http://localhost/state

Flere detaljer om tilgjengelige kommandoer finner du i [kildekoden til SH-RPi-daemon](https://github.com/hatlabs/SH-RPi-daemon/).

## Firmware

Programkoden som kjører på ATtiny1616-mikrokontrolleren på kortet, kalles SH-RPi-firmwaren.

Repositoriet for firmwaren ligger på [https://github.com/hatlabs/SH-RPi-firmware](https://github.com/hatlabs/SH-RPi-firmware).

De følgende underavsnittene beskriver hvordan du oppdaterer firmwaren for å få nye funksjoner, eller hvis du vil endre den selv.

### Oppdatering av firmwaren

Det er mulig å oppdatere SH-RPi-firmwaren med selve Raspberry Pi-en.
Det krever noen jumpere og litt konfigurasjon av programvaren.

Flashingen skjer over UPDI-grensesnittet på ATtiny-en med [`avrdude`](https://github.com/SpenceKonde/AVR-Guidance/blob/master/UPDI/jtag2updi.md).

#### Maskinvarekonfigurasjon

Sett jumpere på alle pinnene på PROG-listen, slik det er vist i rødt i figuren nedenfor. Dette kobler programmeringskretsen for mikrokontrolleren og det serielle feilsøkingsgrensesnittet til Raspberry Pi-en. I tillegg tvinges 5 V-utgangen fra buck-kontrolleren på, slik at Raspberry Pi-en ikke slår seg av når flashingen starter.

<figure markdown="span">
![](SH-RPi-2.0.0-prog-conx.jpg){ width="50%" }
<figcaption>Sett de røde jumperne for å aktivere selvflashing.</figcaption>
</figure>

Merk! For at alt skal virke riktig etterpå, er det helt avgjørende at du fjerner minst den tredje jumperen fra PROG-listen. Ellers vil ikke Raspberry Pi-en kunne slå seg av.

#### Konfigurasjonsendringer på Raspberry Pi

Neste steg er å aktivere de serielle UART-ene på Raspberry Pi-en. De brukes både til UPDI-grensesnittet og til det serielle feilsøkingsgrensesnittet.
På Pi-modeller med Bluetooth er UART-en normalt reservert av Bluetooth-kretsen på kortet. Vi deaktiverer derfor Bluetooth.

Legg til følgende linjer på slutten av `/boot/firmware/config.txt`:

```ini
dtoverlay=disable-bt
dtoverlay=uart5
```

Den første deaktiverer Bluetooth-modemet. Den andre aktiverer UART5-grensesnittet på GPIO 12 og 13, på pinne 32 og 33. Dette er det serielle grensesnittet som SH-RPi-firmwaren bruker til feilsøking.

Vi må også deaktivere systemtjenesten som initialiserer Bluetooth-modemet:

```bash
sudo systemctl disable hciuart
```

Til slutt hindrer du systemets seriekonsoll i å koble seg til serieporten. Fjern delen `console=serial0,115200` fra begynnelsen av `/boot/cmdline.txt`.

Start på nytt for at endringene skal tre i kraft.

#### Installasjon av flashingprogramvaren

Takket være rammeverket [PlatformIO](https://platformio.org/) kan alle nødvendige verktøy lastes ned og installeres automatisk. Vi må bare hente
kildekoden til firmwaren først. Vi installerer versjonskontrollsystemet `git` og kloner repositoriet for firmwaren:

```bash
sudo apt update
sudo apt -y install git
git clone git@github.com:hatlabs/SH-RPi-firmware.git
```

Nå kan vi installere PlatformIO-rammeverket:

```bash
sudo pip3 install -U platformio
```

Rediger filen `platformio.ini` og endre `upload_port` til `/dev/ttyAMA0`:

```ini
[env]
...
upload_port = /dev/ttyAMA0
monitor_port = /dev/ttyAMA1
```

#### Flashing

Til slutt kan vi bygge og laste opp firmwaren. Første gang du kjører denne kommandoen, lastes de nødvendige verktøyene ned og installeres. Det kan ta en stund.

```bash
cd SH-RPi-firmware
pio run -t upload
```

De hvite status-LED-ene slukner under flashingen. Etter noen sekunder lyser de igjen, og flashingen er ferdig. Fjern nå jumperne fra PROG-listen.

#### Gjenoppretting av Bluetooth

Hvis du vil fortsette å bruke Bluetooth, må du huske å angre trinnene du gjorde tidligere. Da må du reversere endringene du gjorde i `/boot/firmware/config.txt` og `/boot/cmdline.txt`, og aktivere `hciuart`-tjenesten på nytt:

1. Fjern følgende linjer fra `/boot/firmware/config.txt`:

```ini
dtoverlay=disable-bt
dtoverlay=uart5
```

2. Legg `console=serial0,115200` tilbake i begynnelsen av `/boot/cmdline.txt`.

3. Aktiver `hciuart`-tjenesten på nytt ved å kjøre:

```bash
sudo systemctl enable hciuart
```

4. Start Raspberry Pi-en på nytt for at endringene skal tre i kraft.

Det var alt! Du har oppdatert firmwaren på Sailor Hat for Raspberry Pi, og gjenopprettet Bluetooth-funksjonaliteten hvis du ønsket det.
