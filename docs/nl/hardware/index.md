---
title: Hardwarebeschrijving
translated_from: 257eeaa16d90da32404917c6093ffa709b5400f8
---

# Hardwarebeschrijving

## Rondleiding over de kaart

Hieronder worden de verschillende functionele blokken van de Sailor Hat for Raspberry Pi beschreven.

<figure markdown="span">
![](SH-RPi-2.0.0-func.jpg){ width="60%" }
<figcaption>Functionele blokken van de SH-RPi.</figcaption>
</figure>

1. Voedingsingang en beveiliging.
   De voeding wordt aangesloten via een Phoenix MC-compatibele connector met een steek van 3,81 mm (0,15").
   Het toegestane spanningsbereik is 9–32 V.
   De beveiligingsschakeling aan de voedingsingang bestaat uit:
   - 4 A-SMD-zekering
   - 33 V-transientonderdrukker (piekpulsvermogen 5000 W)
   - Ompoolbeveiligingsdiode
   - Een smoorspoel en een pi-filter om geleide elektromagnetische storing te beheersen
2. Step-downconverter (buck) van de eerste trap, met stroombegrenzing.
   De step-downconverter zet de ingangsspanning om naar 8,8 V, een spanning die de supercondensatorbank aankan.
   De schakeling van de step-downconverter bevat ook een aparte stroombegrenzer die de ingangsstroom tot 0,8 A terugbrengt (bij de standaardinstelling).
3. Drie supercondensatoren van 20 F en 3,0 V.
   De supercondensatorbank vormt de energiebuffer voor de Raspberry Pi.
   Ze kan een Raspberry Pi 4B tot 70 seconden voeden (uiteraard afhankelijk van het aantal aangesloten randapparaten) en zuinigere modellen veel langer.
   De supercondensator maakt het ook mogelijk de Raspberry Pi te voeden via een interface met beperkt vermogen, zoals de NMEA 2000-bus, die de maximale stroom per knooppunt tot 1,0 A beperkt.
4. Microcontroller.
   De werking van de SH-RPi wordt aangestuurd door een ATtiny1616-microcontroller.
   De microcontroller vervult de volgende functies:
   - Meet de ingangsspanning
   - Meet de ingangsstroom
   - Meet de spanning over de supercondensatoren
   - Stuurt de ledbalk met status-leds aan
   - Stuurt de 5 V-uitgang aan
   - Ontvangt interruptsignalen van de realtimeklok
   - Meldt de status van de SH-RPi via I2C aan de service op de Raspberry Pi
5. Step-downconverter van de tweede trap.
   De step-downconverter zet de spanning van de supercondensatorbank om naar de 5 V-ingangsspanning van de Raspberry Pi. De maximale momentane uitgangsstroom is 5 A, waarbij zonder actieve koeling ten minste 3 A continu haalbaar is.
   De werking van de step-downconverter wordt geregeld door de microcontroller. De microcontroller schakelt de boostconverter in wanneer de spanning over de supercondensatoren boven 8,0 V is gestegen.
   Tijdens het afsluiten van het systeem of bij een watchdogherstart schakelt de microcontroller de boostconverter uit om de ingangsspanning van de Raspberry Pi te onderbreken.
6. Ledbalk met status-leds.
   De vier status-leds geven de bedrijfsstatus van de kaart aan, zoals beschreven in het onderdeel [Status-leds](#status-leds).
7. Realtimeklok.
   De kaart bevat een PCF8563-realtimeklok die de tijd nauwkeurig bijhoudt, ook zonder internet- of GPS-verbinding.
   De RTC communiceert via I2C met de Raspberry Pi.

## Connectoren

<div class="row">
  <div class="col-sm-6">

<figure markdown="span">
![](SH-RPi-2.0.0-conx.jpg){ width="100%" }
<figcaption>Connectoren van de SH-RPi, bovenzijde.</figcaption>
</figure>

   </div>
   <div class="col-sm-6">

<figure markdown="span">
![](SH-RPi-2.0.0-conx-back.jpg){ width="100%" }
<figcaption>Connectoren van de SH-RPi, onderzijde.</figcaption>
</figure>

   </div>
</div>

1. Connector voor de voedingsingang.

   De voedingsconnector is een Phoenix MC-compatibele connector met een steek van 3,81 mm (0,15").
   Bij de verkoopverpakking wordt een passende klemmenstekker met schroefaansluiting geleverd.
2. 5 V-uitgangsconnector.
   Op deze connector kunnen externe 5 V-randapparaten worden aangesloten. Ook de 5 V-uitgangsconnector is een Phoenix MC-compatibele connector met een steek van 3,81 mm (0,15").
3. Doorverbonden GPIO-pinheader van de Raspberry Pi.
   Dit is een standaard 2×20-pins GPIO-pinheader van de Raspberry Pi. Met de meegeleverde doorsteekpinheader wordt de SH-RPi op een Raspberry Pi aangesloten.
   Bovenop de Sailor Hat kunnen verdere HAT's worden gestapeld.
4. Programmeer- en debugheader van de ATtiny1616.
   Via deze header kan de microcontroller met een externe programmer worden geprogrammeerd, of kan programmeren op de kaart zelf worden ingeschakeld.
5. Stroombegrenzerheader.
   Op de stroombegrenzerheader kunnen jumpers worden geplaatst om de stroomlimiet op 1,8 A of 2,8 A te zetten (standaard is 0,8 A).
   Plaats een jumper horizontaal op de bovenste rij (met opdruk `2A`) om de stroomlimiet op 1,8 A te zetten. Plaats een jumper horizontaal op de onderste rij (met opdruk `3A`) om de stroomlimiet op 2,8 A te zetten.
6. Header voor externe interrupt. Niet functioneel in hardware v2.0.0.
7. Batterijconnector CR1220 voor de realtimeklok (aan de onderzijde).
   De realtimeklok heeft een CR1220-backupbatterij nodig om de tijd bij te houden wanneer het systeem is uitgeschakeld.
   De batterij moet met de pluskant (de vlakkere kant) van de kaart af worden geplaatst.
8. Soldeerbrug RTC Enable.
   De realtimeklok is standaard ingeschakeld.
   Om de RTC uit te schakelen, snijdt u de sporen tussen de soldeerbrugpads door met een scherp mes.
   Let op dat u geen naastgelegen sporen doorsnijdt.
9. GPIO4 Enable. Verbind de pads om GPIO4 van de Raspberry Pi te koppelen aan poort PB5 van de microcontroller op de kaart.
   Dit is alleen zinvol met aangepaste firmware.

## Voeding

De SH-RPi bevat een geïntegreerd voedingssysteem dat de Raspberry Pi van een schone voedingsspanning voorziet, ook vanaf een storingsgevoelige voedingsbron zoals een ongeregelde voeding of het “huishoud”-accusysteem van een boot. De voeding staat ingangsspanningen tussen 9–32 V toe, al wordt een spanning onder 10 V als onderspanningssituatie beschouwd om diepontladingsschade aan gangbare loodaccu's te voorkomen.

De werking van het voedingssysteem is weergegeven in de afbeelding hieronder.

De maximale ingangsstroom is begrensd om bovenliggende voedingen en bedrading te beschermen. De standaard stroomlimiet is 0,8 A, maar de limiet kan worden verhoogd naar 1,8 A of 2,8 A door jumpers op de stroombegrenzerheader te plaatsen.

De ingangsspanning wordt door de step-downconverter van de eerste trap verlaagd om de supercondensatorbank tot een spanning van 8,8 V op te laden. De supercondensatoren vormen de energiebuffer voor de Raspberry Pi, zowel voor kortdurende spanningsstoringen als om tijdens het afsluiten van het systeem de laatste voeding te leveren.

De step-downconverter van de tweede trap zet de spanning over de supercondensatoren om naar de 5 V-ingangsspanning van de Raspberry Pi. De microcontroller schakelt de 5 V-uitgang in wanneer de spanning over de supercondensatoren boven 8,0 V ligt, en uit wanneer die onder 5,0 V zakt. Deze grenzen kan de gebruiker zelf instellen.

De maximale piekstroom naar de Raspberry Pi is 5 A. De maximale gemiddelde uitgangsstroom hangt af van de instelling van de ingangsstroombegrenzer en van de omgevingstemperatuur. Bij een ingangsstroomlimiet van 0,8 A bedraagt de maximale continue uitgangsstroom ongeveer 1,4 A. Bij een ingangsstroomlimiet van 2,8 A wordt de maximale gemiddelde uitgangsstroom begrensd door de thermische eigenschappen van het systeem. In de open lucht bij kamertemperatuur bedraagt de maximale
   gemiddelde 5 V-uitgangsstroom ten minste 3,0 A. Met actieve koeling van de SH-RPi-kaart zijn hogere waarden mogelijk.

Bij een uitgangsstroom van 1,4 A bedraagt het totale rendement van de voeding 79 %.

<figure markdown="span">
![](psu_diagram.svg){ width="70%" }
<figcaption>Werkingsschema van de voeding met voorbeeldwaarden voor stroom en spanning.</figcaption>
</figure>

## Status-leds

De ledbalk aan de linkerzijde van de SH-RPi geeft de bedrijfsstatus van de kaart aan.
De balkweergave toont de laadtoestand van de supercondensatorbank. De eerste led begint te branden wanneer de spanning boven 5 V komt, en alle leds branden volledig bij een supercondensatorspanning van 9 V.

Over de balkweergave heen geven verschillende knipperpatronen de toestand van de kaart aan.

| Patroon | Beschrijving |
|---------|-------------|
| Geen knipperen | Laden/normaal bedrijf (1) |
| Korte onderbreking elke 4 s | Watchdog actief (2)  |
| Lopend naar links | Geen ingangsspanning (3) |
| Twee korte onderbrekingen met pauze van 1 s| Bezig met afsluiten (4) |
| Twee flitsen met pauze van 2 s | Slaapstand (5) |
| Afwisselend knipperende leds| Watchdogherstart (6) |
| Snel knipperen | Storing – neem contact op met de fabrikant (7) |

Hieronder volgt een gedetailleerde beschrijving van de toestanden:

1. De supercondensatoren worden geladen en als de spanning over de supercondensatoren boven 8,0 V ligt, is de 5 V-uitgang ingeschakeld.
   De daemon in Raspberry Pi OS is niet actief.
2. De daemon is actief en de watchdog is ingeschakeld. Het besturingssysteem is opgestart en draait normaal.
3. De voedingsspanning is weggevallen en de supercondensatoren lopen leeg. De 5 V-uitgang is ingeschakeld.
4. De daemon heeft het afsluiten in gang gezet. De SH-RPi wacht tot de Raspberry Pi is afgesloten.
5. De SH-RPi staat in de slaapstand. De 5 V-uitgang is uitgeschakeld en de kaart wacht op een alarm van de realtimeklok om te ontwaken.
6. De SH-RPi ontving 10 s lang geen heartbeat van de daemon, wat erop wijst dat de Pi is vastgelopen.
   De Raspberry Pi wordt gereset door de 5 V twee seconden uit te schakelen.
7. De SH-RPi heeft overspanning op de supercondensatoren vastgesteld. Neem contact op met de fabrikant voor verdere hulp.


## Watchdogherstart

Naast de voeding bevat de Sailor Hat for Raspberry Pi een hardwarematige watchdogtimer waarmee de Raspberry Pi opnieuw kan worden gestart wanneer de software of de hardware vastloopt. De watchdogtimer is standaard ingeschakeld en kan zo nodig worden uitgeschakeld met de opdracht `shrpi set watchdog 0` op de opdrachtregel van het apparaat. Wanneer de watchdogtimer is ingeschakeld, herstart hij de Raspberry Pi als hij binnen een vooraf ingestelde tijd (doorgaans 10 seconden) geen “heartbeat”-signaal van de Raspberry Pi ontvangt.

Op de Raspberry Pi moet een service draaien die periodiek een heartbeatsignaal naar de SH-RPi stuurt. Die service kan worden geïnstalleerd uit het meegeleverde pakket.

Als de watchdogtimer een herstart uitlokt, schakelt de SH-RPi de 5 V-uitgang korte tijd uit om de Raspberry Pi te laten herstarten. Daarna schakelt de SH-RPi de 5 V-uitgang weer in, zodat de Raspberry Pi opnieuw kan opstarten.

## Realtimeklok

De SH-RPi bevat een PCF8563-realtimeklok (RTC) die de tijd nauwkeurig bijhoudt, ook wanneer de Raspberry Pi geen internetverbinding heeft of er geen GPS-signaal beschikbaar is. De RTC is via de I2C-bus met de Raspberry Pi verbonden.

Om de RTC te gebruiken moet aan de onderzijde van de kaart een CR1220-backupbatterij worden geplaatst. De pluskant (de vlakkere kant) van de batterij moet van de kaart af wijzen.

Wanneer de SH-RPi-kaart wordt gebruikt met een ingebouwde RTC, kunnen de RTC's conflicterende I2C-adressen hebben.
In dat geval kan de RTC op de SH-RPi worden uitgeschakeld door de sporen tussen de soldeerbrugpads `RTC EN` door te snijden.

## Hardwareconfiguratie

De gebruiker kan de Sailor Hat for Raspberry Pi aan specifieke toepassingen aanpassen. De configuratiemogelijkheden zijn:

1. Instelling van de stroombegrenzer.
   De ingangsstroombegrenzer kan op 0,8 A (standaard), 1,8 A of 2,8 A worden gezet door jumpers op de stroombegrenzerheader te plaatsen.
2. Realtimeklok in- of uitschakelen.
   De RTC kan met een soldeerbrug worden in- of uitgeschakeld.
3. GPIO4 inschakelen.
   Verbind de pads om GPIO4 van de Raspberry Pi te koppelen aan poort PB5 van de microcontroller op de kaart. Dit is alleen zinvol met aangepaste firmware.

## I2C

De Sailor Hat communiceert met de Raspberry Pi
via I2C-bus 1 op de GPIO-pinnen 3 en 5 (respectievelijk GPIO2 en GPIO3).
Het I2C-adres is 0x6d.

De PCF8563-realtimeklok reserveert daarnaast het I2C-adres 0x51 op dezelfde bus.
