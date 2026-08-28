---
title: OpenPlotter-palvelimen asennus
translated_from: 69cd214b5911c56a3544b6ab748a0ad149ba04e9
---

!!! warning
    Tätä osiota ei ole vielä päivitetty vastaamaan v2-laitteiston muutoksia.

<div style="-moz-filter: opacity(30%); -webkit-filter: opacity(30%); filter: opacity(30%);">

## Johdanto

Tässä ohjeessa rakennetaan OpenPlotter-palvelin [Sailor Hat for Raspberry Pi](https://docs.hatlabs.fi/sh-rpi/) -kortin ([ostolinkki](https://hatlabs.fi/product/sh-rpi-enclosure-kit/)) ja OpenPlotter-ohjelmiston avulla.
Palvelin on pienikokoinen ja vesitiivis, ja se saa käyttövirtansa vaivattomasti veneen 12/24 V:n sähköjärjestelmästä.
Se liittyy myös helposti veneen olemassa olevaan elektroniikkaan.

Mukana tuleva ohjelmisto tallentaa kaiken oleellisen NMEA 2000 -liikenteen veneessä, ja sen avulla voi seurata eri suureiden käyttäytymistä sekä reaaliajassa että jälkikäteen integroitujen mittaripaneelien ja Grafana-koontinäyttöjen kautta.
Lisäksi palvelin voi vastaanottaa ja käsitellä tietoa muista lähteistä, kuten [SH-ESP32-anturilaitteista](https://docs.hatlabs.fi/sh-esp32/) tai internetpalveluista.

Esimerkkejä visualisoinneista:

<figure markdown="span">
![](assets/screenshots/001_examples.jpg){ width="75%" }
<figcaption>Esimerkkejä visualisoinneista.</figcaption>
</figure>

## Tarvittavat osat

Tämän ohjeen läpikäyntiin tarvitaan seuraavat osat:

- [SH-RPi-kotelosarja](https://hatlabs.fi/product/sh-rpi-enclosure-kit/)

  SH-RPi on se salainen ainesosa, joka tuo Raspberry Pi:lle tarvittavat laitteistoliitännät veneen järjestelmiin. Siihen kuuluu integroitu, suojattu 12/24 V:n virtalähde turvallisine sammutustoimintoineen sekä erotettu NMEA 2000 -yhteensopiva CAN-liitäntä.

  Tässä ohjeessa käytetään muovikoteloa, ja Pi saa virtansa NMEA 2000 -paneeliliittimen kautta. Lisäksi käytetään USB A -paneeliliitintä, joka helpottaa liitäntöjä tarvittaessa, ja jäähdytystä parannetaan tuulettimella. Voit vapaasti muokata omaa kokoonpanoasi.

  Käytämme myös erillistä USB-WiFi-sovitinta, koska se helpottaa asennusta (ylimääräisestä verkkoliitännästä voi olla hyötyä veneessäkin). Jos et halua USB-WiFi-sovitinta, voit vaihtoehtoisesti kytkeä Pi:n langalliseen ethernet-verkkoon ja päätyä samaan lopputulokseen.

- Raspberry Pi 4B

  4 GB:n muistimalli riittää hyvin. Amazonilla on usein lyömättömät hinnat, tai voit katsoa jälleenmyyjäluettelon Raspberry Pi:n sivustolta:

    * [amazon.com](https://www.amazon.com/Raspberry-Model-2019-Quad-Bluetooth/dp/B07TC2BK1X/)
    * [amazon.de](https://www.amazon.de/-/en/Raspberry-ARM-Cortex-A72-WLAN-ac-Bluetooth-Micro-HDMI-Single/dp/B07TC2BK1X/)
    * [amazon.co.uk](https://www.amazon.co.uk/Raspberry-Pi-ARM-Cortex-A72-Bluetooth-Micro-HDMI/dp/B07TC2BK1X/)
    * [Raspberry Pi:n jälleenmyyjäluettelo](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/?variant=raspberry-pi-4-model-b-4gb)

- MicroSD-muistikortti

  MicroSD-kortilla on Raspberry Pi:n käyttöjärjestelmä ja datatiedostot. Samsungin Evo Plus -korteista on ollut hyviä kokemuksia. Muistikortit ovat halpoja ja isommat kortit kestävät Raspberry Pi -käytössä paremmin, joten hanki vähintään 64 GB:n kortti:

  * [amazon.com](https://www.amazon.com/Samsung-MicroSDXC-Memory-Adapter-MB-MC64GA/dp/B06XFWPXYD/)
  * [amazon.de](https://www.amazon.de/-/en/Samsung-Flash-Memory-MicroSDXC-Class/dp/B08BKCB4JW/)
  * [amazon.co.uk](https://www.amazon.co.uk/Samsung-MicroSDXC-Class-UHS-I-Memory/dp/B08BKCB4JW/)

- Kaksipuolista teippiä tai kuumaliimaa

  Tuulettimen kiinnittämiseen tarvitaan lyhyt pätkä kaksipuolista teippiä tai tilkka kuumaliimaa.

- Kutistesukkaa, sisähalkaisija 3 mm

  Vaikka se ei ole aivan välttämätöntä, sisähalkaisijaltaan 3 mm:n kutistesukka on hyödyllistä paneeliliittimen juotettujen johtimien tukemiseen.

- [NMEA 2000 -naarasliitin](https://hatlabs.fi/product/nmea-2000-cable-plug/)

  Jos teet ensiasennuksen kotona, ylimääräinen NMEA 2000 micro -liitin on kätevä laitteen syöttöjännitteen tuomiseen.

## Laitteiston kokoaminen

### Liitinreikien poraaminen

Kuten aina, kun ehjään koteloon porataan reikiä, suunnittele erittäin huolellisesti etukäteen. Paneeliliittimet vievät yllättävän paljon tilaa, eikä reikää voi helposti paikata saati siirtää.

Itse mittaan mieluiten kotelon ja teen porausmallineen vektoripiirto-ohjelmalla. Piirustus auttaa hahmottamaan liittimen ja mutterin vaatimat enimmäismitat.

Jos et tiedä, mitä ohjelmaa käyttäisit, [Inkscape](https://inkscape.org) on hyvä yleistyökalu. Teknisemmin suuntautuneille myös CAD-ohjelmisto, kuten [LibreCAD](https://librecad.org), voi toimia.

Halusin kolme reikää muovikotelon lyhyelle sivulle. Tässä on tekemäni malline:

<figure markdown="span">
![](assets/plastic-enclosure-end-template.svg){ width="50%" }
<figcaption><a href="assets/plastic-enclosure-end-template.svg">Esimerkki porausmallineesta.</a></figcaption>
</figure>

[Malline](assets/plastic-enclosure-end-template.svg) on SVG-tiedosto eli vektorigrafiikkaa, joten voit tallentaa sen ja muokata mieleiseksesi.
Jos et tiedä, mitä ohjelmaa käyttäisit, kokeile vaikka edellä mainittua [Inkscapea](https://inkscape.org). Itse käytän Affinity Designeria, joka on edullinen kaupallinen suunnitteluohjelma MacOS:lle.

Jos SVG-tiedoston avaaminen tuottaa vaikeuksia, malline on saatavilla myös [PDF-muodossa](assets/plastic-enclosure-end-template.pdf).

Kun malline on valmis, merkitse keskipiste koteloon ja teippaa malline koteloon niin, että keskipisteet osuvat kohdakkain.

<figure markdown="span">
![](assets/photos/01_drill-template.jpg){ width="50%" }
<figcaption>Porausmalline kotelon päällä.</figcaption>
</figure>


Tarkan porauksen helpottamiseksi kannattaa merkitä reikien keskipisteet merkkipuikolla (terävä naula ja kevyt vasaran napautus käyvät myös).

Poraa esireiät pienellä poranterällä (noin 3 mm). Poraa sitten lopulliset reiät porrasterällä. Käytä aikaa ja hidasta pyörimisnopeutta. Pienemmät, epätavallisen kokoiset reiät, kuten 6,5 mm:n reikä, kannattaa viimeistellä vastaavan kokoisella metalliporanterällä.

Muovin poraaminen jättää reikien ympärille paljon purseita. Ne saa pois terävällä veitsellä.

Lopuksi: muovikotelossa integroidut korokkeet voivat olla poraamiesi reikien tiellä. Minun piti poistaa yksi koroke. Käytin Dremel-työkalua, mutta tukevat pihdit saattavat myös toimia.

Tältä lopputulos näyttää minun tapauksessani.

<figure markdown="span">
![](assets/photos/02_drilled_holes.jpg){ width="50%" }
<figcaption>Poratut reiät.</figcaption>
</figure>


### Johtimien kytkeminen NMEA 2000 -paneeliliittimeen

Seuraavaksi juotetaan JST XH -johdinsarjat NMEA 2000 -paneeliliittimeen. Sama tapa toimii myös SP13-virtaliittimien juottamiseen, jos päätät käyttää niitä.
Aloitetaan täyttämällä liittimen juotoskupit tinalla.

<figure markdown="span">
![](assets/photos/021_soldered_cups.jpg){ width="50%" }
<figcaption>Juotetut kupit.</figcaption>
</figure>


Sekä itse kortti että CAN-liitäntä halutaan syöttää NMEA 2000 -liittimen kautta. Tapoja on useampi kuin yksi, mutta käytetään ilmeisintä ja kytketään molempien liittimien johdinsarjat NMEA-paneeliliittimeen.

Kuori lyhyt matka punaista ja mustaa johdinta ja kierrä ne yhteen.

<figure markdown="span">
![](assets/photos/022_spliced_wires.jpg){ width="50%" }
<figcaption>Yhteen kierretyt johtimet.</figcaption>
</figure>


Liitinnastojen eristämiseen ja juotosliitosten mekaaniseen tukemiseen kannattaa käyttää kutistesukkaa. Katkaise lyhyitä pätkiä kutistesukkaa ja pujota ne johtimiin. (Arvaa, kuka unohti tämän kohdan _taas_ näitä kuvia otettaessa.)

Juota johtimet liittimeen — sekä yksittäiset signaalijohtimet että yhteen kierretyt virtajohtimet.

Alla oleva kaavio esittää oikean nastajärjestyksen. Kyllä, kyseessä on urosliitin, mutta koska liitintä katsotaan väärästä päästä, käytetään vastakkaisen sukupuolen kaaviota. (Kyllä, se on hieman sekavaa.)

<figure markdown="span">
![](assets/nmea_2000_female_pinout.png){ width="50%" }
<figcaption>NMEA 2000 micro C -naarasliittimen nastajärjestys.</figcaption>
</figure>


Juota ensin keskimmäinen nasta. Se on nyt helpompaa, kun muut johtimet eivät vielä heilu tiellä. CAN_L-johtimen vakioväri on sininen, mutta meidän johdinsarjassamme se on keltainen.

<figure markdown="span">
![](assets/photos/023_soldered_L.jpg){ width="50%" }
<figcaption>Keskimmäinen nasta juotettuna.</figcaption>
</figure>


Juota seuraavaksi kolme muuta johdinta paikoilleen. Suojavaippa jätetään kytkemättä.

Tältä liittimesi pitäisi tässä vaiheessa näyttää:

<figure markdown="span">
![](assets/photos/024_all_soldered.jpg){ width="50%" }
<figcaption>Kaikki juotettuna.</figcaption>
</figure>


Oletan rohkeasti, että muistit pujottaa kutistesukan palat paikoilleen ennen johtimien juottamista. Nyt on aika liu'uttaa ne juotosliitosten päälle ja kutistaa ne kuumailmapuhaltimella (tai sytyttimen liekillä). Lopputuloksen pitäisi olla suunnilleen tällainen:

<figure markdown="span">
![](assets/photos/025_heat_shrink.jpg){ width="50%" }
<figcaption>Kutistesukka kutistettuna.</figcaption>
</figure>


Ruuvaa valmis NMEA 2000 -paneeliliitin koteloon.

Vielä yksi kuva valmiista liittimestä ja nastajärjestyksestä:

<figure markdown="span">
![](assets/photos/n2k_connector_wiring_photo.jpg){ width="50%" }
<figcaption>Valmis liitin.</figcaption>
</figure>


### Muiden paneeliliittimien kytkeminen

Nyt kun vaikein osuus on takana, muut liittimet voi ruuvata paikoilleen. WiFi-antenniliittimen vesitiiviyttä voi parantaa lisäämällä liittimen ympärille pienen O-renkaan tai tiivisteen ennen kiinnitystä.

Lopputuloksen pitäisi olla tällainen:

<figure markdown="span">
![](assets/photos/03_connectors_in_place.jpg){ width="50%" }
<figcaption>Liittimet paikoillaan.</figcaption>
</figure>


### SH-RPi:n kokoonpano

Seuraavaksi Raspberry Pi kiinnitetään koteloon.
Käytämme muovikoteloa ja kiinnityssovittimia, joiden pitäisi olla tulleet kotelon mukana.

Kiinnitä ensin lyhyet välikkeet kiinnityssovittimiin M2.5-muttereilla. Kiristä ne kunnolla.

<figure markdown="span">
![](assets/photos/04_adapters_with_standoffs.jpg){ width="50%" }
<figcaption>Sovittimet ja välikkeet.</figcaption>
</figure>


Kun välikkeet ovat paikoillaan, sovittimet voi kiinnittää koteloon itsekierteittävillä ruuveilla.

<figure markdown="span">
![](assets/photos/05_adapters_in_place.jpg){ width="50%" }
<figcaption>Sovittimet kiinnitettyinä.</figcaption>
</figure>


Raspberry Pi tulee välikkeiden päälle. Kiinnitä ylemmät välikkeet M2.5-ruuveilla ja alemmat kahdella 16 mm:n kuusiovälikkeellä.

<figure markdown="span">
![](assets/photos/06_rpi_mounted.jpg){ width="50%" }
<figcaption>Raspberry Pi kiinnitettynä.</figcaption>
</figure>


Seuraavaksi Sailor Hat. Paina se Raspberry Pi:n GPIO-liittimeen. Kiinnitä se kahdella M2.5-ruuvilla.

**HUOM**: Kun HAT-kortti pitää joskus irrottaa, tekisi mieli keinuttaa sitä sivusuunnassa. Se toimii kyllä hyvin, mutta samalla on pieni riski taivuttaa Pi:n liittimen nastoja liittimen kummastakin päästä. Keinuta korttia sen sijaan ylös ja alas ja vedä samalla varovasti ylöspäin. Se on hieman hitaampaa, mutta kortti irtoaa paljon pienemmällä nastojen taipumisriskillä.

Tässä vaiheessa voit myös kytkeä kaikki USB-laitteet sekä SH-RPi:n virta- ja CAN-kaapelit. Jos käytät tuuletinta, kiinnitä sekin. Kiinnitä se kaksipuolisella teipillä tai tilkalla kuumaliimaa Raspberry Pi:n viereen tarrapuoli Pi:tä kohti.

Tältä valmis kokoonpano näyttää:

<figure markdown="span">
![](assets/photos/07_sh-rpi_mounted.jpg){ width="50%" }
<figcaption>Sailor Hat kiinnitettynä.</figcaption>
</figure>


Älä sulje kantta vielä. Pi:hin pitää vielä asettaa muistikortti.

## Ohjelmisto

Tässä osiossa Raspberry Pi:lle asennetaan OpenPlotter-ohjelmisto. OpenPlotter on Raspberry Pi OS:ään perustuva, veneilykäyttöön erikoistunut ohjelmistojakelu. Siitä on useita versioita; tässä ohjeessa käytetään versiota, joka toimii ilman näyttöä (headless), eli Raspberry Pi:hin ei ole kytketty näyttöä suoraan. Näyttämiseen käytetään sen sijaan selainta tai etätyöpöytäyhteyttä, jolloin palvelimen ja näyttöjen sijoittelu on turvallisempaa ja vapaampaa.

### OpenPlotterin asentaminen

OpenPlotter asennetaan kirjoittamalla levykuva MicroSD-kortille ja asettamalla kortti Raspberry Pi:hin.

Lataa ensin [Raspberry Pi Imager](https://www.raspberrypi.org/software/). Imager on helppokäyttöinen ohjelma, jolla ladattu levykuvatiedosto kirjoitetaan muistikortille.

**HUOMAA:** Imager on ladattavissa vain macOS-, Windows- ja Ubuntu Linux -järjestelmiin. Jos käytät jotain muuta käyttöjärjestelmää tai Linux-jakelua, kortin flashaamiseen tarvitaan jokin muu ohjelma (mutta siinä vaiheessa oletan, että tiedät hyvin, miten se tehdään).

Asenna Imager latauksen jälkeen.

Lataa seuraavaksi [OpenPlotter-levykuva](https://openplotter.readthedocs.io/en/latest/getting_started/downloading.html). Itse käytän tässä ohjeessa Headless-levykuvaa. Jos haluat mieluummin kytkeä Pi:hin näytön, voit ottaa Starting-levykuvan. Kun levykuva on ladattu, se pitää ehkä purkaa pakkauksesta ennen flashaamista. Levykuva on melko suuri, joten levyllä kannattaa olla muutama gigatavu vapaata tilaa.

Flashaa levykuva MicroSD-kortille. Aseta kortti ensin tietokoneeseen kytkettyyn kortinlukijaan. Monissa kannettavissa on myös sisäänrakennettu SD-kortinlukija. Sitä varten käytä kortin mukana tullutta SD-sovitinta. Avaa sitten Imager. Valitse käyttöjärjestelmävalikosta listan alalaidasta ”Use custom” ja valitse sen jälkeen ladattu levykuvatiedosto.

[![](assets/screenshots/01_imager.jpg){ width="50%" }](assets/screenshots/01_imager.jpg)

Valitse sitten oikea MicroSD-kortti Storage-painikkeella. Kalliiden virheiden välttämiseksi suosittelen irrottamaan tietokoneesta kaikki muut siirrettävät tallennusvälineet. Napsauta Write. Tässä vaiheessa voi joutua syöttämään salasanan, jotta Imager saa oikeuden kirjoittaa MicroSD-kortille.

[![](assets/screenshots/02_imager_in_progress.jpg){ width="50%" }](assets/screenshots/02_imager_in_progress.jpg)

MicroSD-kortille kirjoittaminen ja tietojen tarkistaminen vie hetken. Sen ajan voi käyttää [VNC Viewerin](https://www.realvnc.com/en/connect/download/viewer/) lataamiseen ja asentamiseen. VNC Viewer on etätyöpöytäohjelma, jolla OpenPlotteria käytetään seuraavissa osioissa.

Kun MicroSD-kortti on valmis, aseta se Raspberry Pi:n MicroSD-korttipaikkaan. Siihen voi joutua irrottamaan HAT-kortin väliaikaisesti. (Niin, valitettavasti ohje ei ole 100-prosenttisen johdonmukainen.)

Kytke lopuksi laitteeseen virta. Raspberry Pi:hin voi kyllä kytkeä 5 V:n USB-C-kaapelin, mutta se tuottaa ongelmia, kun SH-RPi:n daemon asennetaan myöhemmin tässä ohjeessa. Käytä siis 12 V:n virtalähdettä (oikeastaan mikä tahansa 10–32 V käy) ja kytke se NMEA 2000 -liittimeen. Voit myös työntää lyhyitä naaraspuolisia hyppyjohtimia suoraan JST XH -liittimiin ja kytkeä johtimet virtalähteeseen pienillä hauenleuoilla. Käytä mielikuvitustasi!

### OpenPlotterin ensimmäinen määritys

Tässä vaiheessa sinulla pitäisi olla laite, jossa vilkkuu paljon valoja mutta johon ei saa yhteyttä. Onneksi keino on olemassa. Kun katsot ympäriltäsi löytyviä Wi-Fi-verkkoja, listalla pitäisi näkyä verkko nimeltä ”openplotter”:

[![](assets/screenshots/03_select_wifi.jpg){ width="50%" }](assets/screenshots/03_select_wifi.jpg)

Yhdistä siihen verkkoon (salasana on `12345678`).

Nyt olet Pi:n ulottuvilla. Yhteyden ottamiseen käytetään aiemmin asennettua VNC Vieweria.

[![](assets/screenshots/04_vnc_viewer.jpg){ width="50%" }](assets/screenshots/04_vnc_viewer.jpg)

Kirjoita aloitusnäytön osoiteriville `openplotter.local` (jos se ei toimi, kokeile IP-osoitetta `10.10.10.1`). Jos palvelin löytyi, eteen tulee kirjautumisnäyttö:

[![](assets/screenshots/05_vnc_credentials.jpg){ width="50%" }](assets/screenshots/05_vnc_credentials.jpg)

Syötä käyttäjätunnus `pi` ja salasana `raspberry`.

Jos kaikki onnistui, eteen avautuu koskematon OpenPlotter-työpöytänäkymä:

[![](assets/screenshots/06_vnc_connected.jpg){ width="50%" }](assets/screenshots/06_vnc_connected.jpg)

Hienoa! Käy läpi Pi:n aloitusopastus. Ensin pitää syöttää uusi salasana ja valita maa, kieli ja muut perusasetukset.

Jos olet kytkenyt yhteensopivan USB-WiFi-sovittimen, sinun pitää valita WiFi-verkko, johon yhdistetään. Tämä on hyvin kätevää, koska sen kautta pääsee internetiin lataamaan päivitykset ja muut tarpeelliset.

[![](assets/screenshots/07_pick_raspi_wifi.jpg){ width="50%" }](assets/screenshots/07_pick_raspi_wifi.jpg)

Huomaa, että jos WiFi-sovitinta ei ole kytketty, alkumääritys voi poiketa hieman alla kuvatusta.

Alkumäärityksen aikana Pi päivittää järjestelmän ohjelmistot. Se kestää hetken, joten hae kahvia tai leiki puolisosi, lastesi tai lemmikkiesi kanssa.

[![](assets/screenshots/08_update.jpg){ width="50%" }](assets/screenshots/08_update.jpg)

Kun määritys on valmis, käynnistä Pi uudelleen. Olit yhteydessä Pi:n WiFi-tukiasemaan, joten tietokoneesi verkkoyhteys palaa tässä vaiheessa tavalliseen WiFi-verkkoosi. Jos sinulla on USB-WiFi-sovitin ja määritit Pi:n käyttämään samaa verkkoa, pääset Pi:hin edelleen samalla `openplotter.local`-osoitteella. Ymmärrätkö nyt, miksi suosittelin ylimääräisen WiFi-sovittimen hankkimista? Muussa tapauksessa sinun pitää yhdistää uudelleen ”openplotter”-verkkoon, kun se taas ilmestyy näkyviin.

[![](assets/screenshots/09_basic_setup_complete.jpg){ width="50%" }](assets/screenshots/09_basic_setup_complete.jpg)

Joka tapauksessa. Palaa VNC Vieweriin ja ota yhteys osoitteeseen `openplotter.local`. Vaihdoit `pi`-käyttäjän salasanan alkumäärityksen aikana, joten VNC Vieweriin pitää syöttää uusi salasana.

Kun olet taas sisällä, muokataan OpenPlotter-asennuksen verkkoasetuksia. Valitse Raspberry-valikosta OpenPlotter -> Network.

(Network-sovellus saattaa avattaessa ilmoittaa haluavansa määrittää järjestelmän uudelleen. Anna sen tehdä niin ja avaa sovellus uudelleen, kun se on valmis.)

[![](assets/screenshots/11_open_openplotter_network.jpg){ width="50%" }](assets/screenshots/11_open_openplotter_network.jpg)

Verkkopaneelissa näkyvät käytettävissä olevat verkkolaitteet vasemmalla ja tukiaseman asetukset oikealla.

Jos et halua tukiasemaa, valitse vasemman reunan valikosta ”none”. Jos haluat säilyttää tukiaseman (ja suosittelen sitä, koska se tarjoaa varayhteyden Pi:hin), verkon salasana on tärkeää vaihtaa:

[![](assets/screenshots/14_openplotter_network_password.jpg){ width="50%" }](assets/screenshots/14_openplotter_network_password.jpg)

WiFi-asiakasasetukset löytyvät OpenPlotter-työpöydän oikeasta yläkulmasta WiFi-symbolin takaa. Siellä määritetään lisäverkot, kuten veneesi WiFi-tukiasema.

[![](assets/screenshots/16_wifi_client_settings.jpg){ width="50%" }](assets/screenshots/16_wifi_client_settings.jpg)

Käynnistä OpenPlotter uudelleen verkkoasetusten muuttamisen jälkeen.

### SH-RPi-daemonin asentaminen

Kiireellisimmät asiat on hoidettu, joten on aika asentaa SH-RPi-daemon. ([Daemonit](https://en.wikipedia.org/wiki/Daemon_(computing)#Etymology) ovat hyväntahtoisia henkiä, jotka auttavat määrittämään ihmisen luonteen tai persoonallisuuden. Tai tässä tapauksessa taustapalveluita UNIX-sukuisille käyttöjärjestelmille.) Sen voisi tehdä VNC Viewerilla avaamalla Raspberry-valikosta Accessories -> Terminal, ja sitä suosittelen Windows-käyttäjille, mutta Mac- ja Linux-käyttäjille näytän, miten OpenPlotter-laitteeseen otetaan yhteys SSH:lla.

Tehdään ensin pieni sivupolku. Sen sijaan että ottaisimme suoraan ssh-yhteyden, kopioidaan ensin `ssh-copy-id`-komennolla SSH-julkisavain laitteeseen. Sen jälkeen kirjautuminen onnistuu ilman salasanaa.

Mac-käyttäjien pitää ehkä asentaa `ssh-copy-id` ensin. Se on saatavilla [Homebrew'n](https://brew.sh/) kautta — jos et ole vielä asentanut sitä, tee se! Se on mainio! Kun se on asennettu, anna komento:

    brew install ssh-copy-id

Linux-käyttäjiä sen sijaan hemmotellaan, ja heillä `ssh-copy-id` on jo valmiiksi asennettuna.

Kopioi seuraavaksi julkinen avain:

    ssh-copy-id pi@openplotter.local

Siinä kaikki! Nyt Pi:hin voi kirjautua ilman salasanaa. Suosittelen tätä tapaa kaikissa etäkäytettävissä järjestelmissä — se on turvallisempi kuin salasanat.

[![](assets/screenshots/18_ssh.jpg){ width="50%" }](assets/screenshots/18_ssh.jpg)

Kun olet kirjautunut komennolla `ssh pi@openplotter.local`, kopioi asennuskomento komentoriville:

    curl -L \
    https://raw.githubusercontent.com/hatlabs/SH-RPi-daemon/main/install.sh \
    | sudo bash

Jos järjestelmääsi on muokattu vain vähän, tämä komento tekee tarvittavat asetusmuutokset ja asentaa daemon-ohjelmiston automaattisesti. Siihen menee vain muutama sekunti. Asennuksen jälkeen tarvitsee vain käynnistää laite käsin uudelleen:

    sudo reboot

Tarkkaile uudelleenkäynnistyksen aikana SH-RPi:n LEDejä. RX-LED on ollut tasaisen vihreä ja tila-LED tasaisen punainen, mutta uudelleenkäynnistyksen jälkeen RX-LED välkkyy iloisesti (olettaen, että NMEA 2000 -väylällä on liikennettä), ja tila-LED on punainen mutta vilkahtaa kerran sekunnissa. Nämä muutokset kertovat, että CAN-liitäntä ja daemonin watchdog ovat aktiivisia. Jee.

Kun otat uudelleenkäynnistyksen jälkeen yhteyden VNC:llä, näet seuraavan viestin:

[![](assets/screenshots/20_after_reboot.jpg){ width="50%" }](assets/screenshots/20_after_reboot.jpg)

Tämä kertoo, että CAN-liitäntä on nyt aktiivinen mutta sitä ei ole vielä määritetty [Signal K:hon](https://signalk.org). Se tehdään seuraavassa osiossa.

### Signal K:n määrittäminen vastaanottamaan NMEA 2000 -liikennettä

NMEA 2000 -datan käsittelyä varten Signal K pitää määrittää vastaanottamaan sitä. Avaa Signal K -koontinäyttö osoitteessa [http://openplotter.local:3000/](http://openplotter.local:3000/).

Jotta palvelimella voi tehdä mitään, tietoturva pitää ottaa käyttöön ja luoda ylläpitäjän tunnus. Napsauta oikean yläkulman ”Login”-painiketta:

[![](assets/screenshots/21_sk_server_dashboard.jpg){ width="50%" }](assets/screenshots/21_sk_server_dashboard.jpg)

Ohjelma pyytää luomaan uuden ylläpitäjän tunnuksen. Itse käytän mieluiten käyttäjätunnusta `admin` ja salasanana sopivaa, helposti muistettavaa ja helposti kirjoitettavaa salasanaa. Tähän pääsee käsiksi vain sisäverkosta.

Seuraavaksi kannattaa ehkä päivittää SK-palvelin:

[![](assets/screenshots/23_update_server.jpg){ width="50%" }](assets/screenshots/23_update_server.jpg)

Kun se on tehty, päästään asiaan ja otetaan `can0` käyttöön palvelimella. Mene kohtaan Data Connections ja napsauta Add-painiketta:

[![](assets/screenshots/26_data_connections_add.jpg){ width="50%" }](assets/screenshots/26_data_connections_add.jpg)

Määritä sitten yhteys seuraavasti, vieritä alas ja napsauta Submit:

[![](assets/screenshots/28_correct_settings.jpg){ width="50%" }](assets/screenshots/28_correct_settings.jpg)

Kun datayhteys on lisätty, käynnistä palvelin taas uudelleen. Nyt koontinäytöllä pitäisi näkyä yhteysliikennettä:

[![](assets/screenshots/30_can0_activity.jpg){ width="50%" }](assets/screenshots/30_can0_activity.jpg)

Jee. Aika onnitella itseäsi. Olet päässyt pitkälle!

Halutessasi voit avata vasemman reunan valikosta Data Browserin ja katsoa, mitä dataa vastaanotat.

### Mittaripaneelien luominen

Jos dataa tulee, voit jo visualisoida sitä avaamalla SK Instrument Panelin:

[![](assets/screenshots/301_sk_plugins.jpg){ width="50%" }](assets/screenshots/301_sk_plugins.jpg)

Polkuja voi määrittää jakoavainpainikkeesta. Paneelien kokoa ja sijaintia voi säätää napsauttamalla lukkopainiketta.

Testilaboratorioni on aivan peltikaton alla, jossa GPS-kuuluvuutta ei ole lainkaan, ja ainoa kiinnostava data verkossani tulee [1-Wire-lämpötila-anturilta](https://docs.hatlabs.fi/sh-esp32/pages/tutorials/onewire-temperature/). Niinpä mittaripaneelini koostuu nyt kolmesta lämpötila-arvosta:

[![](assets/screenshots/302_sk_instrument_panel.jpg){ width="50%" }](assets/screenshots/302_sk_instrument_panel.jpg)

Hieman surullista, mutta samalla jännittävää!

Vakiomuotoisen Instrument Panelin lisäksi Signal K:lle on paljon erittäin hyviä koontinäyttösovelluksia. Kannattaa kokeilla [KIPiä](https://github.com/mxtommy/Kip) (löytyy SK-palvelimen sovelluskaupasta) tai [Wilhelm SK:ta](https://www.wilhelmsk.com/) (vain iOS-laitteille, saatavilla App Storesta).

### InfluxDB:n ja Grafanan asentaminen

Tämän ohjeen viimeisissä vaiheissa asennetaan ja määritetään InfluxDB ja Grafana, joilla veneen datasta luodaan historiatietokanta ja visualisointeja. Vaiheita on vielä muutama ja näytöt näyttävät työläiltä, mutta pieni vaiva kannattaa!

InfluxDB on aikasarjatietokanta, johon data tallennetaan. Grafana on visualisointityökalu, jota käytetään usein IT-järjestelmien tilan seuraamiseen, mutta monipuolisuutensa ansiosta se sopii myös veneilydatan visualisointiin.

Asenna InfluxDB ja Grafana palaamalla VNC Vieweriin ja avaamalla Raspberry-valikosta OpenPlotter -> Dashboards:

[![](assets/screenshots/31_openplotter_dashboards.jpg){ width="50%" }](assets/screenshots/31_openplotter_dashboards.jpg)

Valitse InfluxDB ja napsauta Install. Siihen menee hetki, mutta kun se on valmis, palaa Apps-välilehdelle, valitse Grafana ja napsauta Install. Siinä kaikki.

[![](assets/screenshots/32_install.jpg){ width="50%" }](assets/screenshots/32_install.jpg)

Seuraavaksi InfluxDB:hen pitää luoda uusi tietokanta. Avaa selaimessa Chronograf, InfluxDB:n verkkokäyttöliittymä: [http://openplotter.local:8889/](http://openplotter.local:8889/).

[![](assets/screenshots/34_open_chronograf.jpg){ width="50%" }](assets/screenshots/34_open_chronograf.jpg)


Klikkaa alkumääritys läpi. Chronografin InfluxDB-yhteys käyttää käyttäjätunnusta `admin` ja salasanaa `admin`. Koontinäytön luomisen ja Kapacitor-määrityksen voi ohittaa.

Luo seuraavaksi uusi tietokanta InfluxDB Admin -näytöltä:

[![](assets/screenshots/37_create_signalk_db.jpg){ width="50%" }](assets/screenshots/37_create_signalk_db.jpg)

Anna tietokannan nimeksi `signalk` ja klikkaa muuten vain läpi. Valmista.

Nyt kun tietokanta odottaa meitä, syötetään sinne dataa. Palaa Signal K -koontinäytölle määrittämään InfluxDB-kirjoitusliitännäinen:

[![](assets/screenshots/39_sk_plugin_config.jpg){ width="50%" }](assets/screenshots/39_sk_plugin_config.jpg)

Jätä käyttäjätunnus ja salasana tyhjiksi. Tietokantamme oli `signalk`. Halutessasi voit muuttaa erän kirjoitusväliä ja datan tarkkuutta. Väli on oletuksena 10 sekuntia, mutta jos haluat datan näkyvän lähempänä reaaliaikaa, syötä 2. Tarkkuus määrää, kuinka usein yksittäinen mittaus kirjoitetaan tietokantaan. Oletusarvo 200 ms lienee riittävä, mutta itse halusin vielä enemmän ja valitsin 100 ms. Valitse myös alla näkyvät valintaruudut.

[![](assets/screenshots/40_settings.jpg){ width="50%" }](assets/screenshots/40_settings.jpg)

Ota asetukset käyttöön vierittämällä alas ja napsauttamalla Submit. Tässä vaiheessa mittausten pitäisi virrata tietokantaan. Varmistetaan se. Palaa Chronografiin ja valitse Explore-näkymä. Alalaidassa pitäisi olla lähde nimeltä `signalk.autogen`. Valitse se, jolloin yksittäisten mittausten nimien pitäisi ilmestyä näkyviin. Hienoa.

[![](assets/screenshots/41_verify_data.jpg){ width="50%" }](assets/screenshots/41_verify_data.jpg)

Jäljellä on enää historiatiedon visualisointi.

### Esimerkkikoontinäytön luominen Grafanaan

Näytetään Grafanalla hienoja kuvaajia. Avaa Grafana selaimessa: [http://openplotter.local:3001](http://openplotter.local:3001).

[![](assets/screenshots/42_open_grafana.jpg){ width="50%" }](assets/screenshots/42_open_grafana.jpg)

Grafana vaatii uuden salasanan, joten syötä se. Kun pääset aloitusnäytölle, määritä InfluxDB-tietolähde:

[![](assets/screenshots/44_grafana_data_sources.jpg){ width="50%" }](assets/screenshots/44_grafana_data_sources.jpg)

Määrityksissä oletusosoite näkyy tummanharmaana, mutta itse jouduin kirjoittamaan sen erikseen. Muuten kyse on taas samasta `signalk`-tietokannasta sekä tyhjästä käyttäjätunnuksesta ja salasanasta. Varmista tietolähteen toiminta napsauttamalla ”Save and Test”.

[![](assets/screenshots/46_config_data_source.jpg){ width="50%" }](assets/screenshots/46_config_data_source.jpg)

Kerrataan tässä vaiheessa, mitä meillä on. Signal K vastaanottaa datan NMEA 2000:sta, InfluxDB tallentaa sen, ja Grafana on kytketty InfluxDB:hen. Lopuksi voidaan luoda Grafana-koontinäyttö ja lisätä siihen datapaneeleja.

Paneelieditori näyttää hieman työläältä, mutta perusvaiheet ovat suoraviivaisia.

[![](assets/screenshots/54_panel_title.jpg){ width="50%" }](assets/screenshots/54_panel_title.jpg)

Muokkaa kyselyä. Valitse ensin mittaus FROM-riviltä. Toiseksi pitää lisätä laskutoimitus mittayksiköiden muuntamiseksi (Grafana ei juuri tunne yksiköitä, joten oletuksena se näyttää datan aina niissä SI-yksiköissä, joissa se on tallennettu). Esimerkiksi kelvineistä celsiusasteisiin päästään vähentämällä 273,15. Tai metreistä sekunnissa solmuiksi kertomalla luvulla 3600 ja jakamalla luvulla 1852.

Viimeistele paneeli antamalla sille otsikko ja ottamalla muutokset käyttöön.

Nyt koontinäytölläsi pitäisi olla yksi paneeli, jossa näkyy vähän aikasarjadataa. Lisää pari paneelia napsauttamalla Add Panel -painiketta. Paneeleja voi siirrellä ja niiden kokoa muuttaa vetämällä otsikoista ja kulmista. Lopuksi voit valita yläpalkista sopivan aikavälin ja tallentaa koontinäytön.

Tältä oma moottorin lämpötilaa esittävä koontinäyttöni näyttää:

[![](assets/screenshots/56_two_more_panels.jpg){ width="50%" }](assets/screenshots/56_two_more_panels.jpg)

Siinä se. Mene luomaan upeita koontinäyttöjä ja näytä ne venesatamasi ja pursiseurasi kavereille! Jaa ne myös [Hat Labsin keskustelufoorumilla](https://github.com/hatlabs/discussions/discussions) muiden inspiraatioksi!


</div>
