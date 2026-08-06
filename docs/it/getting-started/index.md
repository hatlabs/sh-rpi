---
title: Guida introduttiva
translated_from: 46b4add9db5ebdedd9ae7e3eba99744cd34a074c
---

# Guida introduttiva

## Montaggio dell’hardware

L’SH-RPi viene consegnato completamente assemblato. I passaggi di installazione dell’hardware sono i seguenti:

1. Inserire il connettore a pettine passante a 40 pin nell’SH-RPi attraverso il connettore femmina sul lato inferiore, con i pin rivolti verso l’alto.
2. Innestare l’SH-RPi sul connettore GPIO del Raspberry Pi (eventualmente utilizzando i distanziali esagonali).
3. Collegare conduttori di alimentazione adeguati alle spine a morsetti. Le spine a morsetti vengono fornite con le viti serrate: allentarle prima di inserire i conduttori.

<figure markdown="span">
![](shrpi_v2_hardware_assembly.jpg){ width="50%" }
<figcaption>Schema di montaggio dell’SH-RPi v2.0.0.</figcaption>
</figure>

### Collegamento dell’alimentazione

!!! warning
    Non collegare mai l’ingresso di alimentazione al connettore di uscita da 5 V! In caso contrario il Raspberry Pi e l’SH-RPi subiranno danni permanenti.

Collegare una sorgente di alimentazione da 10–32 V al connettore di ingresso dell’alimentazione dell’SH-RPi, come mostrato nella figura seguente.

<figure markdown="span">
![](shrpi_power_input.jpg){ width="50%" }
<figcaption>Collegare la sorgente di alimentazione al connettore cerchiato in verde.</figcaption>
</figure>

La sorgente di alimentazione deve essere dimensionata per almeno 1,0 A alla tensione di uscita indicata.
A parità di condizioni, un alimentatore con tensione di uscita più elevata, ad esempio 24 V, garantisce un funzionamento leggermente più efficiente.
Per il resto, gli impianti da 12 V di imbarcazioni e veicoli, o le sorgenti di alimentazione in corrente continua, funzionano bene.

## Installazione del software

Raspberry Pi OS richiede software aggiuntivo per eseguire il servizio di sistema che avvia automaticamente lo spegnimento quando l’alimentazione viene interrotta.
Per semplificare l’installazione è disponibile uno script di installazione automatica.

### Installazione automatica

È disponibile uno script di installazione automatica. Lo script è collaudato su Raspberry Pi OS appena installato e può non funzionare su sistemi fortemente modificati.
L’installazione non è stata collaudata su altri sistemi operativi.

Per eseguire lo script di installazione automatica, copiare e incollare il comando seguente nel prompt dei comandi del Raspberry Pi:

    curl -L \
        https://raw.githubusercontent.com/hatlabs/SH-RPi-daemon/main/install-online.sh \
        | sudo bash

Il comando occupa tre righe e, una volta incollato nella finestra del terminale, può mostrare caratteri di continuazione di riga. Non è un problema. Premere “Enter” per eseguire il comando.

<figure markdown="span">
![](automated-installation-screenshot.png){ width="80%" }
<figcaption>Il comando di installazione nel terminale</figcaption>
</figure>

Il comando scarica lo script di installazione e lo esegue automaticamente.

Lo script di installazione automatica:

- abilita l’interfaccia I2C, necessaria all’SH-RPi per comunicare con il Raspberry Pi
- se è stato selezionato il supporto per la scheda aggiuntiva di interfaccia NMEA 2000
  - abilita l’interfaccia SPI e un overlay
  - definisce l’interfaccia di rete CAN
- se è stato selezionato il supporto per la scheda aggiuntiva di interfaccia NMEA 0183
  - abilita l’interfaccia SPI e un overlay
- abilita l’overlay per l’orologio in tempo reale (RTC)
- se è stato selezionato il supporto per il MAX-M8Q GNSS HAT
  - abilita l’interfaccia seriale UART
  - disabilita la console seriale
  - disabilita il Bluetooth, poiché è in conflitto con l’interfaccia seriale UART
- installa il software di servizio dell’SH-RPi

## Custodie

Se si intende utilizzare il Raspberry Pi e l’SH-RPi all’aperto, su un veicolo o su un’imbarcazione, oppure in ambienti fortemente condensanti, collocare sempre il dispositivo in una custodia impermeabile!
Hat Labs
offre una varietà di [custodie impermeabili](https://shop.hatlabs.fi/collections/accessories-enclosures).

Le custodie di dimensioni media e grande sono dotate di una piastra di base forata e di adattatori di fissaggio con cui montare il Raspberry Pi, gli HAT aggiuntivi e altri componenti.
Le altre custodie vengono fornite con supporti adesivi stampati in 3D.

### Montaggio nella custodia media

La custodia di dimensioni medie è progettata per ospitare in posizione verticale il Raspberry Pi 4 Model B, l’SH-RPi e più HAT. L’installazione è descritta di seguito.

#### Montaggio

Si parte da una custodia vuota, mostrata nella figura seguente.

<figure markdown="span">
![](01_bare_box.jpg){ width="50%" }
<figcaption>Custodia priva di componenti.</figcaption>
</figure>

Installare per prima cosa tutti i connettori necessari. Prima di installarli può essere necessario saldarvi i conduttori. Le istruzioni di saldatura per i terminali a coppa si trovano in questo video di YouTube:

<iframe width="560" height="315" src="https://www.youtube.com/embed/_GLeCt_u3U8" frameborder="0" allowfullscreen></iframe>

Non esiste un vero standard per la piedinatura dei connettori di alimentazione, ma si consiglia di collegare sempre GND al pin 1 e +12 V/24 V al pin 2. La figura seguente mostra il connettore di alimentazione installato.

Inserire quindi i connettori nella custodia. La figura seguente mostra i connettori installati.

<figure markdown="span">
![](02_conx.jpg){ width="50%" }
<figcaption>Connettori installati.</figcaption>
</figure>

Se la custodia deve essere utilizzata in un ambiente condensante, ad esempio su un’imbarcazione o all’aperto, sigillare i fori rimanenti con pressacavi con tappo cieco. La figura seguente mostra come installare il tappo nel pressacavo.

<figure markdown="span">
![](03_gland_plug.jpg){ width="50%" }
<figcaption>Tappo del pressacavo.</figcaption>
</figure>

La figura seguente mostra i pressacavi installati. In questo modo la custodia diventa impermeabile.

<figure markdown="span">
![](04_conx_plugs.jpg){ width="50%" }
<figcaption>Pressacavi installati.</figcaption>
</figure>

Si prendono ora le parti da installare nella custodia e le si dispone sulla piastra di base. La figura seguente mostra le parti da installare. Le parti in plastica nera sono i supporti verticali che tengono in posizione lo stack di schede.

<figure markdown="span">
![](05_ingredients.jpg){ width="50%" }
<figcaption>Gli ingredienti.</figcaption>
</figure>

Per prima cosa i distanziali esagonali da 6 mm vengono avvitati nei supporti verticali. Serrare solo a mano!

La figura seguente mostra i supporti verticali con i distanziali installati.

<figure markdown="span">
![](06_vertical_mounts.jpg){ width="50%" }
<figcaption>Supporti verticali con distanziali esagonali.</figcaption>
</figure>

È quindi possibile fissare i supporti al Raspberry Pi o alla scheda base. Utilizzare le viti M2,5 per fissare la scheda accanto ai pin GPIO e i distanziali esagonali M2,5 da 16 mm sul lato opposto.

Si installa ora il connettore a pettine passante sull’SH-RPi. Premere delicatamente e in modo uniforme per evitare di piegare i pin. L’altezza ottimale del connettore dipende dall’ordine degli HAT. Se l’SH-RPi viene inserito direttamente sopra il Raspberry Pi, rimuovere il distanziatore dal connettore a pettine passante. Il distanziatore è invece necessario se l’SH-RPi viene installato sopra un altro HAT di interfaccia.

<figure markdown="span">
![](07_stack_thru_conx.jpg){ width="50%" }
<figcaption>Inserimento del connettore a pettine passante.</figcaption>
</figure>

La figura seguente mostra l’SH-RPi montato sulla scheda base.

<figure markdown="span">
![](08_shrpi_mounted.jpg){ width="50%" }
<figcaption>L’SH-RPi montato sulla scheda base.</figcaption>
</figure>

#### Cablaggio dell’alimentazione

In questa guida pratica viene installato anche un CAN HAT aggiuntivo per la connettività NMEA 2000. La figura seguente mostra il CAN HAT montato sull’SH-RPi.

<figure markdown="span">
![](09_can_mounted.jpg){ width="50%" }
<figcaption>Il CAN HAT montato sull’SH-RPi.</figcaption>
</figure>

Il passaggio successivo consiste nell’installare lo stack di schede sulla piastra di base. Utilizzare le viti M3 in dotazione per fissare lo stack in posizione. Non serrare eccessivamente le viti.

<figure markdown="span">
![](10_on_base_mount.jpg){ width="50%" }
<figcaption>Lo stack di schede installato sulla piastra di base.</figcaption>
</figure>

Spelare quindi i conduttori dei connettori. Se si utilizza un connettore di alimentazione separato, il conduttore rosso NMEA 2000 va lasciato non spelato oppure tagliato del tutto. La figura seguente mostra i conduttori spelati.

<figure markdown="span">
![](13_stripped_wires.jpg){ width="50%" }
<figcaption>Conduttori di alimentazione e CAN spelati.</figcaption>
</figure>

Il passaggio successivo consiste nel collegare i conduttori ai connettori della scheda. Il connettore di alimentazione va collegato alla spina a morsetti come mostrato nella figura seguente.

Quando si innesta la spina a morsetti, prestare _molta_ attenzione a inserirla nel connettore di ingresso dell’SH-RPi. Collegandola al connettore di uscita da 5 V si rischia di danneggiare tutti i dispositivi dello stack!

<figure markdown="span">
![](14_power_conx.jpg){ width="50%" }
<figcaption>Disposizione della spina a morsetti del connettore di alimentazione.</figcaption>
</figure>

I conduttori CAN vanno quindi collegati al connettore CAN0 del CAN HAT come mostrato di seguito. Il nero è la massa, il bianco è CAN high (H) e il blu è CAN low (L).

<figure markdown="span">
![](15_wires_plugged.jpg){ width="50%" }
<figcaption>Disposizione finale del cablaggio.</figcaption>
</figure>

#### Alimentazione dalla rete NMEA 2000

A bordo di un’imbarcazione è anche possibile alimentare il sistema dalla rete NMEA 2000. In questo caso vengono utilizzati tutti i conduttori del connettore NMEA 2000.

<figure markdown="span">
![](18_alt_can_wires.jpg){ width="50%" }
<figcaption>Quando il dispositivo viene alimentato dalla rete NMEA 2000, vengono utilizzati tutti i conduttori del connettore NMEA 2000.</figcaption>
</figure>

I conduttori nero e rosso vengono collegati alla spina a morsetti di alimentazione, con un breve spezzone di conduttore nero giuntato al morsetto GND come mostrato nella figura seguente. Il breve conduttore nero si collega al morsetto GND del connettore CAN0 del CAN HAT.

<figure markdown="span">
![](19_spliced_gnd.jpg){ width="50%" }
<figcaption>Collegare il conduttore GND NMEA 2000 sia alla spina a morsetti di alimentazione sia al connettore CAN0 del CAN HAT.</figcaption>
</figure>

La figura seguente mostra la disposizione finale del cablaggio quando il dispositivo viene alimentato dalla rete NMEA 2000.

<figure markdown="span">
![](20_can_power_wiring.jpg){ width="50%" }
<figcaption>Disposizione finale del cablaggio quando il dispositivo viene alimentato dalla rete NMEA 2000.</figcaption>
</figure>

#### Fissaggio dello stack

Infine, l’estremità libera dello stack può essere fissata alla piastra di base con piccole fascette; in alternativa, semplici fascette sono una soluzione pratica e facile da usare. Le due figure seguenti mostrano l’installazione delle fascette.

<figure markdown="span">
![](11_tie_wraps.jpg){ width="50%" }
<figcaption>Fascette inserite.</figcaption>
</figure>

<figure markdown="span">
![](12_tie_wraps_2.jpg){ width="50%" }
<figcaption>Installazione delle fascette completata.</figcaption>
</figure>

#### Completamento del montaggio

A questo punto la piastra di base può essere inserita nella custodia.

<figure markdown="span">
![](16_in_place.jpg){ width="50%" }
<figcaption>La piastra di base in posizione.</figcaption>
</figure>

Fissare la piastra di base alla custodia con le viti in dotazione.

<figure markdown="span">
![](17_screw_base_mount.jpg){ width="50%" }
<figcaption>Avvitamento della piastra di base alla custodia.</figcaption>
</figure>

Il montaggio è così completato. La figura seguente mostra il sistema che lampeggia allegramente nella custodia.

<figure markdown="span">
![](21_all_done.jpg){ width="50%" }
<figcaption>Il sistema completato.</figcaption>
</figure>

La custodia può essere fissata a una parete o a una paratia attraverso i fori d’angolo mostrati nella figura seguente.

<figure markdown="span">
![](22_mounting.jpg){ width="50%" }
<figcaption>Posizione dei fori di fissaggio.</figcaption>
</figure>


### Foratura

Se si utilizza una custodia priva di fori predisposti, è necessario praticare i fori da sé.

Come minimo serve un foro per l’ingresso di alimentazione e, in qualsiasi custodia metallica, un altro per un’antenna Wi-Fi o un connettore Ethernet via cavo.

Pianificare la posizione dei fori e dei connettori in funzione del luogo di installazione previsto.
Se si prevede il montaggio a parete della custodia, orientare i connettori verso il basso per ridurre al minimo la possibilità di infiltrazioni d’acqua.

Sia l’alluminio sia il policarbonato sono relativamente teneri e possono essere forati con una punta a gradini (quella che sembra un piccolo albero di Natale metallico).
Forando la plastica, le normali punte da metallo possono mordere troppo e incrinare la parete.

<figure markdown="span">
![](step_drill_bit.jpg){ width="50%" }
<figcaption>Un esempio di punte a gradini.</figcaption>
</figure>

Diametri dei fori adatti ai diversi connettori:

- SMA (antenna Wi-Fi): 6,5–7 mm o 1/4"
- Pressacavo PG7 e connettore da pannello M12 (NMEA 2000): 12,5 mm o 1/2"
- Connettori da pannello SP13 (connettori in plastica blu-nera): 13 mm.
- Pressacavo PG9: 16 mm o 5/8"
- Connettore da pannello RJ45: 21–22 mm
- Connettore da pannello USB tipo A: 21–22 mm

### Fissaggio del Raspberry Pi

Le custodie fornite da Hat Labs includono adattatori di fissaggio con cui montare il Raspberry Pi.

### Saldatura dei connettori da pannello

Quando si saldano i conduttori interni ai connettori da pannello, utilizzare sempre guaina termorestringente sui singoli conduttori.
Ricordare sempre di infilare la guaina termorestringente sui conduttori _prima_ di saldare...
Di norma è possibile aggiungere prima lo stagno nella cavità del pin del connettore, poi rifonderlo e inserire il conduttore.

### Collegamento di una ventola

Si consiglia di collocare una ventola all’interno della custodia per migliorare la circolazione dell’aria e la trasmissione del calore attraverso le
superfici della custodia.
Una piccola ventola da 40 mm può essere fissata nella custodia con nastro biadesivo o colla a caldo.

La ventola va collegata al connettore di uscita generico da 5 V dell’SH-RPi:

<figure markdown="span">
![](shrpi_5v_output.jpg){ width="50%" }
<figcaption>Collegare la ventola al connettore indicato dalla freccia rossa.</figcaption>
</figure>

### Completamento dell’installazione

Una volta praticati i fori, fissato il Raspberry Pi, saldati i connettori da pannello e collegata la ventola, chiudere la custodia per proteggere l’SH-RPi e il Raspberry Pi dalle intemperie. Verificare che tutti i collegamenti siano saldi e che la custodia sia sigillata ermeticamente per impedire infiltrazioni d’acqua.

### Collaudo del sistema

Completata l’installazione, alimentare il sistema Raspberry Pi e SH-RPi per verificare che tutto funzioni correttamente. Controllare che il Raspberry Pi si avvii, che la ventola giri e che l’SH-RPi comunichi con il Raspberry Pi. Una volta accertato il corretto funzionamento, è possibile procedere alla configurazione del software e all’integrazione del sistema nell’ambiente previsto.

Congratulazioni! Il montaggio dell’hardware e l’allestimento della custodia del sistema SH-RPi e Raspberry Pi sono completati.
