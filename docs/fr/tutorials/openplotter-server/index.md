---
title: Installation du serveur OpenPlotter
translated_from: 69cd214b5911c56a3544b6ab748a0ad149ba04e9
---

!!! warning
    Cette section n'a pas encore été mise à jour pour les changements du matériel v2.

<div style="-moz-filter: opacity(30%); -webkit-filter: opacity(30%); filter: opacity(30%);">

## Introduction

Dans ce tutoriel, nous construisons un serveur OpenPlotter avec [Sailor Hat for Raspberry Pi](https://docs.hatlabs.fi/sh-rpi/) ([lien d'achat](https://hatlabs.fi/product/sh-rpi-enclosure-kit/)) et le logiciel OpenPlotter.
Le serveur est compact et étanche, et il s'alimente facilement sur le réseau 12/24 V du bateau.
Il s'intègre également sans peine à l'électronique de bord existante.

Le logiciel fourni enregistre tout le trafic NMEA 2000 essentiel à bord et permet de visualiser le comportement des différentes valeurs en temps réel comme dans le passé, à l'aide de tableaux d'instruments intégrés et de tableaux de bord Grafana.
Le serveur peut en outre recevoir et traiter des informations issues d'autres sources, par exemple des [capteurs SH-ESP32](https://docs.hatlabs.fi/sh-esp32/) ou de divers services Internet.

Quelques exemples de visualisations :

<figure markdown="span">
![](assets/screenshots/001_examples.jpg){ width="75%" }
<figcaption>Exemples de visualisations.</figcaption>
</figure>

## Pièces nécessaires

Pour réaliser ce tutoriel, vous avez besoin des pièces suivantes :

- [Kit boîtier SH-RPi](https://hatlabs.fi/product/sh-rpi-enclosure-kit/)

  Le SH-RPi est l'ingrédient secret qui apporte au Raspberry Pi les interfaces matérielles exigées par les systèmes du bateau. La carte comprend une alimentation 12/24 V intégrée et protégée, avec arrêt sécurisé, ainsi qu'une interface CAN isolée et compatible NMEA 2000.

  Dans ce tutoriel, nous utilisons le boîtier plastique et alimentons le Pi par un connecteur de panneau NMEA 2000. Un connecteur de panneau USB type A est ajouté pour faciliter les branchements au besoin, et un ventilateur améliore la dissipation thermique. Adaptez librement votre propre configuration.

  Nous utilisons également un adaptateur WiFi USB supplémentaire, car cela simplifie l'installation (cette interface réseau de plus peut aussi rendre service à bord). Si vous ne voulez pas de l'adaptateur WiFi USB, vous pouvez brancher le Pi sur un Ethernet filaire pour un résultat équivalent.

- Un Raspberry Pi 4B

  Un modèle avec 4 Go de mémoire suffit. Amazon pratique souvent des prix imbattables, ou vous pouvez consulter la liste des distributeurs sur le site de Raspberry Pi :

    * [amazon.com](https://www.amazon.com/Raspberry-Model-2019-Quad-Bluetooth/dp/B07TC2BK1X/)
    * [amazon.de](https://www.amazon.de/-/en/Raspberry-ARM-Cortex-A72-WLAN-ac-Bluetooth-Micro-HDMI-Single/dp/B07TC2BK1X/)
    * [amazon.co.uk](https://www.amazon.co.uk/Raspberry-Pi-ARM-Cortex-A72-Bluetooth-Micro-HDMI/dp/B07TC2BK1X/)
    * [Liste des distributeurs Raspberry Pi](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/?variant=raspberry-pi-4-model-b-4gb)

- Carte mémoire MicroSD

  La carte MicroSD héberge le système d'exploitation et les fichiers de données du Raspberry Pi. Les cartes Samsung Evo Plus m'ont donné de bons résultats. Les cartes mémoire coûtent peu et les grandes capacités sont plus fiables sur Raspberry Pi, alors prenez-en une d'au moins 64 Go :

  * [amazon.com](https://www.amazon.com/Samsung-MicroSDXC-Memory-Adapter-MB-MC64GA/dp/B06XFWPXYD/)
  * [amazon.de](https://www.amazon.de/-/en/Samsung-Flash-Memory-MicroSDXC-Class/dp/B08BKCB4JW/)
  * [amazon.co.uk](https://www.amazon.co.uk/Samsung-MicroSDXC-Class-UHS-I-Memory/dp/B08BKCB4JW/)

- Ruban adhésif double face ou colle chaude

  Un court morceau de ruban double face ou une noisette de colle chaude sert à fixer le ventilateur.

- Gaine thermorétractable, 3 mm de diamètre intérieur

  Sans être indispensable, de la gaine thermorétractable de 3 mm de diamètre intérieur est utile pour sécuriser les fils soudés du connecteur de panneau.

- [Embase femelle NMEA 2000](https://hatlabs.fi/product/nmea-2000-cable-plug/)

  Si vous réalisez la première installation à la maison, une fiche NMEA 2000 micro supplémentaire est pratique pour amener la tension d'alimentation à l'appareil.

## Assemblage du matériel

### Perçage des trous pour les connecteurs

Comme toujours lorsqu'on perce un boîtier en parfait état : préparez très soigneusement. Les connecteurs de panneau occupent étonnamment de place, et un trou ne se rebouche pas facilement, encore moins ne se déplace.

Personnellement, je préfère relever les cotes du boîtier et créer un gabarit de perçage dans un logiciel de dessin vectoriel. Un dessin aide à visualiser les dimensions maximales qu'exigent le connecteur et son écrou.

Si vous ne savez pas quel logiciel utiliser, [Inkscape](https://inkscape.org) est un bon outil polyvalent. Si vous êtes plus porté sur la technique, un logiciel de CAO comme [LibreCAD](https://librecad.org) peut convenir aussi.

Je voulais trois trous sur le petit côté du boîtier plastique. Voici le gabarit que j'ai réalisé :

<figure markdown="span">
![](assets/plastic-enclosure-end-template.svg){ width="50%" }
<figcaption><a href="assets/plastic-enclosure-end-template.svg">Exemple de gabarit de perçage.</a></figcaption>
</figure>

Le [gabarit](assets/plastic-enclosure-end-template.svg) est un fichier SVG, donc vectoriel : vous pouvez l'enregistrer et le modifier à votre convenance.
Si vous ne savez pas quel logiciel employer, essayez par exemple [Inkscape](https://inkscape.org), mentionné plus haut. J'utilise pour ma part Affinity Designer, un logiciel de conception commercial et peu coûteux disponible pour MacOS.

Si l'ouverture du SVG pose problème, le gabarit existe aussi en [version PDF](assets/plastic-enclosure-end-template.pdf).

Une fois le gabarit terminé, marquez le point central sur le boîtier et scotchez le gabarit de sorte que les points centraux coïncident.

<figure markdown="span">
![](assets/photos/01_drill-template.jpg){ width="50%" }
<figcaption>Gabarit de perçage sur le boîtier.</figcaption>
</figure>


Pour percer avec précision, il est utile de marquer le centre des trous au pointeau (un clou pointu et un léger coup de marteau font aussi l'affaire).

Percez des avant-trous avec un foret fin (3 mm environ). Utilisez ensuite un foret étagé pour les trous définitifs. Prenez votre temps et travaillez à vitesse lente. Terminez les petits trous de cotes inhabituelles, comme celui de 6,5 mm, avec un foret à métaux du diamètre correspondant.

Le perçage du plastique laisse beaucoup de bavures autour des trous. Elles s'enlèvent avec un couteau bien affûté.

Enfin, sur le boîtier plastique, les entretoises moulées peuvent gêner les trous que vous avez percés. J'ai dû en retirer une. J'ai utilisé un outil Dremel, mais une pince robuste devrait aussi convenir.

Voici le résultat dans mon cas.

<figure markdown="span">
![](assets/photos/02_drilled_holes.jpg){ width="50%" }
<figcaption>Trous percés.</figcaption>
</figure>


### Raccordement des fils au connecteur de panneau NMEA 2000

Nous allons maintenant souder les faisceaux JST XH au connecteur de panneau NMEA 2000. La même approche vaut pour souder les connecteurs d'alimentation SP13 si vous préférez en utiliser un.
Commençons par étamer les coupelles à souder du connecteur.

<figure markdown="span">
![](assets/photos/021_soldered_cups.jpg){ width="50%" }
<figcaption>Coupelles étamées.</figcaption>
</figure>


Nous voulons alimenter à la fois la carte elle-même et l'interface CAN par le connecteur NMEA 2000. Il y a plus d'une façon de procéder, mais retenons la méthode évidente et raccordons les deux faisceaux au connecteur de panneau NMEA.

Dénudez une courte longueur des fils rouge et noir et torsadez-les ensemble.

<figure markdown="span">
![](assets/photos/022_spliced_wires.jpg){ width="50%" }
<figcaption>Fils torsadés ensemble.</figcaption>
</figure>


Il est recommandé d'utiliser de la gaine thermorétractable pour isoler les broches du connecteur et soutenir mécaniquement les soudures. Coupez de courts morceaux de gaine et enfilez-les sur les fils. (Devinez qui a oublié cette étape _encore une fois_ en préparant les photos de ce tutoriel.)

Soudez les fils sur le connecteur, aussi bien les fils de signal individuels que les fils d'alimentation torsadés.

Le schéma ci-dessous donne le brochage correct. Oui, c'est un connecteur mâle, mais comme nous le regardons du mauvais côté, nous utilisons le schéma du genre opposé. (Oui, c'est un peu déroutant.)

<figure markdown="span">
![](assets/nmea_2000_female_pinout.png){ width="50%" }
<figcaption>Brochage de l'embase femelle NMEA 2000 micro C.</figcaption>
</figure>


Commencez par souder la broche centrale. C'est plus facile maintenant, tant que les autres fils ne pendent pas encore autour. La couleur normalisée du fil CAN_L est le bleu, mais notre faisceau utilise du jaune.

<figure markdown="span">
![](assets/photos/023_soldered_L.jpg){ width="50%" }
<figcaption>Broche centrale soudée.</figcaption>
</figure>


Soudez ensuite les trois autres fils. Le blindage reste non raccordé.

Voici à quoi votre connecteur doit ressembler à ce stade :

<figure markdown="span">
![](assets/photos/024_all_soldered.jpg){ width="50%" }
<figcaption>Tout est soudé.</figcaption>
</figure>


Je suppose hardiment que vous avez pensé à enfiler les morceaux de gaine avant de souder les fils. Il est temps de les faire glisser sur vos soudures et de les rétreindre au pistolet à air chaud (ou à la flamme d'un briquet). Le résultat doit ressembler à peu près à ceci :

<figure markdown="span">
![](assets/photos/025_heat_shrink.jpg){ width="50%" }
<figcaption>Gaine thermorétractable posée.</figcaption>
</figure>


Vissez le connecteur de panneau NMEA 2000 terminé sur le boîtier.

Encore une photo d'un connecteur terminé et du brochage :

<figure markdown="span">
![](assets/photos/n2k_connector_wiring_photo.jpg){ width="50%" }
<figcaption>Connecteur terminé.</figcaption>
</figure>


### Raccordement des autres connecteurs de panneau

Maintenant que le plus dur est fait, les autres connecteurs peuvent être vissés en place. Pour améliorer l'étanchéité du connecteur d'antenne WiFi, vous pouvez ajouter un petit joint torique ou une rondelle d'étanchéité autour du connecteur avant de le monter.

Au final, voici ce que vous devez obtenir :

<figure markdown="span">
![](assets/photos/03_connectors_in_place.jpg){ width="50%" }
<figcaption>Connecteurs en place.</figcaption>
</figure>


### Assemblage du SH-RPi

Nous allons maintenant monter le Raspberry Pi dans le boîtier.
Nous utilisons le boîtier plastique et les adaptateurs de montage qui devaient être livrés avec.

Fixez d'abord les entretoises courtes aux adaptateurs de montage avec les écrous M2,5. Serrez-les fermement.

<figure markdown="span">
![](assets/photos/04_adapters_with_standoffs.jpg){ width="50%" }
<figcaption>Adaptateurs et entretoises.</figcaption>
</figure>


Une fois les entretoises en place, les adaptateurs eux-mêmes se montent sur le boîtier avec les vis autotaraudeuses.

<figure markdown="span">
![](assets/photos/05_adapters_in_place.jpg){ width="50%" }
<figcaption>Adaptateurs montés.</figcaption>
</figure>


Le Raspberry Pi vient sur les entretoises. Fixez les entretoises supérieures avec les vis M2,5 et les inférieures avec deux entretoises hexagonales de 16 mm.

<figure markdown="span">
![](assets/photos/06_rpi_mounted.jpg){ width="50%" }
<figcaption>Raspberry Pi monté.</figcaption>
</figure>


Vient ensuite le Sailor Hat. Enfoncez-le sur le connecteur GPIO du Raspberry Pi. Immobilisez-le avec deux vis M2,5.

**NB** : le jour où vous devrez retirer la carte HAT, vous serez tenté de la faire basculer latéralement. Cela fonctionne bien, mais il existe aussi un petit risque de tordre les broches du connecteur du Pi à ses deux extrémités. Faites plutôt osciller la carte de haut en bas tout en tirant doucement vers le haut. C'est un peu plus lent, mais la carte se libère avec beaucoup moins de risque de tordre les broches.

À ce stade, vous pouvez aussi brancher tous les périphériques USB et raccorder les câbles d'alimentation et CAN du SH-RPi. Si vous utilisez un ventilateur, montez-le également. Fixez-le au ruban double face ou avec un peu de colle chaude à côté du Raspberry Pi, l'étiquette tournée vers le Pi.

Voici à quoi ressemble l'assemblage terminé :

<figure markdown="span">
![](assets/photos/07_sh-rpi_mounted.jpg){ width="50%" }
<figcaption>Sailor Hat monté.</figcaption>
</figure>


Ne refermez pas encore le couvercle. Il vous reste à insérer la carte mémoire dans le Pi.

## Logiciel

Dans cette section, nous installons le logiciel OpenPlotter sur le Raspberry Pi. OpenPlotter est une distribution logicielle spécialisée pour le monde maritime, fondée sur Raspberry Pi OS. Elle existe en plusieurs déclinaisons ; dans ce tutoriel, nous utilisons une version sans écran (headless), c'est-à-dire sans écran raccordé directement au Raspberry Pi. L'affichage passe alors par un navigateur ou une connexion à distance, ce qui permet de placer le serveur plus sûrement et les écrans là où vous en avez besoin.

### Installation d'OpenPlotter

OpenPlotter s'installe en écrivant une image système sur une carte MicroSD, puis en insérant cette carte dans le Raspberry Pi.

Téléchargez d'abord [Raspberry Pi Imager](https://www.raspberrypi.org/software/). Imager est un logiciel simple d'emploi qui écrit le fichier image téléchargé sur la carte mémoire.

**REMARQUE :** Imager n'est téléchargeable que pour macOS, Windows et Ubuntu Linux. Si vous utilisez un autre système d'exploitation ou une autre distribution Linux, il vous faudra un autre logiciel pour flasher la carte (mais à ce stade, je suppose que vous savez très bien comment faire).

Une fois téléchargé, installez Imager.

Téléchargez ensuite l'[image OpenPlotter](https://openplotter.readthedocs.io/en/latest/getting_started/downloading.html). J'utilise l'image Headless dans ce tutoriel. Si vous préférez raccorder un écran au Pi, vous pouvez prendre l'image Starting. Une fois l'image téléchargée, il faudra peut-être la décompresser avant de flasher. L'image système est assez volumineuse : prévoyez quelques gigaoctets d'espace libre sur votre disque.

Flashez l'image sur la carte MicroSD. Insérez d'abord la carte dans un lecteur relié à votre ordinateur. De nombreux portables disposent aussi d'un lecteur de cartes SD intégré ; utilisez alors l'adaptateur SD livré avec la carte. Ouvrez ensuite Imager. Dans le menu du système d'exploitation, choisissez « Use custom » tout en bas de la liste, puis sélectionnez le fichier image téléchargé.

[![](assets/screenshots/01_imager.jpg){ width="50%" }](assets/screenshots/01_imager.jpg)

Sélectionnez ensuite la bonne carte MicroSD avec le bouton Storage. Pour éviter toute erreur coûteuse, je recommande de débrancher tout autre support amovible de votre ordinateur. Cliquez sur Write. Vous devrez peut-être saisir votre mot de passe à ce stade pour autoriser Imager à écrire sur la carte MicroSD.

[![](assets/screenshots/02_imager_in_progress.jpg){ width="50%" }](assets/screenshots/02_imager_in_progress.jpg)

L'écriture et la vérification de la carte MicroSD prennent un certain temps. Profitons-en pour télécharger et installer [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/). VNC Viewer est un logiciel de bureau à distance que nous utiliserons pour accéder à OpenPlotter dans les sections suivantes.

Quand la carte MicroSD est prête, insérez-la dans le lecteur MicroSD du Raspberry Pi. Il vous faudra peut-être débrancher temporairement la carte HAT pour cela. (Oui, désolé, le tutoriel n'est pas cohérent à 100 %.)

Mettez enfin l'appareil sous tension. Il est certes possible de brancher un câble USB-C 5 V sur le Raspberry Pi, mais cela vous causera des ennuis dès que vous installerez le démon SH-RPi plus loin dans ce tutoriel. Utilisez donc une alimentation 12 V (en réalité, tout ce qui se situe entre 10–32 V convient) et raccordez-la à une fiche NMEA 2000. Vous pouvez aussi enficher de courts cavaliers femelles directement dans les connecteurs JST XH et relier les fils à une alimentation avec de petites pinces crocodiles. Faites preuve d'imagination !

### Première configuration d'OpenPlotter

À ce stade, vous devriez avoir un appareil couvert de voyants clignotants, mais aucun moyen de communiquer avec lui. Heureusement, il existe une porte d'entrée. Si vous regardez les réseaux Wi-Fi disponibles autour de vous, vous devriez voir un réseau nommé « openplotter » :

[![](assets/screenshots/03_select_wifi.jpg){ width="50%" }](assets/screenshots/03_select_wifi.jpg)

Connectez-vous à ce réseau (le mot de passe est `12345678`).

Vous voilà à portée du Pi. Pour y accéder, nous utiliserons VNC Viewer, installé précédemment.

[![](assets/screenshots/04_vnc_viewer.jpg){ width="50%" }](assets/screenshots/04_vnc_viewer.jpg)

Sur l'écran d'accueil, saisissez `openplotter.local` dans la barre d'adresse (si cela ne marche pas, essayez l'adresse IP `10.10.10.1`). Si le serveur a été trouvé, un écran d'authentification vous accueille :

[![](assets/screenshots/05_vnc_credentials.jpg){ width="50%" }](assets/screenshots/05_vnc_credentials.jpg)

Saisissez l'identifiant `pi` et le mot de passe `raspberry`.

Si tout s'est bien passé, un bureau OpenPlotter intact vous accueille :

[![](assets/screenshots/06_vnc_connected.jpg){ width="50%" }](assets/screenshots/06_vnc_connected.jpg)

Parfait ! Parcourez l'assistant de bienvenue du Pi. Vous devrez d'abord saisir un nouveau mot de passe et choisir le pays, la langue et d'autres réglages de base.

Si vous avez branché une clé WiFi USB compatible, vous devrez choisir un réseau WiFi auquel vous connecter. C'est très pratique, car cela vous ouvre l'accès à Internet pour télécharger les mises à jour et le reste.

[![](assets/screenshots/07_pick_raspi_wifi.jpg){ width="50%" }](assets/screenshots/07_pick_raspi_wifi.jpg)

Notez que sans adaptateur WiFi branché, la configuration initiale peut différer un peu de ce qui est décrit ci-dessous.

Pendant la configuration initiale, le Pi met à jour les logiciels du système. Cela prend un moment : allez chercher un café ou jouez avec votre conjoint, vos enfants ou vos animaux.

[![](assets/screenshots/08_update.jpg){ width="50%" }](assets/screenshots/08_update.jpg)

Une fois la configuration terminée, redémarrez le Pi. Vous étiez connecté au point d'accès WiFi du Pi ; la connexion réseau de votre ordinateur revient donc maintenant à votre WiFi habituel. Si vous avez l'adaptateur WiFi USB et avez configuré le Pi sur le même réseau, vous y accédez toujours par la même adresse `openplotter.local`. Vous comprenez pourquoi je conseillais l'adaptateur WiFi supplémentaire ? Sinon, il vous faudra vous reconnecter au réseau « openplotter » dès qu'il redevient disponible.

[![](assets/screenshots/09_basic_setup_complete.jpg){ width="50%" }](assets/screenshots/09_basic_setup_complete.jpg)

Bref. Revenez à VNC Viewer et connectez-vous à `openplotter.local`. Vous avez changé le mot de passe de l'utilisateur `pi` pendant la configuration initiale ; saisissez donc le nouveau mot de passe dans VNC Viewer.

Une fois de retour, nous allons modifier les réglages réseau de l'installation OpenPlotter. Dans le menu Raspberry, choisissez OpenPlotter -> Network.

(À l'ouverture, l'application Network peut se plaindre de vouloir reconfigurer votre système. Laissez-la faire et rouvrez l'application une fois terminé.)

[![](assets/screenshots/11_open_openplotter_network.jpg){ width="50%" }](assets/screenshots/11_open_openplotter_network.jpg)

Dans le panneau réseau, les périphériques réseau disponibles apparaissent à gauche et les réglages du point d'accès à droite.

Si vous ne voulez pas de point d'accès, choisissez « none » dans le menu de gauche. Si vous souhaitez le conserver (et je le recommande, car il vous ménage un accès de secours au Pi), il est important de changer le mot de passe du réseau :

[![](assets/screenshots/14_openplotter_network_password.jpg){ width="50%" }](assets/screenshots/14_openplotter_network_password.jpg)

Les réglages du client WiFi se trouvent sous le symbole WiFi, en haut à droite du bureau OpenPlotter. C'est là que vous configurez d'autres réseaux, comme le point d'accès WiFi de votre bateau.

[![](assets/screenshots/16_wifi_client_settings.jpg){ width="50%" }](assets/screenshots/16_wifi_client_settings.jpg)

Après avoir modifié les réglages réseau, redémarrez OpenPlotter.

### Installation du démon SH-RPi

Le plus urgent étant réglé, il est temps d'installer le démon SH-RPi. (Les [démons](https://en.wikipedia.org/wiki/Daemon_(computing)#Etymology) sont des esprits bienveillants qui contribuent à définir le caractère ou la personnalité d'une personne. Ou, en l'occurrence, des services d'arrière-plan des systèmes d'exploitation issus d'UNIX.) Nous pourrions le faire depuis VNC Viewer en ouvrant Accessories -> Terminal dans le menu Raspberry, et c'est ce que je conseille aux utilisateurs de Windows ; mais pour les utilisateurs de Mac et de Linux, je montre comment accéder à l'appareil OpenPlotter en SSH.

Faisons d'abord un petit détour. Plutôt que de nous connecter en ssh tête baissée, copions d'abord notre clé publique SSH sur l'appareil avec `ssh-copy-id`. Les connexions suivantes se feront alors sans mot de passe.

Les utilisateurs de Mac devront peut-être installer `ssh-copy-id` au préalable. Il est disponible via [Homebrew](https://brew.sh/) — si vous ne l'avez pas encore installé, faites-le ! C'est excellent ! Ensuite, lancez :

    brew install ssh-copy-id

Les utilisateurs de Linux, en revanche, sont choyés : `ssh-copy-id` y est déjà préinstallé.

Copiez ensuite la clé publique :

    ssh-copy-id pi@openplotter.local

Et voilà ! Vous pouvez désormais vous connecter au Pi sans mot de passe. Je recommande cette méthode sur tous les systèmes auxquels vous accédez à distance — elle est plus sûre que les mots de passe.

[![](assets/screenshots/18_ssh.jpg){ width="50%" }](assets/screenshots/18_ssh.jpg)

Une fois connecté avec `ssh pi@openplotter.local`, collez la commande d'installation dans l'invite :

    curl -L \
    https://raw.githubusercontent.com/hatlabs/SH-RPi-daemon/main/install.sh \
    | sudo bash

Sur un système relativement peu modifié, cette commande applique automatiquement les changements de configuration nécessaires et installe le logiciel du démon. Cela ne prend que quelques secondes. Il ne vous reste qu'à redémarrer manuellement une fois l'installation terminée :

    sudo reboot

Pendant le redémarrage, observez les LED du SH-RPi. La LED RX était vert fixe et la LED d'état rouge fixe ; après le redémarrage, la LED RX scintille joyeusement (à condition qu'il y ait du trafic sur le bus NMEA 2000), et la LED d'état reste rouge mais clignote brièvement chaque seconde. Ces changements indiquent que l'interface CAN et le watchdog du démon sont actifs. Voilà.

Lorsque vous vous connectez en VNC après le redémarrage, le message suivant s'affiche :

[![](assets/screenshots/20_after_reboot.jpg){ width="50%" }](assets/screenshots/20_after_reboot.jpg)

Cela signifie que l'interface CAN est désormais active, mais qu'elle n'est pas encore configurée dans [Signal K](https://signalk.org). Nous le ferons dans la section suivante.

### Configurer Signal K pour recevoir le trafic NMEA 2000

Pour traiter les données NMEA 2000, il faut configurer Signal K afin qu'il les reçoive. Ouvrez le tableau de bord Signal K à l'adresse [http://openplotter.local:3000/](http://openplotter.local:3000/).

Pour pouvoir agir sur le serveur, vous devez activer la sécurité et créer un utilisateur administrateur. Cliquez sur le bouton « Login » en haut à droite :

[![](assets/screenshots/21_sk_server_dashboard.jpg){ width="50%" }](assets/screenshots/21_sk_server_dashboard.jpg)

Il vous est demandé de créer un nouvel utilisateur administrateur. Je préfère `admin` comme identifiant, puis un mot de passe facile à retenir et à taper. Ce compte n'est accessible que depuis votre réseau interne.

Vous voudrez ensuite peut-être mettre à jour le serveur SK :

[![](assets/screenshots/23_update_server.jpg){ width="50%" }](assets/screenshots/23_update_server.jpg)

Cela fait, passons aux choses sérieuses et activons `can0` sur le serveur. Allez dans Data Connections et cliquez sur le bouton Add :

[![](assets/screenshots/26_data_connections_add.jpg){ width="50%" }](assets/screenshots/26_data_connections_add.jpg)

Configurez ensuite la connexion comme ci-dessous, faites défiler vers le bas et cliquez sur Submit :

[![](assets/screenshots/28_correct_settings.jpg){ width="50%" }](assets/screenshots/28_correct_settings.jpg)

Après avoir ajouté la connexion de données, redémarrez de nouveau le serveur. Le tableau de bord doit maintenant montrer une certaine activité :

[![](assets/screenshots/30_can0_activity.jpg){ width="50%" }](assets/screenshots/30_can0_activity.jpg)

Voilà. Le moment de vous féliciter. Vous êtes allé loin !

Si vous le souhaitez, vous pouvez aussi ouvrir Data Browser dans le menu de gauche pour voir quelles données vous recevez.

### Créer des tableaux d'instruments

Si vous recevez des données, vous pouvez déjà les visualiser en ouvrant SK Instrument Panel :

[![](assets/screenshots/301_sk_plugins.jpg){ width="50%" }](assets/screenshots/301_sk_plugins.jpg)

Le bouton en forme de clé permet de configurer certains chemins. La taille et la position des cadrans se règlent en cliquant sur le bouton cadenas.

Mon laboratoire d'essai se trouve juste sous un toit métallique, sans la moindre réception GPS, et les seules données intéressantes de mon réseau proviennent du [capteur de température 1-Wire](https://docs.hatlabs.fi/sh-esp32/pages/tutorials/onewire-temperature/). Mon tableau d'instruments se compose donc de trois valeurs de température :

[![](assets/screenshots/302_sk_instrument_panel.jpg){ width="50%" }](assets/screenshots/302_sk_instrument_panel.jpg)

Un peu triste, mais enthousiasmant à la fois !

Outre l'Instrument Panel standard, il existe de très bonnes applications de tableau de bord pour Signal K. Vous pouvez essayer [KIP](https://github.com/mxtommy/Kip) (disponible dans la boutique d'applications du serveur SK) ou [Wilhelm SK](https://www.wilhelmsk.com/) (uniquement pour les appareils iOS, sur l'App Store).

### Installation d'InfluxDB et de Grafana

Dans les dernières étapes de ce tutoriel, nous installons et configurons InfluxDB et Grafana pour constituer un historique et des visualisations des données du bateau. Il reste quelques étapes et des écrans d'apparence chargée, mais ce petit effort en vaut la peine !

InfluxDB est une base de données de séries temporelles où nous stockerons les données. Grafana est une boîte à outils de visualisation souvent employée pour surveiller la santé des systèmes informatiques, mais dont la polyvalence convient tout aussi bien à nos données maritimes.

Pour installer InfluxDB et Grafana, revenez à VNC Viewer et ouvrez OpenPlotter -> Dashboards dans le menu Raspberry :

[![](assets/screenshots/31_openplotter_dashboards.jpg){ width="50%" }](assets/screenshots/31_openplotter_dashboards.jpg)

Sélectionnez InfluxDB et cliquez sur Install. Cela prend un moment ; une fois terminé, revenez à l'onglet Apps, sélectionnez Grafana et cliquez sur Install. C'est tout.

[![](assets/screenshots/32_install.jpg){ width="50%" }](assets/screenshots/32_install.jpg)

Il nous faut ensuite créer une base de données dans InfluxDB. Ouvrez Chronograf, l'interface web d'InfluxDB, dans votre navigateur : [http://openplotter.local:8889/](http://openplotter.local:8889/).

[![](assets/screenshots/34_open_chronograf.jpg){ width="50%" }](assets/screenshots/34_open_chronograf.jpg)


Parcourez la configuration initiale. La connexion InfluxDB de Chronograf utilise l'identifiant `admin` et le mot de passe `admin`. Vous pouvez passer la création de tableaux de bord et la configuration de Kapacitor.

Créez ensuite la nouvelle base de données depuis l'écran InfluxDB Admin :

[![](assets/screenshots/37_create_signalk_db.jpg){ width="50%" }](assets/screenshots/37_create_signalk_db.jpg)

Donnez à la base le nom `signalk` et validez le reste. Terminé.

Maintenant que la base nous attend, alimentons-la. Revenez au tableau de bord Signal K pour configurer le greffon d'écriture InfluxDB :

[![](assets/screenshots/39_sk_plugin_config.jpg){ width="50%" }](assets/screenshots/39_sk_plugin_config.jpg)

Laissez l'identifiant et le mot de passe vides. Notre base s'appelait `signalk`. Si vous le souhaitez, modifiez l'intervalle d'écriture par lots et la résolution des données. L'intervalle est de 10 secondes par défaut ; pour un affichage plus proche du temps réel, saisissez 2. La résolution détermine la fréquence d'écriture d'une mesure dans la base. La valeur par défaut de 200 ms convient sans doute, mais j'en voulais davantage et j'ai choisi 100 ms. Cochez également les cases indiquées ci-dessous.

[![](assets/screenshots/40_settings.jpg){ width="50%" }](assets/screenshots/40_settings.jpg)

Faites défiler vers le bas et cliquez sur Submit pour appliquer la configuration. À ce stade, les mesures doivent affluer dans la base. Vérifions-le. Revenez à Chronograf et choisissez la vue Explore. Une source nommée `signalk.autogen` doit apparaître en bas. Sélectionnez-la : les noms des mesures individuelles doivent s'afficher. Parfait.

[![](assets/screenshots/41_verify_data.jpg){ width="50%" }](assets/screenshots/41_verify_data.jpg)

Il ne reste plus qu'à visualiser les données historiques.

### Créer un exemple de tableau de bord Grafana

Nous allons utiliser Grafana pour afficher de jolies courbes. Ouvrez Grafana dans votre navigateur : [http://openplotter.local:3001](http://openplotter.local:3001).

[![](assets/screenshots/42_open_grafana.jpg){ width="50%" }](assets/screenshots/42_open_grafana.jpg)

Grafana exige la saisie d'un nouveau mot de passe ; faites-le. Une fois sur l'écran d'accueil, configurez la source de données InfluxDB :

[![](assets/screenshots/44_grafana_data_sources.jpg){ width="50%" }](assets/screenshots/44_grafana_data_sources.jpg)

Dans la configuration, l'URL par défaut apparaît en gris foncé, mais j'ai constaté qu'il fallait la saisir explicitement. Pour le reste, c'est encore la même base `signalk` et un identifiant et un mot de passe vides. Cliquez sur « Save and Test » pour vérifier que votre source de données fonctionne.

[![](assets/screenshots/46_config_data_source.jpg){ width="50%" }](assets/screenshots/46_config_data_source.jpg)

Récapitulons ce que nous avons à ce stade. Signal K reçoit les données du NMEA 2000, InfluxDB les stocke, et Grafana est raccordé à InfluxDB. Enfin, nous pouvons créer un tableau de bord Grafana et y ajouter de nouveaux panneaux de données.

L'éditeur de panneau paraît chargé, mais les étapes de base sont simples.

[![](assets/screenshots/54_panel_title.jpg){ width="50%" }](assets/screenshots/54_panel_title.jpg)

Modifiez la requête. Sélectionnez d'abord une mesure dans la ligne FROM. Ensuite, vous devez ajouter un opérateur mathématique pour convertir les unités de mesure (Grafana ne connaît guère les unités : par défaut, il affiche toujours les données dans les unités SI où elles sont stockées). Par exemple, pour passer des kelvins aux degrés Celsius, il faut soustraire 273,15. Ou, pour passer des m/s aux nœuds, multiplier par 3600 et diviser par 1852.

Terminez le panneau en lui donnant un titre et en appliquant les modifications.

Vous devriez maintenant avoir un panneau unique affichant un peu de données temporelles dans votre tableau de bord. Ajoutez-en deux ou trois autres avec le bouton Add Panel. Vous pouvez positionner et redimensionner les panneaux en faisant glisser leurs titres et leurs coins. Enfin, choisissez une plage de temps adaptée dans la barre supérieure et enregistrez le tableau de bord.

Voici à quoi ressemble mon tableau de bord des températures moteur :

[![](assets/screenshots/56_two_more_panels.jpg){ width="50%" }](assets/screenshots/56_two_more_panels.jpg)

C'est tout. Créez de superbes tableaux de bord et montrez-les à vos amis de la marina et du yacht-club ! Partagez-les aussi sur le [forum de discussion Hat Labs](https://github.com/hatlabs/discussions/discussions) pour inspirer les autres !


</div>
