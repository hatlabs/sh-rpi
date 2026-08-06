---
title: Vanliga frågor
translated_from: 6f552968db2af4b4fcbf3f6ca0ed8d741ed06f48
---

# Vanliga frågor

## Kan jag driva Raspberry Pi:n via den vanliga USB-C-kontakten medan SH-RPi:n är ansluten?

Svaret är nej. Eller åtminstone bör det undvikas. Ingenting händer om SH-RPi:n har matning och superkondensatorerna är laddade över 5 V. Men om superkondensatorerna är urladdade matas de bakvägen via 5 V-bussen. I praktiken överbelastar det troligen USB-nätaggregatet och får det att stänga av sig utan någon bestående skada. Situationen är ändå inte kontrollerad, och nätaggregatet, Raspberry Pi:n eller SH-RPi:n själv kan skadas.

En annan aspekt är att daemonen inte ser någon inspänning ens när superkondensatorerna är laddade, och därför utlöser en avstängning direkt efter starten.
