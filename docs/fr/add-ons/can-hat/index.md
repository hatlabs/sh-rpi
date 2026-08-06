---
title: Waveshare 2-Channel Isolated CAN HAT
translated_from: 91112523c75ae01ec3e4cdcdabdcff0fe5fdbd78
---

# CAN HAT

Le Waveshare 2-Channel Isolated CAN HAT offre deux interfaces CAN isolées au Raspberry Pi. Le CAN HAT repose sur le contrôleur CAN MCP2515 et sur des émetteurs-récepteurs CAN SI65HVD230/SN65HVD230. Ce HAT permet de réaliser une seule interface NMEA 2000 conforme, ou deux autres interfaces CAN. Lorsqu'il sert d'interface NMEA 2000, le second canal doit rester inutilisé, en raison des exigences d'isolement de NMEA 2000.

Le HAT intègre un transformateur DC/DC isolé et ne nécessite aucune alimentation externe.

Cette page décrit l'installation et la configuration du CAN HAT lorsqu'il est utilisé avec le Sailor Hat for Raspberry Pi. Pour plus de détails sur le CAN HAT, consultez la [page wiki de Waveshare](https://www.waveshare.com/wiki/2-CH_CAN_HAT).

## Configuration des cavaliers

!!! warning
    Vérifiez la position des cavaliers avant de raccorder le HAT !

Le CAN HAT possède deux cavaliers pour les résistances de terminaison embarquées du bus CAN. En fonctionnement normal, ils doivent être placés en position `OFF` !

Le CAN HAT possède en outre un cavalier de sélection de tension. Il doit être placé sur `3V3` lors de l'utilisation avec un Raspberry Pi, faute de quoi le Raspberry Pi risque d'être endommagé.

## Raccordement du HAT

Insérez avec précaution le connecteur traversant dans le connecteur GPIO du CAN HAT. Enfichez ensuite
le HAT sur le connecteur GPIO 40 broches du Raspberry Pi ou du Sailor Hat. Le bord du connecteur doit être fixé à la carte inférieure à l'aide des entretoises hexagonales.

Lorsque le HAT est utilisé comme interface NMEA 2000, seule l'interface CAN0 doit être utilisée. L'interface CAN1 doit rester non connectée. La figure ci-dessous montre le câblage de l'interface NMEA 2000.

<figure markdown="span">
![](can_hat_wiring.jpg){ width="50%" }
<figcaption>Câblage de l'interface NMEA 2000. Le fil rouge reste non connecté.</figcaption>
</figure>

## Configuration logicielle

Le script d'installation du Sailor Hat permet de configurer et d'activer l'interface CAN. Si vous préférez procéder à une installation manuelle, consultez la [page wiki de Waveshare](https://www.waveshare.com/wiki/2-CH_CAN_HAT) pour les détails.

## Alimenter le SH-RPi par l'interface NMEA 2000

Il est possible d'alimenter le Raspberry Pi par l'interface NMEA 2000. Pour cela, les fils d'alimentation et de masse du NMEA 2000 doivent être raccordés à l'entrée d'alimentation du SH-RPi, tandis que les fils H et L vont au connecteur CAN0 du CAN HAT. Une liaison de masse doit en outre être établie entre le SH-RPi et le CAN HAT, comme le montre la figure ci-dessous.

<figure markdown="span">
![](can_hat_n2k_power.jpg){ width="50%" }
<figcaption>Câblage permettant d'alimenter le SH-RPi par l'interface NMEA 2000.</figcaption>
</figure>
