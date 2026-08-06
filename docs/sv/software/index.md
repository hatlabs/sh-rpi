---
title: Programvara
translated_from: fde8306627421de6b86970b1032ab7a63699a495
---

# Programvara

## Introduktion

Sailor Hat for Raspberry Pi kräver ytterligare programvara i Raspberry Pi:s operativsystem för att enhetens alla funktioner ska kunna utnyttjas. Ett installationsskript tillhandahålls som automatiskt installerar all nödvändig programvara på en ny Raspberry Pi OS-installation. Användningen av installationsskriptet beskrivs i [avsnittet Kom igång](../getting-started/index.md). Du behöver bara följa anvisningarna för manuell installation om du inte vill att automatiska skript ändrar din systemkonfiguration, eller om du måste felsöka din installation.

För manuell installation, ladda ner koden på [github.com/hatlabs/SH-RPi-daemon](https://github.com/hatlabs/SH-RPi-daemon). Nödvändig programvara och konfigurationsändringar samt detaljerna kring firmware beskrivs nedan.

### Aktivera I2C och SPI

I2C- och SPI-gränssnitten måste aktiveras. Det kan göras antingen genom att köra `raspi-config` eller genom att redigera `/boot/firmware/config.txt` direkt.

Om du använder `raspi-config` kan du hoppa till slutet av det här underavsnittet.

```bash
sudo nano /boot/firmware/config.txt
```

Leta upp följande rad:

```ini
#dtparam=i2c_arm=on
```

och redigera den genom att ta bort kommentarstecknet i början:

```ini
dtparam=i2c_arm=on
```

### Aktivera de nya gränssnitten

Redigera `/boot/firmware/config.txt` igen:

    sudo nano /boot/firmware/config.txt

Bläddra ner till avsnittet `[all]`.

Du behöver lägga till tre nya rader där. Aktivera först RTC:n (om din enhet har en):

    dtoverlay=i2c-rtc,pcf8563

Konfigurera sedan kärnan så att den signalerar till Sailor Hat vid avstängning:

    dtoverlay=gpio-poweroff,gpiopin=2,input,active_low=17

Skriv återigen filen genom att trycka Ctrl-O och avsluta Nano genom att trycka Ctrl-X.

## Raspberry Pi-daemon

För att Raspberry Pi OS ska känna till strömtillståndet måste en daemon (systemtjänst) installeras.

Om du har klonat SH-RPi-daemon-repot kan du installera daemonen med följande kommandon:

```bash
sudo apt install -y python3-pip
sudo pip3 install .
```

Därefter måste du installera tjänstens definitionsfil och aktivera tjänsten:

```bash
sudo install -o root shrpid.service /lib/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable shrpid
```

Det var allt! Efter en omstart startar daemonen automatiskt.

*Obs: Det automatiska installationsskriptet som beskrivs i [avsnittet Kom igång](../getting-started/index.md) utför alla programvaruinstallationssteg ovan automatiskt.*

### Daemonens konfigurationsfil

Du kan ändra daemonens inställningar genom att skapa och redigera konfigurationsfilen `/etc/shrpid.conf`.
Filen använder YAML-format.
Följande inställningar är tillgängliga:

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

Du kan skapa en ny konfigurationsfil genom att köra `nano /etc/shrpid.conf` och klistra in innehållet ovan i filen.
Kommentera bort de rader du inte vill ändra.
Spara filen genom att trycka Ctrl-O och avsluta Nano genom att trycka Ctrl-X.

## Kommandoradsgränssnitt

Kommandoradsgränssnittet är ett Python-skript som kan användas för att styra Sailor Hat for Raspberry Pi från Raspberry Pi:s kommandorad. Det installeras av installationsskriptet som beskrivs i [avsnittet Kom igång](../getting-started/index.md).

Skriptet `shrpi` kan köras med flaggan `--help` för att få anvisningar om de olika kommandona. Några huvudsakliga användningsfall beskrivs nedan.

```bash
shrpi print
```

Skriver ut aktuell status och konfiguration för Sailor Hat for Raspberry Pi.

```bash
shrpi set <option> <value>
```

Ställer in olika konfigurationsvärden. Till exempel

```bash
shrpi set led 50
```

ställer in LED-ljusstyrkan till 50 %.

```bash
shrpi sleep 3600
```

Stänger av Raspberry Pi och slår på den igen efter 3600 sekunder (1 timme).

```bash
shrpi sleep 15:00
```

Stänger av Raspberry Pi och slår på den igen kl. 15:00.

```bash
shrpi sleep 15:00:00
```

## REST-API

`shrpid` implementerar ett REST-API som kan användas för att fråga efter aktuell status och konfiguration för Sailor Hat for Raspberry Pi och för att ställa in konfigurationsvärden.
API:et är tillgängligt via ett filsocket på `/var/run/shrpid.sock`. Nedan visas en exempelförfrågan med `curl`:

    curl --unix-socket /var/run/shrpid.sock http://localhost/state

För mer information om tillgängliga kommandon, se [källkoden för SH-RPi-daemon](https://github.com/hatlabs/SH-RPi-daemon/).

## Firmware

Programkoden som körs på den inbyggda ATtiny1616-mikrokontrollern kallas SH-RPi:s firmware.

Firmware-repot finns på [https://github.com/hatlabs/SH-RPi-firmware](https://github.com/hatlabs/SH-RPi-firmware).

Följande underavsnitt beskriver hur du uppdaterar firmware för att få nya funktioner, eller om du vill modifiera den själv.

### Uppdatera firmware

Det går att uppdatera SH-RPi:s firmware med hjälp av Raspberry Pi själv.
Det kräver några byglar och lite programvarukonfiguration.

Flashningen görs via UPDI-gränssnittet på ATtiny med [`avrdude`](https://github.com/SpenceKonde/AVR-Guidance/blob/master/UPDI/jtag2updi.md).

#### Hårdvarukonfiguration

Sätt byglar på alla stift på PROG-bygellisten enligt det som är markerat i rött i figuren nedan. Detta kopplar mikrokontrollerns programmeringskrets och det seriella felsökningsgränssnittet till Raspberry Pi. Dessutom tvingas buckregulatorns 5 V-utgång på, så att Raspberry Pi inte stänger av sig själv när flashningen startar.

<figure markdown="span">
![](SH-RPi-2.0.0-prog-conx.jpg){ width="50%" }
<figcaption>Sätt de röda byglarna för att aktivera självflashning.</figcaption>
</figure>

Obs! För att allt ska fungera korrekt efteråt är det nödvändigt att du tar bort åtminstone den tredje bygeln från PROG-bygellisten. Annars kan Raspberry Pi inte stänga av sig själv.

#### Konfigurationsändringar i Raspberry Pi

Nästa steg är att aktivera de seriella UART:arna på Raspberry Pi. De används både som UPDI-gränssnitt och som seriellt felsökningsgränssnitt.
På Pi-modeller med Bluetooth är UART:en normalt reserverad av den inbyggda Bluetooth-kretsen. Vi inaktiverar därför Bluetooth.

Lägg till följande rader i slutet av `/boot/firmware/config.txt`:

```ini
dtoverlay=disable-bt
dtoverlay=uart5
```

Den första inaktiverar Bluetooth-modemet. Den andra aktiverar UART5-gränssnittet på GPIO 12 och 13, på stift 32 och 33. Detta är det seriella gränssnitt som SH-RPi:s firmware använder för felsökning.

Vi måste också inaktivera systemtjänsten som initierar Bluetooth-modemet:

```bash
sudo systemctl disable hciuart
```

Förhindra slutligen att systemets seriekonsol kopplar upp sig mot serieporten. Ta bort delen `console=serial0,115200` i början av `/boot/cmdline.txt`.

Starta om för att ändringarna ska träda i kraft.

#### Installera flashningsprogramvaran

Tack vare ramverket [PlatformIO](https://platformio.org/) kan alla nödvändiga verktyg laddas ner och installeras automatiskt. Vi behöver bara hämta
firmwarens källkod först. Vi installerar versionshanteringssystemet `git` och klonar firmware-repot:

```bash
sudo apt update
sudo apt -y install git
git clone git@github.com:hatlabs/SH-RPi-firmware.git
```

Nu kan vi installera PlatformIO-ramverket:

```bash
sudo pip3 install -U platformio
```

Redigera filen `platformio.ini` och ändra `upload_port` till `/dev/ttyAMA0`:

```ini
[env]
...
upload_port = /dev/ttyAMA0
monitor_port = /dev/ttyAMA1
```

#### Flashning

Nu kan vi slutligen bygga och ladda upp firmware. Första gången du kör kommandot laddar det ner och installerar de nödvändiga verktygen. Det kan ta en stund.

```bash
cd SH-RPi-firmware
pio run -t upload
```

De vita status-LED:erna släcks under flashningen. Efter några sekunder tänds de igen och flashningen är klar. Ta då bort byglarna från PROG-bygellisten.

#### Återställa Bluetooth

Om du vill fortsätta använda Bluetooth, kom ihåg att ångra stegen du gjorde tidigare. Du behöver återställa ändringarna i `/boot/firmware/config.txt` och `/boot/cmdline.txt` samt aktivera tjänsten `hciuart` igen:

1. Ta bort följande rader från `/boot/firmware/config.txt`:

```ini
dtoverlay=disable-bt
dtoverlay=uart5
```

2. Lägg tillbaka `console=serial0,115200` i början av `/boot/cmdline.txt`.

3. Aktivera tjänsten `hciuart` igen genom att köra:

```bash
sudo systemctl enable hciuart
```

4. Starta om din Raspberry Pi för att ändringarna ska träda i kraft.

Det var allt! Du har uppdaterat firmware på din Sailor Hat for Raspberry Pi och återställt Bluetooth-funktionaliteten om du ville det.
