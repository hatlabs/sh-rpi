---
title: Domande frequenti
translated_from: 6f552968db2af4b4fcbf3f6ca0ed8d741ed06f48
---

# Domande frequenti

## È possibile alimentare il Raspberry Pi tramite il connettore USB-C standard mentre l’SH-RPi è collegato?

La risposta è no. O quantomeno, è una situazione da evitare. Non succede nulla se l’SH-RPi è alimentato e i supercondensatori sono carichi oltre 5 V. Se però i supercondensatori sono scarichi, verranno alimentati a ritroso attraverso il bus a 5 V. In pratica questo sovraccaricherà con ogni probabilità l’alimentatore USB, che si spegnerà senza subire danni permanenti. Si tratta tuttavia di una situazione non controllata e sono possibili danni all’alimentatore, al Raspberry Pi o all’SH-RPi stesso.

Un altro aspetto è che, anche con i supercondensatori carichi, il software del demone non rileverà alcuna tensione di ingresso e avvierà uno spegnimento subito dopo l’avvio.
