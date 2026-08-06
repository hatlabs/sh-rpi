---
title: Logiciel
translated_from: fde8306627421de6b86970b1032ab7a63699a495
---

# Logiciel

## Introduction

Le Sailor Hat for Raspberry Pi nécessite un logiciel supplémentaire sur le système d'exploitation Raspberry Pi pour exploiter pleinement les fonctions de l'appareil. Un script d'installation est fourni pour installer automatiquement tous les logiciels requis sur une installation neuve de Raspberry Pi OS. Son utilisation est décrite dans la [section Prise en main](../getting-started/index.md). Vous n'aurez besoin des instructions d'installation manuelle que si vous préférez qu'aucun script automatisé ne modifie la configuration de votre système, ou si vous devez diagnostiquer votre installation.

Pour une installation manuelle, téléchargez le code sur [github.com/hatlabs/SH-RPi-daemon](https://github.com/hatlabs/SH-RPi-daemon). Les logiciels et les modifications de configuration nécessaires, ainsi que les détails du firmware, sont décrits ci-dessous.

### Activation de l'I2C et du SPI

Les interfaces I2C et SPI doivent être activées. Cela peut se faire soit en exécutant `raspi-config`, soit en modifiant directement `/boot/firmware/config.txt`.

Si vous utilisez `raspi-config`, passez directement à la fin de cette sous-section.

```bash
sudo nano /boot/firmware/config.txt
```

Repérez la ligne suivante :

```ini
#dtparam=i2c_arm=on
```

et modifiez-la en supprimant le marqueur de commentaire au début :

```ini
dtparam=i2c_arm=on
```

### Activation des nouvelles interfaces

Modifiez à nouveau `/boot/firmware/config.txt` :

    sudo nano /boot/firmware/config.txt

Descendez jusqu'à la section `[all]`.

Vous devez y ajouter trois nouvelles lignes. Activez d'abord l'horloge temps réel (RTC), si votre appareil en possède une :

    dtoverlay=i2c-rtc,pcf8563

Configurez ensuite le noyau pour qu'il signale la mise hors tension au Sailor Hat :

    dtoverlay=gpio-poweroff,gpiopin=2,input,active_low=17

Là encore, écrivez le fichier en appuyant sur Ctrl-O et quittez Nano en appuyant sur Ctrl-X.

## Démon du Raspberry Pi

Pour que Raspberry Pi OS connaisse l'état de l'alimentation, un démon (logiciel de service) doit être installé.

Si vous avez cloné le dépôt SH-RPi-daemon, vous pouvez installer le démon avec les commandes suivantes :

```bash
sudo apt install -y python3-pip
sudo pip3 install .
```

Vous devrez ensuite installer le fichier de définition du service et activer le service :

```bash
sudo install -o root shrpid.service /lib/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable shrpid
```

C'est tout ! Après un redémarrage, le démon démarre automatiquement.

*Remarque : le script d'installation automatisé décrit dans la [section Prise en main](../getting-started/index.md) effectue automatiquement toutes les étapes d'installation logicielle décrites ci-dessus.*

### Fichier de configuration du démon

Vous pouvez régler les paramètres du démon en créant et en modifiant le fichier de configuration `/etc/shrpid.conf`.
Le fichier utilise le format YAML.
Les options suivantes sont disponibles :

```yaml
# I2C bus number. You should never need to change this.
i2c-bus: 1
# I2C address of the SH-RPi. Only change this if you have custom firmware.
i2c-addr: 0x6d
# Maximum allowed blackout duration before shutdown.
blackout-time-limit: 3.0
# Input voltage limit for blackout detection.
blackout-voltage-limit: 9.0
# Socket file for the REST API. You should never need to change this.
socket: /var/run/shrpid.sock
# Group for the socket file. You should never need to change this.
socket-group: adm
# Command used to initiate a shutdown. Replace this with a custom script
# to customize the shutdown behavior.
poweroff: /sbin/poweroff
```

Vous pouvez créer un nouveau fichier de configuration en exécutant `nano /etc/shrpid.conf` et en y collant le contenu ci-dessus.
Commentez les lignes que vous ne souhaitez pas modifier.
Enregistrez le fichier en appuyant sur Ctrl-O et quittez Nano en appuyant sur Ctrl-X.

## Interface en ligne de commande

L'interface en ligne de commande est un script Python qui permet de piloter le Sailor Hat for Raspberry Pi depuis la ligne de commande du Raspberry Pi. Elle est installée par le script d'installation décrit dans la [section Prise en main](../getting-started/index.md).

Le script `shrpi` peut être exécuté avec l'option `--help` pour obtenir des explications sur les différentes commandes. Les principaux cas d'usage sont décrits ci-dessous.

```bash
shrpi print
```

Affiche l'état et la configuration actuels du Sailor Hat for Raspberry Pi.

```bash
shrpi set <option> <value>
```

Définit différentes valeurs de configuration. Par exemple,

```bash
shrpi set led 50
```

règle la luminosité des LED à 50 %.

```bash
shrpi sleep 3600
```

Éteint le Raspberry Pi et le rallume au bout de 3600 secondes (1 heure).

```bash
shrpi sleep 15:00
```

Éteint le Raspberry Pi et le rallume à 15:00 (3 h de l'après-midi).

```bash
shrpi sleep 15:00:00
```

## API REST

`shrpid` implémente une API REST qui permet d'interroger l'état et la configuration actuels du Sailor Hat for Raspberry Pi et de définir des valeurs de configuration.
L'API est disponible sur un socket fichier à l'emplacement `/var/run/shrpid.sock`. Un exemple de requête avec `curl` est présenté ci-dessous :

    curl --unix-socket /var/run/shrpid.sock http://localhost/state

Pour plus de détails sur les commandes disponibles, consultez le [code source de SH-RPi-daemon](https://github.com/hatlabs/SH-RPi-daemon/).

## Firmware

Le code exécuté par le microcontrôleur ATtiny1616 embarqué s'appelle le firmware du SH-RPi.

Le dépôt du firmware se trouve à l'adresse [https://github.com/hatlabs/SH-RPi-firmware](https://github.com/hatlabs/SH-RPi-firmware).

Les sous-sections suivantes décrivent comment mettre à jour le firmware pour obtenir de nouvelles fonctions, ou si vous souhaitez le modifier vous-même.

### Mise à jour du firmware

Il est possible de mettre à jour le firmware du SH-RPi avec le Raspberry Pi lui-même.
Cela nécessite quelques cavaliers et un peu de configuration logicielle.

Le flashage s'effectue via l'interface UPDI de l'ATtiny à l'aide d'[`avrdude`](https://github.com/SpenceKonde/AVR-Guidance/blob/master/UPDI/jtag2updi.md).

#### Configuration matérielle

Placez des cavaliers sur toutes les broches du connecteur PROG comme indiqué en rouge sur la figure ci-dessous. Cela raccorde au Raspberry Pi le circuit de programmation du microcontrôleur et l'interface série de débogage. De plus, la sortie 5 V du contrôleur abaisseur (buck) est forcée à l'état actif, afin que le Raspberry Pi ne se coupe pas lui-même au démarrage du flashage.

<figure markdown="span">
![](SH-RPi-2.0.0-prog-conx.jpg){ width="50%" }
<figcaption>Placez les cavaliers rouges pour activer l'auto-flashage.</figcaption>
</figure>

Attention ! Pour un fonctionnement correct par la suite, il est indispensable de retirer au moins le troisième cavalier du connecteur PROG. Sinon, le Raspberry Pi ne pourra pas se couper lui-même.

#### Modifications de la configuration du Raspberry Pi

L'étape suivante consiste à activer les UART série du Raspberry Pi. Ils servent à la fois d'interface UPDI et d'interface série de débogage.
Sur les Pi équipés du Bluetooth, l'UART est normalement réservé au circuit Bluetooth embarqué. Désactivons donc le Bluetooth.

Ajoutez les lignes suivantes à la fin de `/boot/firmware/config.txt` :

```ini
dtoverlay=disable-bt
dtoverlay=uart5
```

La première désactive le modem Bluetooth. La seconde active l'interface UART5 sur les GPIO 12 et 13, aux broches 32 et 33. C'est l'interface série utilisée par le firmware du SH-RPi pour le débogage.

Nous devons également désactiver le service système qui initialise le modem Bluetooth :

```bash
sudo systemctl disable hciuart
```

Empêchez enfin la console série du système de s'attacher au port série. Supprimez la partie `console=serial0,115200` au début de `/boot/cmdline.txt`.

Redémarrez pour que les modifications prennent effet.

#### Installation du logiciel de flashage

Grâce au framework [PlatformIO](https://platformio.org/), tous les outils nécessaires peuvent être téléchargés et installés automatiquement. Il nous faut simplement récupérer
d'abord le code source du firmware. Installons le système de gestion de versions `git` et clonons le dépôt du firmware :

```bash
sudo apt update
sudo apt -y install git
git clone git@github.com:hatlabs/SH-RPi-firmware.git
```

Nous pouvons maintenant installer le framework PlatformIO :

```bash
sudo pip3 install -U platformio
```

Modifiez le fichier `platformio.ini` et remplacez `upload_port` par `/dev/ttyAMA0` :

```ini
[env]
...
upload_port = /dev/ttyAMA0
monitor_port = /dev/ttyAMA1
```

#### Flashage

Nous pouvons enfin compiler et téléverser le firmware. Au premier lancement, cette commande télécharge et installe les outils nécessaires. Cela peut prendre un certain temps.

```bash
cd SH-RPi-firmware
pio run -t upload
```

Les LED d'état blanches s'éteignent pendant le flashage. Au bout de quelques secondes, elles se rallument et le flashage est terminé. Retirez alors les cavaliers du connecteur PROG.

#### Restauration du Bluetooth

Si vous souhaitez continuer à utiliser le Bluetooth, pensez à annuler les étapes précédentes. Pour cela, vous devez revenir sur les modifications apportées à `/boot/firmware/config.txt` et `/boot/cmdline.txt`, puis réactiver le service `hciuart` :

1. Supprimez les lignes suivantes de `/boot/firmware/config.txt` :

```ini
dtoverlay=disable-bt
dtoverlay=uart5
```

2. Rajoutez `console=serial0,115200` au début de `/boot/cmdline.txt`.

3. Réactivez le service `hciuart` en exécutant :

```bash
sudo systemctl enable hciuart
```

4. Redémarrez votre Raspberry Pi pour que les modifications prennent effet.

C'est terminé ! Vous avez mis à jour le firmware de votre Sailor Hat for Raspberry Pi et rétabli le Bluetooth si vous le souhaitiez.
