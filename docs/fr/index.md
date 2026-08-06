---
title: Introduction
translated_from: 0ec24a83f9a21c842e78cd792ae3510e89df0e34
---

# Introduction

!!! info
    Vous cherchez l'ancienne documentation du Sailor Hat for Raspberry Pi v1.0.0 ? Elle est disponible sur [docs.hatlabs.fi/sh-rpi-v1](https://docs.hatlabs.fi/sh-rpi-v1/).

Le Sailor Hat for Raspberry Pi (SH-RPi) est une carte de gestion de l'alimentation polyvalente, conçue pour le Raspberry Pi et les ordinateurs monocartes similaires. Avec un SH-RPi raccordé, vous pouvez construire des serveurs profondément intégrés qui s'arrêtent en toute sécurité lorsque l'alimentation est coupée et se réveillent automatiquement lorsqu'elle revient.

Le SH-RPi prend en charge tous les modèles de Raspberry Pi équipés d'un connecteur GPIO 40 broches (tous les modèles depuis le Pi 1 Model B+). Il est en outre compatible avec les cartes Raspberry Pi Compute Module 4 et avec les autres ordinateurs monocartes dotés d'un connecteur GPIO 40 broches compatible Raspberry Pi ou d'une interface I2C externe avec une entrée d'alimentation 5 V.

<figure markdown="span">
![](shrpi_v2.0.0_top_render_ortho.jpg){ width="60%" }
<figcaption>Sailor Hat for Raspberry Pi v2.0.0.</figcaption>
</figure>

## Principales caractéristiques

- **Large plage de tension d'entrée** : alimentez votre Raspberry Pi en toute sécurité depuis un système 12 V ou 24 V, comme on en trouve couramment sur les véhicules et les bateaux. Le SH-RPi accepte une plage d'entrée de 10–32 V et dispose d'un filtrage supplémentaire et d'une protection contre les surtensions.
- **Forte capacité de courant de sortie** : 3 A de courant de sortie continu en 5 V (selon la température ambiante), avec des pointes jusqu'à 5 A. Avec un refroidissement actif, 4 A de courant de sortie continu sont possibles. Le SH-RPi peut alimenter les configurations Raspberry Pi les plus exigeantes.
- **Insensibilité aux micro-coupures** : les supercondensateurs intégrés font que les coupures de courant intermittentes passent inaperçues et maintiennent votre serveur en marche pendant les creux de tension et les micro-coupures.
- **Compatibilité avec le bus NMEA 2000** : alimentez votre Raspberry Pi directement depuis le bus NMEA 2000. Le SH-RPi intègre un circuit de limitation de courant qui borne le courant d'entrée maximal à environ 0,8 A. Les supercondensateurs fournissent la puissance de pointe nécessaire aux appareils gourmands comme les écrans et les disques SSD.
- **Arrêt sécurisé** : le Raspberry Pi est informé des coupures de courant et s'arrête en toute sécurité, alimenté par les supercondensateurs. Cela élimine le risque de corruption des cartes SD.
- **Horloge temps réel** : gardez votre Raspberry Pi à l'heure grâce à l'horloge temps réel intégrée et à sa pile de sauvegarde.
- **Temporisateur chien de garde (watchdog)** : redémarrez automatiquement votre Raspberry Pi après un plantage grâce au temporisateur chien de garde intégré.
- **Empilable** : ajoutez des fonctions en empilant d'autres HAT Raspberry Pi, par exemple GPS, NMEA 2000 ou NMEA 0183.

Sailor Hat for Raspberry Pi est du matériel libre, sous licence Creative Commons Attribution-ShareAlike 4.0 International.

## Se procurer le matériel

Vous pouvez acheter des cartes SH-RPi auprès de [Hat Labs Oy](https://shop.hatlabs.fi/products/sh-rpi). Tous les fichiers de conception sont également disponibles dans le [dépôt GitHub du matériel SH-RPi](https://github.com/hatlabs/sh-rpi-hardware/).
