---
title: Hardwarebeskrivelse
translated_from: 257eeaa16d90da32404917c6093ffa709b5400f8
---

# Hardwarebeskrivelse

## Rundtur på kortet

Nedenfor beskrives de forskellige funktionsblokke i Sailor Hat for Raspberry Pi.

<figure markdown="span">
![](SH-RPi-2.0.0-func.jpg){ width="60%" }
<figcaption>SH-RPi'ens funktionsblokke.</figcaption>
</figure>

1. Strømindgang og beskyttelse.
   Strømmen tilføres gennem et Phoenix MC-kompatibelt stik med 3,81 mm (0,15") benafstand.
   Det tilladte spændingsområde er 9–32 V.
   Beskyttelseskredsløbet ved strømindgangen omfatter:
   - 4 A SMD-sikring
   - 33 V transientbeskyttelsesdiode (5000 W impulseffekt)
   - Beskyttelsesdiode mod omvendt polaritet
   - En drosselspole og et pi-filter til styring af ledningsbårne elektromagnetiske forstyrrelser
2. Buckomformer (step-down) i første trin med strømbegrænsning.
   Buckomformeren omformer indgangsspændingen til en spænding på 8,8 V, som superkondensatorbanken kan håndtere.
   Kredsløbet omkring buckomformeren indeholder desuden en separat strømbegrænser, som holder indgangsstrømmen nede på 0,8 A (ved standardindstillingen).
3. Tre superkondensatorer på 20 F og 3,0 V.
   Superkondensatorbanken fungerer som energireserve for Raspberry Pi'en.
   Den kan forsyne en Raspberry Pi 4B i op til 70 sekunder (afhængigt af mængden af yderligere perifere enheder, naturligvis) og modeller med lavere strømforbrug meget længere.
   Superkondensatoren gør det også muligt at forsyne Raspberry Pi'en fra en grænseflade med lav effekt, f.eks. NMEA 2000-bussen, som begrænser den maksimale strøm pr. node til 1,0 A.
4. Mikrocontroller.
   SH-RPi'ens funktioner styres af en ATtiny1616-mikrocontroller.
   Mikrocontrolleren udfører følgende opgaver:
   - Måler indgangsspændingen
   - Måler indgangsstrømmen
   - Måler superkondensatorernes spænding
   - Styrer status-LED-rækken
   - Styrer 5 V-udgangen
   - Modtager oplysninger om interrupts fra realtidsuret
   - Videregiver SH-RPi'ens status til tjenesten på Raspberry Pi'en via I2C
5. Buckomformer i andet trin.
   Buckomformeren omformer superkondensatorbankens spænding til Raspberry Pi'ens indgangsspænding på 5 V. Den maksimale øjeblikkelige udgangsstrøm er 5 A, og mindst 3 A kan opnås som kontinuerlig strøm uden aktiv køling.
   Buckomformerens drift styres af mikrocontrolleren. Mikrocontrolleren aktiverer boostomformeren, når superkondensatorspændingen er steget over 8,0 V.
   Under en systemnedlukning eller en watchdog-genstart deaktiverer mikrocontrolleren boostomformeren for at afbryde Raspberry Pi'ens indgangsspænding.
6. Status-LED-række.
   Kortets fire status-LED'er viser driftsstatus som beskrevet i afsnittet [Status-LED'er](#status-leder).
7. Realtidsur.
   Kortet har et PCF8563-realtidsur, som kan holde tiden nøjagtigt, også når der hverken er internet- eller GPS-forbindelse.
   Realtidsuret kommunikerer med Raspberry Pi'en via I2C.

## Stik

<div class="row">
  <div class="col-sm-6">

<figure markdown="span">
![](SH-RPi-2.0.0-conx.jpg){ width="100%" }
<figcaption>SH-RPi'ens stik, oversiden.</figcaption>
</figure>

   </div>
   <div class="col-sm-6">

<figure markdown="span">
![](SH-RPi-2.0.0-conx-back.jpg){ width="100%" }
<figcaption>SH-RPi'ens stik, undersiden.</figcaption>
</figure>

   </div>
</div>

1. Strømindgangsstik.

   Strømstikket er et Phoenix MC-kompatibelt stik med 3,81 mm (0,15") benafstand.
   Salgspakken indeholder en kompatibel skrueklemme.
2. 5 V-udgangsstik.
   Eksterne perifere enheder til 5 V kan tilsluttes dette stik. 5 V-udgangsstikket er ligeledes et Phoenix MC-kompatibelt stik med 3,81 mm (0,15") benafstand.
3. Gennemgående GPIO-stikliste til Raspberry Pi.
   Dette er en almindelig 2×20-benet Raspberry Pi-GPIO-stikliste. Den medfølgende stabelstikliste skal sættes i for at forbinde SH-RPi'en med en Raspberry Pi.
   Yderligere HAT'er kan stables oven på Sailor Hat.
4. Programmerings- og fejlfindingsstikliste til ATtiny1616.
   Stiklisten kan bruges til at programmere mikrocontrolleren med en ekstern programmeringsenhed eller til at aktivere programmering på selve kortet.
5. Strømbegrænserstikliste.
   Der kan placeres jumpere på strømbegrænserstiklisten for at ændre strømgrænsen til 1,8 A eller 2,8 A (standard er 0,8 A).
   Placer en jumper vandret på den øverste række (mærket 2A) for at sætte strømgrænsen til 1,8 A. Placer en jumper vandret på den nederste række (mærket 3A) for at sætte strømgrænsen til 2,8 A.
6. Stikliste til eksternt interrupt. Ikke funktionel i v2.0.0-hardware.
7. CR1220-batteritilslutning til realtidsuret (på undersiden).
   Realtidsuret kræver et CR1220-backupbatteri for at kunne holde tiden, når systemet er slukket.
   Batteriet skal vende med plussiden (den fladere side) væk fra kortet.
8. RTC Enable-loddejumper.
   Realtidsuret er aktiveret som standard.
   Hvis du vil deaktivere RTC'en, skærer du sporene mellem loddejumperens loddeflader over med en skarp kniv.
   Pas på ikke at skære nærliggende spor over.
9. GPIO4 Enable. Forbind loddefladerne for at koble Raspberry Pi'ens GPIO4 til mikrocontrollerens port PB5 på kortet.
   Dette kræver tilpasset firmwarefunktionalitet for at være nyttigt.

## Strømforsyning

SH-RPi'en har et integreret strømforsyningssystem, der giver Raspberry Pi'en en ren strømforsyning fra en støjfyldt strømkilde som f.eks. ustabiliserede strømforsyninger eller en båds forbrugsbatterisystem. Strømforsyningen tillader indgangsspændinger mellem 9–32 V, men en spænding under 10 V betragtes som en underspændingssituation for at forhindre skader fra dybafladning på typiske blybatterier.

Funktionsdiagrammet for strømforsyningssystemet er vist på billedet nedenfor.

Den maksimale indgangsstrøm er begrænset for at beskytte de foranliggende strømforsyninger og ledningsføringen. Standardstrømgrænsen er 0,8 A, men grænsen kan hæves til 1,8 A eller 2,8 A ved at placere jumpere på strømbegrænserstiklisten.

Indgangsspændingen sænkes af buckomformeren i første trin, så superkondensatorbanken oplades til en spænding på 8,8 V. Superkondensatorerne bruges som energireserve for Raspberry Pi'en, både ved kortvarige spændingsudfald og som sidste udvej for strøm under en systemnedlukning.

Buckomformeren i andet trin omformer superkondensatorspændingen til Raspberry Pi'ens indgangsspænding på 5 V. Mikrocontrolleren aktiverer 5 V-udgangen, når superkondensatorspændingen er over 8,0 V, og deaktiverer den, når superkondensatorspændingen falder til under 5,0 V. Brugeren kan konfigurere disse grænser.

Den maksimale spidsstrøm ud til Raspberry Pi'en er 5 A. Den maksimale gennemsnitlige udgangsstrøm afhænger af indstillingen for indgangsstrømbegrænseren og af omgivelsestemperaturen. Ved en indgangsstrømgrænse på 0,8 A er den maksimale vedvarende udgangsstrøm ca. 1,4 A. Ved en indgangsstrømgrænse på 2,8 A begrænses den maksimale gennemsnitlige udgangsstrøm af systemets termiske forhold. I et åbent rum ved stuetemperatur er den maksimale gennemsnitlige udgangsstrøm ved 5 V mindst 3,0 A. Højere værdier er mulige med aktiv køling af SH-RPi-kortet.

Ved en udgangsstrøm på 1,4 A er strømforsyningens samlede virkningsgrad 79 %.

<figure markdown="span">
![](psu_diagram.svg){ width="70%" }
<figcaption>Funktionsdiagram for strømforsyningen med eksempler på strøm- og spændingsværdier.</figcaption>
</figure>

## Status-LED'er

SH-RPi'ens LED-række i venstre side af kortet viser kortets driftsstatus.
Søjlevisningen viser superkondensatorbankens opladningstilstand. Den første LED begynder at lyse, når spændingen er over 5 V, og alle LED'er lyser fuldt ved en superkondensatorspænding på 9 V.

Oven på søjlevisningen angiver forskellige blinkmønstre kortets tilstand som følger.

| Mønster | Beskrivelse |
|---------|-------------|
| Intet blink | Opladning/normal drift (1) |
| Kort slukning hvert 4. sekund | Watchdog aktiv (2)  |
| Ruller mod venstre | Ingen indgangsspænding (3) |
| To korte slukninger med 1 s pause| Lukker ned (4) |
| To blink med 2 s pause | I dvale (5) |
| Skiftevis blinkende LED'er| Watchdog-genstart (6) |
| Hurtig blinken | Fejl – kontakt producenten (7) |

Herunder følger en detaljeret beskrivelse af tilstandene:

1. Superkondensatorerne oplades, og hvis superkondensatorspændingen er over 8,0 V, er 5 V-udgangen aktiveret.
   Dæmonen (baggrundstjenesten) i Raspberry Pi OS er ikke aktiv.
2. Dæmonen er aktiv, og watchdoggen er aktiveret. Styresystemet er startet op og kører normalt.
3. Indgangsspændingen er væk, og superkondensatorerne aflades. 5 V-udgangen er aktiveret.
4. Dæmonen har startet en nedlukning. SH-RPi'en venter på, at Raspberry Pi'en lukker ned.
5. SH-RPi'en er i dvale. 5 V-udgangen er deaktiveret, og kortet venter på en alarm fra realtidsuret, som skal vække den.
6. SH-RPi'en har ikke modtaget et heartbeat-signal (livstegn) fra dæmonen i 10 s, hvilket tyder på, at Pi'en er gået ned.
   Raspberry Pi'en nulstilles ved at slukke for 5 V i to sekunder.
7. SH-RPi'en har registreret overspænding på superkondensatorerne. Kontakt producenten for yderligere hjælp.


## Watchdog-genstartsfunktion

Ud over strømforsyningen indeholder Sailor Hat for Raspberry Pi en hardwarebaseret watchdog-timer, som kan bruges til at genstarte Raspberry Pi'en, hvis software eller hardware låser fast. Watchdog-timeren er aktiveret som standard og kan om nødvendigt deaktiveres med kommandoen `shrpi set watchdog 0` på enhedens kommandolinje. Når den er aktiveret, genstarter watchdog-timeren Raspberry Pi'en, hvis den ikke modtager et »heartbeat«-signal fra Raspberry Pi'en inden for et forud fastsat tidsrum (typisk 10 sekunder).

Raspberry Pi'en skal køre en tjeneste, som sender et periodisk heartbeat-signal til SH-RPi'en. Tjenesten kan installeres fra den medfølgende softwarepakke.

Hvis watchdog-timeren udløser en genstart, deaktiverer SH-RPi'en 5 V-udgangen i et kort stykke tid for at tvinge Raspberry Pi'en til at genstarte. Derefter aktiverer SH-RPi'en 5 V-udgangen igen, så Raspberry Pi'en kan starte op på ny.

## Realtidsur

SH-RPi'en har et PCF8563-realtidsur (RTC), som kan holde tiden nøjagtigt, også når Raspberry Pi'en ikke er forbundet til internettet, eller der ikke er noget GPS-signal. Realtidsuret er forbundet til Raspberry Pi'en via I2C-bussen.

For at bruge RTC'en skal der monteres et CR1220-backupbatteri på undersiden af kortet. Batteriets plusside (den fladere side) skal vende væk fra kortet.

Når SH-RPi-kortet bruges sammen med en enhed med indbygget RTC, kan RTC'erne have modstridende I2C-adresser.
I så fald kan RTC'en på SH-RPi'en deaktiveres ved at skære sporene mellem RTC EN-loddejumperens loddeflader over.

## Hardwarekonfiguration

Brugeren kan konfigurere Sailor Hat for Raspberry Pi til bestemte anvendelser. Konfigurationsmulighederne omfatter:

1. Indstilling af strømbegrænseren.
   Indgangsstrømbegrænseren kan sættes til 0,8 A (standard), 1,8 A eller 2,8 A ved at placere jumpere på strømbegrænserstiklisten.
2. Aktivering af realtidsuret.
   Realtidsuret kan aktiveres eller deaktiveres med en loddejumper.
3. Aktivering af GPIO4.
   Forbind loddefladerne for at koble Raspberry Pi'ens GPIO4 til mikrocontrollerens port PB5 på kortet. Dette kræver tilpasset firmwarefunktionalitet for at være nyttigt.

## I2C

Sailor Hat kommunikerer med Raspberry Pi'en
via I2C-bus 1 på GPIO-ben 3 og 5 (henholdsvis GPIO2 og GPIO3).
I2C-adressen er 0x6d.

PCF8563-realtidsuret reserverer desuden I2C-adressen 0x51 på den samme bus.
