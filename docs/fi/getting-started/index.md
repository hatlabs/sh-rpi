---
title: Aloitusopas
translated_from: 46b4add9db5ebdedd9ae7e3eba99744cd34a074c
---

# Aloitusopas

## Laitteiston kokoaminen

SH-RPi toimitetaan täysin koottuna. Laitteiston asennusvaiheet ovat:

1. Työnnä 40-nastainen pinoamisliitin SH-RPi:hin alapuolen kannan kautta, nastat ylöspäin.
2. Kytke SH-RPi Raspberry Pi:n GPIO-liittimeen (halutessasi kuusiokantaisia välikkeitä käyttäen).
3. Kiinnitä sopivat virtajohtimet liitinpistokkeisiin. Liitinpistokkeet toimitetaan ruuvit kiristettyinä, joten muista löysätä ne ennen johtimien asettamista.

<figure markdown="span">
![](shrpi_v2_hardware_assembly.jpg){ width="50%" }
<figcaption>SH-RPi v2.0.0:n kokoamiskaavio.</figcaption>
</figure>

### Käyttöjännitteen kytkentä

!!! warning
    Älä koskaan kytke käyttöjännitettä 5 V:n lähtöliittimeen! Se vaurioittaa Raspberry Pi:n ja SH-RPi:n pysyvästi.

Kytke 10–32 V:n virtalähde SH-RPi:n jännitetuloliittimeen alla olevan kuvan mukaisesti.

<figure markdown="span">
![](shrpi_power_input.jpg){ width="50%" }
<figcaption>Kytke virtalähde vihreällä ympyröityyn liittimeen.</figcaption>
</figure>

Virtalähteen on kestettävä vähintään 1,0 A:n virta ilmoitetulla lähtöjännitteellä.
Muiden tekijöiden ollessa samat suuremman lähtöjännitteen, kuten 24 V:n, teholähde tuottaa hieman tehokkaamman toiminnan.
Muuten veneiden ja ajoneuvojen 12 V:n järjestelmät tai tasavirtalähteet toimivat hyvin.

## Ohjelmiston asennus

Raspberry Pi OS tarvitsee lisäohjelmistoa, jotta järjestelmäpalvelu voi käynnistää sammutuksen automaattisesti virran katketessa.
Asennusta helpottamaan on tarjolla automaattinen asennusskripti.

### Automaattinen asennus

Tarjolla on automaattinen asennusskripti. Skripti on testattu vastaflashatulla Raspberry Pi OS:llä, ja se voi epäonnistua voimakkaasti muokatuissa järjestelmissä.
Asennusta ei ole testattu muissa käyttöjärjestelmissä.

Aja automaattinen asennusskripti kopioimalla ja liittämällä seuraava komento Raspberry Pi:n komentokehotteeseen:

    curl -L \
        https://raw.githubusercontent.com/hatlabs/SH-RPi-daemon/main/install-online.sh \
        | sudo bash

Komento on kolmen rivin mittainen, ja kun liität sen terminaali-ikkunaan, se saattaa näyttää rivinjatkomerkkejä. Se ei haittaa. Aja komento painamalla Enter.

<figure markdown="span">
![](automated-installation-screenshot.png){ width="80%" }
<figcaption>Asennuskomento terminaalissa</figcaption>
</figure>

Komento hakee asennusskriptin ja ajaa sen automaattisesti.

Automaattinen asennusskripti:

- ottaa käyttöön I2C-liitännän, jota SH-RPi tarvitsee viestiäkseen Raspberry Pi:n kanssa
- jos NMEA 2000 -liitännän lisäkortin tuki on valittu
  - ottaa käyttöön SPI-liitännän ja laiteoverlayn
  - määrittää CAN-verkkoliitännän
- jos NMEA 0183 -liitännän lisäkortin tuki on valittu
  - ottaa käyttöön SPI-liitännän ja laiteoverlayn
- ottaa käyttöön reaaliaikakellon laiteoverlayn
- jos MAX-M8Q GNSS HATin tuki on valittu
  - ottaa käyttöön sarjaliikenteen UART-liitännän
  - poistaa käytöstä sarjakonsolin
  - poistaa käytöstä Bluetoothin, koska se on ristiriidassa sarjaliikenteen UART-liitännän kanssa
- asentaa SH-RPi:n palveluohjelmiston

## Kotelot

Jos aiot käyttää Raspberry Pi:tä ja SH-RPi:tä ulkona, ajoneuvossa, veneessä tai voimakkaasti kondensoivissa olosuhteissa, sijoita laite aina vesitiiviiseen koteloon!
Hat Labs
tarjoaa erilaisia [vesitiiviitä koteloita](https://shop.hatlabs.fi/collections/accessories-enclosures).

Keskikokoisen ja suuren kotelon mukana tulee rei'itetty pohjalevy ja kiinnityssovittimet, joilla Raspberry Pi:n, lisä-HAT-kortit ja muut osat voi kiinnittää.
Muiden koteloiden mukana toimitetaan 3D-tulostetut tarrakiinnikkeet.

### Keskikokoisen kotelon kokoaminen

Keskikokoinen kotelo on suunniteltu siten, että siihen mahtuu Raspberry Pi 4 Model B, SH-RPi ja useita HAT-kortteja pystysuunnassa. Asennus kuvataan alla.

#### Kokoaminen

Aloitamme tyhjästä kotelosta, joka näkyy seuraavassa kuvassa.

<figure markdown="span">
![](01_bare_box.jpg){ width="50%" }
<figcaption>Kotelo ilman osia.</figcaption>
</figure>

Asenna ensin kaikki tarvitsemasi liittimet. Ennen liittimien asentamista niihin voi olla tarpeen juottaa johtimet. Kuppiliitäntöjen juotto-ohjeet löytyvät tästä YouTube-videosta:

<iframe width="560" height="315" src="https://www.youtube.com/embed/_GLeCt_u3U8" frameborder="0" allowfullscreen></iframe>

Virtaliittimien nastajärjestykselle ei ole varsinaista standardia, mutta suosittelemme kytkemään aina GND:n nastaan 1 ja +12 V / 24 V nastaan 2. Seuraava kuva näyttää asennetun virtaliittimen.

Työnnä sitten liittimet koteloon. Seuraava kuva näyttää asennetut liittimet.

<figure markdown="span">
![](02_conx.jpg){ width="50%" }
<figcaption>Asennetut liittimet.</figcaption>
</figure>

Jos koteloa käytetään kondensoivissa olosuhteissa, kuten veneessä tai ulkona, tiivistä jäljelle jäävät reiät tulpatuilla läpivientiholkeilla. Seuraava kuva näyttää, miten tulppa asennetaan läpivientiholkkiin.

<figure markdown="span">
![](03_gland_plug.jpg){ width="50%" }
<figcaption>Läpivientiholkin tulppa.</figcaption>
</figure>

Ja seuraava kuva näyttää asennetut läpivientiholkit. Tämä tekee kotelosta vesitiiviin.

<figure markdown="span">
![](04_conx_plugs.jpg){ width="50%" }
<figcaption>Asennetut läpivientiholkit.</figcaption>
</figure>

Seuraavaksi otamme koteloon asennettavat osat ja asetamme ne pohjalevylle. Seuraavassa kuvassa näkyvät asennettavat osat. Mustat muoviosat ovat pystykiinnikkeitä, jotka pitävät piirilevypinon paikallaan.

<figure markdown="span">
![](05_ingredients.jpg){ width="50%" }
<figcaption>Tarvikkeet.</figcaption>
</figure>

Ensin 6 mm:n kuusiovälikkeet ruuvataan pystykiinnikkeisiin. Kiristä vain käsin!

Seuraava kuva näyttää pystykiinnikkeet välikkeineen.

<figure markdown="span">
![](06_vertical_mounts.jpg){ width="50%" }
<figcaption>Pystykiinnikkeet kuusiovälikkeineen.</figcaption>
</figure>

Sen jälkeen kiinnikkeet voi kiinnittää Raspberry Pi:hin tai emolevyyn. Käytä M2.5-ruuveja kortin kiinnittämiseen GPIO-nastojen viereen ja M2.5 16 mm:n kuusiovälikkeitä vastakkaiselle puolelle.

Seuraavaksi asennamme pinoamisliittimen SH-RPi:hin. Paina varovasti ja tasaisesti, jotta nastat eivät taivu. Liittimen sopiva korkeus riippuu HAT-korttien järjestyksestä. Jos asetat SH-RPi:n suoraan Raspberry Pi:n päälle, poista välike pinoamisliittimestä. Välikettä sen sijaan tarvitaan, jos asennat SH-RPi:n toisen liitäntä-HATin päälle.

<figure markdown="span">
![](07_stack_thru_conx.jpg){ width="50%" }
<figcaption>Pinoamisliittimen asentaminen.</figcaption>
</figure>

Seuraavassa kuvassa SH-RPi on kiinnitetty emolevyyn.

<figure markdown="span">
![](08_shrpi_mounted.jpg){ width="50%" }
<figcaption>SH-RPi kiinnitettynä emolevyyn.</figcaption>
</figure>

#### Virtajohdotus

Tässä läpikäynnissä asennamme lisäksi CAN HATin NMEA 2000 -yhteyttä varten. Seuraava kuva näyttää CAN HATin kiinnitettynä SH-RPi:hin.

<figure markdown="span">
![](09_can_mounted.jpg){ width="50%" }
<figcaption>CAN HAT kiinnitettynä SH-RPi:hin.</figcaption>
</figure>

Seuraavaksi piirilevypino asennetaan pohjalevylle. Kiinnitä pino paikalleen mukana toimitetuilla M3-ruuveilla. Älä kiristä ruuveja liikaa.

<figure markdown="span">
![](10_on_base_mount.jpg){ width="50%" }
<figcaption>Piirilevypino asennettuna pohjalevylle.</figcaption>
</figure>

Kuori seuraavaksi liitinjohtimet. Jos käytössä on erillinen virtaliitin, NMEA 2000:n punainen johdin jätetään kuorimatta tai katkaistaan kokonaan. Seuraava kuva näyttää kuoritut johtimet.

<figure markdown="span">
![](13_stripped_wires.jpg){ width="50%" }
<figcaption>Kuoritut virta- ja CAN-johtimet.</figcaption>
</figure>

Seuraavaksi johtimet kytketään piirilevyn liittimiin. Virtaliitin kytketään liitinpistokkeeseen seuraavan kuvan mukaisesti.

Kun kytket liitinpistokkeen, ole _erittäin_ tarkkana, että kytket sen SH-RPi:n tuloliittimeen. Voit vaurioittaa kaikki pinon laitteet, jos kytket sen 5 V:n lähtöliittimeen!

<figure markdown="span">
![](14_power_conx.jpg){ width="50%" }
<figcaption>Virtaliittimen liitinpistokkeen kytkentä.</figcaption>
</figure>

Sen jälkeen CAN-johtimet kytketään CAN HATin CAN0-liittimeen alla olevan kuvan mukaisesti. Musta on maa, valkoinen on CAN high (H) ja sininen on CAN low (L).

<figure markdown="span">
![](15_wires_plugged.jpg){ width="50%" }
<figcaption>Lopullinen kytkentä.</figcaption>
</figure>

#### Syöttö NMEA 2000:sta

Veneessä käytettäessä järjestelmän voi syöttää myös NMEA 2000 -verkosta. Tällöin kaikki NMEA 2000 -liittimen johtimet ovat käytössä.

<figure markdown="span">
![](18_alt_can_wires.jpg){ width="50%" }
<figcaption>Kun laite syötetään NMEA 2000 -verkosta, kaikki NMEA 2000 -liittimen johtimet ovat käytössä.</figcaption>
</figure>

Musta ja punainen johdin kytketään virtaliitinpistokkeeseen, ja GND-napaan jatketaan lyhyt pätkä mustaa johdinta seuraavan kuvan mukaisesti. Lyhyt musta johdin kytkeytyy CAN HATin CAN0-liittimen GND-napaan.

<figure markdown="span">
![](19_spliced_gnd.jpg){ width="50%" }
<figcaption>Kytke NMEA 2000:n GND-johdin sekä virtaliitinpistokkeeseen että CAN HATin CAN0-liittimeen.</figcaption>
</figure>

Seuraava kuva näyttää lopullisen kytkennän, kun laite syötetään NMEA 2000 -verkosta.

<figure markdown="span">
![](20_can_power_wiring.jpg){ width="50%" }
<figcaption>Lopullinen kytkentä, kun laite syötetään NMEA 2000 -verkosta.</figcaption>
</figure>

#### Pinon kiinnittäminen

Lopuksi pinon vapaan pään voi kiinnittää pohjalevyyn pienillä nippusiteillä, mutta vaihtoehtoisesti yksinkertaiset kiinnityssiteet ovat helppo ja kätevä ratkaisu. Seuraavat kaksi kuvaa näyttävät kiinnityssiteiden asennuksen.

<figure markdown="span">
![](11_tie_wraps.jpg){ width="50%" }
<figcaption>Kiinnityssiteet asetettuina.</figcaption>
</figure>

<figure markdown="span">
![](12_tie_wraps_2.jpg){ width="50%" }
<figcaption>Valmis kiinnityssiteiden asennus.</figcaption>
</figure>

#### Kokoamisen viimeistely

Tässä vaiheessa pohjalevyn voi asettaa koteloon.

<figure markdown="span">
![](16_in_place.jpg){ width="50%" }
<figcaption>Pohjalevy paikallaan.</figcaption>
</figure>

Kiinnitä pohjalevy koteloon mukana toimitetuilla ruuveilla.

<figure markdown="span">
![](17_screw_base_mount.jpg){ width="50%" }
<figcaption>Pohjalevyn ruuvaaminen koteloon.</figcaption>
</figure>

Kokoaminen on valmis. Alla oleva kuva näyttää kokoonpanon iloisesti vilkkumassa kotelossaan.

<figure markdown="span">
![](21_all_done.jpg){ width="50%" }
<figcaption>Valmis kokoonpano.</figcaption>
</figure>

Kotelon voi kiinnittää seinään tai laipioon alla olevassa kuvassa näkyvistä kulmarei'istä.

<figure markdown="span">
![](22_mounting.jpg){ width="50%" }
<figcaption>Kiinnitysreikien sijainnit.</figcaption>
</figure>


### Reikien poraaminen

Jos käytät koteloa, jossa ei ole valmiiksi porattuja reikiä, reiät on porattava itse.

Vähintään tarvitset yhden reiän käyttöjännitteelle ja, metallikotelossa, toisen WiFi-antennille tai kiinteälle Ethernet-liittimelle.

Suunnittele reikien ja liittimien sijoittelu suunnittelemasi asennuspaikan mukaan.
Jos aiot asentaa kotelon seinälle, sijoita liittimet alaspäin, jotta veden pääsy sisään on mahdollisimman epätodennäköistä.

Sekä alumiini että polykarbonaatti ovat suhteellisen pehmeitä, ja niitä voi porata porrasterällä (sellaisella, joka näyttää pieneltä metalliselta joulukuuselta).
Muovia porattaessa tavallinen metalliporanterä puree helposti liian syvälle ja voi halkaista seinämän.

<figure markdown="span">
![](step_drill_bit.jpg){ width="50%" }
<figcaption>Esimerkki porrasteristä.</figcaption>
</figure>

Sopivat reikäkoot eri liittimille:

- SMA (WiFi-antenni): 6,5–7 mm tai 1/4"
- PG7-läpivientiholkki ja M12-paneeliliitin (NMEA 2000): 12,5 mm tai 1/2"
- SP13-paneeliliittimet (sinimustat muoviliittimet): 13 mm
- PG9-läpivientiholkki: 16 mm tai 5/8"
- RJ45-paneeliliitin: 21–22 mm
- USB A -paneeliliitin: 21–22 mm

### Raspberry Pi:n kiinnittäminen

Hat Labsin toimittamien koteloiden mukana tulee kiinnityssovittimet, joilla Raspberry Pi:n voi kiinnittää.

### Paneeliliittimien juottaminen

Kun juotat sisäisiä johtimia paneeliliittimiin, käytä aina kutistesukkaa yksittäisten johtimien päällä.
Muista aina pujottaa kutistesukka johtimeen _ennen_ juottamista...
Yleensä juotostinaa kannattaa ensin lisätä liittimen nastan koloon ja sitten sulattaa tina uudelleen ja työntää johdin paikalleen.

### Tuulettimen kytkeminen

Kotelon sisään kannattaa sijoittaa tuuletin parantamaan ilmankiertoa ja lämmönsiirtoa kotelon pintojen kautta.
Pienen 40 mm:n tuulettimen voi kiinnittää koteloon kaksipuolisella teipillä tai kuumaliimalla.

Tuuletin kytketään SH-RPi:n yleiskäyttöiseen 5 V:n lähtöliittimeen:

<figure markdown="span">
![](shrpi_5v_output.jpg){ width="50%" }
<figcaption>Kytke tuuletin punaisen nuolen osoittamaan liittimeen.</figcaption>
</figure>

### Asennuksen viimeistely

Kun olet porannut reiät, kiinnittänyt Raspberry Pi:n, juottanut paneeliliittimet ja kytkenyt tuulettimen, sulje kotelo suojataksesi SH-RPi:n ja Raspberry Pi:n sään vaikutuksilta. Varmista, että kaikki liitokset ovat tiukasti kiinni ja kotelo on tiiviisti suljettu, jotta vettä ei pääse sisään.

### Järjestelmän testaaminen

Kun asennus on valmis, kytke Raspberry Pi ja SH-RPi päälle varmistaaksesi, että kaikki toimii oikein. Tarkista, että Raspberry Pi käynnistyy, tuuletin pyörii ja SH-RPi viestii Raspberry Pi:n kanssa. Kun olet varmistanut kaiken toimivan, voit jatkaa ohjelmiston määrittämiseen ja järjestelmän liittämiseen suunniteltuun ympäristöönsä.

Onnittelut! Olet saanut SH-RPi- ja Raspberry Pi -järjestelmäsi laitteiston kokoamisen ja koteloinnin valmiiksi.
