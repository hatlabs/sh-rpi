---
title: Description du matériel
translated_from: 257eeaa16d90da32404917c6093ffa709b5400f8
---

# Description du matériel

## Tour d'horizon de la carte

Les différents blocs fonctionnels du Sailor Hat for Raspberry Pi sont décrits ci-dessous.

<figure markdown="span">
![](SH-RPi-2.0.0-func.jpg){ width="60%" }
<figcaption>Blocs fonctionnels du SH-RPi.</figcaption>
</figure>

1. Entrée d'alimentation et protection.
   L'alimentation est fournie par un connecteur au pas de 3,81 mm (0,15") compatible Phoenix MC.
   La plage de tension admise est de 9–32 V.
   Le circuit de protection de l'entrée d'alimentation comprend :
   - un fusible SMD de 4 A
   - un suppresseur de transitoires (TVS) de 33 V (puissance de pointe en impulsion de 5000 W)
   - une diode de protection contre l'inversion de polarité
   - une self et un filtre en pi pour maîtriser les perturbations électromagnétiques conduites
2. Convertisseur abaisseur (buck) de premier étage avec limitation de courant.
   Le convertisseur abaisseur transforme la tension d'entrée en une tension de 8,8 V que le banc de supercondensateurs peut supporter.
   Le circuit du convertisseur abaisseur comprend également un limiteur de courant distinct qui bride le courant d'entrée à 0,8 A (au réglage par défaut).
3. Trois supercondensateurs de 20 F et 3,0 V.
   Le banc de supercondensateurs sert de réservoir d'énergie au Raspberry Pi.
   Il peut alimenter un Raspberry Pi 4B pendant 70 secondes au maximum (selon, bien entendu, le nombre de périphériques supplémentaires), et les modèles moins gourmands bien plus longtemps.
   Les supercondensateurs permettent également d'alimenter le Raspberry Pi depuis une interface de faible puissance telle que le bus NMEA 2000, qui limite le courant maximal d'un nœud individuel à 1,0 A.
4. Microcontrôleur.
   Le fonctionnement du SH-RPi est piloté par un microcontrôleur ATtiny1616.
   Le microcontrôleur assure les fonctions suivantes :
   - mesure de la tension d'entrée
   - mesure du courant d'entrée
   - mesure de la tension des supercondensateurs
   - commande de la rangée de LED d'état
   - commande de la sortie 5 V
   - réception des informations d'interruption de l'horloge temps réel
   - communication de l'état du SH-RPi au service du Raspberry Pi via I2C
5. Convertisseur abaisseur de second étage.
   Le convertisseur abaisseur convertit la tension du banc de supercondensateurs en la tension d'alimentation 5 V du Raspberry Pi. Le courant de sortie instantané maximal est de 5 A, et au moins 3 A sont atteignables en courant continu sans refroidissement actif.
   Le fonctionnement du convertisseur abaisseur est piloté par le microcontrôleur. Le microcontrôleur active le convertisseur élévateur lorsque la tension des supercondensateurs a dépassé 8,0 V.
   Lors de l'arrêt du système ou d'un redémarrage par le chien de garde (watchdog), le microcontrôleur désactive le convertisseur élévateur pour couper la tension d'alimentation du Raspberry Pi.
6. Rangée de LED d'état.
   Les quatre LED d'état indiquent l'état de fonctionnement de la carte, comme décrit à la section [LED d'état](#led-detat).
7. Horloge temps réel.
   La carte comprend une horloge temps réel PCF8563 capable de conserver l'heure avec précision même en l'absence de connexion Internet ou GPS.
   L'horloge temps réel communique avec le Raspberry Pi via I2C.

## Connecteurs

<div class="row">
  <div class="col-sm-6">

<figure markdown="span">
![](SH-RPi-2.0.0-conx.jpg){ width="100%" }
<figcaption>Connecteurs du SH-RPi, face supérieure.</figcaption>
</figure>

   </div>
   <div class="col-sm-6">

<figure markdown="span">
![](SH-RPi-2.0.0-conx-back.jpg){ width="100%" }
<figcaption>Connecteurs du SH-RPi, face inférieure.</figcaption>
</figure>

   </div>
</div>

1. Connecteur d'entrée d'alimentation.

   Le connecteur d'alimentation est un connecteur au pas de 3,81 mm (0,15") compatible Phoenix MC.
   L'emballage de vente contient un bornier débrochable à vis compatible.
2. Connecteur de sortie 5 V.
   Les périphériques 5 V externes peuvent être raccordés à ce connecteur. Le connecteur de sortie 5 V est lui aussi un connecteur au pas de 3,81 mm (0,15") compatible Phoenix MC.
3. Connecteur GPIO Raspberry Pi traversant.
   Il s'agit d'un connecteur GPIO Raspberry Pi 2x20 broches standard. Le connecteur traversant fourni doit être inséré pour relier le SH-RPi à un Raspberry Pi.
   D'autres HAT peuvent être empilés au-dessus du Sailor Hat.
4. Connecteur de programmation et de débogage de l'ATtiny1616.
   Ce connecteur permet de programmer le microcontrôleur avec un programmateur externe, ou d'activer la programmation sur carte.
5. Connecteur à cavaliers du limiteur de courant.
   Des cavaliers peuvent être placés sur le connecteur à cavaliers du limiteur de courant pour porter la limite de courant à 1,8 A ou 2,8 A (la valeur par défaut est 0,8 A).
   Placez un cavalier horizontalement sur la rangée du haut (marquée 2A) pour régler la limite de courant à 1,8 A. Placez un cavalier horizontalement sur la rangée du bas (marquée 3A) pour régler la limite de courant à 2,8 A.
6. Connecteur d'interruption externe. Non fonctionnel sur le matériel v2.0.0.
7. Connecteur de pile CR1220 pour l'horloge temps réel (sur la face inférieure).
   L'horloge temps réel a besoin d'une pile de sauvegarde CR1220 pour conserver l'heure lorsque le système est hors tension.
   La pile doit être orientée face positive (la plus plate) à l'opposé de la carte.
8. Pont à souder RTC Enable.
   L'horloge temps réel est activée par défaut.
   Pour la désactiver, coupez les pistes entre les plages du pont à souder avec un couteau bien affûté.
   Veillez à ne couper aucune piste voisine.
9. GPIO4 Enable. Reliez les plages pour connecter la broche GPIO4 du Raspberry Pi au port PB5 du microcontrôleur embarqué.
   Pour que cela soit utile, une fonctionnalité de firmware personnalisée est nécessaire.

## Alimentation

Le SH-RPi intègre un sous-système d'alimentation qui fournit au Raspberry Pi une alimentation propre à partir d'une source électrique perturbée, comme une alimentation non régulée ou le parc de batteries « servitude » d'un bateau. L'alimentation accepte des tensions d'entrée de 9–32 V, mais une tension inférieure à 10 V est considérée comme une situation de sous-tension, afin d'éviter d'endommager par décharge profonde les batteries au plomb usuelles.

Le schéma de fonctionnement du sous-système d'alimentation est présenté sur l'image ci-dessous.

Le courant d'entrée maximal est bridé afin de protéger les alimentations en amont et le câblage. La limite de courant par défaut est de 0,8 A, mais elle peut être portée à 1,8 A ou 2,8 A en plaçant des cavaliers sur le connecteur à cavaliers du limiteur de courant.

La tension d'entrée est abaissée par le convertisseur abaisseur de premier étage, qui charge le banc de supercondensateurs jusqu'à une tension de 8,8 V. Les supercondensateurs constituent un réservoir d'énergie pour le Raspberry Pi, aussi bien lors de micro-coupures de courte durée que comme source d'énergie de dernier recours pendant l'arrêt du système.

Le convertisseur abaisseur de second étage convertit la tension des supercondensateurs en la tension d'alimentation 5 V du Raspberry Pi. Le microcontrôleur active la sortie 5 V lorsque la tension des supercondensateurs dépasse 8,0 V, et la désactive lorsque cette tension descend sous 5,0 V. L'utilisateur peut configurer ces seuils.

Le courant de sortie de crête maximal vers le Raspberry Pi est de 5 A. Le courant de sortie moyen maximal dépend du réglage du limiteur de courant d'entrée et de la température ambiante. Avec une limite de courant d'entrée de 0,8 A, le courant de sortie soutenu maximal est d'environ 1,4 A. Avec un réglage de limite de courant d'entrée de 2,8 A, le courant de sortie moyen maximal est limité par le comportement thermique du système. À l'air libre et à température ambiante, le courant de sortie 5 V moyen maximal est d'au moins 3,0 A. Des valeurs supérieures sont possibles en refroidissant activement la carte SH-RPi.

À un courant de sortie de 1,4 A, le rendement global de l'alimentation est de 79 %.

<figure markdown="span">
![](psu_diagram.svg){ width="70%" }
<figcaption>Schéma de fonctionnement de l'alimentation, avec des valeurs de courant et de tension données à titre d'exemple.</figcaption>
</figure>

## LED d'état

La rangée de LED du SH-RPi, sur le côté gauche de la carte, indique l'état de fonctionnement de la carte.
L'affichage en barre indique l'état de charge du banc de supercondensateurs. La première LED commence à s'allumer lorsque la tension dépasse 5 V, et toutes les LED sont pleinement allumées à une tension de 9 V aux bornes des supercondensateurs.

Superposés à l'affichage en barre, différents motifs de clignotement indiquent l'état de la carte comme suit.

| Motif | Description |
|-------|-------------|
| Aucun clignotement | Charge ou fonctionnement normal (1) |
| Brève extinction toutes les 4 s | Chien de garde actif (2) |
| Défilement vers la gauche | Pas de tension d'entrée (3) |
| Deux extinctions brèves avec une pause de 1 s | Arrêt en cours (4) |
| Deux allumages brefs avec une pause de 2 s | Veille (5) |
| LED clignotant en alternance | Redémarrage par le chien de garde (6) |
| Clignotement rapide | Défaut – contactez le fabricant (7) |

Description détaillée des états :

1. Les supercondensateurs se chargent et, si leur tension dépasse 8,0 V, la sortie 5 V est activée.
   Le démon de Raspberry Pi OS n'est pas actif.
2. Le démon est actif et le chien de garde est activé. Le système d'exploitation a démarré et fonctionne normalement.
3. L'alimentation d'entrée est perdue et les supercondensateurs se déchargent. La sortie 5 V est activée.
4. Le démon a lancé un arrêt. Le SH-RPi attend que le Raspberry Pi s'éteigne.
5. Le SH-RPi est en veille. La sortie 5 V est désactivée et la carte attend une alarme de l'horloge temps réel pour se réveiller.
6. Le SH-RPi n'a pas reçu de signal de vie (heartbeat) du démon pendant 10 s, ce qui laisse penser que le Pi a planté.
   Le Raspberry Pi est réinitialisé en coupant le 5 V pendant deux secondes.
7. Le SH-RPi a détecté une surtension des supercondensateurs. Contactez le fabricant pour obtenir de l'aide.


## Fonction de redémarrage par le chien de garde

Outre l'alimentation, le Sailor Hat for Raspberry Pi intègre un temporisateur chien de garde matériel qui permet de redémarrer le Raspberry Pi en cas de blocage logiciel ou matériel. Le temporisateur chien de garde est activé par défaut et peut, au besoin, être désactivé avec la commande `shrpi set watchdog 0` sur la ligne de commande de l'appareil. Lorsqu'il est activé, le temporisateur chien de garde redémarre le Raspberry Pi s'il ne reçoit pas de signal de vie (« heartbeat ») du Raspberry Pi dans un intervalle de temps prédéfini (typiquement 10 secondes).

Le Raspberry Pi doit exécuter un service qui envoie périodiquement un signal de vie au SH-RPi. Ce service s'installe à partir du paquet logiciel fourni.

Si le temporisateur chien de garde déclenche un redémarrage, le SH-RPi désactive brièvement la sortie 5 V pour forcer le redémarrage du Raspberry Pi. Le SH-RPi réactive ensuite la sortie 5 V afin que le Raspberry Pi puisse démarrer de nouveau.

## Horloge temps réel

Le SH-RPi comprend une horloge temps réel (RTC) PCF8563 qui conserve l'heure avec précision même lorsque le Raspberry Pi n'est pas connecté à Internet ou qu'aucun signal GPS n'est disponible. La RTC est reliée au Raspberry Pi par le bus I2C.

Pour utiliser la RTC, une pile de sauvegarde CR1220 doit être installée sur la face inférieure de la carte. La face positive de la pile (la plus plate) doit être orientée à l'opposé de la carte.

Lorsque la carte SH-RPi est utilisée avec un appareil doté de sa propre RTC, les adresses I2C des deux horloges peuvent entrer en conflit.
Dans ce cas, la RTC du SH-RPi peut être désactivée en coupant les pistes entre les plages du pont à souder RTC EN.

## Configuration matérielle

L'utilisateur peut configurer le Sailor Hat for Raspberry Pi pour l'adapter à des cas d'usage particuliers. Les options de configuration sont les suivantes :

1. Réglage du limiteur de courant.
   Le limiteur de courant d'entrée peut être réglé sur 0,8 A (par défaut), 1,8 A ou 2,8 A en plaçant des cavaliers sur le connecteur à cavaliers du limiteur de courant.
2. Activation de l'horloge temps réel.
   La RTC peut être activée ou désactivée à l'aide d'un pont à souder.
3. Activation de GPIO4.
   Reliez les plages pour connecter la broche GPIO4 du Raspberry Pi au port PB5 du microcontrôleur embarqué. Pour que cela soit utile, une fonctionnalité de firmware personnalisée est nécessaire.

## I2C

Le Sailor Hat communique avec le Raspberry Pi
par le bus I2C 1, sur les broches GPIO 3 et 5 (respectivement GPIO2 et GPIO3).
L'adresse I2C est 0x6d.

L'horloge temps réel PCF8563 réserve en outre l'adresse I2C 0x51 sur le même bus.
