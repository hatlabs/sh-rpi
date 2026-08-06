---
title: Foire aux questions
translated_from: 6f552968db2af4b4fcbf3f6ca0ed8d741ed06f48
---

# FAQ

## Puis-je alimenter le Raspberry Pi par le connecteur USB-C standard pendant que le SH-RPi est raccordé ?

La réponse est non. Ou du moins, il vaut mieux l'éviter. Rien ne se passe si le SH-RPi est alimenté et que les supercondensateurs sont chargés au-dessus de 5 V. En revanche, si les supercondensateurs sont déchargés, ils seront alimentés en retour par le bus 5 V. En pratique, cela surchargera probablement l'alimentation USB et la fera se couper, sans dommage permanent. La situation n'est toutefois pas maîtrisée, et l'alimentation, le Raspberry Pi ou le SH-RPi lui-même peuvent être endommagés.

Autre point : même avec les supercondensateurs chargés, le démon ne verra aucune tension d'entrée et déclenchera un arrêt immédiatement après le démarrage.
