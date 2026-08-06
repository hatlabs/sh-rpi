---
title: Kom igång
translated_from: 46b4add9db5ebdedd9ae7e3eba99744cd34a074c
---

# Kom igång

## Montering av hårdvaran

SH-RPi levereras färdigmonterad. Installationsstegen för hårdvaran är:

1. För in den 40-poliga genomgående stiftlisten i SH-RPi genom sockeln på undersidan, med stiften uppåt.
2. Anslut SH-RPi till GPIO-stiftlisten på Raspberry Pi (eventuellt med sexkantsdistanserna).
3. Anslut lämpliga strömledare till plintkontakterna. Plintkontakterna levereras med åtdragna skruvar, så se till att lossa dem innan du för in ledarna.

<figure markdown="span">
![](shrpi_v2_hardware_assembly.jpg){ width="50%" }
<figcaption>Monteringsschema för SH-RPi v2.0.0.</figcaption>
</figure>

### Strömanslutning

!!! warning
    Anslut aldrig strömingången till 5 V-utgångskontakten! Det skadar Raspberry Pi och SH-RPi permanent.

Anslut en strömkälla på 10–32 V till SH-RPi:s ingångskontakt för ström enligt följande figur.

<figure markdown="span">
![](shrpi_power_input.jpg){ width="50%" }
<figcaption>Anslut strömkällan till kontakten som är inringad i grönt.</figcaption>
</figure>

Strömkällan måste klara minst 1,0 A vid den angivna utspänningen.
Allt annat lika ger ett nätaggregat med högre utspänning, till exempel 24 V, något effektivare drift.
I övrigt fungerar 12 V-system i båtar och fordon, eller likströmskällor, bra.

## Installation av programvaran

Raspberry Pi OS behöver ytterligare programvara för att köra den systemtjänst som automatiskt startar en avstängning när strömmen bryts.
Ett automatiskt installationsskript finns för att förenkla installationen.

### Automatisk installation

Ett automatiskt installationsskript tillhandahålls. Skriptet är testat på nyss flashad Raspberry Pi OS och kan misslyckas på kraftigt modifierade system.
Installationen har inte testats på andra operativsystem.

Kör det automatiska installationsskriptet genom att kopiera och klistra in följande kommando i kommandotolken på Raspberry Pi:

    curl -L \
        https://raw.githubusercontent.com/hatlabs/SH-RPi-daemon/main/install-online.sh \
        | sudo bash

Kommandot sträcker sig över tre rader, och när du klistrar in det i terminalfönstret kan det visa radfortsättningstecken. Det gör inget. Tryck på ”Enter” för att köra kommandot.

<figure markdown="span">
![](automated-installation-screenshot.png){ width="80%" }
<figcaption>Installationskommandot i terminalen</figcaption>
</figure>

Kommandot hämtar installationsskriptet och kör det automatiskt.

Det automatiska installationsskriptet kommer att:

- aktivera I2C-gränssnittet, som SH-RPi behöver för att kommunicera med Raspberry Pi
- om stöd för tilläggskortet för NMEA 2000-gränssnitt har valts
  - aktivera SPI-gränssnittet och en device tree-overlay
  - definiera CAN-nätverksgränssnittet
- om stöd för tilläggskortet för NMEA 0183-gränssnitt har valts
  - aktivera SPI-gränssnittet och en device tree-overlay
- aktivera device tree-overlayn för realtidsklockan
- om stöd för MAX-M8Q GNSS HAT har valts
  - aktivera det seriella UART-gränssnittet
  - inaktivera seriekonsolen
  - inaktivera Bluetooth, eftersom det står i konflikt med det seriella UART-gränssnittet
- installera SH-RPi:s tjänsteprogramvara

## Kapslingar

Om du planerar att använda din Raspberry Pi och SH-RPi utomhus, i ett fordon eller på en båt, eller i starkt kondenserande miljöer, placera alltid enheten i en vattentät kapsling!
Hat Labs
erbjuder ett urval av [vattentäta kapslingar](https://shop.hatlabs.fi/collections/accessories-enclosures).

De mellanstora och stora kapslingarna levereras med en perforerad bottenplatta och monteringsadaptrar som kan användas för att montera Raspberry Pi, ytterligare HAT-kort och andra komponenter.
Övriga kapslingar levereras med 3D-printade klisterfästen.

### Bygge av mellanstor kapsling

Den mellanstora kapslingen är konstruerad för att rymma Raspberry Pi 4 Model B, SH-RPi och flera HAT-kort i vertikalt läge. Installationen beskrivs nedan.

#### Montering

Vi börjar med en tom kapsling, som visas i följande figur.

<figure markdown="span">
![](01_bare_box.jpg){ width="50%" }
<figcaption>Kapsling utan några komponenter.</figcaption>
</figure>

Montera först alla kontakter du behöver. Innan du monterar kontakterna kan du behöva löda ledare till dem. Lödanvisningar för lödkoppar finns i den här YouTube-videon:

<iframe width="560" height="315" src="https://www.youtube.com/embed/_GLeCt_u3U8" frameborder="0" allowfullscreen></iframe>

Det finns ingen egentlig standard för strömkontakternas stiftkonfiguration, men vi föreslår att du alltid ansluter GND till stift 1 och +12 V/24 V till stift 2. Följande figur visar den monterade strömkontakten.

För sedan in kontakterna i kapslingen. Följande figur visar de monterade kontakterna.

<figure markdown="span">
![](02_conx.jpg){ width="50%" }
<figcaption>Monterade kontakter.</figcaption>
</figure>

Om kapslingen ska användas i en kondenserande miljö, till exempel på en båt eller utomhus, täta de återstående hålen med pluggade kabelgenomföringar. Följande figur visar hur pluggen ska monteras i kabelgenomföringarna.

<figure markdown="span">
![](03_gland_plug.jpg){ width="50%" }
<figcaption>Blindplugg för kabelgenomföring.</figcaption>
</figure>

Och följande figur visar de monterade kabelgenomföringarna. Detta gör kapslingen vattentät.

<figure markdown="span">
![](04_conx_plugs.jpg){ width="50%" }
<figcaption>Monterade kabelgenomföringar.</figcaption>
</figure>

Därefter tar vi de delar vi vill montera i kapslingen och placerar dem på bottenplattan. Följande figur visar delarna vi ska montera. De svarta plastdelarna är vertikalfästena som håller kortstapeln på plats.

<figure markdown="span">
![](05_ingredients.jpg){ width="50%" }
<figcaption>Ingredienser.</figcaption>
</figure>

Först skruvas 6 mm sexkantsdistanserna in i vertikalfästena. Dra endast åt för hand!

Följande figur visar vertikalfästena med distanserna monterade.

<figure markdown="span">
![](06_vertical_mounts.jpg){ width="50%" }
<figcaption>Vertikalfästen med sexkantsdistanser.</figcaption>
</figure>

Sedan kan du fästa fästena på Raspberry Pi eller bärkortet. Använd M2,5-skruvarna för att fästa kortet intill GPIO-stiften och M2,5 16 mm sexkantsdistanserna på motsatt sida.

Därefter monterar vi den genomgående stiftlisten på SH-RPi. Tryck försiktigt och jämnt så att stiften inte böjs. Den optimala listhöjden beror på HAT-kortens ordning. Om du sätter SH-RPi direkt ovanpå Raspberry Pi ska du ta bort distansen från den genomgående stiftlisten. Distansen behövs däremot om du monterar SH-RPi ovanpå ett annat gränssnitts-HAT-kort.

<figure markdown="span">
![](07_stack_thru_conx.jpg){ width="50%" }
<figcaption>Montering av den genomgående stiftlisten.</figcaption>
</figure>

Nästa figur visar SH-RPi monterad på bärkortet.

<figure markdown="span">
![](08_shrpi_mounted.jpg){ width="50%" }
<figcaption>SH-RPi monterad på bärkortet.</figcaption>
</figure>

#### Strömkabeldragning

I den här genomgången monterar vi dessutom ett CAN HAT-kort för NMEA 2000-anslutning. Följande figur visar CAN HAT-kortet monterat på SH-RPi.

<figure markdown="span">
![](09_can_mounted.jpg){ width="50%" }
<figcaption>CAN HAT-kortet monterat på SH-RPi.</figcaption>
</figure>

Nästa steg är att montera kortstapeln på bottenplattan. Använd de medföljande M3-skruvarna för att fästa stapeln på plats. Dra inte åt skruvarna för hårt.

<figure markdown="span">
![](10_on_base_mount.jpg){ width="50%" }
<figcaption>Kortstapeln monterad på bottenplattan.</figcaption>
</figure>

Avisolera sedan kontakternas ledare. Om en separat strömkontakt används ska den röda NMEA 2000-ledaren lämnas oavisolerad eller klippas av helt. Följande figur visar de avisolerade ledarna.

<figure markdown="span">
![](13_stripped_wires.jpg){ width="50%" }
<figcaption>Avisolerade ström- och CAN-ledare.</figcaption>
</figure>

Nästa steg är att ansluta ledarna till kortets kontakter. Strömkontakten ska anslutas till plintkontakten enligt följande figur.

När du sätter i plintkontakten, var _mycket_ noga med att sätta den i ingångskontakten på SH-RPi. Du kan skada alla enheter i stapeln om du sätter den i 5 V-utgångskontakten!

<figure markdown="span">
![](14_power_conx.jpg){ width="50%" }
<figcaption>Kopplingen i strömkontaktens plintkontakt.</figcaption>
</figure>

Därefter ska CAN-ledarna anslutas till kontakten CAN0 på CAN HAT-kortet enligt nedan. Svart är jord, vit är CAN high (H) och blå är CAN low (L).

<figure markdown="span">
![](15_wires_plugged.jpg){ width="50%" }
<figcaption>Slutlig kabelkoppling.</figcaption>
</figure>

#### Strömförsörjning från NMEA 2000

Vid användning på en båt kan du också strömförsörja systemet från NMEA 2000-nätverket. I så fall används alla ledare från NMEA 2000-kontakten.

<figure markdown="span">
![](18_alt_can_wires.jpg){ width="50%" }
<figcaption>När enheten strömförsörjs från NMEA 2000-nätverket används alla ledare från NMEA 2000-kontakten.</figcaption>
</figure>

Den svarta och den röda ledaren ansluts till plintkontakten för ström, med en kort bit svart ledare skarvad till GND-polen enligt följande figur. Den korta svarta ledaren ansluts till GND-polen på CAN HAT-kortets CAN0-kontakt.

<figure markdown="span">
![](19_spliced_gnd.jpg){ width="50%" }
<figcaption>Anslut NMEA 2000-nätets GND-ledare till både plintkontakten för ström och CAN HAT-kortets CAN0-kontakt.</figcaption>
</figure>

Nästa figur visar den slutliga kabelkopplingen när enheten strömförsörjs från NMEA 2000-nätverket.

<figure markdown="span">
![](20_can_power_wiring.jpg){ width="50%" }
<figcaption>Slutlig kabelkoppling när enheten strömförsörjs från NMEA 2000-nätverket.</figcaption>
</figure>

#### Fästa kortstapeln

Slutligen kan stapelns lösa ände fästas i bottenplattan med små buntband; buntband är ett enkelt och lättanvänt alternativ. De följande två figurerna visar monteringen av buntbanden.

<figure markdown="span">
![](11_tie_wraps.jpg){ width="50%" }
<figcaption>Buntband isatta.</figcaption>
</figure>

<figure markdown="span">
![](12_tie_wraps_2.jpg){ width="50%" }
<figcaption>Färdig buntbandsmontering.</figcaption>
</figure>

#### Slutföra monteringen

Nu kan bottenplattan sättas in i kapslingen.

<figure markdown="span">
![](16_in_place.jpg){ width="50%" }
<figcaption>Bottenplattan på plats.</figcaption>
</figure>

Fäst bottenplattan i kapslingen med de medföljande skruvarna.

<figure markdown="span">
![](17_screw_base_mount.jpg){ width="50%" }
<figcaption>Bottenplattan skruvas fast i kapslingen.</figcaption>
</figure>

Nu är monteringen klar. Figuren nedan visar bygget som blinkar glatt i kapslingen.

<figure markdown="span">
![](21_all_done.jpg){ width="50%" }
<figcaption>Det färdiga bygget.</figcaption>
</figure>

Kapslingen kan monteras på en vägg eller ett skott genom hörnhålen som visas i figuren nedan.

<figure markdown="span">
![](22_mounting.jpg){ width="50%" }
<figcaption>Monteringshålens placering.</figcaption>
</figure>


### Borra hål

Om du använder en kapsling utan förborrade hål måste du borra hålen själv.

Som minimum behöver du ett hål för strömingången och, i en metallkapsling, ytterligare ett för en WiFi-antenn eller en trådbunden Ethernet-kontakt.

Planera placeringen av hål och kontakter efter den tänkta installationsplatsen.
Om du planerar väggmontage av kapslingen ska du placera kontakterna nedåt för att minimera risken för vatteninträngning.

Både aluminium och polykarbonat är relativt mjuka och kan borras med en stegborr (en som ser ut som en liten julgran i metall).
Vid borrning i plast kan vanliga metallborrar lätt ta för hårt och spräcka väggen.

<figure markdown="span">
![](step_drill_bit.jpg){ width="50%" }
<figcaption>Exempel på stegborrar.</figcaption>
</figure>

Lämpliga hålstorlekar för olika kontakter:

- SMA (WiFi-antenn): 6,5–7 mm eller 1/4"
- PG7-kabelgenomföring och M12-panelkontakt (NMEA 2000): 12,5 mm eller 1/2"
- SP13-panelkontakter (blåsvarta plastkontakter): 13 mm.
- PG9-kabelgenomföring: 16 mm eller 5/8"
- RJ45-panelkontakt: 21–22 mm
- USB typ A-panelkontakt: 21–22 mm

### Montera Raspberry Pi

Kapslingarna från Hat Labs innehåller monteringsadaptrar som kan användas för att montera Raspberry Pi.

### Löda panelkontakterna

När du löder de inre ledarna till panelkontakterna ska du alltid använda krympslang på de enskilda ledarna.
Kom alltid ihåg att trä krympslangen på ledarna _innan_ du löder...
Oftast kan du först fylla kontaktstiftets hålighet med lod och sedan smälta om lodet och föra in ledaren.

### Ansluta en fläkt

En fläkt inne i kapslingen rekommenderas för att förbättra luftcirkulationen och värmeöverföringen genom kapslingens
ytor.
En liten 40 mm fläkt kan monteras i kapslingen med dubbelhäftande tejp eller varmlim.

Fläkten ska anslutas till den allmänna 5 V-utgångskontakten på SH-RPi:

<figure markdown="span">
![](shrpi_5v_output.jpg){ width="50%" }
<figcaption>Anslut fläkten till kontakten som den röda pilen pekar på.</figcaption>
</figure>

### Slutföra installationen

När du har borrat hålen, monterat Raspberry Pi, lött panelkontakterna och anslutit fläkten, stäng kapslingen för att skydda din SH-RPi och Raspberry Pi mot väder och vind. Se till att alla anslutningar sitter fast och att kapslingen är tätt sluten så att vatten inte tränger in.

### Testa systemet

När installationen är klar, slå på ditt Raspberry Pi- och SH-RPi-system för att kontrollera att allt fungerar som det ska. Kontrollera att Raspberry Pi startar, att fläkten går och att SH-RPi kommunicerar med Raspberry Pi. När du har verifierat att allt fungerar kan du gå vidare med att konfigurera programvaran och integrera systemet i den tänkta miljön.

Grattis! Du har nu slutfört monteringen av hårdvaran och kapslingen för ditt SH-RPi- och Raspberry Pi-system.
