---
title: Compute Module 4
translated_from: 2769961d8eba6a0a776d8bf6566816716c7c9cac
---

# Compute Module 4

[Compute Module 4](https://www.raspberrypi.org/products/compute-module-4/) er et computermodul i lille formfaktor, som sættes i et bærekort. CM4'en yder præcis den samme CPU-ydelse som Raspberry Pi 4B og er en kraftfuld, fleksibel og billig løsning til indlejrede anvendelser. Når man bygger indlejrede computere, har CM4'en flere fordele frem for Raspberry Pi 4B:

- Indbygget eMMC-flashhukommelse: CM4-kortene har afhængigt af modellen op til 32 GB eMMC-flashhukommelse. Denne hukommelse er både mere pålidelig og hurtigere end det SD-kort, der bruges i Raspberry Pi 4B.
- Mulighed for en ekstern WiFi-antenne: CM4'en har et dedikeret stik til en ekstern WiFi-antenne. Det er nyttigt, hvis signalstyrken fra den interne WiFi-antenne ikke er tilstrækkelig.
- M.2-stik: Mange bærekort har et M.2-stik, som kan bruges til at tilslutte en M.2-SSD eller et M.2-WiFi-modul.
- Lavere strømforbrug: I uformelle tests har vi målt, at en CM4 og et bærekort bruger over 20 % mindre strøm end en Raspberry Pi 4B.

Til gengæld har de fleste CM4-bærekort ingen USB 3.0-hub, hvilket betyder, at USB-portene er begrænset til USB 2.0-hastigheder. Desuden er det en anelse mere kompliceret at flashe eMMC'en end at flashe et SD-kort. Processen beskrives nedenfor.

## Flashning af eMMC-hukommelsen på CM4'en

Først skal du downloade et egnet systemimage. Vi bruger [OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/downloading.html) Headless image som eksempel, men processen er den samme for andre systemimages. **Bemærk:** Brug altid et 64-bit systemimage! Nogle softwarekomponenter får problemer, når de kører på et 32-bit system (især InfluxDB).

eMMC-hukommelsen kan flashes med det samme systemimage som Raspberry Pi 4B. Flashningsprocessen har to ekstra trin. For det første skal CM4'en sættes i en særlig BOOT-tilstand, som faktisk *forhindrer* enheden i at starte op og gør det muligt at flashe eMMC'en. For det andet skal et lille `rpiboot`-værktøj installeres og køres på den computer, der bruges til flashningen, så eMMC-hukommelsen kan monteres på din computer. Når disse trin er gennemført, er flashningsprocessen identisk med den, der bruges til Raspberry Pi 4B.

Til Windows findes `rpiboot` som en færdigkompileret programfil, men til Linux og MacOS skal du selv kompilere den fra kildekoden. Processen for hver platform beskrives i afsnittene nedenfor.

Bemærkninger til installationsprocessen:

1. For at flashe eMMC'en skal bærekortet sættes i BOOT-tilstand. På Waveshare CM4-IO-BASE-kortene skal den lille BOOT-kontakt ved siden af HDMI0-stikket sættes i positionen ON.
2. Bærekortet skal være tilsluttet en ekstern strømkilde under flashningen. Brug SH-RPi-kortet til det!

### Windows

1. Følg vejledningen i [Raspberry Pi-dokumentationen](https://www.raspberrypi.com/documentation/computers/compute-module.html#flashing-the-compute-module-emmc) for at sætte flashningstilstanden op på værtscomputeren.
2. Følg [installationsvejledningen til OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html).
3. **Bemærk:** Start ikke systemet op endnu! Vi skal først justere nogle få indstillinger som beskrevet i afsnittet om CM4-konfiguration nedenfor.
4. Når du har ændret konfigurationsindstillingerne, skal du sætte BOOT-kontakten tilbage i positionen OFF og genstarte systemet. Derefter kan du fortsætte med OpenPlotter-vejledningen.

### Mac

På en Mac skal du kompilere `rpiboot`-værktøjet fra kildekoden.

1. For at kompilere værktøjet skal du have [Homebrew](https://brew.sh/) installeret. Gør det først.
2. Følg derefter [trinnene i `usbboot`-repositoriet](https://github.com/raspberrypi/usbboot#macos). Når du kører `sudo ./rpiboot`, skal CM4-bærekortet være tilsluttet din computer og forsynet med strøm fra SH-RPi'en. Hvis du får en fejlmeddelelse, så kontrollér USB-kablet og BOOT-kontakten på bærekortet.
3. Følg [installationsvejledningen til OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html). **Bemærk:** Start ikke systemet op endnu! Vi skal først justere nogle få indstillinger som beskrevet i afsnittet om CM4-konfiguration nedenfor.
4. Når du har ændret konfigurationsindstillingerne, skal du sætte BOOT-kontakten tilbage i positionen OFF og genstarte systemet. Derefter kan du fortsætte med OpenPlotter-vejledningen.

### Linux

Ligesom på en Mac skal du kompilere `rpiboot`-værktøjet fra kildekoden på Linux.

1. For at kompilere værktøjet skal du have [Homebrew](https://brew.sh/) installeret. Gør det først.
2. Følg derefter [trinnene i `usbboot`-repositoriet](https://github.com/raspberrypi/usbboot#linux--cygwin--wsl). Når du kører `sudo ./rpiboot`, skal CM4-bærekortet være tilsluttet din computer og forsynet med strøm fra SH-RPi'en. Hvis du får en fejlmeddelelse, så kontrollér USB-kablet og BOOT-kontakten på bærekortet.
3. Følg [installationsvejledningen til OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html). **Bemærk:** Start ikke systemet op endnu! Vi skal først justere nogle få indstillinger som beskrevet i afsnittet om CM4-konfiguration nedenfor.
4. Når du har ændret konfigurationsindstillingerne, skal du sætte BOOT-kontakten tilbage i positionen OFF og genstarte systemet. Derefter kan du fortsætte med OpenPlotter-vejledningen.

## CM4-konfiguration

### Aktivering af USB-portene

Før du starter systemet op første gang, skal du foretage nogle få ændringer i konfigurationen. Som standard er USB-portene deaktiveret på CM4'en. Det kan naturligvis være et stort problem, hvis du vil bruge systemet med tastatur og mus. For at aktivere USB-portene skal du redigere filen `config.txt` på eMMC-hukommelsen. Boot-partitionen bør allerede være monteret på din computer som et USB-drev. Åbn drevet, og rediger filen `config.txt`. Tilføj følgende linje sidst i filen:

    dtoverlay=dwc2,dr_mode=host

Gem filen, og luk den.

### Aktivering af ekstern WiFi-antenne

Hvis du har en ekstern WiFi-antenne, skal du redigere filen `config.txt` igen. Tilføj følgende linje sidst i filen:

    dtparam=ant2

Andre mulige værdier er `ant1` for PCB-antennen og `noant` for at deaktivere begge antenner. Standardværdien er `ant1`.
