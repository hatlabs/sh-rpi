---
title: Introduzione
translated_from: 0ec24a83f9a21c842e78cd792ae3510e89df0e34
---

# Introduzione

!!! info
    Alla ricerca della vecchia documentazione di Sailor Hat for Raspberry Pi v1.0.0? È disponibile all’indirizzo [docs.hatlabs.fi/sh-rpi-v1](https://docs.hatlabs.fi/sh-rpi-v1/).

Sailor Hat for Raspberry Pi (SH-RPi) è una versatile scheda di gestione dell’alimentazione progettata per il Raspberry Pi e per computer a scheda singola analoghi. Con l’SH-RPi collegato è possibile realizzare server profondamente integrati, che si spengono in modo sicuro quando l’alimentazione viene tolta e si riaccendono automaticamente quando viene ripristinata.

L’SH-RPi supporta tutti i modelli di Raspberry Pi dotati di connettore GPIO a 40 pin (tutti i modelli a partire dal Pi 1 Model B+). È inoltre compatibile con le schede Raspberry Pi Compute Module 4 e con altri computer a scheda singola dotati di un connettore GPIO a 40 pin compatibile con Raspberry Pi oppure di un’interfaccia I2C esterna con ingresso di alimentazione a 5 V.

<figure markdown="span">
![](shrpi_v2.0.0_top_render_ortho.jpg){ width="60%" }
<figcaption>Sailor Hat for Raspberry Pi v2.0.0.</figcaption>
</figure>

## Caratteristiche principali

- **Ampio intervallo di tensione di ingresso**: alimentare in sicurezza il Raspberry Pi da un impianto a 12 V o 24 V, come quelli comunemente presenti su veicoli e imbarcazioni. L’SH-RPi ha un intervallo di ingresso di 10–32 V, con filtraggio aggiuntivo e protezione contro le sovratensioni.
- **Elevata capacità di corrente in uscita**: 3 A di corrente continua in uscita a 5 V (in funzione della temperatura ambiente), con picchi fino a 5 A. Con il raffreddamento attivo è possibile arrivare a 4 A di corrente continua in uscita. L’SH-RPi è in grado di alimentare anche le configurazioni Raspberry Pi più esigenti.
- **Immunità alle microinterruzioni**: i supercondensatori integrati fanno sì che le interruzioni di corrente intermittenti vengano ignorate, mantenendo il server in funzione durante gli abbassamenti di tensione o le microinterruzioni.
- **Compatibilità con il bus NMEA 2000**: alimentare il Raspberry Pi direttamente dal bus NMEA 2000. L’SH-RPi integra un circuito di limitazione di corrente che limita la corrente massima di ingresso a circa 0,8 A. I supercondensatori forniscono la potenza di picco necessaria ai dispositivi più esigenti, come schermi e unità SSD.
- **Spegnimento sicuro**: il Raspberry Pi viene informato delle interruzioni di corrente e si spegne in modo sicuro, alimentato dai supercondensatori. Questo elimina il rischio di schede SD danneggiate.
- **Orologio in tempo reale**: mantenere il Raspberry Pi sincronizzato grazie all’orologio in tempo reale integrato e alla batteria tampone.
- **Timer watchdog**: riavviare automaticamente il Raspberry Pi in caso di blocco grazie al timer watchdog integrato.
- **Impilabile**: aggiungere funzioni impilando altri HAT per Raspberry Pi, ad esempio GPS, NMEA 2000 o NMEA 0183.

Sailor Hat for Raspberry Pi è hardware aperto, distribuito con licenza Creative Commons Attribuzione – Condividi allo stesso modo 4.0 Internazionale.

## Come procurarsi l’hardware

Le schede SH-RPi si possono acquistare da [Hat Labs Oy](https://shop.hatlabs.fi/products/sh-rpi). Tutti i file di progetto sono inoltre disponibili nel [repository GitHub dell’hardware SH-RPi](https://github.com/hatlabs/sh-rpi-hardware/).
