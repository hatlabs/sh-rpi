---
title: Usein kysytyt kysymykset
---

# UKK

## Voinko syöttää Raspberry Pi:tä tavallisesta USB-C-liittimestä, kun SH-RPi on kytkettynä?

Vastaus on ei. Tai ainakin sitä kannattaa välttää. Mitään ei tapahdu, jos SH-RPi:llä on käyttöjännite ja superkondensaattorit on ladattu yli 5 V:n. Jos superkondensaattorit sen sijaan ovat purkautuneet, ne saavat syöttönsä takaperin 5 V:n väylän kautta. Käytännössä tämä todennäköisesti ylikuormittaa USB-teholähteen ja saa sen sammumaan ilman pysyvää vahinkoa. Tilanne ei kuitenkaan ole hallittu, ja teholähde, Raspberry Pi tai SH-RPi itse voi vaurioitua.

Toinen näkökohta on, että vaikka superkondensaattorit olisivat ladattuja, daemon-ohjelmisto ei näe lainkaan syöttöjännitettä ja käynnistää sammutuksen heti käynnistymisen jälkeen.
