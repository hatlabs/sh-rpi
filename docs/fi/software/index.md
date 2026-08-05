---
title: Ohjelmisto
translated_from: fde8306627421de6b86970b1032ab7a63699a495
---

# Ohjelmisto

## Johdanto

Sailor Hat for Raspberry Pi tarvitsee Raspberry Pi -käyttöjärjestelmään lisäohjelmistoa, jotta laitteen kaikki toiminnot ovat käytettävissä. Tarjolla on asennusskripti, joka asentaa kaikki tarvittavat ohjelmistot automaattisesti puhtaaseen Raspberry Pi OS -asennukseen. Asennusskriptin käyttö kuvataan [Aloitusoppaassa](../getting-started/index.md). Käsin tehtävän asennuksen ohjeita tarvitset vain, jos et halua automaattisten skriptien muuttavan järjestelmäsi asetuksia tai jos joudut selvittämään asennusongelmia.

Käsin asennusta varten lataa koodi osoitteesta [github.com/hatlabs/SH-RPi-daemon](https://github.com/hatlabs/SH-RPi-daemon). Tarvittavat ohjelmistot ja asetusmuutokset sekä firmwaren yksityiskohdat kuvataan alla.

### I2C:n ja SPI:n käyttöönotto

I2C- ja SPI-liitännät on otettava käyttöön. Sen voi tehdä joko ajamalla `raspi-config` tai muokkaamalla tiedostoa `/boot/firmware/config.txt` suoraan.

Jos käytät `raspi-config`ia, hyppää tämän alaosion loppuun.

```bash
sudo nano /boot/firmware/config.txt
```

Etsi seuraava rivi:

```ini
#dtparam=i2c_arm=on
```

ja muokkaa sitä poistamalla kommenttimerkki alusta:

```ini
dtparam=i2c_arm=on
```

### Uusien liitäntöjen käyttöönotto

Muokkaa jälleen tiedostoa `/boot/firmware/config.txt`:

    sudo nano /boot/firmware/config.txt

Vieritä alas `[all]`-osioon.

Sinne on lisättävä kolme uutta riviä. Ota ensin käyttöön reaaliaikakello (jos laitteessasi on sellainen):

    dtoverlay=i2c-rtc,pcf8563

Määritä sitten ydin ilmoittamaan Sailor Hatille sammutuksesta:

    dtoverlay=gpio-poweroff,gpiopin=2,input,active_low=17

Kirjoita tiedosto jälleen painamalla Ctrl-O ja poistu Nanosta painamalla Ctrl-X.

## Raspberry Pi:n daemon

Jotta Raspberry Pi OS tietäisi virtatilanteen, on asennettava daemon (palveluohjelmisto).

Jos olet kloonannut SH-RPi-daemon-repositorion, voit asentaa daemonin seuraavilla komennoilla:

```bash
sudo apt install -y python3-pip
sudo pip3 install .
```

Seuraavaksi on asennettava palvelun määrittelytiedosto ja otettava palvelu käyttöön:

```bash
sudo install -o root shrpid.service /lib/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable shrpid
```

Siinä kaikki! Uudelleenkäynnistyksen jälkeen daemon käynnistyy automaattisesti.

*Huomaa: [Aloitusoppaassa](../getting-started/index.md) kuvattu automaattinen asennusskripti tekee kaikki yllä kuvatut ohjelmiston asennusvaiheet automaattisesti.*

### Daemonin asetustiedosto

Voit muuttaa daemonin asetuksia luomalla ja muokkaamalla asetustiedostoa `/etc/shrpid.conf`.
Tiedosto käyttää YAML-muotoilua.
Käytettävissä ovat seuraavat asetukset:

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

Voit luoda uuden asetustiedoston ajamalla `nano /etc/shrpid.conf` ja liittämällä yllä olevan sisällön tiedostoon.
Kommentoi pois ne rivit, joita et halua muuttaa.
Tallenna tiedosto painamalla Ctrl-O ja poistu Nanosta painamalla Ctrl-X.

## Komentoriviliittymä

Komentoriviliittymä on Python-skripti, jolla Sailor Hat for Raspberry Pi:tä voi ohjata Raspberry Pi:n komentoriviltä. Sen asentaa [Aloitusoppaassa](../getting-started/index.md) kuvattu asennusskripti.

Skriptin `shrpi` voi ajaa `--help`-valitsimella, jolloin se kertoo eri komennoista. Tärkeimmät käyttötapaukset kuvataan alla.

```bash
shrpi print
```

Tulostaa Sailor Hat for Raspberry Pi:n nykyisen tilan ja asetukset.

```bash
shrpi set <option> <value>
```

Asettaa eri asetusarvoja. Esimerkiksi

```bash
shrpi set led 50
```

asettaa LEDien kirkkaudeksi 50 %.

```bash
shrpi sleep 3600
```

Sammuttaa Raspberry Pi:n ja käynnistää sen uudelleen 3600 sekunnin (yhden tunnin) kuluttua.

```bash
shrpi sleep 15:00
```

Sammuttaa Raspberry Pi:n ja käynnistää sen uudelleen kello 15:00.

```bash
shrpi sleep 15:00:00
```

## REST-rajapinta

`shrpid` toteuttaa REST-rajapinnan, jolla voi kysellä Sailor Hat for Raspberry Pi:n nykyistä tilaa ja asetuksia sekä asettaa asetusarvoja.
Rajapinta on saatavilla tiedostosoketissa `/var/run/shrpid.sock`. Alla on esimerkkikysely `curl`illa:

    curl --unix-socket /var/run/shrpid.sock http://localhost/state

Lisätietoja käytettävissä olevista komennoista löytyy [SH-RPi-daemonin lähdekoodista](https://github.com/hatlabs/SH-RPi-daemon/).

## Firmware

Kortilla olevassa ATtiny1616-mikro-ohjaimessa ajettavaa ohjelmakoodia kutsutaan SH-RPi:n firmwareksi.

Firmwaren repositorio on osoitteessa [https://github.com/hatlabs/SH-RPi-firmware](https://github.com/hatlabs/SH-RPi-firmware).

Seuraavissa alaosioissa kuvataan, miten firmware päivitetään uusien ominaisuuksien saamiseksi tai jos haluat muokata sitä itse.

### Firmwaren päivitys

SH-RPi:n firmwaren voi päivittää Raspberry Pi:llä itsellään.
Se vaatii muutamia hyppyjä ja hieman ohjelmistoasetuksia.

Flashaus tehdään ATtinyn UPDI-liitännän kautta [`avrdude`](https://github.com/SpenceKonde/AVR-Guidance/blob/master/UPDI/jtag2updi.md)-ohjelmalla.

#### Laitteiston asetukset

Aseta hypyt kaikkiin PROG-liittimen nastoihin alla olevassa kuvassa punaisella merkityllä tavalla. Tämä kytkee mikro-ohjaimen ohjelmointipiirin ja virheenjäljityksen sarjaliitännän Raspberry Pi:hin. Lisäksi hakkuriohjaimen 5 V:n lähtö pakotetaan päälle, jotta Raspberry Pi ei sammuta itseään flashausta aloitettaessa.

<figure markdown="span">
![](SH-RPi-2.0.0-prog-conx.jpg){ width="50%" }
<figcaption>Aseta punaiset hypyt ottaaksesi itseflashauksen käyttöön.</figcaption>
</figure>

Huomaa! Jotta laite toimisi jälkeenpäin oikein, PROG-liittimestä on ehdottomasti poistettava vähintään kolmas hyppy. Muuten Raspberry Pi ei pysty sammuttamaan itseään.

#### Raspberry Pi:n asetusmuutokset

Seuraavaksi Raspberry Pi:n sarjaliikenteen UARTit on otettava käyttöön. Niitä käytetään sekä UPDI- että sarjavirheenjäljitysliitäntöinä.
Bluetoothilla varustetuissa Pi-malleissa UART on normaalisti kortin Bluetooth-piirin varaama. Poistetaan siis Bluetooth käytöstä.

Lisää seuraavat rivit tiedoston `/boot/firmware/config.txt` loppuun:

```ini
dtoverlay=disable-bt
dtoverlay=uart5
```

Ensimmäinen poistaa Bluetooth-modeemin käytöstä. Toinen ottaa käyttöön UART5-liitännän GPIO-nastoissa 12 ja 13, jotka ovat nastoissa 32 ja 33. Tätä sarjaliitäntää SH-RPi:n firmware käyttää virheenjäljitykseen.

Myös Bluetooth-modeemin alustava järjestelmäpalvelu on poistettava käytöstä:

```bash
sudo systemctl disable hciuart
```

Estä lopuksi järjestelmän sarjakonsolia kiinnittymästä sarjaporttiin. Poista osa `console=serial0,115200` tiedoston `/boot/cmdline.txt` alusta.

Käynnistä uudelleen, jotta muutokset tulevat voimaan.

#### Flashausohjelmiston asennus

[PlatformIO](https://platformio.org/) -kehyksen ansiosta kaikki tarvittavat työkalut voidaan ladata ja asentaa automaattisesti. Ensin on vain haettava
firmwaren lähdekoodi. Asennetaan `git`-versionhallinta ja kloonataan firmwaren repositorio:

```bash
sudo apt update
sudo apt -y install git
git clone git@github.com:hatlabs/SH-RPi-firmware.git
```

Nyt voimme asentaa PlatformIO-kehyksen:

```bash
sudo pip3 install -U platformio
```

Muokkaa tiedostoa `platformio.ini` ja vaihda `upload_port`-arvoksi `/dev/ttyAMA0`:

```ini
[env]
...
upload_port = /dev/ttyAMA0
monitor_port = /dev/ttyAMA1
```

#### Flashaus

Lopuksi voimme kääntää ja siirtää firmwaren. Ensimmäisellä ajokerralla komento lataa ja asentaa tarvittavat työkalut. Siihen voi mennä hetki.

```bash
cd SH-RPi-firmware
pio run -t upload
```

Valkoiset tila-LEDit sammuvat flashauksen ajaksi. Muutaman sekunnin kuluttua ne syttyvät uudelleen, ja flashaus on valmis. Poista tässä vaiheessa hypyt PROG-liittimestä.

#### Bluetoothin palauttaminen

Jos haluat käyttää Bluetoothia jatkossakin, muista peruuttaa aiemmin tekemäsi muutokset. Sitä varten sinun on peruttava muutokset tiedostoihin `/boot/firmware/config.txt` ja `/boot/cmdline.txt` sekä otettava `hciuart`-palvelu uudelleen käyttöön:

1. Poista seuraavat rivit tiedostosta `/boot/firmware/config.txt`:

```ini
dtoverlay=disable-bt
dtoverlay=uart5
```

2. Lisää `console=serial0,115200` takaisin tiedoston `/boot/cmdline.txt` alkuun.

3. Ota `hciuart`-palvelu uudelleen käyttöön ajamalla:

```bash
sudo systemctl enable hciuart
```

4. Käynnistä Raspberry Pi uudelleen, jotta muutokset tulevat voimaan.

Siinä kaikki! Olet päivittänyt Sailor Hat for Raspberry Pi:n firmwaren ja palauttanut Bluetooth-toiminnallisuuden, jos halusit.
