---
title: Häufig gestellte Fragen
translated_from: 6f552968db2af4b4fcbf3f6ca0ed8d741ed06f48
---

# FAQ

## Kann ich den Raspberry Pi über den normalen USB-C-Anschluss versorgen, während der SH-RPi angeschlossen ist?

Die Antwort lautet nein. Zumindest sollte man das vermeiden. Es passiert nichts, solange der SH-RPi versorgt ist und die Superkondensatoren über 5 V geladen sind. Sind die Superkondensatoren dagegen entladen, werden sie über die 5-V-Schiene rückgespeist. In der Praxis wird dadurch das USB-Netzteil überlastet und schaltet sich vermutlich ohne bleibenden Schaden ab. Das ist jedoch kein kontrollierter Zustand, und Schäden am Netzteil, am Raspberry Pi oder am SH-RPi selbst sind möglich.

Ein weiterer Punkt ist, dass die Daemon-Software auch bei geladenen Superkondensatoren keine Eingangsspannung sieht und unmittelbar nach dem Start ein Herunterfahren auslöst.
