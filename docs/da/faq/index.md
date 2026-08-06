---
title: Ofte stillede spørgsmål
translated_from: 6f552968db2af4b4fcbf3f6ca0ed8d741ed06f48
---

# FAQ

## Kan jeg forsyne Raspberry Pi'en via det almindelige USB-C-stik, mens SH-RPi'en er tilsluttet?

Svaret er nej. Eller det bør i det mindste undgås. Der sker ikke noget, hvis SH-RPi'en har strøm, og superkondensatorerne er opladet til over 5 V. Men hvis superkondensatorerne er afladet, bliver de forsynet baglæns via 5 V-bussen. I praksis vil det sandsynligvis overbelaste USB-strømforsyningen og få den til at slukke uden varig skade. Situationen er dog ikke kontrolleret, og strømforsyningen, Raspberry Pi'en eller SH-RPi'en selv kan tage skade.

Et andet forhold er, at selv med opladede superkondensatorer vil dæmonsoftwaren (baggrundstjenesten) ikke se nogen indgangsspænding og vil udløse en nedlukning umiddelbart efter opstarten.
