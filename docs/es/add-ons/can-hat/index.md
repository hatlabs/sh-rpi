---
title: Waveshare 2-Channel Isolated CAN HAT
translated_from: 91112523c75ae01ec3e4cdcdabdcff0fe5fdbd78
---

# CAN HAT

El Waveshare 2-Channel Isolated CAN HAT proporciona dos interfaces CAN aisladas para la Raspberry Pi. El CAN HAT se basa en el controlador CAN MCP2515 y en los transceptores CAN SI65HVD230/SN65HVD230. El HAT permite implementar una única interfaz NMEA 2000 conforme a la norma o dos interfaces CAN de otro tipo. Cuando se usa como interfaz NMEA 2000, el segundo canal debe quedar sin usar, debido a los requisitos de aislamiento de NMEA 2000.

El HAT lleva un transformador CC/CC aislado integrado y no requiere alimentación externa.

En esta página se describe la instalación y la configuración del CAN HAT cuando se usa junto con el Sailor Hat for Raspberry Pi. Para más detalles sobre el CAN HAT, consultar la [página wiki de Waveshare](https://www.waveshare.com/wiki/2-CH_CAN_HAT).

## Configuración de los puentes

!!! warning
    ¡Comprobar la posición de los puentes antes de conectar el HAT!

El CAN HAT tiene dos puentes para las resistencias de terminación del bus CAN de la propia placa. ¡Para el funcionamiento normal deben estar en la posición `OFF`!

Además, el CAN HAT tiene un puente de selección de tensión. Debe estar en `3V3` cuando se usa con una Raspberry Pi; de lo contrario, la Raspberry Pi puede sufrir daños.

## Conexión del HAT

Insertar con cuidado el conector de pines pasante (stack-through) en el conector GPIO del CAN HAT. A continuación,
encajar el HAT en el conector GPIO de 40 pines de la Raspberry Pi o del Sailor Hat. El borde del conector debe fijarse a la placa inferior con los separadores hexagonales.

Cuando el HAT se usa con una interfaz NMEA 2000, solo debe utilizarse la interfaz «CAN0». La interfaz «CAN1» debe dejarse sin conectar. La figura siguiente muestra el cableado de la interfaz NMEA 2000.

<figure markdown="span">
![](can_hat_wiring.jpg){ width="50%" }
<figcaption>Cableado de la interfaz NMEA 2000. El cable rojo se deja sin conectar.</figcaption>
</figure>

## Configuración del software

El script de instalación del Sailor Hat permite configurar y habilitar la interfaz CAN. Para realizar una instalación manual, consultar los detalles en la [página wiki de Waveshare](https://www.waveshare.com/wiki/2-CH_CAN_HAT).

## Alimentación del SH-RPi mediante la interfaz NMEA 2000

Es posible alimentar la Raspberry Pi mediante la interfaz NMEA 2000. Para ello, los cables de alimentación y de masa de NMEA 2000 deben conectarse a la entrada de alimentación del SH-RPi, mientras que los cables H y L deben ir al conector «CAN0» del CAN HAT. Además, hay que establecer una conexión de masa entre el SH-RPi y el CAN HAT, tal como se muestra en la figura siguiente.

<figure markdown="span">
![](can_hat_n2k_power.jpg){ width="50%" }
<figcaption>Configuración del cableado para alimentar el SH-RPi mediante la interfaz NMEA 2000.</figcaption>
</figure>
