---
title: Compute Module 4
translated_from: 2769961d8eba6a0a776d8bf6566816716c7c9cac
---

# Compute Module 4

[Compute Module 4](https://www.raspberrypi.org/products/compute-module-4/) är en datormodul i litet format som ansluts till ett bärkort. CM4:an ger samma processorprestanda som Raspberry Pi 4B och är en kraftfull, flexibel och billig lösning för inbyggda tillämpningar. När du bygger inbyggda datorer har CM4:an flera fördelar jämfört med Raspberry Pi 4B:

- Inbyggt eMMC-flashminne: CM4-korten har beroende på modell upp till 32 GB eMMC-flashminne. Det minnet är både tillförlitligare och snabbare än SD-kortet som används i Raspberry Pi 4B.
- Möjlighet till extern WiFi-antenn: CM4:an har en särskild kontakt för en extern WiFi-antenn. Det är användbart om signalstyrkan hos den inbyggda WiFi-antennen inte räcker till.
- M.2-kontakt: Många bärkort har en M.2-kontakt som kan användas för att ansluta en M.2-SSD eller en M.2-WiFi-modul.
- Lägre strömförbrukning: i informella tester har vi sett att en CM4 med bärkort förbrukar över 20 % mindre effekt än en Raspberry Pi 4B.

Nackdelen är att de flesta CM4-bärkort saknar USB 3.0-hubb, vilket innebär att USB-portarna är begränsade till USB 2.0-hastigheter. Dessutom är det något krångligare att flasha eMMC-minnet än att flasha ett SD-kort. Processen beskrivs nedan.

## Flasha eMMC-minnet på CM4:an

Först måste du ladda ner en lämplig systemavbild. Vi använder [OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/downloading.html) Headless-avbilden som exempel, men processen är densamma för andra avbilder. **Observera:** Använd alltid en 64-bitars avbild! Vissa programvarukomponenter får problem på ett 32-bitarssystem (särskilt InfluxDB).

eMMC-minnet kan flashas med samma systemavbild som Raspberry Pi 4B. Flashningen har två extra steg. Först måste CM4:an ställas i ett särskilt BOOT-läge, som faktiskt *hindrar* enheten från att starta och gör det möjligt att flasha eMMC:n. Sedan måste ett litet verktyg, `rpiboot`, installeras och köras på datorn du flashar från, så att eMMC-minnet kan monteras på datorn. När de stegen är klara är flashningen identisk med den som används för Raspberry Pi 4B.

För Windows finns `rpiboot` som en färdigkompilerad körbar fil, men för Linux och MacOS måste du kompilera den från källkod. Processen för varje plattform beskrivs i avsnitten nedan.

Anmärkningar om installationsprocessen:

1. För att flasha eMMC:n måste bärkortet ställas i BOOT-läge. På Waveshares CM4-IO-BASE-kort ska den lilla BOOT-omkopplaren bredvid HDMI0-kontakten ställas i läget ON.
2. Bärkortet måste vara anslutet till en extern strömkälla under flashningen. Använd SH-RPi-kortet för det!

### Windows

1. Följ anvisningarna i [Raspberry Pi-dokumentationen](https://www.raspberrypi.com/documentation/computers/compute-module.html#flashing-the-compute-module-emmc) för att ställa in flashningsläget på värddatorn.
2. Följ [installationsanvisningarna för OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html).
3. **Observera:** Starta inte systemet ännu! Vi behöver först justera några inställningar, enligt beskrivningen i avsnittet CM4-konfiguration nedan.
4. När du har ändrat konfigurationsinställningarna ställer du tillbaka BOOT-omkopplaren i läget OFF och startar om systemet. Sedan kan du fortsätta med OpenPlotter-anvisningarna.

### Mac

På en Mac måste du kompilera verktyget `rpiboot` från källkod.

1. För att kompilera verktyget behöver du ha [Homebrew](https://brew.sh/) installerat. Gör det först.
2. Följ sedan [stegen i `usbboot`-repositoriet](https://github.com/raspberrypi/usbboot#macos). När du kör `sudo ./rpiboot` ska CM4-bärkortet vara anslutet till datorn och strömsatt via SH-RPi:n. Om du får ett felmeddelande, kontrollera USB-kabeln och BOOT-omkopplaren på bärkortet.
3. Följ [installationsanvisningarna för OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html). **Observera:** Starta inte systemet ännu! Vi behöver först justera några inställningar, enligt beskrivningen i avsnittet CM4-konfiguration nedan.
4. När du har ändrat konfigurationsinställningarna ställer du tillbaka BOOT-omkopplaren i läget OFF och startar om systemet. Sedan kan du fortsätta med OpenPlotter-anvisningarna.

### Linux

Precis som på en Mac måste du kompilera verktyget `rpiboot` från källkod på Linux.

1. För att kompilera verktyget behöver du ha [Homebrew](https://brew.sh/) installerat. Gör det först.
2. Följ sedan [stegen i `usbboot`-repositoriet](https://github.com/raspberrypi/usbboot#linux--cygwin--wsl). När du kör `sudo ./rpiboot` ska CM4-bärkortet vara anslutet till datorn och strömsatt via SH-RPi:n. Om du får ett felmeddelande, kontrollera USB-kabeln och BOOT-omkopplaren på bärkortet.
3. Följ [installationsanvisningarna för OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html). **Observera:** Starta inte systemet ännu! Vi behöver först justera några inställningar, enligt beskrivningen i avsnittet CM4-konfiguration nedan.
4. När du har ändrat konfigurationsinställningarna ställer du tillbaka BOOT-omkopplaren i läget OFF och startar om systemet. Sedan kan du fortsätta med OpenPlotter-anvisningarna.

## CM4-konfiguration

### Aktivera USB-portarna

Innan du startar systemet första gången behöver du göra några ändringar i konfigurationen. Som standard är USB-portarna avaktiverade på CM4:an. Det kan förstås vara ett stort problem om du vill använda systemet med tangentbord och mus. För att aktivera USB-portarna behöver du redigera filen `config.txt` på eMMC-minnet. Boot-partitionen ska redan vara monterad på datorn som en USB-enhet. Öppna enheten och redigera filen `config.txt`. Lägg till följande rad sist i filen:

    dtoverlay=dwc2,dr_mode=host

Spara filen och stäng den.

### Aktivera extern WiFi-antenn

Om du har en extern WiFi-antenn behöver du redigera filen `config.txt` igen. Lägg till följande rad sist i filen:

    dtparam=ant2

Andra möjliga värden är `ant1` för PCB-antennen och `noant` för att avaktivera båda antennerna. Standardvärdet är `ant1`.
