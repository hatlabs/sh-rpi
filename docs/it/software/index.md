---
title: Software
translated_from: fde8306627421de6b86970b1032ab7a63699a495
---

# Software

## Introduzione

Il Sailor Hat for Raspberry Pi richiede software aggiuntivo sul sistema operativo Raspberry Pi per sfruttarne appieno le funzionalità. È disponibile uno script di installazione che installa automaticamente tutto il software necessario su un’installazione pulita di Raspberry Pi OS. L’uso dello script di installazione è descritto nella [Guida introduttiva](../getting-started/index.md). Le istruzioni per l’installazione manuale servono solo se si preferisce non far modificare la configurazione del sistema da script automatici, oppure se occorre risolvere problemi di installazione.

Per l’installazione manuale, scaricare il codice da [github.com/hatlabs/SH-RPi-daemon](https://github.com/hatlabs/SH-RPi-daemon). Il software e le modifiche di configurazione necessari, così come i dettagli del firmware, sono descritti di seguito.

### Abilitazione di I2C e SPI

Le interfacce I2C e SPI devono essere abilitate. È possibile farlo eseguendo `raspi-config` oppure modificando direttamente `/boot/firmware/config.txt`.

Se si utilizza `raspi-config`, passare direttamente alla fine di questa sottosezione.

```bash
sudo nano /boot/firmware/config.txt
```

Individuare la riga seguente:

```ini
#dtparam=i2c_arm=on
```

e modificarla rimuovendo il segno di commento all’inizio:

```ini
dtparam=i2c_arm=on
```

### Abilitazione delle nuove interfacce

Modificare nuovamente `/boot/firmware/config.txt`:

    sudo nano /boot/firmware/config.txt

Scorrere fino alla sezione `[all]`.

Occorre aggiungere tre nuove righe. Per prima cosa abilitare l’orologio in tempo reale (RTC), se il dispositivo ne è dotato:

    dtoverlay=i2c-rtc,pcf8563

Configurare quindi il kernel affinché segnali lo spegnimento al Sailor Hat:

    dtoverlay=gpio-poweroff,gpiopin=2,input,active_low=17

Anche in questo caso, salvare il file premendo Ctrl-O e uscire da Nano premendo Ctrl-X.

## Demone del Raspberry Pi

Perché Raspberry Pi OS conosca lo stato dell’alimentazione, è necessario installare un demone (software di servizio).

Se il repository SH-RPi-daemon è stato clonato, è possibile installare il demone con i comandi seguenti:

```bash
sudo apt install -y python3-pip
sudo pip3 install .
```

Successivamente occorre installare il file di definizione del servizio e abilitare il servizio:

```bash
sudo install -o root shrpid.service /lib/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable shrpid
```

Fatto! Dopo un riavvio il demone si avvia automaticamente.

*Nota: lo script di installazione automatica descritto nella [Guida introduttiva](../getting-started/index.md) esegue automaticamente tutti i passaggi di installazione del software descritti sopra.*

### File di configurazione del demone

È possibile configurare le impostazioni del demone creando e modificando il file di configurazione `/etc/shrpid.conf`.
Il file utilizza la formattazione YAML.
Sono disponibili le opzioni seguenti:

```yaml
# I2C bus number. You should never need to change this.
i2c-bus: 1
# I2C address of the SH-RPi. Only change this if you have custom firmware.
i2c-addr: 0x6d
# Maximum allowed blackout duration before shutdown.
blackout-time-limit: 3.0
# Input voltage limit for blackout detection.
blackout-voltage-limit: 9.0
# Socket file for the REST API. You should never need to change this.
socket: /var/run/shrpid.sock
# Group for the socket file. You should never need to change this.
socket-group: adm
# Command used to initiate a shutdown. Replace this with a custom script
# to customize the shutdown behavior.
poweroff: /sbin/poweroff
```

È possibile creare un nuovo file di configurazione eseguendo `nano /etc/shrpid.conf` e incollandovi il contenuto riportato sopra.
Commentare le righe che non si desidera modificare.
Salvare il file premendo Ctrl-O e uscire da Nano premendo Ctrl-X.

## Interfaccia a riga di comando

L’interfaccia a riga di comando è uno script Python con cui controllare il Sailor Hat for Raspberry Pi dalla riga di comando del Raspberry Pi. Viene installata dallo script di installazione descritto nella [Guida introduttiva](../getting-started/index.md).

Lo script `shrpi` può essere eseguito con l’opzione `--help` per ottenere istruzioni sui vari comandi. Di seguito sono descritti alcuni casi d’uso principali.

```bash
shrpi print
```

Stampa lo stato e la configurazione attuali del Sailor Hat for Raspberry Pi.

```bash
shrpi set <option> <value>
```

Imposta i vari valori di configurazione. Ad esempio,

```bash
shrpi set led 50
```

imposta la luminosità dei LED al 50%.

```bash
shrpi sleep 3600
```

Spegne il Raspberry Pi e lo riaccende dopo 3600 secondi (1 ora).

```bash
shrpi sleep 15:00
```

Spegne il Raspberry Pi e lo riaccende alle 15:00 (le 3 del pomeriggio).

```bash
shrpi sleep 15:00:00
```

## API REST

`shrpid` implementa un’API REST con cui interrogare lo stato e la configurazione attuali del Sailor Hat for Raspberry Pi e impostare i valori di configurazione.
L’API è disponibile su un socket su file in `/var/run/shrpid.sock`. Di seguito è riportato un esempio di interrogazione con `curl`:

    curl --unix-socket /var/run/shrpid.sock http://localhost/state

Per ulteriori dettagli sui comandi disponibili, consultare il [codice sorgente di SH-RPi-daemon](https://github.com/hatlabs/SH-RPi-daemon/).

## Firmware

Il codice eseguito dal microcontrollore ATtiny1616 a bordo della scheda è chiamato firmware dell’SH-RPi.

Il repository del firmware si trova all’indirizzo [https://github.com/hatlabs/SH-RPi-firmware](https://github.com/hatlabs/SH-RPi-firmware).

Le sottosezioni seguenti descrivono come aggiornare il firmware per ottenere nuove funzionalità o per modificarlo autonomamente.

### Aggiornamento del firmware

È possibile aggiornare il firmware dell’SH-RPi utilizzando il Raspberry Pi stesso.
Servono alcuni jumper e un po’ di configurazione software.

Il firmware viene flashato tramite l’interfaccia UPDI dell’ATtiny con [`avrdude`](https://github.com/SpenceKonde/AVR-Guidance/blob/master/UPDI/jtag2updi.md).

#### Configurazione dell’hardware

Posizionare i jumper su tutti i pin del connettore a pettine PROG come indicato in rosso nella figura seguente. In questo modo il circuito di programmazione del microcontrollore e l’interfaccia seriale di debug vengono collegati al Raspberry Pi. Inoltre l’uscita da 5 V del controller buck viene forzata in stato attivo, così che il Raspberry Pi non si spenga all’avvio del flashing.

<figure markdown="span">
![](SH-RPi-2.0.0-prog-conx.jpg){ width="50%" }
<figcaption>Posizionare i jumper rossi per abilitare il flashing autonomo.</figcaption>
</figure>

Nota! Per il corretto funzionamento successivo è indispensabile rimuovere almeno il terzo jumper dal connettore a pettine PROG. In caso contrario il Raspberry Pi non sarà in grado di spegnersi.

#### Modifiche alla configurazione del Raspberry Pi

Il passaggio successivo consiste nell’abilitare le UART seriali del Raspberry Pi. Vengono utilizzate sia per l’interfaccia UPDI sia per quella seriale di debug.
Sui modelli di Pi dotati di Bluetooth, la UART è normalmente riservata al circuito Bluetooth integrato. Occorre quindi disabilitare il Bluetooth.

Aggiungere le righe seguenti alla fine di `/boot/firmware/config.txt`:

```ini
dtoverlay=disable-bt
dtoverlay=uart5
```

La prima disabilita il modem Bluetooth. La seconda abilita l’interfaccia UART5 sui GPIO 12 e 13, corrispondenti ai pin 32 e 33. È l’interfaccia seriale utilizzata per il debug dal firmware dell’SH-RPi.

Occorre inoltre disabilitare il servizio di sistema che inizializza il modem Bluetooth:

```bash
sudo systemctl disable hciuart
```

Infine, impedire alla console seriale di sistema di collegarsi alla porta seriale. Rimuovere la parte `console=serial0,115200` dall’inizio di `/boot/cmdline.txt`.

Riavviare affinché le modifiche abbiano effetto.

#### Installazione del software di flashing

Grazie al framework [PlatformIO](https://platformio.org/), tutti gli strumenti necessari possono essere scaricati e installati automaticamente. Occorre solo procurarsi prima
il codice sorgente del firmware. Si installa il sistema di controllo versione `git` e si clona il repository del firmware:

```bash
sudo apt update
sudo apt -y install git
git clone git@github.com:hatlabs/SH-RPi-firmware.git
```

Ora è possibile installare il framework PlatformIO:

```bash
sudo pip3 install -U platformio
```

Modificare il file `platformio.ini` e impostare `upload_port` su `/dev/ttyAMA0`:

```ini
[env]
...
upload_port = /dev/ttyAMA0
monitor_port = /dev/ttyAMA1
```

#### Flashing

Infine è possibile compilare e caricare il firmware. La prima volta che il comando viene eseguito, scarica e installa gli strumenti necessari. L’operazione può richiedere qualche minuto.

```bash
cd SH-RPi-firmware
pio run -t upload
```

I LED di stato bianchi si spengono durante il flashing. Dopo qualche secondo si riaccendono e il flashing è completato. A questo punto, rimuovere i jumper dal connettore a pettine PROG.

#### Ripristino del Bluetooth

Per continuare a utilizzare il Bluetooth, occorre annullare i passaggi eseguiti in precedenza. A tal fine è necessario ripristinare le modifiche apportate a `/boot/firmware/config.txt` e `/boot/cmdline.txt` e riabilitare il servizio `hciuart`:

1. Rimuovere le righe seguenti da `/boot/firmware/config.txt`:

```ini
dtoverlay=disable-bt
dtoverlay=uart5
```

2. Aggiungere nuovamente `console=serial0,115200` all’inizio di `/boot/cmdline.txt`.

3. Riabilitare il servizio `hciuart` eseguendo:

```bash
sudo systemctl enable hciuart
```

4. Riavviare il Raspberry Pi affinché le modifiche abbiano effetto.

Fatto! Il firmware del Sailor Hat for Raspberry Pi è stato aggiornato e, se necessario, la funzionalità Bluetooth è stata ripristinata.
