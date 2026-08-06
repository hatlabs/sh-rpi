---
title: Preguntas frecuentes
translated_from: 6f552968db2af4b4fcbf3f6ca0ed8d741ed06f48
---

# FAQ

## ¿Se puede alimentar la Raspberry Pi por el conector USB-C estándar mientras el SH-RPi está conectado?

La respuesta es no. O, al menos, conviene evitarlo. No ocurre nada si el SH-RPi está alimentado y los supercondensadores están cargados por encima de 5 V. Sin embargo, si los supercondensadores están descargados, se alimentarán en sentido inverso a través del bus de 5 V. En la práctica, esto sobrecargará probablemente la fuente de alimentación USB y hará que se apague, sin daños permanentes. Aun así, no es una situación controlada y es posible que se dañe la fuente de alimentación, la Raspberry Pi o el propio SH-RPi.

Otro aspecto es que, incluso con los supercondensadores cargados, el software del demonio no verá ninguna tensión de entrada e iniciará un apagado inmediatamente después del arranque.
