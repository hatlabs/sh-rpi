---
title: Waveshare MAX-M8Q GNSS HAT
translated_from: 94d29c50a654fad026d00f597a18d7b0d3625d85
---

# GNSS HAT

El Waveshare MAX-M8Q GNSS HAT proporciona un receptor GNSS de alta calidad para la Raspberry Pi, basado en el módulo U-blox MAX-M8Q. El MAX-M8Q incorpora un receptor GNSS multiconstelación con una alta sensibilidad de −167 dBm. Admite GPS, GLONASS, BeiDou y Galileo, y puede recibir simultáneamente de tres de ellos. Además, admite varios sistemas de aumentación como SBAS, QZSS, IMES y D-GPS.

En esta página se describe la instalación y la configuración del GNSS HAT cuando se usa junto con el Sailor Hat for Raspberry Pi. Para más detalles sobre el GNSS HAT, consultar la [página wiki de Waveshare](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT).

## Conexión del HAT

Insertar el conector de pines pasante (stack-through) en el conector GPIO del GNSS HAT. A continuación, encajar el HAT en el conector GPIO de 40 pines de la Raspberry Pi. El GNSS HAT se puede apilar sobre otros HAT.

### Uso del GNSS HAT junto con el RS485 HAT

El MAX-M8Q GNSS HAT incorpora una función TIMEPULSE (PPS) que proporciona a la Raspberry Pi una referencia de tiempo GNSS muy
precisa. Por desgracia, esta función de pulso de tiempo está conectada a un pin GPIO que el RS485 HAT también utiliza. Si se usan ambos dispositivos a la vez, hay que desconectar físicamente el pin GPIO en conflicto. La forma más sencilla
de hacerlo es cortar el pin correspondiente del conector de pines pasante. La figura siguiente señala el pin que hay que cortar.

<figure markdown="span">
![](pps_pin.jpg){ width="50%" }
<figcaption>El pin que hay que cortar cuando se usa el GNSS HAT junto con el RS485 HAT.</figcaption>
</figure>

Para asegurarse de cortar el pin correcto, insertar parcialmente el conector de pines pasante en el conector GPIO del GNSS HAT. A continuación, cortar la parte superior del pin señalado en la figura anterior. Retirar el conector de pines pasante y cortar después el pin en la base del conector.

## Configuración del software

La instalación del software del GNSS HAT se automatizará mediante el script de instalación del Sailor Hat.
Por ahora hay que configurar el GNSS HAT manualmente siguiendo las instrucciones de la [página wiki del Waveshare MAX-M8Q GNSS HAT](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT). No hacen falta los pasos posteriores a la configuración de `gpsd`.

Según la configuración, el GNSS HAT ofrecerá un dispositivo serie `/dev/ttyAMA0` o `/dev/ttyS0` para los datos NMEA 0183. OpenPlotter dispone de una práctica utilidad de configuración de dispositivos serie que permite configurar y conectar el GNSS HAT a Signal K.

## Batería de respaldo

El GNSS HAT dispone de un conector para una batería de respaldo. La batería de respaldo sirve para conservar la información de efemérides cuando la Raspberry Pi está sin alimentación. La batería de respaldo no es obligatoria, pero acorta el tiempo necesario para obtener una posición GNSS tras encender la Raspberry Pi.

El tipo de batería de respaldo es ML1220. Es una batería de litio recargable y **no** debe sustituirse por una pila no recargable. ¡Hacerlo conlleva riesgo de explosión e incendio! Los usuarios avanzados pueden, bajo su propia responsabilidad, retirar la resistencia R3 para desactivar la función de carga y usar así una pila CR1220 no recargable. Los esquemas y el trazado del PCB están disponibles en la [página wiki de Waveshare](https://www.waveshare.com/wiki/MAX-M8Q_GNSS_HAT).
