---
title: Ofte stilte spørsmål
translated_from: 6f552968db2af4b4fcbf3f6ca0ed8d741ed06f48
---

# Ofte stilte spørsmål

## Kan jeg forsyne Raspberry Pi-en gjennom den vanlige USB-C-kontakten mens SH-RPi er tilkoblet?

Svaret er nei. Eller i det minste bør det unngås. Ingenting skjer hvis SH-RPi har strøm og superkondensatorene er ladet over 5 V. Hvis superkondensatorene derimot er utladet, blir de matet baklengs gjennom 5 V-bussen. I praksis vil dette sannsynligvis overbelaste USB-strømforsyningen og få den til å slå seg av, uten varig skade. Situasjonen er likevel ikke kontrollert, og strømforsyningen, Raspberry Pi-en eller SH-RPi selv kan bli skadet.

Et annet forhold er at daemon-programvaren ikke ser noen inngangsspenning selv om superkondensatorene er ladet, og derfor utløser en nedstenging straks etter oppstart.
