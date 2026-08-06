---
title: Laitteiston kuvaus
translated_from: 257eeaa16d90da32404917c6093ffa709b5400f8
---

# Laitteiston kuvaus

## Kierros kortin ympäri

Sailor Hat for Raspberry Pi:n eri toiminnalliset lohkot kuvataan alla.

<figure markdown="span">
![](SH-RPi-2.0.0-func.jpg){ width="60%" }
<figcaption>SH-RPi:n toiminnalliset lohkot.</figcaption>
</figure>

1. Käyttöjännitteen syöttö ja suojaus.
   Käyttöjännite syötetään Phoenix MC -yhteensopivan liittimen kautta, nastaväli 3,81 mm (0,15").
   Sallittu jännitealue on 9–32 V.
   Tulon suojauspiiriin kuuluvat:
   - 4 A:n SMD-sulake
   - 33 V:n transienttisuojadiodi (5000 W huippupulssiteho)
   - Napaisuussuojausdiodi
   - Kuristin ja pii-suodin johtuvien sähkömagneettisten häiriöiden hallintaan
2. Ensimmäisen vaiheen alentava hakkuri (buck) virranrajoituksella.
   Hakkuri muuntaa syöttöjännitteen 8,8 V:n jännitteeksi, jota superkondensaattoripankki kestää.
   Alentavan hakkurin piirissä on myös erillinen virranrajoitin, joka rajaa tulovirran 0,8 A:iin (oletusasetuksella).
3. Kolme 20 F:n 3,0 V:n superkondensaattoria.
   Superkondensaattoripankki toimii Raspberry Pi:n energiavarastona.
   Se voi syöttää Raspberry Pi 4B:tä jopa 70 sekunnin ajan (riippuen tietysti liitettyjen oheislaitteiden määrästä) ja vähemmän virtaa kuluttavia malleja huomattavasti pidempään.
   Superkondensaattorit tekevät myös mahdolliseksi syöttää Raspberry Pi:tä vähävirtaisesta liitännästä, kuten NMEA 2000 -väylästä, joka rajaa yksittäisen solmun virran enintään 1,0 A:iin.
4. Mikro-ohjain.
   SH-RPi:n toimintaa ohjaa ATtiny1616-mikro-ohjain.
   Mikro-ohjain hoitaa seuraavat tehtävät:
   - Mittaa syöttöjännitteen
   - Mittaa tulovirran
   - Mittaa superkondensaattorien jännitteen
   - Ohjaa tila-LED-riviä
   - Ohjaa 5 V:n lähtöä
   - Vastaanottaa reaaliaikakellon keskeytystiedot
   - Välittää SH-RPi:n tilan Raspberry Pi:n palvelulle I2C:n kautta
5. Toisen vaiheen alentava hakkuri.
   Hakkuri muuntaa superkondensaattoripankin jännitteen Raspberry Pi:n 5 V:n käyttöjännitteeksi. Suurin hetkellinen lähtövirta on 5 A, ja vähintään 3 A on saavutettavissa jatkuvana virtana ilman aktiivista jäähdytystä.
   Mikro-ohjain ohjaa hakkurin toimintaa. Mikro-ohjain kytkee boost-hakkurin päälle, kun superkondensaattorien jännite on noussut yli 8,0 V:n.
   Järjestelmän sammutuksen tai watchdog-uudelleenkäynnistyksen aikana mikro-ohjain kytkee boost-hakkurin pois päältä katkaistakseen Raspberry Pi:n käyttöjännitteen.
6. Tila-LED-rivi.
   Neljä tila-LEDiä osoittavat kortin toimintatilan siten kuin osiossa [Tila-LEDit](#tila-ledit) kuvataan.
7. Reaaliaikakello.
   Kortilla on PCF8563-reaaliaikakello, joka pitää ajan tarkasti myös ilman internet- tai GPS-yhteyttä.
   Reaaliaikakello viestii Raspberry Pi:n kanssa I2C:n kautta.

## Liittimet

<div class="row">
  <div class="col-sm-6">

<figure markdown="span">
![](SH-RPi-2.0.0-conx.jpg){ width="100%" }
<figcaption>SH-RPi:n liittimet, yläpuoli.</figcaption>
</figure>

   </div>
   <div class="col-sm-6">

<figure markdown="span">
![](SH-RPi-2.0.0-conx-back.jpg){ width="100%" }
<figcaption>SH-RPi:n liittimet, alapuoli.</figcaption>
</figure>

   </div>
</div>

1. Käyttöjännitteen tuloliitin.

   Liitin on Phoenix MC -yhteensopiva, nastaväli 3,81 mm (0,15").
   Myyntipakkaus sisältää yhteensopivan ruuviliittimen.
2. 5 V:n lähtöliitin.
   Ulkoiset 5 V:n oheislaitteet voidaan kytkeä tähän liittimeen. Myös 5 V:n lähtöliitin on Phoenix MC -yhteensopiva, nastaväli 3,81 mm (0,15").
3. Läpivievä Raspberry Pi:n GPIO-liitin.
   Tämä on tavallinen 2×20-nastainen Raspberry Pi:n GPIO-liitin. Mukana toimitettava pinoamisliitin on asetettava paikalleen, jotta SH-RPi voidaan kytkeä Raspberry Pi:hin.
   Sailor Hatin päälle voidaan pinota lisää HAT-kortteja.
4. ATtiny1616:n ohjelmointi- ja virheenjäljitysliitin.
   Liittimen kautta mikro-ohjain voidaan ohjelmoida ulkoisella ohjelmointilaitteella tai ottaa käyttöön kortilla tapahtuva ohjelmointi.
5. Virranrajoittimen liitin.
   Virranrajoittimen liittimeen voi asettaa hyppyjä, joilla virtaraja vaihdetaan 1,8 A:iin tai 2,8 A:iin (oletus on 0,8 A).
   Aseta hyppy vaakasuoraan ylimpään riviin (merkintä 2A), niin virtarajaksi tulee 1,8 A. Aseta hyppy vaakasuoraan alimpaan riviin (merkintä 3A), niin virtarajaksi tulee 2,8 A.
6. Ulkoisen keskeytyksen liitin. Ei toiminnassa v2.0.0-laitteistossa.
7. Reaaliaikakellon CR1220-paristoliitin (alapuolella).
   Reaaliaikakello tarvitsee CR1220-varapariston pitääkseen ajan, kun järjestelmä on sammutettuna.
   Paristo on asetettava plusnapa (litteämpi puoli) kortista poispäin.
8. RTC Enable -juotossilta.
   Reaaliaikakello on oletuksena käytössä.
   Kellon voi poistaa käytöstä katkaisemalla juotossillan juotospisteiden väliset johtimet terävällä veitsellä.
   Varo katkaisemasta lähellä olevia johtimia.
9. GPIO4 Enable. Yhdistä juotospisteet, niin Raspberry Pi:n GPIO4 kytkeytyy kortin mikro-ohjaimen porttiin PB5.
   Tämä edellyttää räätälöityä firmwaren toiminnallisuutta ollakseen hyödyllinen.

## Virtalähde

SH-RPi:ssä on integroitu virtalähdejärjestelmä, joka tuottaa Raspberry Pi:lle puhtaan käyttöjännitteen häiriöisestä lähteestä, kuten säätämättömästä virtalähteestä tai veneen käyttöakustosta. Virransyöttö sallii 9–32 V:n syöttöjännitteet, joskin alle 10 V:n jännite tulkitaan alijännitetilanteeksi, jotta tyypilliset lyijyakut eivät vaurioidu syväpurkautumisesta.

Virtalähdejärjestelmän toimintakaavio on esitetty alla olevassa kuvassa.

Suurinta tulovirtaa rajoitetaan syöttävien virtalähteiden ja kaapeloinnin suojaamiseksi. Oletusvirtaraja on 0,8 A, mutta rajan voi nostaa 1,8 A:iin tai 2,8 A:iin asettamalla hyppyjä virranrajoittimen liittimeen.

Ensimmäisen vaiheen alentava hakkuri laskee syöttöjännitteen ja lataa superkondensaattoripankin 8,8 V:n jännitteeseen. Superkondensaattorit toimivat Raspberry Pi:n energiavarastona sekä lyhyiden häiriöiden aikana että viimeisenä virtalähteenä järjestelmän sammutuksen aikana.

Toisen vaiheen alentava hakkuri muuntaa superkondensaattorien jännitteen Raspberry Pi:n 5 V:n käyttöjännitteeksi. Mikro-ohjain kytkee 5 V:n lähdön päälle, kun superkondensaattorien jännite on yli 8,0 V, ja pois päältä, kun jännite laskee alle 5,0 V:n. Käyttäjä voi muuttaa näitä rajoja.

Suurin hetkellinen lähtövirta Raspberry Pi:lle on 5 A. Suurin keskimääräinen lähtövirta riippuu tulovirran rajoitusasetuksesta ja ympäristön lämpötilasta. 0,8 A:n tulovirtarajalla suurin jatkuva lähtövirta on noin 1,4 A. 2,8 A:n tulovirtarajalla suurinta keskimääräistä lähtövirtaa rajoittaa järjestelmän lämpötalous. Avoimessa tilassa huoneenlämmössä suurin keskimääräinen 5 V:n lähtövirta on vähintään 3,0 A. Suuremmat arvot ovat mahdollisia jäähdyttämällä SH-RPi-korttia aktiivisesti.

1,4 A:n lähtövirralla virtalähteen kokonaishyötysuhde on 79 %.

<figure markdown="span">
![](psu_diagram.svg){ width="70%" }
<figcaption>Virtalähteen toimintakaavio esimerkkiarvoin virrasta ja jännitteestä.</figcaption>
</figure>

## Tila-LEDit

SH-RPi:n LED-rivi kortin vasemmassa reunassa osoittaa kortin toimintatilan.
Palkkinäyttö kertoo superkondensaattoripankin varaustilan. Ensimmäinen LED alkaa syttyä, kun jännite on yli 5 V, ja kaikki LEDit palavat täysillä superkondensaattorien 9 V:n jännitteellä.

Palkkinäytön päälle limitettynä eri vilkkumiskuviot osoittavat kortin tilan seuraavasti.

| Kuvio | Kuvaus |
|-------|--------|
| Ei vilkkumista | Lataus tai normaali toiminta (1) |
| Lyhyt katkos 4 s:n välein | Watchdog aktiivinen (2) |
| Vieritys vasemmalle | Ei syöttöjännitettä (3) |
| Kaksi katkosta ja 1 s:n tauko | Sammuu (4) |
| Kaksi välähdystä ja 2 s:n tauko | Lepotila (5) |
| Vuorottelevat LEDit vilkkuvat | Watchdogin uudelleenkäynnistys (6) |
| Nopea vilkkuminen | Vika – ota yhteys valmistajaan (7) |

Tilojen yksityiskohtainen kuvaus:

1. Superkondensaattorit latautuvat, ja jos niiden jännite on yli 8,0 V, 5 V:n lähtö on päällä.
   Raspberry Pi OS:n daemon ei ole aktiivinen.
2. Daemon on aktiivinen ja watchdog käytössä. Käyttöjärjestelmä on käynnistynyt ja toimii normaalisti.
3. Syöttöjännite on kadonnut ja superkondensaattorit purkautuvat. 5 V:n lähtö on päällä.
4. Daemon on käynnistänyt sammutuksen. SH-RPi odottaa Raspberry Pi:n sammumista.
5. SH-RPi on lepotilassa. 5 V:n lähtö on pois päältä, ja kortti odottaa reaaliaikakellon hälytystä herätäkseen.
6. SH-RPi ei ole saanut daemonilta sykettä 10 sekuntiin, mikä viittaa siihen, että Pi on kaatunut.
   Raspberry Pi käynnistetään uudelleen katkaisemalla 5 V kahdeksi sekunniksi.
7. SH-RPi on havainnut superkondensaattorien ylijännitetilan. Ota yhteys valmistajaan.


## Watchdogin uudelleenkäynnistystoiminto

Virtalähteen lisäksi Sailor Hat for Raspberry Pi:ssä on laitteistopohjainen watchdog-ajastin, jolla Raspberry Pi voidaan käynnistää uudelleen ohjelmisto- tai laitteistojumin sattuessa. Watchdog-ajastin on oletuksena käytössä, ja sen voi tarvittaessa poistaa käytöstä komennolla `shrpi set watchdog 0` laitteen komentorivillä. Käytössä ollessaan watchdog-ajastin käynnistää Raspberry Pi:n uudelleen, jos se ei saa Raspberry Pi:ltä sykesignaalia ennalta määrätyn ajan kuluessa (tyypillisesti 10 sekuntia).

Raspberry Pi:ssä on ajettava palvelua, joka lähettää SH-RPi:lle säännöllisen sykesignaalin. Palvelun voi asentaa toimitetusta ohjelmistopaketista.

Jos watchdog-ajastin käynnistää uudelleenkäynnistyksen, SH-RPi katkaisee 5 V:n lähdön lyhyeksi ajaksi pakottaakseen Raspberry Pi:n käynnistymään uudelleen. Tämän jälkeen SH-RPi kytkee 5 V:n lähdön takaisin päälle, jotta Raspberry Pi voi käynnistyä.

## Reaaliaikakello

SH-RPi:ssä on PCF8563-reaaliaikakello (RTC), joka pitää ajan tarkasti myös silloin, kun Raspberry Pi ei ole yhteydessä internetiin tai GPS-signaalia ei ole saatavilla. Reaaliaikakello on kytketty Raspberry Pi:hin I2C-väylän kautta.

Reaaliaikakellon käyttö edellyttää CR1220-varapariston asentamista kortin alapuolelle. Pariston plusnapa (litteämpi puoli) on käännettävä kortista poispäin.

Jos SH-RPi-korttia käytetään sellaisen laitteen kanssa, jossa on oma reaaliaikakello, kellojen I2C-osoitteet voivat olla ristiriidassa.
Tällöin SH-RPi:n reaaliaikakellon voi poistaa käytöstä katkaisemalla RTC EN -juotossillan juotospisteiden väliset johtimet.

## Laitteiston asetukset

Käyttäjä voi mukauttaa Sailor Hat for Raspberry Pi:n asetuksia eri käyttötarkoituksiin. Asetusvaihtoehtoja ovat:

1. Virranrajoittimen asetus.
   Tulovirran rajoittimen voi asettaa arvoon 0,8 A (oletus), 1,8 A tai 2,8 A asettamalla hyppyjä virranrajoittimen liittimeen.
2. Reaaliaikakellon käyttöönotto.
   Reaaliaikakellon voi ottaa käyttöön tai poistaa käytöstä juotossillalla.
3. GPIO4:n käyttöönotto.
   Yhdistä juotospisteet, niin Raspberry Pi:n GPIO4 kytkeytyy kortin mikro-ohjaimen porttiin PB5. Tämä edellyttää räätälöityä firmwaren toiminnallisuutta ollakseen hyödyllinen.

## I2C

Sailor Hat viestii Raspberry Pi:n kanssa
I2C-väylällä 1, GPIO-nastoissa 3 ja 5 (vastaavasti GPIO2 ja GPIO3).
I2C-osoite on 0x6d.

PCF8563-reaaliaikakello varaa lisäksi I2C-osoitteen 0x51 samalta väylältä.
