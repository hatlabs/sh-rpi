---
title: Veelgestelde vragen
translated_from: 6f552968db2af4b4fcbf3f6ca0ed8d741ed06f48
---

# Veelgestelde vragen

## Kan ik de Raspberry Pi via de standaard USB-C-connector voeden terwijl de SH-RPi is aangesloten?

Het antwoord is nee. Of in elk geval: doe dat liever niet. Er gebeurt niets als de SH-RPi voeding heeft en de supercondensatoren boven 5 V geladen zijn. Zijn de supercondensatoren echter ontladen, dan worden ze via de 5 V-bus teruggevoed. In de praktijk overbelast dat waarschijnlijk de USB-voeding, waarna die zichzelf uitschakelt zonder blijvende schade. Toch is dit geen beheerste situatie, en de voeding, de Raspberry Pi of de SH-RPi zelf kan schade oplopen.

Een ander punt is dat de daemon zelfs bij geladen supercondensatoren geen ingangsspanning ziet en direct na het opstarten een afsluiting in gang zet.
