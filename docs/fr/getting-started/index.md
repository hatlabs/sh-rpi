---
title: Prise en main
translated_from: 46b4add9db5ebdedd9ae7e3eba99744cd34a074c
---

# Prise en main

## Montage du matériel

Le SH-RPi est livré entièrement assemblé. Les étapes d'installation du matériel sont les suivantes :

1. Insérez le connecteur traversant 40 broches dans le SH-RPi par l'embase située sur la face inférieure, broches vers le haut.
2. Enfichez le SH-RPi sur le connecteur GPIO du Raspberry Pi (en utilisant si vous le souhaitez les entretoises hexagonales).
3. Fixez les conducteurs d'alimentation appropriés aux borniers débrochables. Les borniers débrochables sont livrés avec les vis serrées : veillez donc à les desserrer avant d'insérer les conducteurs.

<figure markdown="span">
![](shrpi_v2_hardware_assembly.jpg){ width="50%" }
<figcaption>Schéma de montage du matériel pour le SH-RPi v2.0.0.</figcaption>
</figure>

### Raccordement de l'alimentation

!!! warning
    Ne branchez jamais l'entrée d'alimentation sur le connecteur de sortie 5 V ! Cela endommagerait définitivement le Raspberry Pi et le SH-RPi.

Raccordez une source d'alimentation de 10–32 V au connecteur d'entrée d'alimentation du SH-RPi comme le montre la figure suivante.

<figure markdown="span">
![](shrpi_power_input.jpg){ width="50%" }
<figcaption>Branchez la source d'alimentation sur le connecteur entouré en vert.</figcaption>
</figure>

La source d'alimentation doit pouvoir fournir au moins 1,0 A à la tension de sortie indiquée.
Toutes choses égales par ailleurs, une alimentation à tension de sortie plus élevée, par exemple 24 V, donnera un fonctionnement légèrement plus efficace.
Sinon, les circuits 12 V des bateaux et des véhicules, ou les sources d'alimentation continue, conviennent bien.

## Installation du logiciel

Raspberry Pi OS a besoin d'un logiciel supplémentaire pour exécuter le service système qui déclenchera automatiquement l'arrêt du système en cas de coupure de l'alimentation.
Un script d'installation automatisé est fourni pour simplifier l'installation.

### Installation automatisée

Un script d'installation automatisé est fourni. Le script est testé sur un Raspberry Pi OS fraîchement flashé et peut échouer sur des systèmes fortement modifiés.
L'installation n'a pas été testée sur d'autres systèmes d'exploitation.

Pour exécuter le script d'installation automatisé, copiez et collez la commande suivante dans l'invite de commande du Raspberry Pi :

    curl -L \
        https://raw.githubusercontent.com/hatlabs/SH-RPi-daemon/main/install-online.sh \
        | sudo bash

La commande tient sur trois lignes et, lorsque vous la collez dans votre fenêtre de terminal, elle peut afficher des caractères de continuation de ligne. Ce n'est pas un problème. Appuyez sur « Entrée » pour exécuter la commande.

<figure markdown="span">
![](automated-installation-screenshot.png){ width="80%" }
<figcaption>La commande d'installation dans le terminal</figcaption>
</figure>

La commande récupère le script d'installation et l'exécute automatiquement.

Le script d'installation automatisé :

- active l'interface I2C, nécessaire pour que le SH-RPi communique avec le Raspberry Pi
- si la prise en charge de la carte d'extension d'interface NMEA 2000 est sélectionnée
  - active l'interface SPI et un overlay de device tree
  - définit l'interface réseau CAN
- si la prise en charge de la carte d'extension d'interface NMEA 0183 est sélectionnée
  - active l'interface SPI et un overlay de device tree
- active l'overlay de device tree de l'horloge temps réel
- si la prise en charge du MAX-M8Q GNSS HAT est sélectionnée
  - active l'interface UART série
  - désactive la console série
  - désactive le Bluetooth, car il entre en conflit avec l'interface UART série
- installe le logiciel de service du SH-RPi

## Boîtiers

Si vous prévoyez d'utiliser votre Raspberry Pi et votre SH-RPi à l'extérieur, dans un véhicule ou sur un bateau, ou dans des environnements très condensants, placez toujours l'appareil dans un boîtier étanche !
Hat Labs
propose une gamme de [boîtiers étanches](https://shop.hatlabs.fi/collections/accessories-enclosures).

Les boîtiers moyen et grand sont livrés avec une plaque de base perforée et des adaptateurs de fixation permettant de monter le Raspberry Pi, des HAT supplémentaires et d'autres composants.
Les autres boîtiers sont fournis avec des supports adhésifs imprimés en 3D.

### Montage du boîtier moyen

Le boîtier de taille moyenne est conçu pour accueillir le Raspberry Pi 4 Model B, le SH-RPi et plusieurs HAT en orientation verticale. L'installation est décrite ci-dessous.

#### Montage

Nous partons d'un boîtier nu, illustré dans la figure suivante.

<figure markdown="span">
![](01_bare_box.jpg){ width="50%" }
<figcaption>Le boîtier sans aucun composant.</figcaption>
</figure>

Installez d'abord tous les connecteurs dont vous avez besoin. Avant de les installer, il peut être nécessaire d'y souder des conducteurs. Les instructions de soudure des cosses à godet se trouvent dans cette vidéo YouTube :

<iframe width="560" height="315" src="https://www.youtube.com/embed/_GLeCt_u3U8" frameborder="0" allowfullscreen></iframe>

Il n'existe pas de véritable standard pour le brochage des connecteurs d'alimentation, mais nous conseillons de toujours raccorder GND à la broche 1 et +12 V / 24 V à la broche 2. La figure suivante montre le connecteur d'alimentation installé.

Insérez ensuite les connecteurs dans le boîtier. La figure suivante montre les connecteurs installés.

<figure markdown="span">
![](02_conx.jpg){ width="50%" }
<figcaption>Les connecteurs installés.</figcaption>
</figure>

Si le boîtier doit être utilisé dans un environnement condensant, par exemple sur un bateau ou en extérieur, obturez les trous restants avec des presse-étoupes bouchés. La figure suivante montre comment le bouchon obturateur doit être installé dans les presse-étoupes.

<figure markdown="span">
![](03_gland_plug.jpg){ width="50%" }
<figcaption>Le bouchon obturateur du presse-étoupe.</figcaption>
</figure>

Et la figure suivante montre les presse-étoupes installés. Le boîtier devient ainsi étanche.

<figure markdown="span">
![](04_conx_plugs.jpg){ width="50%" }
<figcaption>Les presse-étoupes installés.</figcaption>
</figure>

Nous prenons ensuite les pièces à installer dans le boîtier et nous les posons sur la plaque de base. La figure suivante montre les pièces que nous allons installer. Les pièces en plastique noir sont les supports verticaux qui maintiennent la pile de cartes en place.

<figure markdown="span">
![](05_ingredients.jpg){ width="50%" }
<figcaption>Les ingrédients.</figcaption>
</figure>

Les entretoises hexagonales de 6 mm sont d'abord vissées dans les supports verticaux. Serrez à la main uniquement !

La figure suivante montre les supports verticaux avec les entretoises installées.

<figure markdown="span">
![](06_vertical_mounts.jpg){ width="50%" }
<figcaption>Les supports verticaux avec les entretoises hexagonales.</figcaption>
</figure>

Vous pouvez ensuite fixer les supports au Raspberry Pi ou à la carte de base. Utilisez les vis M2,5 pour fixer la carte à côté des broches GPIO et les entretoises hexagonales M2,5 de 16 mm du côté opposé.

Nous installons ensuite le connecteur traversant sur le SH-RPi. Appuyez doucement et uniformément pour éviter de tordre les broches. La hauteur optimale du connecteur dépend de l'ordre des HAT. Si vous placez le SH-RPi directement au-dessus du Raspberry Pi, retirez l'entretoise en plastique du connecteur traversant. En revanche, cette entretoise est nécessaire si vous installez le SH-RPi au-dessus d'un autre HAT d'interface.

<figure markdown="span">
![](07_stack_thru_conx.jpg){ width="50%" }
<figcaption>Insertion du connecteur traversant.</figcaption>
</figure>

La figure suivante montre le SH-RPi monté sur la carte de base.

<figure markdown="span">
![](08_shrpi_mounted.jpg){ width="50%" }
<figcaption>Le SH-RPi monté sur la carte de base.</figcaption>
</figure>

#### Câblage de l'alimentation

Dans cette démonstration, nous installons également un CAN HAT supplémentaire pour la connectivité NMEA 2000. La figure suivante montre le CAN HAT monté sur le SH-RPi.

<figure markdown="span">
![](09_can_mounted.jpg){ width="50%" }
<figcaption>Le CAN HAT monté sur le SH-RPi.</figcaption>
</figure>

L'étape suivante consiste à installer la pile de cartes sur la plaque de base. Utilisez les vis M3 fournies pour fixer la pile en place. Ne serrez pas trop les vis.

<figure markdown="span">
![](10_on_base_mount.jpg){ width="50%" }
<figcaption>La pile de cartes installée sur la plaque de base.</figcaption>
</figure>

Dénudez ensuite les conducteurs des connecteurs. Si un connecteur d'alimentation séparé est utilisé, le conducteur rouge du NMEA 2000 doit être laissé non dénudé ou coupé entièrement. La figure suivante montre les conducteurs dénudés.

<figure markdown="span">
![](13_stripped_wires.jpg){ width="50%" }
<figcaption>Les conducteurs d'alimentation et CAN dénudés.</figcaption>
</figure>

L'étape suivante consiste à raccorder les conducteurs aux connecteurs de la carte. Le connecteur d'alimentation doit être raccordé au bornier débrochable comme le montre la figure suivante.

Lorsque vous enfichez le bornier débrochable, faites _très_ attention à le brancher sur le connecteur d'entrée du SH-RPi. Vous risquez d'endommager tous les appareils de la pile si vous le branchez sur le connecteur de sortie 5 V !

<figure markdown="span">
![](14_power_conx.jpg){ width="50%" }
<figcaption>Disposition du bornier débrochable du connecteur d'alimentation.</figcaption>
</figure>

Les conducteurs CAN doivent ensuite être raccordés au connecteur CAN0 du CAN HAT comme indiqué ci-dessous. Le noir est la masse, le blanc est CAN high (H) et le bleu est CAN low (L).

<figure markdown="span">
![](15_wires_plugged.jpg){ width="50%" }
<figcaption>Le câblage final.</figcaption>
</figure>

#### Alimentation depuis le NMEA 2000

En utilisation sur un bateau, vous pouvez également alimenter le système depuis le réseau NMEA 2000. Dans ce cas, tous les conducteurs du connecteur NMEA 2000 sont utilisés.

<figure markdown="span">
![](18_alt_can_wires.jpg){ width="50%" }
<figcaption>Lorsque l'appareil est alimenté par le réseau NMEA 2000, tous les conducteurs du connecteur NMEA 2000 sont utilisés.</figcaption>
</figure>

Les conducteurs noir et rouge sont raccordés au bornier débrochable d'alimentation, avec un court morceau de fil noir épissé sur la borne GND comme le montre la figure suivante. Ce court fil noir se raccorde à la borne GND du connecteur CAN0 du CAN HAT.

<figure markdown="span">
![](19_spliced_gnd.jpg){ width="50%" }
<figcaption>Raccordez le conducteur GND du NMEA 2000 à la fois au bornier débrochable d'alimentation et au connecteur CAN0 du CAN HAT.</figcaption>
</figure>

La figure suivante montre le câblage final lorsque l'appareil est alimenté par le réseau NMEA 2000.

<figure markdown="span">
![](20_can_power_wiring.jpg){ width="50%" }
<figcaption>Le câblage final lorsque l'appareil est alimenté par le réseau NMEA 2000.</figcaption>
</figure>

#### Fixation de la pile de cartes

Enfin, l'extrémité libre de la pile peut être fixée à la plaque de base avec de petits colliers de serrage ; c'est une solution simple et facile à mettre en œuvre. Les deux figures suivantes montrent l'installation des colliers de serrage.

<figure markdown="span">
![](11_tie_wraps.jpg){ width="50%" }
<figcaption>Les colliers de serrage mis en place.</figcaption>
</figure>

<figure markdown="span">
![](12_tie_wraps_2.jpg){ width="50%" }
<figcaption>L'installation des colliers de serrage terminée.</figcaption>
</figure>

#### Finalisation du montage

À ce stade, la plaque de base peut être insérée dans le boîtier.

<figure markdown="span">
![](16_in_place.jpg){ width="50%" }
<figcaption>La plaque de base en place.</figcaption>
</figure>

Fixez la plaque de base au boîtier avec les vis fournies.

<figure markdown="span">
![](17_screw_base_mount.jpg){ width="50%" }
<figcaption>Vissage de la plaque de base dans le boîtier.</figcaption>
</figure>

Le montage est enfin terminé. La figure ci-dessous montre l'ensemble clignotant joyeusement dans son boîtier.

<figure markdown="span">
![](21_all_done.jpg){ width="50%" }
<figcaption>L'ensemble terminé.</figcaption>
</figure>

Le boîtier peut être fixé à une paroi ou à une cloison par les trous d'angle visibles sur la figure ci-dessous.

<figure markdown="span">
![](22_mounting.jpg){ width="50%" }
<figcaption>Emplacement des trous de fixation.</figcaption>
</figure>


### Perçage des trous

Si vous utilisez un boîtier sans trous pré-percés, vous devrez percer les trous vous-même.

Au minimum, il vous faut un trou pour l'entrée d'alimentation et, pour tout boîtier métallique, un autre pour une antenne Wi-Fi ou un connecteur Ethernet filaire.

Planifiez l'emplacement des trous et des connecteurs en fonction du lieu d'installation prévu.
Si vous prévoyez une fixation murale du boîtier, orientez les connecteurs vers le bas afin de réduire au maximum les risques d'infiltration d'eau.

L'aluminium comme le polycarbonate sont relativement tendres et peuvent être percés avec un foret étagé (celui qui ressemble à un petit sapin de Noël en métal).
Lors du perçage du plastique, les forets à métaux ordinaires peuvent facilement mordre trop fort et fissurer la paroi.

<figure markdown="span">
![](step_drill_bit.jpg){ width="50%" }
<figcaption>Un exemple de forets étagés.</figcaption>
</figure>

Tailles de trou adaptées aux différents connecteurs :

- SMA (antenne Wi-Fi) : 6,5–7 mm ou 1/4"
- Presse-étoupe PG7 et connecteur de panneau M12 (NMEA 2000) : 12,5 mm ou 1/2"
- Connecteurs de panneau SP13 (connecteurs plastiques bleu et noir) : 13 mm.
- Presse-étoupe PG9 : 16 mm ou 5/8"
- Connecteur de panneau RJ45 : 21–22 mm
- Connecteur de panneau USB type A : 21–22 mm

### Fixation du Raspberry Pi

Les boîtiers fournis par Hat Labs comprennent des adaptateurs de fixation permettant de monter le Raspberry Pi.

### Soudure des connecteurs de panneau

Lorsque vous soudez les conducteurs internes aux connecteurs de panneau, utilisez toujours de la gaine thermorétractable sur chaque conducteur.
Pensez toujours à enfiler la gaine sur le conducteur _avant_ de souder…
En général, vous pouvez d'abord déposer de la soudure dans la cavité de la broche du connecteur, puis refondre la soudure et y insérer le conducteur.

### Raccordement d'un ventilateur

Il est recommandé de placer un ventilateur à l'intérieur du boîtier pour améliorer la circulation de l'air et le transfert de chaleur à travers les
parois du boîtier.
Un petit ventilateur de 40 mm peut être fixé dans le boîtier avec du ruban adhésif double face ou de la colle chaude.

Le ventilateur doit être raccordé au connecteur de sortie 5 V générique du SH-RPi :

<figure markdown="span">
![](shrpi_5v_output.jpg){ width="50%" }
<figcaption>Branchez le ventilateur sur le connecteur indiqué par la flèche rouge.</figcaption>
</figure>

### Finalisation de l'installation

Une fois les trous percés, le Raspberry Pi fixé, les connecteurs de panneau soudés et le ventilateur raccordé, refermez le boîtier pour protéger votre SH-RPi et votre Raspberry Pi des intempéries. Assurez-vous que tous les raccordements sont bien serrés et que le boîtier est hermétiquement fermé afin d'empêcher toute infiltration d'eau.

### Test du système

Une fois l'installation terminée, mettez sous tension votre ensemble Raspberry Pi et SH-RPi pour vérifier que tout fonctionne correctement. Vérifiez que le Raspberry Pi démarre, que le ventilateur tourne et que le SH-RPi communique avec le Raspberry Pi. Lorsque vous avez confirmé que tout fonctionne, vous pouvez passer à la configuration de vos logiciels et à l'intégration du système dans l'environnement prévu.

Félicitations ! Vous avez terminé le montage du matériel et la mise en boîtier de votre système SH-RPi et Raspberry Pi.
