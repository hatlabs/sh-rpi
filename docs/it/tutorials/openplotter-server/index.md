---
title: Installazione del server OpenPlotter
translated_from: 69cd214b5911c56a3544b6ab748a0ad149ba04e9
---

!!! warning
    Questa sezione non è ancora stata aggiornata alle modifiche dell’hardware v2.

<div style="-moz-filter: opacity(30%); -webkit-filter: opacity(30%); filter: opacity(30%);">

## Introduzione

In questo tutorial viene costruito un server OpenPlotter con [Sailor Hat for Raspberry Pi](https://docs.hatlabs.fi/sh-rpi/) ([link per l’acquisto](https://hatlabs.fi/product/sh-rpi-enclosure-kit/)) e il software OpenPlotter.
Il server è compatto e stagno e si alimenta facilmente dall’impianto a 12/24 V della barca.
Si integra inoltre senza difficoltà con l’elettronica di bordo esistente.

Il software incluso registra tutto il traffico NMEA 2000 essenziale a bordo e permette di visualizzare l’andamento dei diversi valori sia in tempo reale sia a posteriori, tramite pannelli strumenti integrati e dashboard Grafana.
Il server può inoltre ricevere ed elaborare informazioni da altre fonti, per esempio dai [dispositivi sensore SH-ESP32](https://docs.hatlabs.fi/sh-esp32/) o da vari servizi Internet.

Alcuni esempi di visualizzazione:

<figure markdown="span">
![](assets/screenshots/001_examples.jpg){ width="75%" }
<figcaption>Esempi di visualizzazione.</figcaption>
</figure>

## Componenti necessari

Per completare questo tutorial servono i componenti seguenti:

- [Kit custodia SH-RPi](https://hatlabs.fi/product/sh-rpi-enclosure-kit/)

  L’SH-RPi è l’ingrediente segreto che fornisce al Raspberry Pi le interfacce hardware richieste dai sistemi della barca. La scheda comprende un’alimentazione a 12/24 V integrata e protetta, con spegnimento sicuro, e un’interfaccia CAN isolata e compatibile NMEA 2000.

  In questo tutorial si usa la custodia in plastica e il Pi viene alimentato attraverso un connettore da pannello NMEA 2000. Si aggiunge inoltre un connettore da pannello USB tipo A per facilitare i collegamenti quando servono, e una ventola di raffreddamento per migliorare la dissipazione del calore. Si può naturalmente adattare la propria configurazione.

  Si usa anche un adattatore WiFi USB aggiuntivo, perché semplifica l’installazione (l’interfaccia di rete in più può tornare utile anche a bordo). Chi non desidera l’adattatore WiFi USB può in alternativa collegare il Pi a una rete Ethernet cablata, con lo stesso risultato.

- Un Raspberry Pi 4B

  Un modello con 4 GB di memoria è sufficiente. Amazon propone spesso prezzi imbattibili, oppure si può consultare l’elenco dei distributori sul sito di Raspberry Pi:

    * [amazon.com](https://www.amazon.com/Raspberry-Model-2019-Quad-Bluetooth/dp/B07TC2BK1X/)
    * [amazon.de](https://www.amazon.de/-/en/Raspberry-ARM-Cortex-A72-WLAN-ac-Bluetooth-Micro-HDMI-Single/dp/B07TC2BK1X/)
    * [amazon.co.uk](https://www.amazon.co.uk/Raspberry-Pi-ARM-Cortex-A72-Bluetooth-Micro-HDMI/dp/B07TC2BK1X/)
    * [Elenco dei distributori Raspberry Pi](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/?variant=raspberry-pi-4-model-b-4gb)

- Scheda di memoria MicroSD

  Sulla scheda MicroSD risiedono il sistema operativo e i file di dati del Raspberry Pi. Con le schede Samsung Evo Plus ho avuto buoni risultati. Le schede di memoria costano poco e quelle di capacità maggiore sono più affidabili nell’uso con Raspberry Pi: conviene quindi prenderne almeno una da 64 GB:

  * [amazon.com](https://www.amazon.com/Samsung-MicroSDXC-Memory-Adapter-MB-MC64GA/dp/B06XFWPXYD/)
  * [amazon.de](https://www.amazon.de/-/en/Samsung-Flash-Memory-MicroSDXC-Class/dp/B08BKCB4JW/)
  * [amazon.co.uk](https://www.amazon.co.uk/Samsung-MicroSDXC-Class-UHS-I-Memory/dp/B08BKCB4JW/)

- Nastro biadesivo o colla a caldo

  Per fissare la ventola di raffreddamento serve un breve pezzo di nastro biadesivo o un po’ di colla a caldo.

- Guaina termorestringente, diametro interno 3 mm

  Pur non essendo indispensabile, la guaina termorestringente da 3 mm di diametro interno è utile per assicurare i fili saldati del connettore da pannello.

- [Presa femmina NMEA 2000](https://hatlabs.fi/product/nmea-2000-cable-plug/)

  Se la prima installazione viene fatta in casa, una spina NMEA 2000 micro in più è comoda per portare la tensione di alimentazione al dispositivo.

## Assemblaggio dell’hardware

### Foratura dei fori per i connettori

Come sempre quando si forano custodie ancora integre, conviene pianificare con molta attenzione. I connettori da pannello occupano sorprendentemente spazio e un foro non si richiude facilmente, tanto meno si sposta.

Personalmente preferisco rilevare le misure della custodia e creare una dima di foratura con un programma di disegno vettoriale. Un disegno aiuta a individuare gli ingombri massimi richiesti dal connettore e dal dado.

Se non si sa quale programma usare, [Inkscape](https://inkscape.org) è un buon strumento generalista. Per chi è più portato alla tecnica può andare bene anche un software CAD come [LibreCAD](https://librecad.org).

Volevo tre fori sul lato corto della custodia in plastica. Questa è la dima che ho realizzato:

<figure markdown="span">
![](assets/plastic-enclosure-end-template.svg){ width="50%" }
<figcaption><a href="assets/plastic-enclosure-end-template.svg">Esempio di dima di foratura.</a></figcaption>
</figure>

La [dima](assets/plastic-enclosure-end-template.svg) è un file SVG, cioè vettoriale, quindi si può salvare e modificare a piacere.
Se non si sa quale software usare, si può provare per esempio [Inkscape](https://inkscape.org), citato sopra. Io uso Affinity Designer, un software di progettazione commerciale a basso costo disponibile per MacOS.

Se l’apertura del file SVG dà problemi, la dima è disponibile anche in [versione PDF](assets/plastic-enclosure-end-template.pdf).

Una volta pronta la dima, segnare il punto centrale sulla custodia e fissare la dima con del nastro in modo che i punti centrali coincidano.

<figure markdown="span">
![](assets/photos/01_drill-template.jpg){ width="50%" }
<figcaption>Dima di foratura sulla scatola.</figcaption>
</figure>


Per forare con precisione conviene segnare i centri dei fori con un bulino (vanno bene anche un chiodo appuntito e un colpetto di martello).

Praticare i fori pilota con una punta piccola (circa 3 mm). Usare poi una punta a gradini per i fori definitivi. Procedere con calma e a bassa velocità. I fori più piccoli di misura insolita, come quello da 6,5 mm, vanno rifiniti con una punta per metallo della misura corrispondente.

Forare la plastica lascia molte bave attorno ai fori. Si tolgono con un coltello affilato.

Infine, sulla custodia in plastica i distanziali stampati possono ostruire i fori praticati. Io ho dovuto rimuoverne uno. Ho usato un utensile Dremel, ma probabilmente vanno bene anche delle pinze robuste.

Ecco come si presenta il risultato nel mio caso.

<figure markdown="span">
![](assets/photos/02_drilled_holes.jpg){ width="50%" }
<figcaption>Fori praticati.</figcaption>
</figure>


### Collegamento dei fili al connettore da pannello NMEA 2000

Ora si saldano i cablaggi JST XH al connettore da pannello NMEA 2000. Lo stesso procedimento vale anche per saldare i connettori di alimentazione SP13, se si preferisce usarne uno.
Si comincia riempiendo di stagno le coppette del connettore.

<figure markdown="span">
![](assets/photos/021_soldered_cups.jpg){ width="50%" }
<figcaption>Coppette stagnate.</figcaption>
</figure>


Si vuole alimentare sia la scheda stessa sia l’interfaccia CAN attraverso il connettore NMEA 2000. I modi sono più di uno, ma conviene seguire quello ovvio e collegare entrambi i cablaggi al connettore da pannello NMEA.

Spelare un breve tratto del filo rosso e di quello nero e attorcigliarli insieme.

<figure markdown="span">
![](assets/photos/022_spliced_wires.jpg){ width="50%" }
<figcaption>Fili attorcigliati.</figcaption>
</figure>


Si consiglia di usare la guaina termorestringente per isolare i pin del connettore e sostenere meccanicamente le saldature. Tagliare brevi pezzi di guaina e infilarli sui fili. (Indovinate chi si è dimenticato di nuovo questo passaggio mentre preparava le foto per il tutorial.)

Saldare i fili al connettore, sia i singoli fili di segnale sia i fili di alimentazione attorcigliati.

Lo schema qui sotto mostra la piedinatura corretta. Sì, è un connettore maschio, ma poiché lo si osserva dal lato sbagliato si usa lo schema del genere opposto. (Sì, è un po’ fuorviante.)

<figure markdown="span">
![](assets/nmea_2000_female_pinout.png){ width="50%" }
<figcaption>Piedinatura della presa femmina NMEA 2000 micro C.</figcaption>
</figure>


Saldare per primo il pin centrale. Ora è più facile, finché gli altri fili non sono ancora d’intralcio. Il colore standard del filo CAN_L è il blu, ma nel nostro cablaggio è giallo.

<figure markdown="span">
![](assets/photos/023_soldered_L.jpg){ width="50%" }
<figcaption>Pin centrale saldato.</figcaption>
</figure>


Saldare poi gli altri tre fili. Lo schermo resta scollegato.

A questo punto il connettore dovrebbe presentarsi così:

<figure markdown="span">
![](assets/photos/024_all_soldered.jpg){ width="50%" }
<figcaption>Tutto saldato.</figcaption>
</figure>


Do’ per scontato, con una certa audacia, che i pezzi di guaina siano stati infilati prima di saldare i fili. È il momento di farli scorrere sopra le saldature e di restringerli con una pistola termica (o con la fiamma di un accendino). Il risultato dovrebbe essere più o meno questo:

<figure markdown="span">
![](assets/photos/025_heat_shrink.jpg){ width="50%" }
<figcaption>Guaina termorestringente applicata.</figcaption>
</figure>


Avvitare il connettore da pannello NMEA 2000 finito sulla custodia.

Ancora una foto di un connettore finito e della piedinatura:

<figure markdown="span">
![](assets/photos/n2k_connector_wiring_photo.jpg){ width="50%" }
<figcaption>Connettore finito.</figcaption>
</figure>


### Collegamento degli altri connettori da pannello

Ora che la parte difficile è alle spalle, gli altri connettori si possono avvitare in sede. Per migliorare la tenuta stagna del connettore dell’antenna WiFi si può aggiungere un piccolo O-ring o una guarnizione attorno al connettore prima del montaggio.

Alla fine si dovrebbe ottenere questo:

<figure markdown="span">
![](assets/photos/03_connectors_in_place.jpg){ width="50%" }
<figcaption>Connettori in sede.</figcaption>
</figure>


### Assemblaggio dell’SH-RPi

Ora si monta il Raspberry Pi nella custodia.
Si usano la custodia in plastica e gli adattatori di montaggio che dovrebbero essere arrivati insieme alla custodia.

Per prima cosa si fissano i distanziali corti agli adattatori di montaggio con i dadi M2,5. Serrarli bene.

<figure markdown="span">
![](assets/photos/04_adapters_with_standoffs.jpg){ width="50%" }
<figcaption>Adattatori con distanziali.</figcaption>
</figure>


Una volta sistemati i distanziali, gli adattatori si montano sulla custodia con le viti autofilettanti.

<figure markdown="span">
![](assets/photos/05_adapters_in_place.jpg){ width="50%" }
<figcaption>Adattatori montati.</figcaption>
</figure>


Il Raspberry Pi va sopra i distanziali. Fissare i distanziali superiori con le viti M2,5 e quelli inferiori con due distanziali esagonali da 16 mm.

<figure markdown="span">
![](assets/photos/06_rpi_mounted.jpg){ width="50%" }
<figcaption>Raspberry Pi montato.</figcaption>
</figure>


Segue il Sailor Hat. Premerlo sul connettore GPIO del Raspberry Pi. Fissarlo con due viti M2,5.

**NB**: quando prima o poi si dovrà togliere l’HAT, viene istintivo farlo oscillare lateralmente. Funziona bene, ma c’è anche un piccolo rischio di piegare i pin del connettore del Pi alle due estremità. Conviene invece far oscillare la scheda in alto e in basso tirando delicatamente verso l’alto. È un po’ più lento, ma la scheda si stacca con un rischio molto minore di piegare i pin.

A questo punto si possono anche collegare tutti i dispositivi USB e i cavi di alimentazione e CAN dell’SH-RPi. Se si usa una ventola di raffreddamento, montare anche quella. Fissarla con nastro biadesivo o un po’ di colla a caldo accanto al Raspberry Pi, con il lato dell’adesivo rivolto verso il Pi.

Ecco come si presenta l’assemblaggio finito:

<figure markdown="span">
![](assets/photos/07_sh-rpi_mounted.jpg){ width="50%" }
<figcaption>Sailor Hat montato.</figcaption>
</figure>


Non chiudere ancora il coperchio. Va ancora inserita la scheda di memoria nel Pi.

## Software

In questa sezione si installa il software OpenPlotter sul Raspberry Pi. OpenPlotter è una distribuzione software specializzata per l’ambito nautico, basata su Raspberry Pi OS. Esiste in diverse varianti; in questo tutorial si usa una versione senza monitor (headless), cioè senza uno schermo collegato direttamente al Raspberry Pi. Per la visualizzazione si usano invece browser o connessioni desktop remoto, il che consente di collocare il server in modo più sicuro e gli schermi dove servono.

### Installazione di OpenPlotter

OpenPlotter si installa scrivendo un’immagine di sistema su una scheda MicroSD e inserendo poi la scheda nel Raspberry Pi.

Scaricare prima [Raspberry Pi Imager](https://www.raspberrypi.org/software/). Imager è un programma semplice da usare che scrive sulla scheda di memoria il file immagine scaricato.

**NOTA:** Imager è scaricabile solo per macOS, Windows e Ubuntu Linux. Con un altro sistema operativo o un’altra distribuzione Linux occorre un software diverso per flashare la scheda (ma a quel punto si presume che si sappia benissimo come si fa).

Una volta scaricato, installare Imager.

Scaricare poi l’[immagine di OpenPlotter](https://openplotter.readthedocs.io/en/latest/getting_started/downloading.html). In questo tutorial uso l’immagine Headless. Chi preferisce collegare uno schermo al Pi può prendere l’immagine Starting. Dopo il download può essere necessario decomprimere l’immagine prima di flasharla. L’immagine di sistema è piuttosto grande, quindi conviene avere qualche gigabyte libero sul disco.

Flashare l’immagine sulla scheda MicroSD. Inserire prima la scheda in un lettore collegato al computer. Molti portatili hanno anche un lettore di schede SD integrato: in quel caso si usa l’adattatore SD ricevuto con la scheda. Aprire poi Imager. Nel menu del sistema operativo selezionare “Use custom” in fondo all’elenco e quindi il file immagine scaricato.

[![](assets/screenshots/01_imager.jpg){ width="50%" }](assets/screenshots/01_imager.jpg)

Selezionare poi la scheda MicroSD corretta con il pulsante Storage. Per evitare errori costosi conviene scollegare dal computer ogni altro supporto rimovibile. Fare clic su Write. A questo punto può essere necessario inserire la password per autorizzare Imager a scrivere sulla scheda MicroSD.

[![](assets/screenshots/02_imager_in_progress.jpg){ width="50%" }](assets/screenshots/02_imager_in_progress.jpg)

La scrittura e la verifica della scheda MicroSD richiedono un po’ di tempo. Si può sfruttare per scaricare e installare [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/). VNC Viewer è un software di desktop remoto che verrà usato per accedere a OpenPlotter nelle sezioni seguenti.

Quando la scheda MicroSD è pronta, inserirla nello slot MicroSD del Raspberry Pi. Per farlo può essere necessario staccare temporaneamente l’HAT. (Sì, spiacente, il tutorial non è coerente al 100 %.)

Infine, accendere il dispositivo. È pur vero che si può collegare un cavo USB-C a 5 V al Raspberry Pi, ma questo crea problemi quando più avanti nel tutorial si installa il demone SH-RPi. Conviene quindi usare un’alimentazione a 12 V (in realtà va bene qualsiasi valore tra 10–32 V) e collegarla a una spina NMEA 2000. Si possono anche infilare corti cavetti femmina direttamente nei connettori JST XH e collegare i fili a un alimentatore con piccole pinze a coccodrillo. Basta un po’ di fantasia.

### Prima configurazione di OpenPlotter

A questo punto si ha un dispositivo pieno di luci lampeggianti ma nessun modo di comunicare con esso. Per fortuna una via c’è. Guardando le reti Wi-Fi disponibili nei dintorni dovrebbe comparire una rete chiamata “openplotter”:

[![](assets/screenshots/03_select_wifi.jpg){ width="50%" }](assets/screenshots/03_select_wifi.jpg)

Collegarsi a quella rete (la password è `12345678`).

Ora si è a portata del Pi. Per accedervi si usa VNC Viewer, installato in precedenza.

[![](assets/screenshots/04_vnc_viewer.jpg){ width="50%" }](assets/screenshots/04_vnc_viewer.jpg)

Nella schermata iniziale digitare `openplotter.local` nella barra degli indirizzi (se non funziona, provare l’indirizzo IP `10.10.10.1`). Se il server viene trovato, compare una schermata di autenticazione:

[![](assets/screenshots/05_vnc_credentials.jpg){ width="50%" }](assets/screenshots/05_vnc_credentials.jpg)

Inserire il nome utente `pi` e la password `raspberry`.

Se tutto è andato a buon fine, compare un desktop OpenPlotter intatto:

[![](assets/screenshots/06_vnc_connected.jpg){ width="50%" }](assets/screenshots/06_vnc_connected.jpg)

Ottimo. Completare la procedura guidata di benvenuto del Pi. Occorre prima inserire una nuova password e scegliere paese, lingua e le altre impostazioni di base.

Se è stata collegata una chiavetta WiFi USB compatibile, va scelta una rete WiFi a cui connettersi. È molto comodo, perché consente di accedere a Internet per scaricare aggiornamenti e altro.

[![](assets/screenshots/07_pick_raspi_wifi.jpg){ width="50%" }](assets/screenshots/07_pick_raspi_wifi.jpg)

Si noti che senza un adattatore WiFi collegato la configurazione iniziale può differire un po’ da quanto descritto sotto.

Durante la configurazione iniziale il Pi aggiorna il software di sistema. Ci vuole un po’: conviene andare a prendere un caffè o giocare con il partner, i figli o gli animali di casa.

[![](assets/screenshots/08_update.jpg){ width="50%" }](assets/screenshots/08_update.jpg)

Al termine della configurazione, riavviare il Pi. Si era collegati all’access point WiFi del Pi, quindi la connessione di rete del computer torna ora alla rete WiFi abituale. Chi ha l’adattatore WiFi USB e ha configurato il Pi sulla stessa rete continua a raggiungerlo allo stesso indirizzo `openplotter.local`. Ecco perché consigliavo l’adattatore WiFi aggiuntivo. Altrimenti occorre ricollegarsi alla rete “openplotter” non appena torna disponibile.

[![](assets/screenshots/09_basic_setup_complete.jpg){ width="50%" }](assets/screenshots/09_basic_setup_complete.jpg)

Comunque. Tornare a VNC Viewer e collegarsi a `openplotter.local`. La password dell’utente `pi` è stata cambiata durante la configurazione iniziale, quindi in VNC Viewer va inserita quella nuova.

Una volta rientrati, si modificano le impostazioni di rete dell’installazione OpenPlotter. Dal menu Raspberry selezionare OpenPlotter -> Network.

(All’apertura, l’applicazione Network potrebbe segnalare di voler riconfigurare il sistema. Conviene lasciarla fare e riaprire l’applicazione al termine.)

[![](assets/screenshots/11_open_openplotter_network.jpg){ width="50%" }](assets/screenshots/11_open_openplotter_network.jpg)

Nel pannello di rete compaiono a sinistra i dispositivi di rete disponibili e a destra le impostazioni dell’access point.

Chi non vuole un access point deve selezionare “none” nel menu di sinistra. Chi preferisce mantenerlo (ed è consigliabile, perché offre un accesso di riserva al Pi) deve assolutamente cambiare la password della rete:

[![](assets/screenshots/14_openplotter_network_password.jpg){ width="50%" }](assets/screenshots/14_openplotter_network_password.jpg)

Le impostazioni del client WiFi si trovano sotto il simbolo WiFi, in alto a destra nel desktop OpenPlotter. È lì che si configurano le altre reti, come l’access point WiFi della barca.

[![](assets/screenshots/16_wifi_client_settings.jpg){ width="50%" }](assets/screenshots/16_wifi_client_settings.jpg)

Dopo aver modificato le impostazioni di rete, riavviare OpenPlotter.

### Installazione del demone SH-RPi

Sbrigate le cose più urgenti, è il momento di installare il demone SH-RPi. (I [demoni](https://en.wikipedia.org/wiki/Daemon_(computing)#Etymology) sono spiriti benevoli che contribuiscono a definire il carattere o la personalità di una persona. O, in questo caso, servizi in background per i sistemi operativi discendenti da UNIX.) Si potrebbe usare VNC Viewer aprendo Accessories -> Terminal dal menu Raspberry, ed è quanto consiglio agli utenti Windows, ma agli utenti Mac e Linux mostro come raggiungere il dispositivo OpenPlotter via SSH.

Prima una piccola digressione. Invece di collegarsi subito in ssh, conviene copiare la propria chiave pubblica SSH sul dispositivo con `ssh-copy-id`. In seguito gli accessi avvengono senza password.

Gli utenti Mac potrebbero dover installare prima `ssh-copy-id`. È disponibile tramite [Homebrew](https://brew.sh/) — chi non l’ha ancora installato faccia pure, è ottimo. Fatto questo:

    brew install ssh-copy-id

Gli utenti Linux, invece, sono viziati e hanno `ssh-copy-id` già preinstallato.

Copiare poi la chiave pubblica:

    ssh-copy-id pi@openplotter.local

Tutto qui. Ora si può accedere al Pi senza password. Consiglio questo metodo su tutti i sistemi raggiunti da remoto — è più sicuro delle password.

[![](assets/screenshots/18_ssh.jpg){ width="50%" }](assets/screenshots/18_ssh.jpg)

Una volta effettuato l’accesso con `ssh pi@openplotter.local`, incollare il comando di installazione al prompt:

    curl -L \
    https://raw.githubusercontent.com/hatlabs/SH-RPi-daemon/main/install.sh \
    | sudo bash

Su un sistema relativamente poco modificato questo comando applica le modifiche di configurazione necessarie e installa il software del demone in automatico. Bastano pochi secondi. Al termine dell’installazione occorre solo riavviare a mano:

    sudo reboot

Durante il riavvio conviene osservare i LED dell’SH-RPi. Il LED RX era verde fisso e il LED di stato rosso fisso; dopo il riavvio il LED RX lampeggia allegramente (ammesso che ci sia traffico sul bus NMEA 2000) e il LED di stato resta rosso ma lampeggia brevemente ogni secondo. Questi cambiamenti indicano che l’interfaccia CAN e il watchdog del demone sono attivi.

Collegandosi a VNC dopo il riavvio compare il messaggio seguente:

[![](assets/screenshots/20_after_reboot.jpg){ width="50%" }](assets/screenshots/20_after_reboot.jpg)

Significa che ora l’interfaccia CAN è attiva ma non è ancora configurata in [Signal K](https://signalk.org). Lo si farà nella sezione successiva.

### Configurare Signal K per ricevere il traffico NMEA 2000

Per elaborare i dati NMEA 2000 occorre configurare Signal K in modo che li riceva. Aprire la dashboard di Signal K all’indirizzo [http://openplotter.local:3000/](http://openplotter.local:3000/).

Per poter fare qualsiasi cosa sul server bisogna abilitare la sicurezza e creare un utente amministratore. Fare clic sul pulsante “Login” in alto a destra:

[![](assets/screenshots/21_sk_server_dashboard.jpg){ width="50%" }](assets/screenshots/21_sk_server_dashboard.jpg)

Viene richiesto di creare un nuovo utente amministratore. Io preferisco `admin` come nome utente e poi una password adatta, facile da ricordare e da digitare. Vi si accede solo dalla rete interna.

Conviene poi aggiornare il server SK:

[![](assets/screenshots/23_update_server.jpg){ width="50%" }](assets/screenshots/23_update_server.jpg)

Fatto questo si può passare al sodo e abilitare `can0` sul server. Andare in Data Connections e fare clic sul pulsante Add:

[![](assets/screenshots/26_data_connections_add.jpg){ width="50%" }](assets/screenshots/26_data_connections_add.jpg)

Configurare poi la connessione come segue, scorrere in basso e fare clic su Submit:

[![](assets/screenshots/28_correct_settings.jpg){ width="50%" }](assets/screenshots/28_correct_settings.jpg)

Dopo aver aggiunto la connessione dati, riavviare di nuovo il server. Ora la dashboard dovrebbe mostrare una certa attività:

[![](assets/screenshots/30_can0_activity.jpg){ width="50%" }](assets/screenshots/30_can0_activity.jpg)

Bene. È il momento di congratularsi con sé stessi: si è arrivati lontano.

Volendo, si può anche aprire Data Browser nel menu di sinistra per vedere quali dati arrivano.

### Creare pannelli strumenti

Se i dati arrivano, li si può già visualizzare aprendo SK Instrument Panel:

[![](assets/screenshots/301_sk_plugins.jpg){ width="50%" }](assets/screenshots/301_sk_plugins.jpg)

Con il pulsante a forma di chiave inglese si possono configurare alcuni percorsi. Dimensioni e posizione dei riquadri si regolano facendo clic sul pulsante con il lucchetto.

Il mio laboratorio di prova si trova proprio sotto un tetto di lamiera, senza alcuna ricezione GPS, e gli unici dati interessanti sulla mia rete arrivano dal [sensore di temperatura 1-Wire](https://docs.hatlabs.fi/sh-esp32/pages/tutorials/onewire-temperature/). Il mio pannello strumenti è quindi composto da tre valori di temperatura:

[![](assets/screenshots/302_sk_instrument_panel.jpg){ width="50%" }](assets/screenshots/302_sk_instrument_panel.jpg)

Un po’ triste, ma allo stesso tempo entusiasmante.

Oltre all’Instrument Panel standard esistono molte ottime applicazioni dashboard per Signal K. Vale la pena provare [KIP](https://github.com/mxtommy/Kip) (nell’app store del server SK) o [Wilhelm SK](https://www.wilhelmsk.com/) (solo per dispositivi iOS, disponibile sull’App Store).

### Installazione di InfluxDB e Grafana

Nelle ultime fasi di questo tutorial si installano e configurano InfluxDB e Grafana per creare uno storico e delle visualizzazioni dei dati della barca. Restano alcuni passaggi e qualche schermata dall’aria affollata, ma il piccolo sforzo vale la pena.

InfluxDB è un database di serie temporali in cui memorizzare i dati. Grafana è uno strumento di visualizzazione spesso usato per monitorare lo stato dei sistemi informatici ma che, per la sua versatilità, si presta bene anche ai nostri dati nautici.

Per installare InfluxDB e Grafana, tornare a VNC Viewer e aprire OpenPlotter -> Dashboards dal menu Raspberry:

[![](assets/screenshots/31_openplotter_dashboards.jpg){ width="50%" }](assets/screenshots/31_openplotter_dashboards.jpg)

Selezionare InfluxDB e fare clic su Install. Ci vuole un po’, ma al termine si torna alla scheda Apps, si seleziona Grafana e si fa clic su Install. Tutto qui.

[![](assets/screenshots/32_install.jpg){ width="50%" }](assets/screenshots/32_install.jpg)

Occorre poi creare un nuovo database in InfluxDB. Aprire Chronograf, l’interfaccia web di InfluxDB, nel browser: [http://openplotter.local:8889/](http://openplotter.local:8889/).

[![](assets/screenshots/34_open_chronograf.jpg){ width="50%" }](assets/screenshots/34_open_chronograf.jpg)


Completare la configurazione iniziale. La connessione InfluxDB di Chronograf usa il nome utente `admin` e la password `admin`. Si possono saltare la creazione delle dashboard e la configurazione di Kapacitor.

Creare poi il nuovo database dalla schermata InfluxDB Admin:

[![](assets/screenshots/37_create_signalk_db.jpg){ width="50%" }](assets/screenshots/37_create_signalk_db.jpg)

Dare al database il nome `signalk` e per il resto proseguire. Fatto.

Ora che il database ci aspetta, gli si dà da mangiare. Tornare alla dashboard di Signal K per configurare il plugin di scrittura su InfluxDB:

[![](assets/screenshots/39_sk_plugin_config.jpg){ width="50%" }](assets/screenshots/39_sk_plugin_config.jpg)

Lasciare vuoti nome utente e password. Il nostro database si chiamava `signalk`. Volendo, si possono modificare l’intervallo di scrittura a lotti e la risoluzione dei dati. L’intervallo predefinito è di 10 secondi, ma per una visualizzazione più vicina al tempo reale si può inserire 2. La risoluzione stabilisce ogni quanto una singola misura viene scritta nel database. Il valore predefinito di 200 ms va probabilmente bene, ma io ne volevo di più e ho scelto 100 ms. Selezionare anche le caselle mostrate sotto.

[![](assets/screenshots/40_settings.jpg){ width="50%" }](assets/screenshots/40_settings.jpg)

Scorrere in basso e fare clic su Submit per applicare la configurazione. A questo punto le misure dovrebbero affluire nel database. Conviene verificarlo. Tornare a Chronograf e selezionare la vista Explore. In fondo dovrebbe comparire una sorgente chiamata `signalk.autogen`. Selezionandola dovrebbero apparire i nomi delle singole misure. Ottimo.

[![](assets/screenshots/41_verify_data.jpg){ width="50%" }](assets/screenshots/41_verify_data.jpg)

Resta solo da visualizzare i dati storici.

### Creare una dashboard Grafana di esempio

Si userà Grafana per mostrare qualche bel grafico. Aprire Grafana nel browser: [http://openplotter.local:3001](http://openplotter.local:3001).

[![](assets/screenshots/42_open_grafana.jpg){ width="50%" }](assets/screenshots/42_open_grafana.jpg)

Grafana richiede l’inserimento di una nuova password: farlo. Arrivati alla schermata iniziale, configurare la sorgente dati InfluxDB:

[![](assets/screenshots/44_grafana_data_sources.jpg){ width="50%" }](assets/screenshots/44_grafana_data_sources.jpg)

Nella configurazione l’URL predefinito è mostrato in grigio scuro, ma ho constatato di doverlo digitare esplicitamente. Per il resto valgono di nuovo lo stesso database `signalk` e nome utente e password vuoti. Fare clic su “Save and Test” per verificare che la sorgente dati funzioni.

[![](assets/screenshots/46_config_data_source.jpg){ width="50%" }](assets/screenshots/46_config_data_source.jpg)

A questo punto conviene riepilogare la situazione. Signal K riceve i dati dal NMEA 2000, InfluxDB li memorizza e Grafana è collegato a InfluxDB. Infine si può creare una dashboard Grafana e aggiungere nuovi pannelli dati.

L’editor dei pannelli sembra affollato, ma i passaggi di base sono lineari.

[![](assets/screenshots/54_panel_title.jpg){ width="50%" }](assets/screenshots/54_panel_title.jpg)

Modificare la query. Selezionare prima una misura nella riga FROM. In secondo luogo va aggiunto un operatore matematico per convertire le unità di misura (Grafana non conosce granché le unità, quindi per impostazione predefinita mostra sempre i dati nelle unità SI in cui sono memorizzati). Per esempio, per passare dai kelvin ai gradi Celsius bisogna sottrarre 273,15. Oppure, per passare da m/s ai nodi, moltiplicare per 3600 e dividere per 1852.

Completare il pannello dandogli un titolo e applicando le modifiche.

Ora nella dashboard dovrebbe comparire un solo pannello con un po’ di dati temporali. Aggiungerne un paio con il pulsante Add Panel. I pannelli si possono posizionare e ridimensionare trascinandone i titoli e gli angoli. Infine si può scegliere un intervallo di tempo adatto nella barra superiore e salvare la dashboard.

Ecco come si presenta la mia dashboard delle temperature del motore:

[![](assets/screenshots/56_two_more_panels.jpg){ width="50%" }](assets/screenshots/56_two_more_panels.jpg)

È tutto. Non resta che creare dashboard spettacolari e mostrarle agli amici del porto e del circolo velico. Conviene condividerle anche sul [forum di discussione di Hat Labs](https://github.com/hatlabs/discussions/discussions) per ispirare gli altri.


</div>
