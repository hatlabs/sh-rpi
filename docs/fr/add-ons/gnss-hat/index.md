---
title: Waveshare MAX-M8Q GNSS HAT
translated_from: 94d29c50a654fad026d00f597a18d7b0d3625d85
---

# GNSS HAT

Le Waveshare MAX-M8Q GNSS HAT offre au Raspberry Pi un récepteur GNSS de qualité, fondé sur le module U-blox MAX-M8Q. Le MAX-M8Q embarque un récepteur GNSS multiconstellation d'une sensibilité élevée de −167 dBm. Il prend en charge GPS, GLONASS, BeiDou et Galileo, et peut recevoir simultanément trois de ces systèmes. Il gère en outre plusieurs systèmes d'augmentation tels que SBAS, QZSS, IMES et D-GPS.

Cette page décrit l'installation et la configuration du GNSS HAT lorsqu'il est utilisé avec le Sailor Hat for Raspberry Pi. Pour plus de détails sur le GNSS HAT, consultez la [page wiki de Waveshare](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT).

## Raccordement du HAT

Insérez le connecteur traversant dans le connecteur GPIO du GNSS HAT. Enfichez ensuite le HAT sur le connecteur GPIO 40 broches du Raspberry Pi. Le GNSS HAT peut être empilé au-dessus d'autres HAT.

### Utiliser le GNSS HAT avec le RS485 HAT

Le MAX-M8Q GNSS HAT dispose d'une fonction TIMEPULSE (PPS) qui fournit au Raspberry Pi une référence
temporelle GNSS très précise. Malheureusement, cette fonction d'impulsion temporelle est reliée à une broche GPIO également utilisée par le RS485 HAT. Si ces deux appareils sont utilisés ensemble, la broche GPIO en conflit doit être physiquement déconnectée. Le plus simple
est de couper la broche correspondante sur le connecteur traversant. La figure ci-dessous met en évidence la broche à couper.

<figure markdown="span">
![](pps_pin.jpg){ width="50%" }
<figcaption>La broche à couper lorsque le GNSS HAT est utilisé avec le RS485 HAT.</figcaption>
</figure>

Pour être sûr de couper la bonne broche, insérez partiellement le connecteur traversant dans le connecteur GPIO du GNSS HAT. Coupez ensuite le haut de la broche mise en évidence sur la figure ci-dessus. Retirez le connecteur traversant, puis coupez la broche à la base du connecteur.

## Configuration logicielle

L'installation logicielle du GNSS HAT sera automatisée par le script d'installation du Sailor Hat.
Pour l'instant, vous devez configurer le GNSS HAT à la main en suivant les instructions de la [page wiki du Waveshare MAX-M8Q GNSS HAT](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT). Les étapes situées au-delà de la configuration de `gpsd` ne sont pas nécessaires.

Selon la configuration, le GNSS HAT expose un périphérique série `/dev/ttyAMA0` ou `/dev/ttyS0` pour les données NMEA 0183. OpenPlotter dispose d'un outil pratique de configuration des périphériques série, qui permet de paramétrer le GNSS HAT et de le connecter à Signal K.

## Batterie de sauvegarde

Le GNSS HAT dispose d'un connecteur de batterie de sauvegarde. La batterie de sauvegarde conserve les éphémérides lorsque le Raspberry Pi est hors tension. Elle n'est pas obligatoire, mais elle accélère l'obtention d'un point GNSS après la mise sous tension du Raspberry Pi.

La batterie de sauvegarde est de type ML1220. Il s'agit d'un accumulateur au lithium **rechargeable** ; il ne doit en **aucun cas** être remplacé par une batterie **non rechargeable**. Cela entraînerait un risque d'explosion et d'incendie ! Les utilisateurs avertis peuvent, à leurs propres risques, retirer la résistance R3 pour désactiver le circuit de charge et utiliser une pile CR1220 non rechargeable. Les schémas et le dessin du circuit imprimé sont disponibles sur la [page wiki de Waveshare](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT).
