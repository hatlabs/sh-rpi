---
title: Compute Module 4
translated_from: 2769961d8eba6a0a776d8bf6566816716c7c9cac
---

# Compute Module 4

Il [Compute Module 4](https://www.raspberrypi.org/products/compute-module-4/) è un modulo di calcolo di piccole dimensioni che si innesta su una scheda portante (carrier board). Offrendo prestazioni della CPU identiche a quelle del Raspberry Pi 4B, il CM4 è una soluzione potente, flessibile ed economica per le applicazioni embedded. Nella realizzazione di computer embedded il CM4 presenta diversi vantaggi rispetto al Raspberry Pi 4B:

- Memoria flash eMMC integrata: le schede CM4 dispongono, a seconda del modello, di un massimo di 32 GB di memoria flash eMMC. Questa memoria è più affidabile e più veloce della scheda SD usata nel Raspberry Pi 4B.
- Possibilità di antenna WiFi esterna: il CM4 ha un connettore dedicato per un’antenna WiFi esterna. È utile quando la potenza del segnale dell’antenna WiFi interna non è sufficiente.
- Connettore M.2: molte schede base dispongono di un connettore M.2 utilizzabile per collegare un SSD M.2 o un modulo WiFi M.2.
- Consumo più contenuto: in prove informali abbiamo rilevato che un CM4 con la relativa scheda base consuma oltre il 20% in meno rispetto a un Raspberry Pi 4B.

Per contro, la maggior parte delle schede base per CM4 non include un hub USB 3.0, il che limita le porte USB alla velocità USB 2.0. Inoltre, scrivere l’immagine nella memoria eMMC è leggermente più complicato che scriverla su una scheda SD. Il procedimento è descritto di seguito.

## Scrittura della memoria eMMC sul CM4

Per prima cosa occorre scaricare un’immagine di sistema adatta. Come esempio viene usata l’immagine Headless di [OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/downloading.html), ma il procedimento è lo stesso per le altre immagini. **Nota:** usare sempre un’immagine a 64 bit! Alcuni componenti software presentano problemi se eseguiti su un sistema a 32 bit (in particolare InfluxDB).

La memoria eMMC può essere scritta con la stessa immagine del Raspberry Pi 4B. Il procedimento di scrittura prevede due passaggi aggiuntivi. Primo: il CM4 deve essere commutato in una speciale modalità BOOT che di fatto *impedisce* l’avvio del dispositivo e consente la scrittura della memoria eMMC. Secondo: sul computer usato per la scrittura occorre installare ed eseguire la piccola utility `rpiboot`, che consente di montare la memoria eMMC sul computer stesso. Completati questi passaggi, il procedimento di scrittura è identico a quello usato per il Raspberry Pi 4B.

Per Windows `rpiboot` è disponibile come eseguibile precompilato, mentre per Linux e macOS occorre compilarlo dai sorgenti. Il procedimento per ciascuna piattaforma è descritto nei capitoli seguenti.

Note sul procedimento di installazione:

1. Per scrivere la memoria eMMC, la scheda base deve essere commutata in modalità BOOT. Sulle schede Waveshare CM4-IO-BASE occorre portare in posizione ON il piccolo selettore BOOT accanto al connettore HDMI0.
2. Durante la scrittura la scheda base deve essere collegata a una sorgente di alimentazione esterna. Usare a questo scopo la scheda SH-RPi!

### Windows

1. Per configurare la modalità di scrittura sul computer host, seguire le istruzioni riportate nella [documentazione Raspberry Pi](https://www.raspberrypi.com/documentation/computers/compute-module.html#flashing-the-compute-module-emmc).
2. Seguire le [istruzioni di installazione di OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html).
3. **Nota:** non avviare ancora il sistema! Occorre prima modificare alcune impostazioni, come descritto più avanti nella sezione Configurazione del CM4.
4. Dopo aver modificato le impostazioni di configurazione, riportare il selettore BOOT in posizione OFF e riavviare il sistema. È quindi possibile proseguire con le istruzioni di OpenPlotter.

### Mac

Su un Mac occorre compilare l’utility `rpiboot` dai sorgenti.

1. Per compilare l’utility è necessario avere installato [Homebrew](https://brew.sh/). Installarlo per primo.
2. Seguire quindi i [passaggi indicati nel repository `usbboot`](https://github.com/raspberrypi/usbboot#macos). Quando si esegue `sudo ./rpiboot`, la scheda base CM4 deve essere collegata al computer e alimentata tramite l’SH-RPi. In caso di messaggio di errore, controllare il cavo USB e il selettore BOOT sulla scheda base.
3. Seguire le [istruzioni di installazione di OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html). **Nota:** non avviare ancora il sistema! Occorre prima modificare alcune impostazioni, come descritto più avanti nella sezione Configurazione del CM4.
4. Dopo aver modificato le impostazioni di configurazione, riportare il selettore BOOT in posizione OFF e riavviare il sistema. È quindi possibile proseguire con le istruzioni di OpenPlotter.

### Linux

Come su un Mac, anche su Linux occorre compilare l’utility `rpiboot` dai sorgenti.

1. Per compilare l’utility è necessario avere installato [Homebrew](https://brew.sh/). Installarlo per primo.
2. Seguire quindi i [passaggi indicati nel repository `usbboot`](https://github.com/raspberrypi/usbboot#linux--cygwin--wsl). Quando si esegue `sudo ./rpiboot`, la scheda base CM4 deve essere collegata al computer e alimentata tramite l’SH-RPi. In caso di messaggio di errore, controllare il cavo USB e il selettore BOOT sulla scheda base.
3. Seguire le [istruzioni di installazione di OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html). **Nota:** non avviare ancora il sistema! Occorre prima modificare alcune impostazioni, come descritto più avanti nella sezione Configurazione del CM4.
4. Dopo aver modificato le impostazioni di configurazione, riportare il selettore BOOT in posizione OFF e riavviare il sistema. È quindi possibile proseguire con le istruzioni di OpenPlotter.

## Configurazione del CM4

### Abilitare le porte USB

Prima del primo avvio del sistema occorre apportare alcune modifiche alla configurazione. Per impostazione predefinita, sul CM4 le porte USB sono disabilitate. Questo può ovviamente costituire un problema serio se il sistema deve essere usato con tastiera e mouse. Per abilitare le porte USB occorre modificare il file `config.txt` nella memoria eMMC. La partizione Boot dovrebbe essere già montata sul computer come unità USB. Aprire l’unità e modificare il file `config.txt`. Aggiungere la riga seguente alla fine del file:

    dtoverlay=dwc2,dr_mode=host

Salvare il file e chiuderlo.

### Abilitare l’antenna WiFi esterna

Se si dispone di un’antenna WiFi esterna, occorre modificare di nuovo il file `config.txt`. Aggiungere la riga seguente alla fine del file:

    dtparam=ant2

Altri valori possibili sono `ant1` per l’antenna sul PCB e `noant` per disabilitare entrambe le antenne. Il valore predefinito è `ant1`.
