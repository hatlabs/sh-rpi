---
title: Descrizione dell’hardware
translated_from: 257eeaa16d90da32404917c6093ffa709b5400f8
---

# Descrizione dell’hardware

## Panoramica della scheda

Di seguito sono descritti i diversi blocchi funzionali del Sailor Hat for Raspberry Pi.

<figure markdown="span">
![](SH-RPi-2.0.0-func.jpg){ width="60%" }
<figcaption>Blocchi funzionali dell’SH-RPi.</figcaption>
</figure>

1. Ingresso di alimentazione e protezione.
    L’alimentazione viene fornita tramite un connettore compatibile Phoenix MC con passo 3,81 mm (0,15").
    L’intervallo di tensione ammesso è 9–32 V.
    Il circuito di protezione all’ingresso comprende:

    - fusibile SMD da 4 A
    - soppressore di transitori di tensione da 33 V (potenza di picco d’impulso di 5000 W)
    - diodo di protezione contro l’inversione di polarità
    - un induttore di filtro e un filtro a pi greco per il controllo delle interferenze elettromagnetiche condotte

2. Convertitore step-down (buck) di primo stadio con limitazione di corrente.
    Il convertitore buck trasforma la tensione di ingresso in un potenziale di 8,8 V che il banco di supercondensatori è in grado di sostenere.
    Il circuito del convertitore step-down comprende anche un limitatore di corrente separato, che riduce la corrente di ingresso a 0,8 A (con l’impostazione predefinita).
3. Tre supercondensatori da 20 F e 3,0 V.
    Il banco di supercondensatori funge da riserva di energia per il Raspberry Pi.
    Può alimentare un Raspberry Pi 4B fino a 70 secondi (in funzione, naturalmente, della quantità di periferiche aggiuntive) e i modelli a consumo più contenuto molto più a lungo.
    I supercondensatori rendono inoltre possibile alimentare il Raspberry Pi tramite un’interfaccia a bassa potenza come il bus NMEA 2000, che limita a 1,0 A la corrente massima del singolo nodo.
4. Microcontrollore.
    Il funzionamento dell’SH-RPi è gestito da un microcontrollore ATtiny1616.
    Il microcontrollore svolge le funzioni seguenti:

    - misura la tensione di ingresso
    - misura la corrente di ingresso
    - misura la tensione dei supercondensatori
    - controlla la barra di LED di stato
    - controlla l’uscita a 5 V
    - riceve le informazioni di interrupt dell’orologio in tempo reale
    - comunica lo stato dell’SH-RPi al servizio sul Raspberry Pi tramite I2C

5. Convertitore buck di secondo stadio.
    Il convertitore buck converte il potenziale del banco di supercondensatori nella tensione di ingresso a 5 V del Raspberry Pi. La corrente massima istantanea in uscita è di 5 A e almeno 3 A sono ottenibili come corrente continua senza raffreddamento attivo.
    Il funzionamento del convertitore buck è gestito dal microcontrollore. Il microcontrollore attiva il convertitore boost quando la tensione dei supercondensatori è salita oltre 8,0 V.
    Durante lo spegnimento del sistema o un riavvio del watchdog, il microcontrollore disattiva il convertitore boost per togliere la tensione di ingresso al Raspberry Pi.
6. Barra di LED di stato.
    I quattro LED di stato indicano lo stato operativo della scheda come descritto nella sezione [LED di stato](#led-di-stato).
7. Orologio in tempo reale.
    La scheda comprende un orologio in tempo reale PCF8563, in grado di mantenere l’ora esatta anche in assenza di connessione a internet o GPS.
    L’RTC comunica con il Raspberry Pi tramite I2C.

## Connettori

<div class="row">
  <div class="col-sm-6">

<figure markdown="span">
![](SH-RPi-2.0.0-conx.jpg){ width="100%" }
<figcaption>Connettori dell’SH-RPi, lato superiore.</figcaption>
</figure>

   </div>
   <div class="col-sm-6">

<figure markdown="span">
![](SH-RPi-2.0.0-conx-back.jpg){ width="100%" }
<figcaption>Connettori dell’SH-RPi, lato inferiore.</figcaption>
</figure>

   </div>
</div>

1. Connettore di ingresso dell’alimentazione.

    Il connettore di alimentazione è di tipo compatibile Phoenix MC con passo 3,81 mm (0,15").
    La confezione di vendita include una spina a morsetti a vite compatibile.
2. Connettore di uscita a 5 V.
    A questo connettore si possono collegare periferiche esterne a 5 V. Anche il connettore di uscita a 5 V è di tipo compatibile Phoenix MC con passo 3,81 mm (0,15").
3. Connettore GPIO passante per Raspberry Pi.
    Si tratta di un connettore GPIO standard per Raspberry Pi a 2× 20 pin. Per collegare l’SH-RPi a un Raspberry Pi occorre inserire il connettore a pettine passante in dotazione.
    Sopra il Sailor Hat si possono impilare altri HAT.
4. Connettore di programmazione e debug dell’ATtiny1616.
    Il connettore consente di programmare il microcontrollore con un programmatore esterno oppure di abilitare la programmazione a bordo scheda.
5. Connettore del limitatore di corrente.
    Sul connettore del limitatore di corrente si possono inserire dei jumper per portare il limite di corrente a 1,8 A o a 2,8 A (il valore predefinito è 0,8 A).
    Inserire un jumper in orizzontale sulla fila superiore (contrassegnata “2A”) per impostare il limite di corrente a 1,8 A. Inserire un jumper in orizzontale sulla fila inferiore (contrassegnata “3A”) per impostare il limite di corrente a 2,8 A.
6. Connettore per interrupt esterno. Non funzionante nell’hardware v2.0.0.
7. Connettore per la batteria CR1220 dell’orologio in tempo reale (sul lato inferiore).
    L’orologio in tempo reale richiede una batteria tampone CR1220 per mantenere l’ora quando il sistema è spento.
    La batteria va orientata con il lato positivo (quello più piatto) rivolto verso l’esterno della scheda.
8. Jumper a saldare RTC Enable.
    L’orologio in tempo reale è abilitato per impostazione predefinita.
    Per disabilitare l’RTC, tagliare le piste tra le piazzole del jumper a saldare con un coltello affilato.
    Prestare attenzione a non tagliare le piste vicine.
9. GPIO4 Enable. Unire le piazzole per collegare il GPIO4 del Raspberry Pi alla porta PB5 del microcontrollore a bordo scheda.
    Perché sia utile, occorre una funzionalità firmware personalizzata.

## Alimentazione

L’SH-RPi integra un sottosistema di alimentazione che fornisce al Raspberry Pi una tensione pulita a partire da una sorgente disturbata, come un alimentatore non regolato o l’impianto della batteria di servizio (“house”) di un’imbarcazione. L’alimentazione ammette tensioni di ingresso da 9 a 32 V, anche se un potenziale inferiore a 10 V viene considerato una condizione di sottotensione, per evitare danni da scarica profonda alle tipiche batterie al piombo.

Lo schema di funzionamento del sottosistema di alimentazione è riportato nella figura sottostante.

La corrente massima di ingresso è limitata per proteggere gli alimentatori a monte e il cablaggio. Il limite di corrente predefinito è 0,8 A, ma può essere aumentato a 1,8 A o 2,8 A inserendo dei jumper sul connettore del limitatore di corrente.

La tensione di ingresso viene abbassata dal convertitore buck di primo stadio per caricare il banco di supercondensatori fino a una tensione di 8,8 V. I supercondensatori costituiscono una riserva di energia per il Raspberry Pi, sia per le microinterruzioni di breve durata sia per fornire alimentazione di ultima istanza durante lo spegnimento del sistema.

Il convertitore buck di secondo stadio converte la tensione dei supercondensatori nella tensione di ingresso a 5 V del Raspberry Pi. L’uscita a 5 V viene attivata dal microcontrollore quando la tensione dei supercondensatori supera 8,0 V e disattivata quando scende sotto 5,0 V. Questi limiti sono configurabili dall’utente.

La corrente massima di picco in uscita verso il Raspberry Pi è di 5 A. La corrente media massima in uscita dipende dall’impostazione del limitatore della corrente di ingresso e dalla temperatura ambiente. Con un limite di corrente di ingresso di 0,8 A, la corrente massima erogabile con continuità è di circa 1,4 A. Con il limite di corrente di ingresso impostato a 2,8 A, la corrente media massima in uscita è determinata dalle caratteristiche termiche del sistema. In spazio aperto e a temperatura ambiente, la corrente media massima dell’uscita a 5 V è di almeno 3,0 A. Valori superiori sono possibili raffreddando attivamente la scheda SH-RPi.

Con una corrente di uscita di 1,4 A, l’efficienza complessiva dell’alimentazione è del 79%.

<figure markdown="span">
![](psu_diagram.svg){ width="70%" }
<figcaption>Schema di funzionamento dell’alimentazione con valori di corrente e tensione di esempio.</figcaption>
</figure>

## LED di stato

La barra di LED dell’SH-RPi, sul lato sinistro della scheda, indica lo stato operativo della scheda.
La barra segnala lo stato di carica del banco di supercondensatori. Il primo LED inizia ad accendersi quando la tensione supera 5 V e tutti i LED sono completamente accesi con un potenziale dei supercondensatori di 9 V.

Sovrapposte alla barra, diverse sequenze di lampeggio indicano lo stato della scheda come segue.

| Sequenza | Descrizione |
|----------|-------------|
| Nessun lampeggio | Carica o funzionamento normale (1) |
| Breve spegnimento ogni 4 s | Watchdog attivo (2) |
| Scorrimento verso sinistra | Nessuna tensione di ingresso (3) |
| Due spegnimenti con pausa di 1 s | Spegnimento in corso (4) |
| Due lampeggi con pausa di 2 s | In sospensione (5) |
| LED alternati lampeggianti | Riavvio del watchdog (6) |
| Lampeggio rapido | Guasto – contattare il produttore (7) |

Segue la descrizione dettagliata degli stati:

1. I supercondensatori si stanno caricando e, se la loro tensione è superiore a 8,0 V, l’uscita a 5 V è attiva.
    Il demone di Raspberry Pi OS non è attivo.
2. Il demone è attivo e il watchdog è abilitato. Il sistema operativo si è avviato e funziona normalmente.
3. L’alimentazione di ingresso è venuta a mancare e i supercondensatori si stanno scaricando. L’uscita a 5 V è attiva.
4. Il demone ha avviato uno spegnimento. L’SH-RPi attende che il Raspberry Pi si spenga.
5. L’SH-RPi è in stato di sospensione. L’uscita a 5 V è disattivata e la scheda attende un allarme dell’orologio in tempo reale per riattivarsi.
6. L’SH-RPi non ha ricevuto un heartbeat dal demone per 10 s, il che indica che il Pi si è bloccato.
    Il Raspberry Pi viene riavviato togliendo i 5 V per due secondi.
7. L’SH-RPi ha rilevato una condizione di sovratensione dei supercondensatori. Contattare il produttore per ulteriore assistenza.


## Funzione di riavvio del watchdog

Oltre all’alimentazione, il Sailor Hat for Raspberry Pi integra un timer watchdog hardware che consente di riavviare il Raspberry Pi in caso di blocco software o hardware. Il timer watchdog è abilitato per impostazione predefinita e, se necessario, può essere disabilitato con il comando `shrpi set watchdog 0` dalla riga di comando del dispositivo. Quando è abilitato, il timer watchdog riavvia il Raspberry Pi se non riceve dal Raspberry Pi un segnale di “heartbeat” entro un intervallo di tempo prestabilito (tipicamente 10 secondi).

Sul Raspberry Pi deve essere in esecuzione un servizio che invia periodicamente un segnale di heartbeat all’SH-RPi. Il servizio può essere installato dal pacchetto software fornito.

Se il timer watchdog attiva un riavvio, l’SH-RPi disattiva l’uscita a 5 V per un breve periodo, in modo da forzare il riavvio del Raspberry Pi. L’SH-RPi riattiva poi l’uscita a 5 V per consentire al Raspberry Pi di avviarsi di nuovo.

## Orologio in tempo reale

L’SH-RPi integra un orologio in tempo reale (RTC) PCF8563, che consente di mantenere l’ora esatta anche quando il Raspberry Pi non è connesso a internet o non è disponibile un segnale GPS. L’RTC è collegato al Raspberry Pi tramite il bus I2C.

Per utilizzare l’RTC occorre installare una batteria tampone CR1220 sul lato inferiore della scheda. Il lato positivo della batteria (quello più piatto) deve essere rivolto verso l’esterno della scheda.

Quando la scheda SH-RPi viene usata insieme a un dispositivo dotato di RTC integrato, gli indirizzi I2C dei due orologi possono entrare in conflitto.
In tal caso l’RTC dell’SH-RPi può essere disabilitato tagliando le piste tra le piazzole del jumper a saldare RTC EN.

## Configurazione dell’hardware

Il Sailor Hat for Raspberry Pi può essere configurato dall’utente per adattarsi a casi d’uso specifici. Le opzioni di configurazione comprendono:

1. Impostazione del limitatore di corrente.
    Il limitatore della corrente di ingresso può essere impostato a 0,8 A (predefinito), 1,8 A o 2,8 A inserendo dei jumper sul connettore del limitatore di corrente.
2. Abilitazione dell’orologio in tempo reale.
    L’RTC può essere abilitato o disabilitato con un jumper a saldare.
3. Abilitazione di GPIO4.
    Unire le piazzole per collegare il GPIO4 del Raspberry Pi alla porta PB5 del microcontrollore a bordo scheda. Perché sia utile, occorre una funzionalità firmware personalizzata.

## I2C

Il Sailor Hat comunica con il Raspberry Pi
sul bus I2C 1, sui pin GPIO 3 e 5 (rispettivamente GPIO2 e GPIO3).
L’indirizzo I2C è 0x6d.

L’orologio in tempo reale PCF8563 riserva inoltre l’indirizzo I2C 0x51 sullo stesso bus.
