---
title: Waveshare 2-Channel Isolated RS485 HAT
translated_from: 7f4b38c33361ca8118a3f68c596e0fb1633d6f5e
---

# RS485 HAT

Il Waveshare 2-Channel Isolated RS485 HAT mette a disposizione due interfacce RS-485 isolate per il Raspberry Pi. Può essere usato per realizzare un’interfaccia NMEA 0183 bidirezionale oppure due interfacce RS-485 bidirezionali generiche. Quando è usato come interfaccia NMEA 0183, un canale serve per la ricezione e l’altro per la trasmissione dei dati.

L’HAT integra un trasformatore DC/DC isolato e non richiede alimentazione esterna.

L’RS485 HAT può essere usato contemporaneamente all’SH-RPi e al CAN HAT.

Questa pagina descrive l’installazione e la configurazione dell’RS485 HAT quando viene usato insieme al Sailor Hat for Raspberry Pi. Per ulteriori dettagli sull’RS485 HAT, consultare la [pagina wiki di Waveshare](https://www.waveshare.com/wiki/2-CH_RS485_HAT).


## Configurazione dei jumper

!!! warning
    Verificare la posizione dei jumper prima di collegare l’HAT!

L’RS485 HAT ha due jumper per le resistenze di terminazione del bus RS-485 a bordo scheda. NMEA 0183 non usa resistenze di terminazione e i jumper devono essere in posizione `OFF`!

## Collegamento dell’HAT

Inserire con cautela il connettore a pettine passante nel connettore GPIO dell’RS-485 HAT. Innestare quindi
l’HAT sul connettore GPIO a 40 pin del Raspberry Pi o del Sailor Hat. Il bordo del connettore va fissato alla scheda sottostante con i distanziali esagonali.

Quando l’HAT è usato come interfaccia NMEA 0183, il canale 1 serve per ricevere i dati (RX) e il canale 2 per trasmetterli (TX). I conduttori TX A e B (o TX+ e TX-) del dispositivo trasmittente vanno collegati ai morsetti A e B del canale 1 dell’HAT, mentre i conduttori RX A e B (o RX+ e RX-) del dispositivo ricevente vanno collegati ai morsetti A e B del canale 2 dell’HAT. La figura sottostante mostra il cablaggio per l’interfaccia NMEA 0183.

<figure markdown="span">
![](nmea0183_wiring.jpg){ width="50%" }
<figcaption>Cablaggio per l’interfaccia NMEA 0183. I colori del cablaggio possono variare a seconda del dispositivo.</figcaption>
</figure>

## Configurazione del software

Lo script di installazione del Sailor Hat può essere usato per configurare e abilitare l’interfaccia RS-485. L’interfaccia sarà resa disponibile da due dispositivi seriali: `/dev/ttySC0` e `/dev/ttySC1`. Di questi, `/dev/ttySC0` serve per ricevere i dati e `/dev/ttySC1` per trasmetterli. Possono essere configurati nelle connessioni dati di Signal K o in qualsiasi altra applicazione NMEA 0183 a scelta.

Per un’installazione manuale, consultare la [pagina wiki di Waveshare](https://www.waveshare.com/wiki/2-CH_RS485_HAT) per i dettagli.
