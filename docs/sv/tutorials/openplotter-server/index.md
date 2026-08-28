---
title: Installation av OpenPlotter-server
translated_from: 69cd214b5911c56a3544b6ab748a0ad149ba04e9
---

!!! warning
    Det här avsnittet har ännu inte uppdaterats för v2-ändringarna i hårdvaran.

<div style="-moz-filter: opacity(30%); -webkit-filter: opacity(30%); filter: opacity(30%);">

## Introduktion

I den här guiden bygger vi en OpenPlotter-server med [Sailor Hat for Raspberry Pi](https://docs.hatlabs.fi/sh-rpi/) ([köplänk](https://hatlabs.fi/product/sh-rpi-enclosure-kit/)) och programvaran OpenPlotter.
Servern är kompakt och vattentät och matas enkelt från båtens 12/24 V-system.
Den ansluts också lätt till båtens befintliga elektronik.

Programvaran som ingår loggar all väsentlig NMEA 2000-trafik ombord och låter dig visualisera olika värden både i realtid och historiskt, med hjälp av inbyggda instrumentpaneler och Grafana-instrumentpaneler.
Servern kan dessutom ta emot och bearbeta information från andra källor, till exempel [SH-ESP32-sensorenheter](https://docs.hatlabs.fi/sh-esp32/) eller olika internettjänster.

Några exempel på visualiseringar:

<figure markdown="span">
![](assets/screenshots/001_examples.jpg){ width="75%" }
<figcaption>Exempel på visualiseringar.</figcaption>
</figure>

## Delar som behövs

För att genomföra den här guiden behöver du följande delar:

- [SH-RPi kapslingssats](https://hatlabs.fi/product/sh-rpi-enclosure-kit/)

  SH-RPi är den hemliga ingrediensen som ger Raspberry Pi de hårdvarugränssnitt som båtens system kräver. Kortet har en inbyggd, skyddad 12/24 V-strömförsörjning med säker avstängning och ett galvaniskt isolerat NMEA 2000-kompatibelt CAN-gränssnitt.

  I den här guiden använder vi plastkapslingen och matar Pi:n genom en NMEA 2000-panelkontakt. Dessutom används en USB typ A-panelkontakt för enklare anslutning vid behov, och en kylfläkt läggs till för bättre värmebortledning. Ändra gärna konfigurationen efter eget tycke.

  Vi använder också en extra USB-WiFi-adapter, eftersom det gör installationen enklare (det extra nätverksgränssnittet kan komma väl till pass ombord också). Om du inte vill ha USB-WiFi-adaptern kan du i stället ansluta Pi:n till trådbundet ethernet med samma resultat.

- En Raspberry Pi 4B

  En modell med 4 GB minne räcker gott. Amazon har ofta oslagbara priser, eller så kan du titta i återförsäljarlistan på Raspberry Pi:s webbplats:

    * [amazon.com](https://www.amazon.com/Raspberry-Model-2019-Quad-Bluetooth/dp/B07TC2BK1X/)
    * [amazon.de](https://www.amazon.de/-/en/Raspberry-ARM-Cortex-A72-WLAN-ac-Bluetooth-Micro-HDMI-Single/dp/B07TC2BK1X/)
    * [amazon.co.uk](https://www.amazon.co.uk/Raspberry-Pi-ARM-Cortex-A72-Bluetooth-Micro-HDMI/dp/B07TC2BK1X/)
    * [Raspberry Pi:s återförsäljarlista](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/?variant=raspberry-pi-4-model-b-4gb)

- MicroSD-minneskort

  På MicroSD-kortet ligger Raspberry Pi:s operativsystem och datafiler. Jag har haft goda erfarenheter av Samsung Evo Plus-kort. Minneskort är billiga och större kort är mer tillförlitliga i Raspberry Pi-sammanhang, så skaffa minst ett på 64 GB:

  * [amazon.com](https://www.amazon.com/Samsung-MicroSDXC-Memory-Adapter-MB-MC64GA/dp/B06XFWPXYD/)
  * [amazon.de](https://www.amazon.de/-/en/Samsung-Flash-Memory-MicroSDXC-Class/dp/B08BKCB4JW/)
  * [amazon.co.uk](https://www.amazon.co.uk/Samsung-MicroSDXC-Class-UHS-I-Memory/dp/B08BKCB4JW/)

- Dubbelhäftande tejp eller smältlim

  En kort bit dubbelhäftande tejp eller en klick smältlim behövs för att montera kylfläkten.

- Krympslang, 3 mm innerdiameter

  Krympslang med 3 mm innerdiameter är visserligen inte absolut nödvändig, men den är bra för att säkra de lödda ledarna till panelkontakten.

- [NMEA 2000-hona](https://hatlabs.fi/product/nmea-2000-cable-plug/)

  Om du gör den första installationen hemma är en extra NMEA 2000 micro-kontakt praktisk för att mata matningsspänning till enheten.

## Montering av hårdvaran

### Borra hål för kontakterna

Som alltid när man borrar hål i en felfri kapsling: planera mycket noga i förväg. Panelkontakterna tar förvånansvärt mycket plats, och ett hål går inte att laga i efterhand, än mindre att flytta.

Själv föredrar jag att mäta upp kapslingen och göra en borrmall i ett vektorritprogram. En ritning hjälper dig att se de största mått som kontakten och muttern kräver.

Om du inte vet vilket program du ska använda är [Inkscape](https://inkscape.org) ett bra allroundverktyg. Är du mer tekniskt lagd kan CAD-program som [LibreCAD](https://librecad.org) också fungera.

Jag ville ha tre hål på plastkapslingens kortsida. Så här ser mallen jag gjorde ut:

<figure markdown="span">
![](assets/plastic-enclosure-end-template.svg){ width="50%" }
<figcaption><a href="assets/plastic-enclosure-end-template.svg">Exempel på borrmall.</a></figcaption>
</figure>

[Mallen](assets/plastic-enclosure-end-template.svg) är en SVG-fil, alltså vektorgrafik, så du kan spara den och ändra den som du vill.
Om du inte vet vilket program du ska använda kan du prova till exempel [Inkscape](https://inkscape.org) som nämndes ovan. Själv använder jag Affinity Designer, ett billigt kommersiellt designprogram för MacOS.

Om du har problem med att öppna SVG-filen finns mallen också som [PDF](assets/plastic-enclosure-end-template.pdf).

När mallen är klar markerar du centrumpunkten på kapslingen och tejpar fast mallen så att centrumpunkterna sammanfaller.

<figure markdown="span">
![](assets/photos/01_drill-template.jpg){ width="50%" }
<figcaption>Borrmall på lådan.</figcaption>
</figure>


För att borra exakt hjälper det att märka ut hålens centrum med en körnare (en vass spik och ett lätt slag med hammaren fungerar också).

Borra styrhål med ett litet borr (omkring 3 mm). Använd sedan ett stegborr för de slutliga hålen. Ta det lugnt och håll lågt varvtal. Mindre hål med udda mått, som det på 6,5 mm, bör efterbearbetas med ett metallborr i motsvarande storlek.

Att borra i plast lämnar mycket grader runt hålen. De tar du bort med en vass kniv.

Till sist kan de inbyggda distanserna i plastkapslingen sitta i vägen för hålen du borrat. Jag fick ta bort en av dem. Jag använde ett Dremel-verktyg, men en kraftig tång fungerar nog också.

Så här ser slutresultatet ut i mitt fall.

<figure markdown="span">
![](assets/photos/02_drilled_holes.jpg){ width="50%" }
<figcaption>Borrade hål.</figcaption>
</figure>


### Ansluta ledare till NMEA 2000-panelkontakten

Nu löder vi JST XH-kablaget till NMEA 2000-panelkontakten. Samma tillvägagångssätt fungerar för att löda SP13-strömkontakter om du väljer en sådan i stället.
Vi börjar med att fylla kontaktens lödkoppar med tenn.

<figure markdown="span">
![](assets/photos/021_soldered_cups.jpg){ width="50%" }
<figcaption>Lödda koppar.</figcaption>
</figure>


Vi vill mata både själva kortet och CAN-gränssnittet via NMEA 2000-kontakten. Det finns mer än ett sätt att göra det, men vi tar den självklara metoden och kopplar båda kablagen till NMEA-panelkontakten.

Skala av en kort bit av den röda och den svarta ledaren och tvinna ihop dem.

<figure markdown="span">
![](assets/photos/022_spliced_wires.jpg){ width="50%" }
<figcaption>Hopskarvade ledare.</figcaption>
</figure>


Använd gärna krympslang för att isolera kontaktstiften och ge lödfogarna mekaniskt stöd. Klipp korta bitar krympslang och trä dem på ledarna. (Gissa vem som glömde det här momentet _igen_ när bilderna till guiden togs.)

Löd fast ledarna i kontakten, både de enskilda signalledarna och de hopskarvade matningsledarna.

Diagrammet nedan visar rätt stiftkonfiguration. Ja, det är en hankontakt, men eftersom vi tittar på kontakten från fel håll använder vi diagrammet för det motsatta könet. (Ja, det är lite förvirrande.)

<figure markdown="span">
![](assets/nmea_2000_female_pinout.png){ width="50%" }
<figcaption>Stiftkonfiguration för NMEA 2000 micro C-hona.</figcaption>
</figure>


Börja med att löda mittstiftet. Det är enklare nu när de andra ledarna ännu inte är i vägen. Standardfärgen för CAN_L-ledaren är blå, men i vårt kablage är den gul i stället.

<figure markdown="span">
![](assets/photos/023_soldered_L.jpg){ width="50%" }
<figcaption>Mittstiftet lött.</figcaption>
</figure>


Löd sedan fast de tre övriga ledarna. Skärmen lämnas oansluten.

Så här bör din kontakt se ut i det här skedet:

<figure markdown="span">
![](assets/photos/024_all_soldered.jpg){ width="50%" }
<figcaption>Allt lött.</figcaption>
</figure>


Jag utgår djärvt från att du kom ihåg att trä på krympslangsbitarna innan du lödde ledarna. Nu är det dags att skjuta dem över lödfogarna och krympa dem med en varmluftspistol (eller lågan från en tändare). Slutresultatet bör se ut ungefär så här:

<figure markdown="span">
![](assets/photos/025_heat_shrink.jpg){ width="50%" }
<figcaption>Krympslangen krympt.</figcaption>
</figure>


Skruva fast den färdiga NMEA 2000-panelkontakten i kapslingen.

Ännu en bild på en färdig kontakt och stiftkonfigurationen:

<figure markdown="span">
![](assets/photos/n2k_connector_wiring_photo.jpg){ width="50%" }
<figcaption>Färdig kontakt.</figcaption>
</figure>


### Ansluta övriga panelkontakter

Nu när den svåra delen är avklarad kan de andra kontakterna skruvas fast. För att göra WiFi-antennkontakten tätare kan du lägga en liten O-ring eller packning runt kontakten innan du monterar den.

Till slut bör du ha det här:

<figure markdown="span">
![](assets/photos/03_connectors_in_place.jpg){ width="50%" }
<figcaption>Kontakterna på plats.</figcaption>
</figure>


### Montering av SH-RPi

Nu ska Raspberry Pi monteras i kapslingen.
Vi använder plastkapslingen och monteringsadaptrarna som bör ha följt med kapslingen.

Först fäster vi de korta distanserna i monteringsadaptrarna med M2.5-muttrarna. Dra åt dem ordentligt.

<figure markdown="span">
![](assets/photos/04_adapters_with_standoffs.jpg){ width="50%" }
<figcaption>Adaptrar med distanser.</figcaption>
</figure>


När distanserna sitter på plats kan adaptrarna monteras i kapslingen med de självgängande skruvarna.

<figure markdown="span">
![](assets/photos/05_adapters_in_place.jpg){ width="50%" }
<figcaption>Adaptrarna monterade.</figcaption>
</figure>


Raspberry Pi:n placeras på distanserna. Fäst de övre distanserna med M2.5-skruvarna och de nedre med två 16 mm sexkantsdistanser.

<figure markdown="span">
![](assets/photos/06_rpi_mounted.jpg){ width="50%" }
<figcaption>Raspberry Pi monterad.</figcaption>
</figure>


Därefter kommer Sailor Hat. Tryck fast kortet på Raspberry Pi:ns GPIO-stiftlist. Säkra det med två M2.5-skruvar.

**OBS**: När du någon gång behöver ta loss HAT-kortet är det frestande att vicka det i sidled. Det fungerar bra, men det finns också en liten risk att böja stiften i vardera änden av Pi:ns stiftlist. Vicka i stället kortet upp och ner samtidigt som du försiktigt drar uppåt. Det går lite långsammare, men kortet lossnar med betydligt mindre risk för böjda stift.

I det här skedet kan du också ansluta alla USB-enheter och koppla in SH-RPi:ns ström- och CAN-kablar. Om du använder en kylfläkt monterar du den också. Fäst den med dubbelhäftande tejp eller en klick smältlim bredvid Raspberry Pi:n, med dekalsidan vänd mot Pi:n.

Så här ser den färdiga monteringen ut:

<figure markdown="span">
![](assets/photos/07_sh-rpi_mounted.jpg){ width="50%" }
<figcaption>Sailor Hat monterad.</figcaption>
</figure>


Stäng inte locket än. Du måste fortfarande sätta i minneskortet i Pi:n.

## Programvara

I det här avsnittet installerar vi OpenPlotter på Raspberry Pi:n. OpenPlotter är en specialiserad marin programvarudistribution som bygger på Raspberry Pi OS. Den finns i flera varianter; i den här guiden används en version utan skärm (headless), det vill säga ingen bildskärm är direkt ansluten till Raspberry Pi:n. För visning används i stället webbläsare eller fjärrskrivbordsanslutningar, vilket ger säkrare placering av servern och skärmar där du behöver dem.

### Installera OpenPlotter

OpenPlotter installeras genom att en systemavbild skrivs till ett MicroSD-kort som sedan sätts i Raspberry Pi:n.

Ladda först ner [Raspberry Pi Imager](https://www.raspberrypi.org/software/). Imager är ett lättanvänt program som skriver den nedladdade avbildsfilen till minneskortet.

**OBSERVERA:** Imager går bara att ladda ner för macOS, Windows och Ubuntu Linux. Använder du något annat operativsystem eller någon annan Linux-distribution får du använda något annat program för att flasha kortet (men då utgår jag från att du mycket väl vet hur det går till).

Installera Imager när nedladdningen är klar.

Ladda sedan ner [OpenPlotter-avbilden](https://openplotter.readthedocs.io/en/latest/getting_started/downloading.html). Jag använder Headless-avbilden i den här guiden. Vill du hellre ansluta en skärm till Pi:n kan du ta Starting-avbilden. När avbilden är nedladdad kan du behöva packa upp den innan du flashar. Systemavbilden är rätt stor, så du bör ha några gigabyte ledigt på disken.

Flasha avbilden till MicroSD-kortet. Sätt först kortet i en kortläsare ansluten till datorn. Många bärbara datorer har också inbyggda SD-kortläsare. För att använda dem tar du SD-adaptern som följde med kortet. Öppna sedan Imager. I operativsystemsmenyn väljer du ”Use custom” längst ner i listan och därefter den nedladdade avbildsfilen.

[![](assets/screenshots/01_imager.jpg){ width="50%" }](assets/screenshots/01_imager.jpg)

Välj sedan rätt MicroSD-kort med knappen Storage. För att undvika dyra misstag rekommenderar jag att du kopplar bort alla andra flyttbara media från datorn. Klicka på Write. Här kan du behöva ange ditt lösenord för att Imager ska få skriva till MicroSD-kortet.

[![](assets/screenshots/02_imager_in_progress.jpg){ width="50%" }](assets/screenshots/02_imager_in_progress.jpg)

Att skriva och verifiera MicroSD-kortet tar en stund. Den tiden kan vi använda till att ladda ner och installera [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/). VNC Viewer är ett fjärrskrivbordsprogram som vi använder för att komma åt OpenPlotter i följande avsnitt.

När MicroSD-kortet är klart sätter du det i Raspberry Pi:ns MicroSD-kortplats. Du kan behöva lossa HAT-kortet tillfälligt för att göra det. (Ja, tyvärr är guiden inte 100 % konsekvent.)

Slå till sist på strömmen. Det går visserligen att koppla in en 5 V USB-C-kabel i Raspberry Pi:n, men det leder till problem när du installerar SH-RPi-daemonen senare i guiden. Använd därför en 12 V-strömförsörjning (allt mellan 10–32 V går faktiskt bra) och koppla den till en NMEA 2000-kontakt. Du kan också sticka in korta hona-byglingskablar direkt i JST XH-kontakterna och koppla ledarna till en strömkälla med små krokodilklämmor. Använd fantasin!

### Första konfigurationen av OpenPlotter

Nu bör du ha en enhet med massor av blinkande lampor men inget sätt att kommunicera med den. Som tur är finns det en väg in. Tittar du på tillgängliga Wi-Fi-nätverk omkring dig bör du se ett nätverk som heter ”openplotter”:

[![](assets/screenshots/03_select_wifi.jpg){ width="50%" }](assets/screenshots/03_select_wifi.jpg)

Anslut till det nätverket (lösenordet är `12345678`).

Nu är du inom räckhåll för Pi:n. För att komma åt den använder vi VNC Viewer som vi installerade tidigare.

[![](assets/screenshots/04_vnc_viewer.jpg){ width="50%" }](assets/screenshots/04_vnc_viewer.jpg)

Skriv `openplotter.local` i adressfältet på startskärmen (fungerar inte det kan du prova IP-adressen `10.10.10.1`). Hittades servern möts du av en ruta för inloggningsuppgifter:

[![](assets/screenshots/05_vnc_credentials.jpg){ width="50%" }](assets/screenshots/05_vnc_credentials.jpg)

Ange användarnamnet `pi` och lösenordet `raspberry`.

Om allt gick bra möts du av ett orört OpenPlotter-skrivbord:

[![](assets/screenshots/06_vnc_connected.jpg){ width="50%" }](assets/screenshots/06_vnc_connected.jpg)

Utmärkt! Gå igenom Pi:ns välkomstguide. Du får först ange ett nytt lösenord och välja land, språk och andra grundinställningar.

Har du anslutit en kompatibel USB-WiFi-adapter får du välja ett WiFi-nätverk att ansluta till. Det är mycket praktiskt, eftersom du då kommer ut på internet och kan ladda ner uppdateringar och annat.

[![](assets/screenshots/07_pick_raspi_wifi.jpg){ width="50%" }](assets/screenshots/07_pick_raspi_wifi.jpg)

Observera att om du inte har någon WiFi-adapter inkopplad kan den första konfigurationen skilja sig något från beskrivningen nedan.

Under den första konfigurationen uppdaterar Pi:n systemprogramvaran. Det tar en stund, så hämta en kopp kaffe eller lek med din partner, dina barn eller dina husdjur.

[![](assets/screenshots/08_update.jpg){ width="50%" }](assets/screenshots/08_update.jpg)

När konfigurationen är klar startar du om Pi:n. Du var ansluten till Pi:ns WiFi-accesspunkt, så datorns nätverksanslutning återgår nu till ditt vanliga WiFi. Har du USB-WiFi-adaptern och ställde in Pi:n på samma nätverk kommer du fortfarande åt den på samma adress, `openplotter.local`. Förstår du nu varför jag rekommenderade den extra WiFi-adaptern? Annars får du ansluta till ”openplotter”-nätverket igen så snart det dyker upp.

[![](assets/screenshots/09_basic_setup_complete.jpg){ width="50%" }](assets/screenshots/09_basic_setup_complete.jpg)

Hur som helst. Gå tillbaka till VNC Viewer och anslut till `openplotter.local`. Du bytte lösenord för användaren `pi` under den första konfigurationen, så du får ange det nya lösenordet i VNC Viewer.

När du är inne igen ändrar vi nätverksinställningarna i OpenPlotter-installationen. Välj OpenPlotter -> Network i Raspberry-menyn.

(När du öppnar Network-appen kan den klaga på att den vill konfigurera om systemet. Låt den göra det och öppna appen igen när den är klar.)

[![](assets/screenshots/11_open_openplotter_network.jpg){ width="50%" }](assets/screenshots/11_open_openplotter_network.jpg)

I nätverkspanelen ser du tillgängliga nätverksenheter till vänster och inställningarna för accesspunkten till höger.

Vill du inte ha någon accesspunkt väljer du ”none” i menyn till vänster. Vill du behålla accesspunkten (och det rekommenderar jag, eftersom den ger dig en reservväg in i Pi:n) är det viktigt att byta nätverkslösenord:

[![](assets/screenshots/14_openplotter_network_password.jpg){ width="50%" }](assets/screenshots/14_openplotter_network_password.jpg)

Inställningarna för WiFi-klienten hittar du under WiFi-symbolen i övre högra hörnet på OpenPlotter-skrivbordet. Där konfigurerar du ytterligare nätverk, till exempel båtens WiFi-accesspunkt.

[![](assets/screenshots/16_wifi_client_settings.jpg){ width="50%" }](assets/screenshots/16_wifi_client_settings.jpg)

Starta om OpenPlotter när du har ändrat nätverksinställningarna.

### Installera SH-RPi-daemonen

Nu när det mest brådskande är avklarat är det dags att installera SH-RPi-daemonen. ([Daemoner](https://en.wikipedia.org/wiki/Daemon_(computing)#Etymology) är välvilliga andar som hjälper till att forma en människas karaktär eller personlighet. Eller i det här fallet bakgrundstjänster i UNIX-besläktade operativsystem.) Vi skulle kunna använda VNC Viewer för det genom att öppna Accessories -> Terminal i Raspberry-menyn, och det rekommenderar jag Windows-användare att göra, men för Mac- och Linux-användare visar jag hur man når OpenPlotter-enheten över SSH.

Först gör vi en liten avstickare. I stället för att bara ssh:a in kopierar vi först vår publika SSH-nyckel till enheten med `ssh-copy-id`. Då kan efterföljande inloggningar göras utan lösenord.

Mac-användare kan behöva installera `ssh-copy-id` först. Det finns via [Homebrew](https://brew.sh/) — har du inte installerat det ännu, gör det! Det är utmärkt! När det är på plats kör du:

    brew install ssh-copy-id

Linux-användare är däremot bortskämda och har redan `ssh-copy-id` förinstallerat.

Kopiera sedan den publika nyckeln:

    ssh-copy-id pi@openplotter.local

Det var allt! Nu kan du logga in på Pi:n utan lösenord. Jag rekommenderar den här metoden på alla system du når på distans — den är säkrare än lösenord.

[![](assets/screenshots/18_ssh.jpg){ width="50%" }](assets/screenshots/18_ssh.jpg)

När du har loggat in med `ssh pi@openplotter.local` klistrar du in installationskommandot i kommandotolken:

    curl -L \
    https://raw.githubusercontent.com/hatlabs/SH-RPi-daemon/main/install.sh \
    | sudo bash

Har du ett relativt orört system installerar det här kommandot de nödvändiga konfigurationsändringarna och programvaran automatiskt. Det tar bara några sekunder. Allt du behöver göra är att starta om manuellt när installationen är klar:

    sudo reboot

Håll ögonen på SH-RPi:ns lysdioder under omstarten. RX-lysdioden har lyst fast grönt och statuslysdioden fast rött, men efter omstarten flimrar RX-lysdioden glatt (förutsatt att det finns trafik på NMEA 2000-bussen), och statuslysdioden lyser rött men blinkar kort varje sekund. Ändringarna visar att CAN-gränssnittet och daemonens watchdog är aktiva. Toppen.

När du ansluter till VNC efter omstarten ser du följande meddelande:

[![](assets/screenshots/20_after_reboot.jpg){ width="50%" }](assets/screenshots/20_after_reboot.jpg)

Det betyder att vi nu har ett aktivt CAN-gränssnitt, men att det ännu inte är konfigurerat i [Signal K](https://signalk.org). Det gör vi i nästa avsnitt.

### Konfigurera Signal K för att ta emot NMEA 2000-trafik

För att kunna bearbeta NMEA 2000-data måste Signal K konfigureras att ta emot den. Öppna Signal K-instrumentpanelen på [http://openplotter.local:3000/](http://openplotter.local:3000/).

För att kunna göra något på servern måste du aktivera säkerhet och skapa en administratörsanvändare. Klicka på knappen ”Login” uppe till höger:

[![](assets/screenshots/21_sk_server_dashboard.jpg){ width="50%" }](assets/screenshots/21_sk_server_dashboard.jpg)

Du ombeds skapa en ny administratörsanvändare. Jag föredrar `admin` som användarnamn och sedan ett lagom lättkommet och lättskrivet lösenord. Det här är bara åtkomligt från ditt interna nätverk.

Därefter kan det vara läge att uppgradera SK-servern:

[![](assets/screenshots/23_update_server.jpg){ width="50%" }](assets/screenshots/23_update_server.jpg)

När det är gjort kan vi komma till saken och aktivera `can0` på servern. Gå till Data Connections och klicka på knappen Add:

[![](assets/screenshots/26_data_connections_add.jpg){ width="50%" }](assets/screenshots/26_data_connections_add.jpg)

Konfigurera sedan anslutningen enligt nedan, rulla ner och klicka på Submit:

[![](assets/screenshots/28_correct_settings.jpg){ width="50%" }](assets/screenshots/28_correct_settings.jpg)

När du har lagt till dataanslutningen startar du om servern igen. Nu bör instrumentpanelen visa lite anslutningsaktivitet:

[![](assets/screenshots/30_can0_activity.jpg){ width="50%" }](assets/screenshots/30_can0_activity.jpg)

Toppen. Dags att gratulera dig själv. Du har kommit långt!

Vill du kan du också öppna Data Browser i menyn till vänster och se vilka data du tar emot.

### Skapa instrumentpaneler

Tar du emot data kan du redan visualisera dem genom att öppna SK Instrument Panel:

[![](assets/screenshots/301_sk_plugins.jpg){ width="50%" }](assets/screenshots/301_sk_plugins.jpg)

Du kan konfigurera sökvägar med skiftnyckelknappen. Panelernas storlek och placering justerar du genom att klicka på låsknappen.

Mitt testlabb ligger precis under ett plåttak utan någon GPS-täckning alls, och de enda intressanta data i mitt nätverk kommer från [1-Wire-temperatursensorn](https://docs.hatlabs.fi/sh-esp32/pages/tutorials/onewire-temperature/). Min instrumentpanel består därför av tre temperaturvärden:

[![](assets/screenshots/302_sk_instrument_panel.jpg){ width="50%" }](assets/screenshots/302_sk_instrument_panel.jpg)

Lite sorgligt, men samtidigt spännande!

Utöver den vanliga Instrument Panel finns det många riktigt bra instrumentpanelsappar för Signal K. Du kan prova [KIP](https://github.com/mxtommy/Kip) (finns i SK-serverns appbutik) eller [Wilhelm SK](https://www.wilhelmsk.com/) (endast för iOS-enheter, finns i App Store).

### Installera InfluxDB och Grafana

I guidens sista steg installerar och konfigurerar vi InfluxDB och Grafana för att skapa en historisk logg och visualiseringar av båtens data. Det är några steg till och en del skärmar som ser rörigt ut, men den lilla insatsen är väl värd det!

InfluxDB är en tidsseriedatabas som vi använder för att lagra data. Grafana är ett visualiseringsverktyg som ofta används för att övervaka IT-systems hälsa, men som tack vare sin mångsidighet också går utmärkt att använda för våra marina data.

För att installera InfluxDB och Grafana går du tillbaka till VNC Viewer och öppnar OpenPlotter -> Dashboards i Raspberry-menyn:

[![](assets/screenshots/31_openplotter_dashboards.jpg){ width="50%" }](assets/screenshots/31_openplotter_dashboards.jpg)

Välj InfluxDB och klicka på Install. Det tar en stund, men när det är klart går du tillbaka till fliken Apps, väljer Grafana och klickar på Install. Det var allt.

[![](assets/screenshots/32_install.jpg){ width="50%" }](assets/screenshots/32_install.jpg)

Sedan måste vi skapa en ny databas i InfluxDB. Öppna Chronograf, InfluxDB:s webbgränssnitt, i webbläsaren: [http://openplotter.local:8889/](http://openplotter.local:8889/).

[![](assets/screenshots/34_open_chronograf.jpg){ width="50%" }](assets/screenshots/34_open_chronograf.jpg)


Klicka dig igenom den första konfigurationen. Chronografs InfluxDB-anslutning använder användarnamnet `admin` och lösenordet `admin`. Du kan hoppa över att skapa instrumentpaneler och att konfigurera Kapacitor.

Skapa sedan den nya databasen på skärmen InfluxDB Admin:

[![](assets/screenshots/37_create_signalk_db.jpg){ width="50%" }](assets/screenshots/37_create_signalk_db.jpg)

Ge databasen namnet `signalk` och klicka dig igenom resten. Klart.

Nu när databasen väntar på oss ska vi mata in data i den. Gå tillbaka till Signal K-instrumentpanelen för att konfigurera insticksmodulen som skriver till InfluxDB:

[![](assets/screenshots/39_sk_plugin_config.jpg){ width="50%" }](assets/screenshots/39_sk_plugin_config.jpg)

Lämna användarnamn och lösenord tomma. Vår databas hette `signalk`. Vill du kan du ändra skrivintervallet för satsvisa skrivningar och dataupplösningen. Intervallet är 10 sekunder som standard, men vill du se data närmare realtid anger du 2. Upplösningen avgör hur ofta en enskild mätning skrivs till databasen. Standardvärdet 200 ms räcker antagligen, men jag ville ha ännu mer och valde 100 ms. Kryssa också i rutorna som visas nedan.

[![](assets/screenshots/40_settings.jpg){ width="50%" }](assets/screenshots/40_settings.jpg)

Rulla ner och klicka på Submit för att tillämpa konfigurationen. Nu bör mätvärden strömma in i databasen. Vi verifierar det. Gå tillbaka till Chronograf och välj vyn Explore. Längst ner bör du ha en källa som heter `signalk.autogen`. Välj den, så bör namnen på de enskilda mätningarna dyka upp. Utmärkt.

[![](assets/screenshots/41_verify_data.jpg){ width="50%" }](assets/screenshots/41_verify_data.jpg)

Det enda som återstår är att visualisera historiska data.

### Skapa en exempelinstrumentpanel i Grafana

Vi använder Grafana för att visa några snygga grafer. Öppna Grafana i webbläsaren: [http://openplotter.local:3001](http://openplotter.local:3001).

[![](assets/screenshots/42_open_grafana.jpg){ width="50%" }](assets/screenshots/42_open_grafana.jpg)

Grafana kräver att du anger ett nytt lösenord, så gör det. När du kommer till startskärmen konfigurerar du InfluxDB som datakälla:

[![](assets/screenshots/44_grafana_data_sources.jpg){ width="50%" }](assets/screenshots/44_grafana_data_sources.jpg)

I konfigurationen visas standardadressen i mörkgrått, men jag upptäckte att jag var tvungen att skriva in den explicit. I övrigt är det samma `signalk`-databas och tomt användarnamn och lösenord. Klicka på ”Save and Test” för att verifiera att datakällan fungerar.

[![](assets/screenshots/46_config_data_source.jpg){ width="50%" }](assets/screenshots/46_config_data_source.jpg)

Låt oss sammanfatta vad vi har. Signal K tar emot data från NMEA 2000, InfluxDB lagrar dem och Grafana är kopplat till InfluxDB. Till sist kan vi skapa en Grafana-instrumentpanel och lägga till nya datapaneler.

Paneleditorn ser lite rörig ut, men grundstegen är enkla.

[![](assets/screenshots/54_panel_title.jpg){ width="50%" }](assets/screenshots/54_panel_title.jpg)

Redigera frågan. Välj först en mätning på raden FROM. För det andra måste du lägga till en matematisk modifierare för att omvandla mätenheterna (Grafana känner inte riktigt till enheter, så som standard visas data alltid i de SI-enheter de lagras i). För att komma från kelvin till grader Celsius drar du till exempel bort 273,15. Eller för att gå från m/s till knop multiplicerar du med 3600 och dividerar med 1852.

Avsluta panelen genom att ge den en titel och tillämpa ändringarna.

Nu bör du ha en enda panel med lite tidsdata synlig i din instrumentpanel. Lägg till ett par paneler till med knappen Add Panel. Du kan flytta och ändra storlek på panelerna genom att dra i deras titlar och hörn. Till sist kan du välja ett lämpligt tidsintervall i den övre listen och spara instrumentpanelen.

Så här ser min färdiga instrumentpanel för motortemperatur ut:

[![](assets/screenshots/56_two_more_panels.jpg){ width="50%" }](assets/screenshots/56_two_more_panels.jpg)

Det var det. Gå och skapa fantastiska instrumentpaneler och visa dem för kompisarna i hamnen och segelsällskapet! Dela dem gärna också på [Hat Labs diskussionsforum](https://github.com/hatlabs/discussions/discussions) som inspiration!


</div>
