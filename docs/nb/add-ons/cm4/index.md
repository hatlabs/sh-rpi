---
title: Compute Module 4
translated_from: 2769961d8eba6a0a776d8bf6566816716c7c9cac
---

# Compute Module 4

[Compute Module 4](https://www.raspberrypi.org/products/compute-module-4/) er en liten datamodul som plugges inn i et bærekort. CM4 gir samme CPU-ytelse som Raspberry Pi 4B og er en kraftig, fleksibel og rimelig løsning for innebygde systemer. Når du bygger innebygde datamaskiner, har CM4 flere fordeler framfor Raspberry Pi 4B:

- Innebygd eMMC-flashminne: CM4-kortene har, avhengig av modell, opptil 32 GB eMMC-flashminne. Dette minnet er både mer pålitelig og raskere enn SD-kortet i Raspberry Pi 4B.
- Mulighet for ekstern WiFi-antenne: CM4 har en egen kontakt for ekstern WiFi-antenne. Det er nyttig hvis signalstyrken til den interne WiFi-antennen ikke er god nok.
- M.2-kontakt: mange bærekort har en M.2-kontakt som kan brukes til å koble til en M.2-SSD eller en M.2-WiFi-modul.
- Lavere strømforbruk: i uformelle tester har vi funnet at et CM4 med bærekort bruker over 20 % mindre strøm enn en Raspberry Pi 4B.

På minussiden har de fleste bærekort for CM4 ingen USB 3.0-hub, slik at USB-portene er begrenset til hastighetene i USB 2.0. Flashing av eMMC-en er dessuten litt mer komplisert enn flashing av et SD-kort. Prosessen er beskrevet nedenfor.

## Flashe eMMC-minnet på CM4

Først må du laste ned et passende systembilde. Vi bruker Headless-systembildet fra [OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/downloading.html) som eksempel, men prosessen er den samme for andre systembilder. **Merk:** Bruk alltid et 64-bits systembilde! Enkelte programvarekomponenter får problemer på et 32-bits system (særlig InfluxDB).

eMMC-minnet kan flashes med det samme systembildet som Raspberry Pi 4B. Flashingen har to ekstra steg. For det første må CM4 settes i en spesiell oppstartsmodus, BOOT, som faktisk *hindrer* enheten i å starte opp, og som gjør det mulig å flashe eMMC-en. For det andre må et lite `rpiboot`-verktøy installeres og kjøres på datamaskinen du flasher fra, slik at eMMC-minnet kan monteres på maskinen. Når disse stegene er gjort, er flashingen identisk med den for Raspberry Pi 4B.

For Windows finnes `rpiboot` som en ferdigkompilert kjørbar fil, men på Linux og MacOS må du kompilere verktøyet fra kildekode. Framgangsmåten for hver plattform er beskrevet i kapitlene nedenfor.

Merknader om installasjonen:

1. For å flashe eMMC-en må bærekortet settes i oppstartsmodusen BOOT. På Waveshare CM4-IO-BASE-kort må den lille BOOT-bryteren ved siden av HDMI0-kontakten settes i ON-posisjon.
2. Bærekortet må være koblet til en ekstern strømkilde mens flashingen pågår. Bruk SH-RPi-kortet til dette!

### Windows

1. Følg instruksjonene i [dokumentasjonen til Raspberry Pi](https://www.raspberrypi.com/documentation/computers/compute-module.html#flashing-the-compute-module-emmc) for å sette opp flashemodus på vertsmaskinen.
2. Følg [installasjonsinstruksjonene for OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html).
3. **Merk:** Ikke start systemet ennå! Vi må justere noen innstillinger først, slik det er beskrevet i avsnittet om CM4-konfigurasjon nedenfor.
4. Når du har endret konfigurasjonsinnstillingene, setter du BOOT-bryteren tilbake i OFF-posisjon og starter systemet på nytt. Deretter kan du fortsette med instruksjonene for OpenPlotter.

### Mac

På en Mac må du kompilere `rpiboot`-verktøyet fra kildekode.

1. For å kompilere verktøyet må du ha [Homebrew](https://brew.sh/) installert. Gjør det først.
2. Følg deretter [stegene i `usbboot`-repositoriet](https://github.com/raspberrypi/usbboot#macos). Når du kjører `sudo ./rpiboot`, skal CM4-bærekortet være koblet til datamaskinen og få strøm fra SH-RPi. Hvis du får en feilmelding, kontroller USB-kabelen og BOOT-bryteren på bærekortet.
3. Følg [installasjonsinstruksjonene for OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html). **Merk:** Ikke start systemet ennå! Vi må justere noen innstillinger først, slik det er beskrevet i avsnittet om CM4-konfigurasjon nedenfor.
4. Når du har endret konfigurasjonsinnstillingene, setter du BOOT-bryteren tilbake i OFF-posisjon og starter systemet på nytt. Deretter kan du fortsette med instruksjonene for OpenPlotter.

### Linux

Som på en Mac må du kompilere `rpiboot`-verktøyet fra kildekode på Linux.

1. For å kompilere verktøyet må du ha [Homebrew](https://brew.sh/) installert. Gjør det først.
2. Følg deretter [stegene i `usbboot`-repositoriet](https://github.com/raspberrypi/usbboot#linux--cygwin--wsl). Når du kjører `sudo ./rpiboot`, skal CM4-bærekortet være koblet til datamaskinen og få strøm fra SH-RPi. Hvis du får en feilmelding, kontroller USB-kabelen og BOOT-bryteren på bærekortet.
3. Følg [installasjonsinstruksjonene for OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html). **Merk:** Ikke start systemet ennå! Vi må justere noen innstillinger først, slik det er beskrevet i avsnittet om CM4-konfigurasjon nedenfor.
4. Når du har endret konfigurasjonsinnstillingene, setter du BOOT-bryteren tilbake i OFF-posisjon og starter systemet på nytt. Deretter kan du fortsette med instruksjonene for OpenPlotter.

## CM4-konfigurasjon

### Aktivere USB-portene

Før du starter systemet for første gang, må du gjøre noen endringer i konfigurasjonen. Som standard er USB-portene deaktivert på CM4. Det kan naturligvis være et stort problem hvis du vil bruke systemet med tastatur og mus. For å aktivere USB-portene må du redigere filen `config.txt` på eMMC-minnet. Boot-partisjonen skal allerede være montert på datamaskinen din som en USB-disk. Åpne disken og rediger filen `config.txt`. Legg til denne linjen på slutten av filen:

    dtoverlay=dwc2,dr_mode=host

Lagre filen og lukk den.

### Aktivere ekstern WiFi-antenne

Hvis du har en ekstern WiFi-antenne, må du redigere filen `config.txt` igjen. Legg til denne linjen på slutten av filen:

    dtparam=ant2

Andre mulige verdier er `ant1` for antennen på kretskortet og `noant` for å deaktivere begge antennene. Standardverdien er `ant1`.
