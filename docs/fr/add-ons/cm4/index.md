---
title: Compute Module 4
translated_from: 2769961d8eba6a0a776d8bf6566816716c7c9cac
---

# Compute Module 4

Le [Compute Module 4](https://www.raspberrypi.org/products/compute-module-4/) est un module informatique de petite taille qui s'enfiche sur une carte porteuse. Offrant des performances CPU identiques à celles du Raspberry Pi 4B, le CM4 est une solution puissante, souple et économique pour les applications embarquées. Pour construire des ordinateurs embarqués, le CM4 présente plusieurs avantages sur le Raspberry Pi 4B :

- Mémoire flash eMMC intégrée : selon le modèle, les cartes CM4 disposent de jusqu'à 32 Go de mémoire flash eMMC. Cette mémoire est à la fois plus fiable et plus rapide que la carte SD utilisée dans le Raspberry Pi 4B.
- Possibilité d'une antenne WiFi externe : le CM4 dispose d'un connecteur dédié à une antenne WiFi externe. C'est utile lorsque le niveau de signal de l'antenne WiFi interne est insuffisant.
- Connecteur M.2 : de nombreuses cartes de base possèdent un connecteur M.2 permettant de brancher un SSD M.2 ou un module WiFi M.2.
- Consommation plus faible : lors de tests informels, nous avons constaté qu'un CM4 associé à une carte de base consomme plus de 20 % de puissance en moins qu'un Raspberry Pi 4B.

En contrepartie, la plupart des cartes de base CM4 n'intègrent pas de concentrateur USB 3.0, ce qui limite les ports USB aux débits USB 2.0. De plus, flasher la mémoire eMMC est un peu plus compliqué que flasher une carte SD. La procédure est décrite ci-dessous.

## Flasher la mémoire eMMC du CM4

Vous devez d'abord télécharger une image système adaptée. Nous prenons pour exemple l'image [OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/downloading.html) Headless, mais la procédure est la même pour les autres images. **Remarque :** utilisez toujours une image 64 bits ! Certains composants logiciels rencontrent des problèmes sur un système 32 bits (InfluxDB en particulier).

La mémoire eMMC peut être flashée avec la même image système que le Raspberry Pi 4B. Le flashage comporte deux étapes supplémentaires. D'une part, le CM4 doit être basculé dans un mode BOOT particulier, qui *empêche* en réalité l'appareil de démarrer et permet de flasher l'eMMC. D'autre part, sur l'ordinateur utilisé pour le flashage, un petit utilitaire `rpiboot` doit être installé et exécuté pour pouvoir monter la mémoire eMMC sur votre ordinateur. Une fois ces étapes accomplies, le flashage est identique à celui du Raspberry Pi 4B.

Sous Windows, `rpiboot` est disponible sous forme d'exécutable précompilé, mais sous Linux et MacOS vous devez le compiler depuis les sources. La procédure propre à chaque plateforme est décrite dans les sections ci-dessous.

Remarques sur la procédure d'installation :

1. Pour flasher l'eMMC, la carte de base doit être basculée en mode BOOT. Sur les cartes Waveshare CM4-IO-BASE, le petit interrupteur BOOT situé à côté du connecteur HDMI0 doit être mis en position ON.
2. La carte de base doit être reliée à une source d'alimentation externe pendant le flashage. Utilisez la carte SH-RPi pour cela !

### Windows

1. Pour préparer le mode de flashage sur l'ordinateur hôte, suivez les instructions de la [documentation Raspberry Pi](https://www.raspberrypi.com/documentation/computers/compute-module.html#flashing-the-compute-module-emmc).
2. Suivez les [instructions d'installation d'OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html).
3. **Remarque :** ne démarrez pas encore le système ! Quelques réglages doivent d'abord être ajustés, comme décrit dans la section Configuration du CM4 ci-dessous.
4. Après avoir modifié les réglages, remettez l'interrupteur BOOT en position OFF et redémarrez le système. Vous pouvez ensuite poursuivre avec les instructions d'OpenPlotter.

### Mac

Sur un Mac, vous devez compiler l'utilitaire `rpiboot` depuis les sources.

1. Pour compiler l'utilitaire, [Homebrew](https://brew.sh/) doit être installé. Commencez par cela.
2. Suivez ensuite les [étapes décrites dans le dépôt `usbboot`](https://github.com/raspberrypi/usbboot#macos). Au moment d'exécuter `sudo ./rpiboot`, la carte de base CM4 doit être reliée à votre ordinateur et alimentée par le SH-RPi. Si vous obtenez un message d'erreur, vérifiez le câble USB et l'interrupteur BOOT de la carte de base.
3. Suivez les [instructions d'installation d'OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html). **Remarque :** ne démarrez pas encore le système ! Quelques réglages doivent d'abord être ajustés, comme décrit dans la section Configuration du CM4 ci-dessous.
4. Après avoir modifié les réglages, remettez l'interrupteur BOOT en position OFF et redémarrez le système. Vous pouvez ensuite poursuivre avec les instructions d'OpenPlotter.

### Linux

Comme sur un Mac, vous devez compiler l'utilitaire `rpiboot` depuis les sources sous Linux.

1. Pour compiler l'utilitaire, [Homebrew](https://brew.sh/) doit être installé. Commencez par cela.
2. Suivez ensuite les [étapes décrites dans le dépôt `usbboot`](https://github.com/raspberrypi/usbboot#linux--cygwin--wsl). Au moment d'exécuter `sudo ./rpiboot`, la carte de base CM4 doit être reliée à votre ordinateur et alimentée par le SH-RPi. Si vous obtenez un message d'erreur, vérifiez le câble USB et l'interrupteur BOOT de la carte de base.
3. Suivez les [instructions d'installation d'OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html). **Remarque :** ne démarrez pas encore le système ! Quelques réglages doivent d'abord être ajustés, comme décrit dans la section Configuration du CM4 ci-dessous.
4. Après avoir modifié les réglages, remettez l'interrupteur BOOT en position OFF et redémarrez le système. Vous pouvez ensuite poursuivre avec les instructions d'OpenPlotter.

## Configuration du CM4

### Activer les ports USB

Avant de démarrer le système pour la première fois, quelques modifications de la configuration sont nécessaires. Par défaut, les ports USB sont désactivés sur le CM4. Cela peut évidemment poser un vrai problème si vous souhaitez utiliser le système avec un clavier et une souris. Pour activer les ports USB, vous devez modifier le fichier `config.txt` sur la mémoire eMMC. La partition Boot devrait déjà être montée sur votre ordinateur comme un lecteur USB. Ouvrez ce lecteur et modifiez le fichier `config.txt`. Ajoutez la ligne suivante à la fin du fichier :

    dtoverlay=dwc2,dr_mode=host

Enregistrez le fichier et fermez-le.

### Activer l'antenne WiFi externe

Si vous disposez d'une antenne WiFi externe, vous devez modifier à nouveau le fichier `config.txt`. Ajoutez la ligne suivante à la fin du fichier :

    dtparam=ant2

Les autres valeurs possibles sont `ant1` pour l'antenne sur circuit imprimé et `noant` pour désactiver les deux antennes. La valeur par défaut est `ant1`.
