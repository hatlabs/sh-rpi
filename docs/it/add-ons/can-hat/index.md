---
title: Waveshare 2-Channel Isolated CAN HAT
translated_from: 91112523c75ae01ec3e4cdcdabdcff0fe5fdbd78
---

# CAN HAT

Il Waveshare 2-Channel Isolated CAN HAT mette a disposizione due interfacce CAN isolate per il Raspberry Pi. Il CAN HAT è basato sul controller CAN MCP2515 e sui transceiver CAN SI65HVD230/SN65HVD230. L’HAT può essere usato per realizzare una singola interfaccia NMEA 2000 conforme oppure due interfacce CAN di altro tipo. Quando è usato come interfaccia NMEA 2000, il secondo canale non deve essere utilizzato, per via dei requisiti di isolamento NMEA 2000.

L’HAT integra un trasformatore DC/DC isolato e non richiede alimentazione esterna.

Questa pagina descrive l’installazione e la configurazione del CAN HAT quando viene usato insieme al Sailor Hat for Raspberry Pi. Per ulteriori dettagli sul CAN HAT, consultare la [pagina wiki di Waveshare](https://www.waveshare.com/wiki/2-CH_CAN_HAT).

## Configurazione dei jumper

!!! warning
    Verificare la posizione dei jumper prima di collegare l’HAT!

Il CAN HAT ha due jumper per le resistenze di terminazione del bus CAN a bordo scheda. Per il funzionamento normale devono essere entrambi in posizione `OFF`!

Il CAN HAT ha inoltre un jumper per la selezione della tensione. Con un Raspberry Pi deve essere impostato su `3V3`, altrimenti il Raspberry Pi può subire danni.

## Collegamento dell’HAT

Inserire con cautela il connettore a pettine passante nel connettore GPIO del CAN HAT. Innestare quindi
l’HAT sul connettore GPIO a 40 pin del Raspberry Pi o del Sailor Hat. Il bordo del connettore va fissato alla scheda sottostante con i distanziali esagonali.

Quando l’HAT è usato con un’interfaccia NMEA 2000, si deve usare soltanto l’interfaccia CAN0. L’interfaccia CAN1 va lasciata scollegata. La figura sottostante mostra il cablaggio per l’interfaccia NMEA 2000.

<figure markdown="span">
![](can_hat_wiring.jpg){ width="50%" }
<figcaption>Cablaggio per l’interfaccia NMEA 2000. Il conduttore rosso resta scollegato.</figcaption>
</figure>

## Configurazione del software

Lo script di installazione del Sailor Hat può essere usato per configurare e abilitare l’interfaccia CAN. Per un’installazione manuale, consultare la [pagina wiki di Waveshare](https://www.waveshare.com/wiki/2-CH_CAN_HAT) per i dettagli.

## Alimentare l’SH-RPi tramite l’interfaccia NMEA 2000

È possibile alimentare il Raspberry Pi tramite l’interfaccia NMEA 2000. A questo scopo i conduttori di alimentazione e di massa NMEA 2000 vanno collegati all’ingresso di alimentazione dell’SH-RPi, mentre i conduttori H e L devono andare al connettore CAN0 sul CAN HAT. Occorre inoltre realizzare un collegamento di massa tra l’SH-RPi e il CAN HAT, come mostrato nella figura sottostante.

<figure markdown="span">
![](can_hat_n2k_power.jpg){ width="50%" }
<figcaption>Configurazione del cablaggio per alimentare l’SH-RPi tramite l’interfaccia NMEA 2000.</figcaption>
</figure>
