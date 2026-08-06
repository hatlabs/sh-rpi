---
title: Hårdvarubeskrivning
translated_from: 257eeaa16d90da32404917c6093ffa709b5400f8
---

# Hårdvarubeskrivning

## En rundtur på kortet

De olika funktionsblocken i Sailor Hat for Raspberry Pi beskrivs nedan.

<figure markdown="span">
![](SH-RPi-2.0.0-func.jpg){ width="60%" }
<figcaption>SH-RPi:ns funktionsblock.</figcaption>
</figure>

1. Strömingång och skydd.
   Strömmen matas in via en Phoenix MC-kompatibel kontakt med 3,81 mm (0,15") stiftavstånd.
   Det tillåtna spänningsområdet är 9–32 V.
   Skyddskretsarna vid strömingången omfattar:
   - 4 A SMD-säkring
   - 33 V transientskydd (5000 W toppulseffekt)
   - Skyddsdiod mot omvänd polaritet
   - En drossel och ett pi-filter som dämpar ledningsbundna elektromagnetiska störningar
2. Spänningssänkande omvandlare (buck) i första steget, med strömbegränsning.
   Buckomvandlaren omvandlar inspänningen till 8,8 V, en nivå som superkondensatorbanken klarar.
   Den spänningssänkande omvandlarkretsen innehåller också en separat strömbegränsare som stryper inströmmen till 0,8 A (med standardinställningen).
3. Tre superkondensatorer på 20 F och 3,0 V.
   Superkondensatorbanken fungerar som energireserv för Raspberry Pi:n.
   Den kan driva en Raspberry Pi 4B i upp till 70 sekunder (beroende på mängden ansluten kringutrustning, förstås) och modeller med lägre effektbehov betydligt längre.
   Superkondensatorerna gör det också möjligt att driva Raspberry Pi:n från ett strömsnålt gränssnitt som NMEA 2000-bussen, där den maximala strömmen per nod är begränsad till 1,0 A.
4. Mikrokontroller.
   SH-RPi:ns funktioner styrs av en ATtiny1616-mikrokontroller.
   Mikrokontrollern utför följande uppgifter:
   - Mäter inspänningen
   - Mäter inströmmen
   - Mäter superkondensatorernas spänning
   - Styr status-LED-raden
   - Styr 5 V-utgången
   - Tar emot avbrottsinformation från realtidsklockan
   - Rapporterar SH-RPi:ns status till tjänsten på Raspberry Pi:n via I2C
5. Buckomvandlare i andra steget.
   Buckomvandlaren omvandlar superkondensatorbankens spänning till Raspberry Pi:ns inspänning på 5 V. Den maximala momentana utströmmen är 5 A, och minst 3 A kan nås som kontinuerlig ström utan aktiv kylning.
   Buckomvandlarens drift styrs av mikrokontrollern. Mikrokontrollern aktiverar boostomvandlaren när superkondensatorernas spänning har stigit över 8,0 V.
   Vid systemavstängning eller watchdog-omstart avaktiverar mikrokontrollern boostomvandlaren för att bryta Raspberry Pi:ns inspänning.
6. Status-LED-rad.
   De fyra status-LED:erna visar kortets driftstatus enligt beskrivningen i avsnittet [Status-LED:er](#status-leder).
7. Realtidsklocka.
   Kortet har en PCF8563-realtidsklocka som håller tiden exakt även utan internet- eller GPS-anslutning.
   Realtidsklockan kommunicerar med Raspberry Pi:n via I2C.

## Kontakter

<div class="row">
  <div class="col-sm-6">

<figure markdown="span">
![](SH-RPi-2.0.0-conx.jpg){ width="100%" }
<figcaption>SH-RPi:ns kontakter, ovansidan.</figcaption>
</figure>

   </div>
   <div class="col-sm-6">

<figure markdown="span">
![](SH-RPi-2.0.0-conx-back.jpg){ width="100%" }
<figcaption>SH-RPi:ns kontakter, undersidan.</figcaption>
</figure>

   </div>
</div>

1. Kontakt för strömingång.

   Strömkontakten är en Phoenix MC-kompatibel kontakt med 3,81 mm (0,15") stiftavstånd.
   Förpackningen innehåller en kompatibel plintkontakt med skruvanslutning.
2. Kontakt för 5 V-utgången.
   Extern 5 V-kringutrustning kan anslutas till den här kontakten. Även kontakten för 5 V-utgången är en Phoenix MC-kompatibel kontakt med 3,81 mm (0,15") stiftavstånd.
3. Genomgående GPIO-stiftlist för Raspberry Pi.
   Det här är en vanlig 2×20-polig GPIO-stiftlist för Raspberry Pi. Den medföljande genomgående stiftlisten ska sättas i för att ansluta SH-RPi:n till en Raspberry Pi.
   Fler HAT-kort kan staplas ovanpå Sailor Hat.
4. Stiftlist för programmering och felsökning av ATtiny1616.
   Via stiftlisten kan mikrokontrollern programmeras med en extern programmerare, eller så kan programmering på kortet aktiveras.
5. Strömbegränsarens bygellist.
   Byglar kan placeras på strömbegränsarens bygellist för att ändra strömgränsinställningen till 1,8 A eller 2,8 A (standardvärdet är 0,8 A).
   Placera en bygel vågrätt på den övre raden (märkt 2A) för att sätta strömgränsen till 1,8 A. Placera en bygel vågrätt på den nedre raden (märkt 3A) för att sätta strömgränsen till 2,8 A.
6. Stiftlist för externt avbrott. Fungerar inte i hårdvaruversion v2.0.0.
7. CR1220-batterikontakt för realtidsklockan (på undersidan).
   Realtidsklockan behöver ett CR1220-backupbatteri för att hålla tiden när systemet är strömlöst.
   Batteriet ska vändas med plussidan (den plattare sidan) bort från kortet.
8. Lödbygeln RTC Enable.
   Realtidsklockan är aktiverad som standard.
   Avaktivera RTC:n genom att skära av ledarna mellan lödbygelns pads med en vass kniv.
   Var noga med att inte skära av några intilliggande ledare.
9. GPIO4 Enable. Förbind lödbygelns pads för att koppla Raspberry Pi:ns GPIO4 till mikrokontrollerporten PB5 på kortet.
   Det kräver anpassad firmware-funktionalitet för att vara till nytta.

## Strömförsörjning

SH-RPi:n har ett integrerat strömförsörjningssystem som ger Raspberry Pi:n en ren matningsspänning från en störig strömkälla, till exempel oreglerade nätaggregat eller en båts ”husbatterisystem”. Strömförsörjningen tillåter inspänningar mellan 9–32 V, men en spänning under 10 V tolkas som underspänning för att förhindra att typiska blybatterier skadas av djupurladdning.

Strömförsörjningssystemets funktionsschema visas i bilden nedan.

Den maximala inströmmen begränsas för att skydda uppströms strömkällor och kablage. Standardströmgränsen är 0,8 A, men gränsen kan höjas till 1,8 A eller 2,8 A genom att placera byglar på strömbegränsarens bygellist.

Inspänningen sänks av buckomvandlaren i första steget, som laddar superkondensatorbanken upp till 8,8 V. Superkondensatorerna fungerar som energireserv för Raspberry Pi:n, både vid kortvariga störningar och som sista utväg under en systemavstängning.

Buckomvandlaren i andra steget omvandlar superkondensatorernas spänning till Raspberry Pi:ns inspänning på 5 V. Mikrokontrollern aktiverar 5 V-utgången när superkondensatorernas spänning är över 8,0 V och avaktiverar den när spänningen sjunker under 5,0 V. Du kan själv ställa in de här gränserna.

Den maximala toppströmmen ut till Raspberry Pi:n är 5 A. Den maximala medelutströmmen beror på strömbegränsarens inställning och omgivningstemperaturen. Vid strömgränsen 0,8 A är den maximala uthålliga utströmmen ungefär 1,4 A. Vid strömgränsinställningen 2,8 A begränsas den maximala medelutströmmen av systemets termiska egenskaper. I fritt utrymme vid rumstemperatur är den maximala medelutströmmen vid 5 V minst 3,0 A. Högre värden är möjliga med aktiv kylning av SH-RPi-kortet.

Vid 1,4 A utström är strömförsörjningens totala verkningsgrad 79 %.

<figure markdown="span">
![](psu_diagram.svg){ width="70%" }
<figcaption>Funktionsschema för strömförsörjningen med exempelvärden för ström och spänning.</figcaption>
</figure>

## Status-LED:er

SH-RPi:ns LED-rad på kortets vänstra sida visar kortets driftstatus.
Stapeldisplayen visar superkondensatorbankens laddningsnivå. Den första LED:en börjar lysa när spänningen är över 5 V, och alla LED:er lyser med full styrka vid 9 V superkondensatorspänning.

Ovanpå stapeldisplayen visar olika blinkmönster kortets tillstånd enligt följande.

| Mönster | Beskrivning |
|---------|-------------|
| Ingen blinkning | Laddning/normal drift (1) |
| Kort släckning var 4:e sekund | Watchdog aktiv (2)  |
| Rullning åt vänster | Ingen inspänning (3) |
| Två släckningar med 1 s paus| Stänger av (4) |
| Två blinkningar med 2 s paus | Viloläge (5) |
| Växelvis blinkande LED:er| Watchdog-omstart (6) |
| Snabb blinkning | Fel – kontakta tillverkaren (7) |

En detaljerad beskrivning av tillstånden följer:

1. Superkondensatorerna laddas, och om deras spänning är över 8,0 V är 5 V-utgången aktiverad.
   Daemonen i Raspberry Pi OS är inte aktiv.
2. Daemonen är aktiv och watchdogen är aktiverad. Operativsystemet har startat och körs normalt.
3. Matningsspänningen har fallit bort och superkondensatorerna laddas ur. 5 V-utgången är aktiverad.
4. Daemonen har startat en avstängning. SH-RPi:n väntar på att Raspberry Pi:n ska stängas av.
5. SH-RPi:n är i viloläge. 5 V-utgången är avaktiverad och kortet väntar på ett larm från realtidsklockan för att vakna.
6. SH-RPi fick ingen heartbeat från daemonen på 10 s, vilket tyder på att Pi:n har kraschat.
   Raspberry Pi:n återställs genom att 5 V stängs av i två sekunder.
7. SH-RPi:n har upptäckt överspänning i superkondensatorerna. Kontakta tillverkaren för vidare hjälp.


## Watchdogens omstartsfunktion

Utöver strömförsörjningen har Sailor Hat for Raspberry Pi en watchdog-timer i hårdvaran som kan starta om Raspberry Pi:n vid en programvaru- eller hårdvarulåsning. Watchdog-timern är aktiverad som standard och kan vid behov avaktiveras med kommandot `shrpi set watchdog 0` på enhetens kommandorad. När den är aktiverad startar watchdog-timern om Raspberry Pi:n om den inte får någon ”heartbeat”-signal från Raspberry Pi:n inom ett förutbestämt tidsintervall (vanligtvis 10 sekunder).

Raspberry Pi:n måste köra en tjänst som skickar en regelbunden heartbeat-signal till SH-RPi:n. Tjänsten kan installeras från det medföljande programvarupaketet.

Om watchdog-timern utlöser en omstart avaktiverar SH-RPi:n 5 V-utgången en kort stund för att tvinga fram en omstart av Raspberry Pi:n. Därefter aktiverar SH-RPi:n 5 V-utgången igen så att Raspberry Pi:n kan starta på nytt.

## Realtidsklocka

SH-RPi:n har en PCF8563-realtidsklocka (RTC) som håller tiden exakt även när Raspberry Pi:n inte är ansluten till internet eller när ingen GPS-signal är tillgänglig. RTC:n är ansluten till Raspberry Pi:n via I2C-bussen.

För att använda RTC:n måste ett CR1220-backupbatteri monteras på kortets undersida. Batteriets plussida (den plattare sidan) ska vara vänd bort från kortet.

När SH-RPi-kortet används tillsammans med en enhet som har en egen inbyggd RTC kan klockornas I2C-adresser krocka.
I så fall kan RTC:n på SH-RPi:n avaktiveras genom att skära av ledarna mellan pads på lödbygeln RTC EN.

## Hårdvarukonfiguration

Du kan konfigurera Sailor Hat for Raspberry Pi så att den passar dina egna användningsfall. Konfigurationsalternativen omfattar:

1. Strömbegränsarens inställning.
   Inströmbegränsaren kan ställas in på 0,8 A (standard), 1,8 A eller 2,8 A genom att placera byglar på strömbegränsarens bygellist.
2. Aktivering av realtidsklockan.
   RTC:n kan aktiveras eller avaktiveras med en lödbygel.
3. Aktivering av GPIO4.
   Förbind lödbygelns pads för att koppla Raspberry Pi:ns GPIO4 till mikrokontrollerporten PB5 på kortet. Det kräver anpassad firmware-funktionalitet för att vara till nytta.

## I2C

Sailor Hat kommunicerar med Raspberry Pi:n
via I2C-buss 1 på GPIO-stiften 3 och 5 (GPIO2 respektive GPIO3).
I2C-adressen är 0x6d.

PCF8563-realtidsklockan reserverar dessutom I2C-adressen 0x51 på samma buss.
