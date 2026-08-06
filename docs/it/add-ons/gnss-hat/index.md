---
title: Waveshare MAX-M8Q GNSS HAT
translated_from: 94d29c50a654fad026d00f597a18d7b0d3625d85
---

# GNSS HAT

Il Waveshare MAX-M8Q GNSS HAT mette a disposizione un ricevitore GNSS di alta qualità per il Raspberry Pi, basato sul modulo U-blox MAX-M8Q. Il MAX-M8Q integra un ricevitore GNSS multicostellazione con un’elevata sensibilità di −167 dBm. Supporta GPS, GLONASS, BeiDou e Galileo e può ricevere contemporaneamente da tre di questi sistemi. Sono inoltre supportati diversi sistemi di augmentation come SBAS, QZSS, IMES e D-GPS.

Questa pagina descrive l’installazione e la configurazione del GNSS HAT quando viene usato insieme al Sailor Hat for Raspberry Pi. Per ulteriori dettagli sul GNSS HAT, consultare la [pagina wiki di Waveshare](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT).

## Collegamento dell’HAT

Inserire il connettore a pettine passante nel connettore GPIO del GNSS HAT. Innestare quindi l’HAT sul connettore GPIO a 40 pin del Raspberry Pi. Il GNSS HAT può essere impilato sopra altri HAT.

### Uso del GNSS HAT insieme all’RS485 HAT

Il MAX-M8Q GNSS HAT dispone della funzione TIMEPULSE (PPS), usata per fornire al Raspberry Pi un riferimento temporale GNSS molto
preciso. Purtroppo questa funzione di impulso temporale è collegata a un pin GPIO usato anche dall’RS485 HAT. Se i due dispositivi vengono usati insieme, il pin GPIO in conflitto deve essere scollegato fisicamente. Il modo più semplice
per farlo è tagliare il pin corrispondente sul connettore a pettine passante. La figura sottostante evidenzia il pin da tagliare.

<figure markdown="span">
![](pps_pin.jpg){ width="50%" }
<figcaption>Il pin da tagliare quando il GNSS HAT viene usato insieme all’RS485 HAT.</figcaption>
</figure>

Per essere certi di tagliare il pin corretto, inserire parzialmente il connettore a pettine passante nel connettore GPIO del GNSS HAT. Tagliare quindi la parte superiore del pin evidenziato nella figura sopra. Sfilare il connettore a pettine passante e tagliare poi il pin alla base del connettore.

## Configurazione del software

L’installazione del software del GNSS HAT sarà automatizzata tramite lo script di installazione del Sailor Hat.
Per il momento il GNSS HAT va configurato manualmente, seguendo le istruzioni riportate nella [pagina wiki del Waveshare MAX-M8Q GNSS HAT](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT). I passaggi successivi alla configurazione di `gpsd` non servono.

A seconda della configurazione, il GNSS HAT metterà a disposizione un dispositivo seriale `/dev/ttyAMA0` oppure `/dev/ttyS0` per i dati NMEA 0183. OpenPlotter dispone di una comoda utility di configurazione dei dispositivi seriali, con cui è possibile impostare il GNSS HAT e collegarlo a Signal K.

## Batteria tampone

Il GNSS HAT dispone di un connettore per la batteria tampone. La batteria tampone serve a conservare le informazioni di effemeridi quando il Raspberry Pi è spento. La batteria tampone non è obbligatoria, ma riduce il tempo necessario per ottenere un fix GNSS dopo l’accensione del Raspberry Pi.

Il tipo di batteria tampone è ML1220. È una pila al litio ricaricabile e **non** deve essere sostituita con una pila non ricaricabile. Farlo comporta il rischio di esplosione e incendio! Gli utenti esperti possono, a proprio rischio, rimuovere la resistenza R3 per disabilitare la funzione di ricarica e usare una pila CR1220 non ricaricabile. Gli schemi elettrici e il layout del PCB sono disponibili nella [pagina wiki di Waveshare](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT).
