---
title: Maskinvarebeskrivelse
translated_from: 257eeaa16d90da32404917c6093ffa709b5400f8
---

# Maskinvarebeskrivelse

## En omvisning på kortet

De ulike funksjonsblokkene i Sailor Hat for Raspberry Pi er beskrevet nedenfor.

<figure markdown="span">
![](SH-RPi-2.0.0-func.jpg){ width="60%" }
<figcaption>Funksjonsblokkene i SH-RPi.</figcaption>
</figure>

1.  Strøminngang og beskyttelse.
    Strømmen tilføres gjennom en Phoenix MC-kompatibel kontakt med 3,81 mm (0,15") senteravstand.
    Tillatt spenningsområde er 9–32 V.
    Beskyttelseskretsen på strøminngangen omfatter:

    - 4 A SMD-sikring
    - 33 V transientbeskyttelse (5000 W topp-pulseffekt)
    - Diode for beskyttelse mot omvendt polaritet
    - En drosselspole og et pi-filter for å begrense ledningsbundet elektromagnetisk støy
2.  Step-down-omformer (buck) i første trinn, med strømbegrensning.
    Buck-omformeren omformer inngangsspenningen til 8,8 V, en spenning superkondensatorbanken tåler.
    Step-down-omformerkretsen inneholder også en egen strømbegrenser som struper inngangsstrømmen til 0,8 A (med standardinnstillingen).
3.  Tre superkondensatorer på 20 F, 3,0 V.
    Superkondensatorbanken fungerer som et energilager for Raspberry Pi-en.
    Den kan forsyne en Raspberry Pi 4B i opptil 70 sekunder (avhengig av hvor mange ekstra tilleggsenheter som er tilkoblet, selvsagt), og modeller med lavere effektbehov mye lenger.
    Superkondensatorene gjør det også mulig å forsyne Raspberry Pi-en fra et grensesnitt med lav effekt, for eksempel NMEA 2000-bussen, som begrenser strømmen per node til maksimalt 1,0 A.
4.  Mikrokontroller.
    SH-RPi styres av en ATtiny1616-mikrokontroller.
    Mikrokontrolleren utfører følgende funksjoner:

    - Måler inngangsspenningen
    - Måler inngangsstrømmen
    - Måler superkondensatorspenningen
    - Styrer status-LED-rekken
    - Styrer 5 V-utgangen
    - Mottar avbruddsinformasjon fra sanntidsklokken
    - Formidler SH-RPi-statusen til tjenesten på Raspberry Pi-en over I2C
5.  Buck-omformer i andre trinn.
    Buck-omformeren omformer spenningen fra superkondensatorbanken til 5 V inngangsspenning for Raspberry Pi-en. Maksimal momentan utgangsstrøm er 5 A, og minst 3 A kan oppnås som kontinuerlig strøm uten aktiv kjøling.
    Mikrokontrolleren styrer buck-omformeren. Mikrokontrolleren aktiverer boost-omformeren når superkondensatorspenningen har steget over 8,0 V.
    Under nedstenging av systemet eller watchdog-omstart deaktiverer mikrokontrolleren boost-omformeren for å kutte inngangsspenningen til Raspberry Pi-en.
6.  Status-LED-rekke.
    De fire status-LED-ene viser kortets driftsstatus slik det er beskrevet i avsnittet [Status-LED-er](#status-led-er).
7.  Sanntidsklokke.
    Kortet har en PCF8563-sanntidsklokke som holder tiden nøyaktig også uten internett- eller GPS-forbindelse.
    Sanntidsklokken kommuniserer med Raspberry Pi-en over I2C.

## Kontakter

<div class="row">
  <div class="col-sm-6">

<figure markdown="span">
![](SH-RPi-2.0.0-conx.jpg){ width="100%" }
<figcaption>Kontaktene på SH-RPi, oversiden.</figcaption>
</figure>

   </div>
   <div class="col-sm-6">

<figure markdown="span">
![](SH-RPi-2.0.0-conx-back.jpg){ width="100%" }
<figcaption>Kontaktene på SH-RPi, undersiden.</figcaption>
</figure>

   </div>
</div>

1.  Kontakt for strøminngang.

    Strømkontakten er en Phoenix MC-kompatibel kontakt med 3,81 mm (0,15") senteravstand.
    Salgspakken inneholder en kompatibel skrueplugg.
2.  Kontakt for 5 V-utgang.
    Eksterne 5 V-enheter kan kobles til denne kontakten. Kontakten for 5 V-utgangen er også en Phoenix MC-kompatibel kontakt med 3,81 mm (0,15") senteravstand.
3.  Gjennomgående GPIO-pinneliste for Raspberry Pi.
    Dette er en standard GPIO-pinneliste for Raspberry Pi med 2×20 pinner. Den medfølgende gjennomgående pinnelisten (stack-through) må settes inn for å koble SH-RPi til en Raspberry Pi.
    Flere HAT-kort kan stables oppå Sailor Hat-kortet.
4.  Pinneliste for programmering og feilsøking av ATtiny1616.
    Pinnelisten kan brukes til å programmere mikrokontrolleren med en ekstern programmerer, eller til å aktivere programmering på selve kortet.
5.  Pinneliste for strømbegrensning.
    Du kan sette jumpere på pinnelisten for strømbegrensning for å endre strømgrensen til 1,8 A eller 2,8 A (standard er 0,8 A).
    Sett en jumper vannrett på den øverste raden (merket 2A) for å sette strømgrensen til 1,8 A. Sett en jumper vannrett på den nederste raden (merket 3A) for å sette strømgrensen til 2,8 A.
6.  Pinneliste for eksternt avbrudd. Ikke i bruk i v2.0.0-maskinvaren.
7.  CR1220-batterikontakt for sanntidsklokken (på undersiden).
    Sanntidsklokken trenger et CR1220-reservebatteri for å holde tiden når systemet er slått av.
    Batteriet må vende med plusspolen (den flatere siden) bort fra kortet.
8.  Loddebroen RTC Enable.
    Sanntidsklokken er aktivert som standard.
    For å deaktivere RTC-en kutter du ledningsbanene mellom loddeflatene på loddebroen med en skarp kniv.
    Pass på at du ikke kutter ledningsbaner i nærheten.
9.  GPIO4 Enable. Koble sammen loddeflatene for å koble Raspberry Pi-ens GPIO4 til mikrokontrollerporten PB5 på kortet.
    Dette krever egen firmware-funksjonalitet for å være til nytte.

## Strømforsyning

SH-RPi har et integrert strømforsyningssystem som gir Raspberry Pi-en ren strøm fra en støyende kilde, for eksempel en uregulert strømforsyning eller båtens forbruksbatteribank. Strømforsyningen tillater inngangsspenninger mellom 9–32 V, men en spenning under 10 V blir regnet som underspenning for å hindre skade fra dyputlading på vanlige blybatterier.

Driftsdiagrammet for strømforsyningssystemet er vist på bildet nedenfor.

Den maksimale inngangsstrømmen er begrenset for å beskytte strømforsyninger og kabling oppstrøms. Standard strømgrense er 0,8 A, men grensen kan økes til 1,8 A eller 2,8 A ved å sette jumpere på pinnelisten for strømbegrensning.

Inngangsspenningen settes ned av buck-omformeren i første trinn, som lader superkondensatorbanken opp til 8,8 V. Superkondensatorene brukes som energilager for Raspberry Pi-en, både under kortvarige strømbortfall og som siste utvei for strøm under en nedstenging av systemet.

Buck-omformeren i andre trinn omformer superkondensatorspenningen til 5 V inngangsspenning for Raspberry Pi-en. 5 V-utgangen aktiveres av mikrokontrolleren når superkondensatorspenningen er over 8,0 V, og deaktiveres når superkondensatorspenningen faller under 5,0 V. Disse grensene kan konfigureres av brukeren.

Maksimal topputgangsstrøm til Raspberry Pi-en er 5 A. Maksimal gjennomsnittlig utgangsstrøm avhenger av innstillingen for inngangsstrømbegrensning og av omgivelsestemperaturen. Med en inngangsstrømgrense på 0,8 A er den maksimale vedvarende utgangsstrømmen omtrent 1,4 A. Med inngangsstrømgrensen satt til 2,8 A begrenses den maksimale gjennomsnittlige utgangsstrømmen av systemets termiske egenskaper. I åpne omgivelser ved romtemperatur er den maksimale gjennomsnittlige 5 V-utgangsstrømmen minst 3,0 A. Høyere verdier er mulige med aktiv kjøling av SH-RPi-kortet.

Ved 1,4 A utgangsstrøm er den totale virkningsgraden til strømforsyningen 79 %.

<figure markdown="span">
![](psu_diagram.svg){ width="70%" }
<figcaption>Driftsdiagram for strømforsyningen med eksempelverdier for strøm og spenning.</figcaption>
</figure>

## Status-LED-er

LED-rekken på venstre side av SH-RPi-kortet viser kortets driftsstatus.
LED-søylen viser ladetilstanden til superkondensatorbanken. Den første LED-en begynner å lyse når spenningen er over 5 V, og alle LED-ene lyser fullt ved 9 V superkondensatorspenning.

Lagt oppå LED-søylen viser ulike blinkemønstre kortets tilstand slik:

| Mønster | Beskrivelse |
|---------|-------------|
| Ingen blinking | Lading / normal drift (1) |
| Kort avbrudd hvert 4. sekund | Watchdog aktiv (2)  |
| Ruller mot venstre | Ingen inngangsspenning (3) |
| To avbrudd med 1 s pause| Stenger ned (4) |
| To blink med 2 s pause | Hvilemodus (5) |
| Vekselvis blinkende LED-er| Watchdog-omstart (6) |
| Rask blinking | Feil – kontakt produsenten (7) |

Detaljert beskrivelse av tilstandene følger:

1.  Superkondensatorene lades, og hvis superkondensatorspenningen er over 8,0 V, er 5 V-utgangen aktivert.
    Daemonen i Raspberry Pi OS er ikke aktiv.
2.  Daemonen er aktiv og watchdogen er aktivert. Operativsystemet har startet opp og kjører normalt.
3.  Strøminngangen er borte og superkondensatorene tømmes. 5 V-utgangen er aktivert.
4.  Daemonen har startet en nedstenging. SH-RPi venter på at Raspberry Pi-en skal stenge ned.
5.  SH-RPi er i hvilemodus. 5 V-utgangen er deaktivert, og kortet venter på en alarm fra sanntidsklokken for å våkne.
6.  SH-RPi har ikke mottatt hjerteslag fra daemonen på 10 s, noe som tyder på at Pi-en har krasjet.
    Raspberry Pi-en tilbakestilles ved å slå av 5 V i to sekunder.
7.  SH-RPi har oppdaget overspenning på superkondensatorene. Kontakt produsenten for videre hjelp.


## Watchdog-omstartsfunksjon

I tillegg til strømforsyningen har Sailor Hat for Raspberry Pi en maskinvarebasert watchdog-timer som kan brukes til å starte Raspberry Pi-en på nytt hvis programvaren eller maskinvaren låser seg. Watchdog-timeren er aktivert som standard, og den kan om nødvendig deaktiveres med kommandoen `shrpi set watchdog 0` på kommandolinjen til enheten. Når den er aktivert, starter watchdog-timeren Raspberry Pi-en på nytt hvis den ikke mottar et «hjerteslag» (heartbeat) fra Raspberry Pi-en innen et forhåndsbestemt tidsintervall (vanligvis 10 sekunder).

Raspberry Pi-en må kjøre en tjeneste som med jevne mellomrom sender et hjerteslag til SH-RPi. Tjenesten kan installeres fra den medfølgende programvarepakken.

Hvis watchdog-timeren utløser en omstart, deaktiverer SH-RPi 5 V-utgangen en kort stund for å tvinge fram en omstart av Raspberry Pi-en. Deretter aktiverer SH-RPi 5 V-utgangen igjen slik at Raspberry Pi-en kan starte opp på nytt.

## Sanntidsklokke

SH-RPi har en PCF8563-sanntidsklokke (RTC) som holder tiden nøyaktig også når Raspberry Pi-en ikke er koblet til internett, eller når GPS-signal ikke er tilgjengelig. RTC-en er koblet til Raspberry Pi-en via I2C-bussen.

For å bruke RTC-en må et CR1220-reservebatteri monteres på undersiden av kortet. Plussiden av batteriet (den flatere siden) skal vende bort fra kortet.

Når SH-RPi-kortet brukes sammen med en enhet som har innebygd RTC, kan RTC-ene ha I2C-adresser som kolliderer.
I så fall kan RTC-en på SH-RPi deaktiveres ved å kutte ledningsbanene mellom loddeflatene på loddebroen RTC EN.

## Maskinvarekonfigurasjon

Brukeren kan konfigurere Sailor Hat for Raspberry Pi for å tilpasse kortet til bestemte bruksområder. Konfigurasjonsmulighetene omfatter:

1.  Innstilling av strømbegrenseren.
    Strømbegrenseren på inngangen kan settes til 0,8 A (standard), 1,8 A eller 2,8 A ved å sette jumpere på pinnelisten for strømbegrensning.
2.  Aktivering av sanntidsklokken.
    RTC-en kan aktiveres eller deaktiveres med en loddebro.
3.  Aktivering av GPIO4.
    Koble sammen loddeflatene for å koble Raspberry Pi-ens GPIO4 til mikrokontrollerporten PB5 på kortet. Dette krever egen firmware-funksjonalitet for å være til nytte.

## I2C

Sailor Hat kommuniserer med Raspberry Pi-en
over I2C-buss 1 på GPIO-pinne 3 og 5 (henholdsvis GPIO2 og GPIO3).
I2C-adressen er 0x6d.

PCF8563-sanntidsklokken reserverer i tillegg I2C-adressen 0x51 på den samme bussen.
