---
title: Waveshare 2-Channel Isolated RS485 HAT
translated_from: 7f4b38c33361ca8118a3f68c596e0fb1633d6f5e
---

# RS485 HAT

Le Waveshare 2-Channel Isolated RS485 HAT offre deux interfaces RS-485 isolées au Raspberry Pi. Il permet de réaliser une interface NMEA 0183 bidirectionnelle ou deux interfaces RS-485 bidirectionnelles génériques. Utilisé comme interface NMEA 0183, un canal sert à la réception des données et l'autre à leur émission.

Le HAT intègre un transformateur DC/DC isolé et ne nécessite aucune alimentation externe.

Le RS485 HAT peut être utilisé en même temps que le SH-RPi et le CAN HAT.

Cette page décrit l'installation et la configuration du RS485 HAT lorsqu'il est utilisé avec le Sailor Hat for Raspberry Pi. Pour plus de détails sur le RS485 HAT, consultez la [page wiki de Waveshare](https://www.waveshare.com/wiki/2-CH_RS485_HAT).


## Configuration des cavaliers

!!! warning
    Vérifiez la position des cavaliers avant de raccorder le HAT !

Le RS485 HAT possède deux cavaliers pour les résistances de terminaison embarquées du bus RS-485. NMEA 0183 n'utilise pas de terminaison, et les cavaliers doivent être placés en position `OFF` !

## Raccordement du HAT

Insérez avec précaution le connecteur traversant dans le connecteur GPIO du RS-485 HAT. Enfichez ensuite
le HAT sur le connecteur GPIO 40 broches du Raspberry Pi ou du Sailor Hat. Le bord du connecteur doit être fixé à la carte inférieure à l'aide des entretoises hexagonales.

Lorsque le HAT est utilisé comme interface NMEA 0183, le canal 1 sert à la réception des données (RX) et le canal 2 à leur émission (TX). Les fils TX A et B de l'appareil émetteur (ou TX+ et TX-) doivent être raccordés aux bornes A et B du canal 1 du HAT, tandis que les fils RX A et B de l'appareil récepteur (ou RX+ et RX-) doivent être raccordés aux bornes A et B du canal 2 du HAT. La figure ci-dessous montre le câblage de l'interface NMEA 0183.

<figure markdown="span">
![](nmea0183_wiring.jpg){ width="50%" }
<figcaption>Câblage de l'interface NMEA 0183. Les couleurs des fils peuvent varier selon l'appareil.</figcaption>
</figure>

## Configuration logicielle

Le script d'installation du Sailor Hat permet de configurer et d'activer l'interface RS-485. L'interface est fournie par deux périphériques série : `/dev/ttySC0` et `/dev/ttySC1`. Parmi eux, `/dev/ttySC0` sert à la réception des données et `/dev/ttySC1` à leur émission. Ils se configurent dans les connexions de données de Signal K ou dans toute autre application NMEA 0183 de votre choix.

Si vous préférez procéder à une installation manuelle, consultez la [page wiki de Waveshare](https://www.waveshare.com/wiki/2-CH_RS485_HAT) pour les détails.
