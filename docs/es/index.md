---
title: Introducción
translated_from: 0ec24a83f9a21c842e78cd792ae3510e89df0e34
---

# Introducción

!!! info
    ¿Se busca la documentación antigua del Sailor Hat for Raspberry Pi v1.0.0? Está disponible en [docs.hatlabs.fi/sh-rpi-v1](https://docs.hatlabs.fi/sh-rpi-v1/).

El Sailor Hat for Raspberry Pi (SH-RPi) es una versátil placa de gestión de la alimentación diseñada para la Raspberry Pi y ordenadores de placa única similares. Con el SH-RPi conectado se pueden crear servidores profundamente integrados que se apagan de forma segura cuando se corta la alimentación y se despiertan automáticamente cuando esta se restablece.

El SH-RPi es compatible con todos los modelos de Raspberry Pi que tienen un conector GPIO de 40 pines (todos los modelos desde la Pi 1 Model B+). Además, es compatible con las placas Raspberry Pi Compute Module 4 y con otros ordenadores de placa única que tengan un conector GPIO de 40 pines compatible con Raspberry Pi o una interfaz I2C externa con entrada de alimentación de 5 V.

<figure markdown="span">
![](shrpi_v2.0.0_top_render_ortho.jpg){ width="60%" }
<figcaption>Sailor Hat for Raspberry Pi v2.0.0.</figcaption>
</figure>

## Características principales

- **Entrada de amplio rango de tensión**: alimentación segura de la Raspberry Pi desde un sistema de 12 V o 24 V, como los habituales en vehículos y embarcaciones. El SH-RPi tiene un rango de entrada de 10–32 V con filtrado adicional y protección contra sobretensiones.
- **Alta capacidad de corriente de salida**: 3 A de corriente de salida continua a 5 V (según la temperatura ambiente), con corrientes de pico de hasta 5 A. Con refrigeración activa se pueden alcanzar 4 A de corriente de salida continua. El SH-RPi puede alimentar incluso las configuraciones de Raspberry Pi más exigentes.
- **Resistencia a los microcortes de alimentación**: los supercondensadores integrados hacen que los cortes de alimentación intermitentes pasen desapercibidos y mantienen el servidor en funcionamiento durante caídas de tensión o microcortes.
- **Compatibilidad con el bus NMEA 2000**: alimentación de la Raspberry Pi directamente desde el bus NMEA 2000. El SH-RPi incluye un circuito de limitación de corriente que limita la corriente máxima de entrada a aproximadamente 0,8 A. Los supercondensadores aportan capacidad de potencia de pico para dispositivos exigentes como pantallas y unidades SSD.
- **Apagado seguro**: la Raspberry Pi recibe aviso de los cortes de alimentación y se apaga de forma segura, alimentada por los supercondensadores. Así se elimina el riesgo de corromper la tarjeta SD.
- **Reloj de tiempo real**: mantiene la Raspberry Pi sincronizada gracias al reloj de tiempo real integrado y a su pila de respaldo.
- **Temporizador watchdog**: reinicio automático de la Raspberry Pi en caso de bloqueo gracias al temporizador watchdog (temporizador de vigilancia) integrado.
- **Apilable**: se pueden añadir más funciones apilando otros HAT de Raspberry Pi, como GPS, NMEA 2000 o NMEA 0183.

El Sailor Hat for Raspberry Pi es hardware abierto, publicado bajo la licencia Creative Commons Attribution-ShareAlike 4.0 International.

## Cómo conseguir el hardware

Las placas SH-RPi se pueden adquirir en [Hat Labs Oy](https://shop.hatlabs.fi/products/sh-rpi). Todos los archivos de diseño están además disponibles en el [repositorio de GitHub del hardware del SH-RPi](https://github.com/hatlabs/sh-rpi-hardware/).
