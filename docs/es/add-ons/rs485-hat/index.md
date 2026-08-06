---
title: Waveshare 2-Channel Isolated RS485 HAT
translated_from: 7f4b38c33361ca8118a3f68c596e0fb1633d6f5e
---

# RS485 HAT

El Waveshare 2-Channel Isolated RS485 HAT proporciona dos interfaces RS-485 aisladas para la Raspberry Pi. Permite implementar una interfaz NMEA 0183 bidireccional o dos interfaces RS-485 bidireccionales genéricas. Cuando se usa como interfaz NMEA 0183, un canal se emplea para recibir datos y el otro para transmitirlos.

El HAT lleva un transformador CC/CC aislado integrado y no requiere alimentación externa.

El RS485 HAT se puede usar simultáneamente con el SH-RPi y el CAN HAT.

En esta página se describe la instalación y la configuración del RS485 HAT cuando se usa junto con el Sailor Hat for Raspberry Pi. Para más detalles sobre el RS485 HAT, consultar la [página wiki de Waveshare](https://www.waveshare.com/wiki/2-CH_RS485_HAT).


## Configuración de los puentes

!!! warning
    ¡Comprobar la posición de los puentes antes de conectar el HAT!

El RS485 HAT tiene dos puentes para las resistencias de terminación del bus RS-485 de la propia placa. NMEA 0183 no utiliza terminadores: ¡los puentes deben estar en la posición `OFF`!

## Conexión del HAT

Insertar con cuidado el conector de pines pasante (stack-through) en el conector GPIO del RS-485 HAT. A continuación,
encajar el HAT en el conector GPIO de 40 pines de la Raspberry Pi o del Sailor Hat. El borde del conector debe fijarse a la placa inferior con los separadores hexagonales.

Cuando el HAT se usa como interfaz NMEA 0183, el canal 1 sirve para recibir datos (RX) y el canal 2 para transmitirlos (TX). Los cables A y B de TX del dispositivo transmisor (o TX+ y TX-) deben conectarse a los terminales A y B del canal 1 del HAT, mientras que los cables A y B de RX del dispositivo receptor (o RX+ y RX-) deben conectarse a los terminales A y B del canal 2 del HAT. La figura siguiente muestra el cableado de la interfaz NMEA 0183.

<figure markdown="span">
![](nmea0183_wiring.jpg){ width="50%" }
<figcaption>Cableado de la interfaz NMEA 0183. Los colores del cableado pueden variar según el dispositivo.</figcaption>
</figure>

## Configuración del software

El script de instalación del Sailor Hat permite configurar y habilitar la interfaz RS-485. La interfaz se ofrece mediante dos dispositivos serie: `/dev/ttySC0` y `/dev/ttySC1`. De ellos, `/dev/ttySC0` se usa para recibir datos y `/dev/ttySC1` para transmitirlos. Se pueden configurar en las conexiones de datos de Signal K o en cualquier otra aplicación NMEA 0183.

Para realizar una instalación manual, consultar los detalles en la [página wiki de Waveshare](https://www.waveshare.com/wiki/2-CH_RS485_HAT).
