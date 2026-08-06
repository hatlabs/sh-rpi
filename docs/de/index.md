---
title: Einführung
translated_from: 0ec24a83f9a21c842e78cd792ae3510e89df0e34
---

# Einführung

!!! info
    Suchen Sie die alte Dokumentation zum Sailor Hat for Raspberry Pi v1.0.0? Sie ist unter [docs.hatlabs.fi/sh-rpi-v1](https://docs.hatlabs.fi/sh-rpi-v1/) verfügbar.

Der Sailor Hat for Raspberry Pi (SH-RPi) ist eine vielseitige Energieverwaltungsplatine für den Raspberry Pi und ähnliche Einplatinencomputer. Mit angeschlossenem SH-RPi lassen sich tief integrierte Server aufbauen, die beim Abschalten der Stromversorgung sicher herunterfahren und automatisch wieder starten, sobald die Spannung zurückkehrt.

Der SH-RPi unterstützt alle Raspberry-Pi-Modelle mit einer 40-poligen GPIO-Stiftleiste (jedes Modell seit dem Pi 1 Model B+). Darüber hinaus ist er mit Raspberry-Pi-Compute-Module-4-Platinen kompatibel sowie mit anderen Einplatinencomputern, die eine 40-polige Raspberry-Pi-kompatible GPIO-Stiftleiste oder eine externe I2C-Schnittstelle mit 5-V-Spannungsversorgung besitzen.

<figure markdown="span">
![](shrpi_v2.0.0_top_render_ortho.jpg){ width="60%" }
<figcaption>Sailor Hat for Raspberry Pi v2.0.0.</figcaption>
</figure>

## Wichtigste Merkmale

- **Weiter Eingangsspannungsbereich**: Versorgen Sie Ihren Raspberry Pi sicher aus einem 12-V- oder 24-V-Bordnetz, wie es in Fahrzeugen und Booten üblich ist. Der SH-RPi hat einen Eingangsspannungsbereich von 10–32 V mit zusätzlicher Filterung und Überspannungsschutz.
- **Hoher Ausgangsstrom**: 3 A Dauerausgangsstrom bei 5 V (abhängig von der Umgebungstemperatur), mit Spitzenströmen bis zu 5 A. Mit aktiver Kühlung sind 4 A Dauerausgangsstrom möglich. Der SH-RPi versorgt selbst die anspruchsvollsten Raspberry-Pi-Aufbauten.
- **Unempfindlich gegen Spannungsstörungen**: Integrierte Superkondensatoren sorgen dafür, dass kurzzeitige Stromausfälle folgenlos bleiben, und halten Ihren Server bei Spannungseinbrüchen und Störungen in Betrieb.
- **NMEA-2000-Bus-Kompatibilität**: Versorgen Sie Ihren Raspberry Pi direkt aus dem NMEA-2000-Bus. Der SH-RPi enthält eine Strombegrenzungsschaltung, die den maximalen Eingangsstrom auf etwa 0,8 A begrenzt. Die Superkondensatoren liefern die Spitzenleistung für stromhungrige Geräte wie Bildschirme und SSD-Laufwerke.
- **Sicheres Herunterfahren**: Der Raspberry Pi wird über Stromausfälle informiert und fährt, gespeist aus den Superkondensatoren, sicher herunter. Damit entfällt das Risiko beschädigter SD-Karten.
- **Echtzeituhr**: Halten Sie die Uhr Ihres Raspberry Pi mit der integrierten Echtzeituhr und der Pufferbatterie synchron.
- **Watchdog-Timer**: Starten Sie Ihren Raspberry Pi nach einem Absturz automatisch mit dem eingebauten Watchdog-Timer neu.
- **Stapelbar**: Erweitern Sie den Funktionsumfang, indem Sie weitere Raspberry-Pi-HATs stapeln, etwa für GPS, NMEA 2000 oder NMEA 0183.

Der Sailor Hat for Raspberry Pi ist offene Hardware und steht unter der Lizenz Creative Commons Namensnennung – Weitergabe unter gleichen Bedingungen 4.0 International.

## Hardware beziehen

SH-RPi-Platinen können Sie bei [Hat Labs Oy](https://shop.hatlabs.fi/products/sh-rpi) kaufen. Alle Designdateien sind außerdem im [SH-RPi-Hardware-Repository auf GitHub](https://github.com/hatlabs/sh-rpi-hardware/) verfügbar.
