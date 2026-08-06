---
title: Primeros pasos
translated_from: 46b4add9db5ebdedd9ae7e3eba99744cd34a074c
---

# Primeros pasos

## Montaje del hardware

El SH-RPi se entrega completamente montado. Los pasos de instalación del hardware son:

1. Introducir el conector de pines pasante (stack-through) de 40 pines en el SH-RPi a través del conector hembra de la cara inferior, con los pines hacia arriba.
2. Conectar el SH-RPi al conector GPIO de la Raspberry Pi (opcionalmente, con los separadores hexagonales).
3. Conectar los cables de alimentación adecuados a las clavijas de terminales. Las clavijas de terminales se suministran con los tornillos apretados, por lo que conviene aflojarlos antes de introducir los cables.

<figure markdown="span">
![](shrpi_v2_hardware_assembly.jpg){ width="50%" }
<figcaption>Diagrama de montaje del hardware del SH-RPi v2.0.0.</figcaption>
</figure>

### Conexión de la alimentación

!!! warning
    ¡No conectar nunca la entrada de alimentación al conector de salida de 5 V! Hacerlo dañará permanentemente la Raspberry Pi y el SH-RPi.

Conectar una fuente de alimentación de 10–32 V al conector de entrada de alimentación del SH-RPi, como se muestra en la figura siguiente.

<figure markdown="span">
![](shrpi_power_input.jpg){ width="50%" }
<figcaption>Conectar la fuente de alimentación al conector rodeado en verde.</figcaption>
</figure>

La fuente de alimentación debe admitir al menos 1,0 A de corriente a la tensión de salida especificada.
En igualdad de condiciones, una alimentación con una tensión de salida mayor, como 24 V, da lugar a un funcionamiento algo más eficiente.
Por lo demás, los sistemas de 12 V de embarcaciones y vehículos, o las fuentes de corriente continua, funcionan bien.

## Instalación del software

Raspberry Pi OS necesita software adicional para ejecutar el servicio del sistema que inicia automáticamente el apagado cuando se corta la alimentación.
Para simplificar el proceso de instalación se proporciona un script de instalación automatizado.

### Instalación automatizada

Se proporciona un script de instalación automatizado. El script está probado en una instalación de Raspberry Pi OS recién grabada y puede fallar en sistemas muy modificados.
La instalación no se ha probado en otros sistemas operativos.

Para ejecutar el script de instalación automatizado, copiar y pegar el comando siguiente en el símbolo del sistema de la Raspberry Pi:

    curl -L \
        https://raw.githubusercontent.com/hatlabs/SH-RPi-daemon/main/install-online.sh \
        | sudo bash

El comando ocupa tres líneas y, al pegarlo en la ventana del terminal, puede mostrar caracteres de continuación de línea. No es un problema. Pulsar «Enter» para ejecutar el comando.

<figure markdown="span">
![](automated-installation-screenshot.png){ width="80%" }
<figcaption>Comando de instalación en el terminal</figcaption>
</figure>

El comando descarga el script de instalación y lo ejecuta automáticamente.

El script de instalación automatizado:

- habilita la interfaz I2C, necesaria para que el SH-RPi se comunique con la Raspberry Pi
- si se selecciona la compatibilidad con la placa adicional de interfaz NMEA 2000
  - habilita la interfaz SPI y un overlay de dispositivo
  - define la interfaz de red CAN
- si se selecciona la compatibilidad con la placa adicional de interfaz NMEA 0183
  - habilita la interfaz SPI y un overlay de dispositivo
- habilita el overlay de dispositivo del reloj de tiempo real
- si se selecciona la compatibilidad con el MAX-M8Q GNSS HAT
  - habilita la interfaz serie UART
  - deshabilita la consola serie
  - deshabilita el Bluetooth, ya que entra en conflicto con la interfaz serie UART
- instala el software de servicio del SH-RPi

## Carcasas

Si la Raspberry Pi y el SH-RPi van a utilizarse en exteriores, en un vehículo o en una embarcación, o en entornos con mucha condensación, ¡colocar siempre el dispositivo en una carcasa estanca!
Hat Labs
ofrece una amplia gama de [carcasas estancas](https://shop.hatlabs.fi/collections/accessories-enclosures).

Las carcasas mediana y grande incluyen una placa de montaje perforada y adaptadores de montaje con los que se pueden fijar la Raspberry Pi, los HAT adicionales y otros componentes.
Las demás carcasas se suministran con soportes adhesivos impresos en 3D.

### Montaje de la carcasa mediana

La carcasa de tamaño mediano está diseñada para alojar la Raspberry Pi 4 Model B, el SH-RPi y varios HAT en orientación vertical. La instalación se describe a continuación.

#### Montaje

Se parte de una carcasa vacía, como se muestra en la figura siguiente.

<figure markdown="span">
![](01_bare_box.jpg){ width="50%" }
<figcaption>Carcasa sin ninguno de los componentes.</figcaption>
</figure>

En primer lugar, instalar todos los conectores necesarios. Antes de instalarlos puede ser necesario soldarles los cables. Las instrucciones de soldadura de los terminales de copa se encuentran en este vídeo de YouTube:

<iframe width="560" height="315" src="https://www.youtube.com/embed/_GLeCt_u3U8" frameborder="0" allowfullscreen></iframe>

No existe un estándar real para la asignación de pines de los conectores de alimentación, pero se recomienda conectar siempre «GND» al pin 1 y +12 V/24 V al pin 2. La figura siguiente muestra el conector de alimentación instalado.

A continuación, introducir los conectores en la carcasa. La figura siguiente muestra los conectores instalados.

<figure markdown="span">
![](02_conx.jpg){ width="50%" }
<figcaption>Conectores instalados.</figcaption>
</figure>

Si la carcasa va a utilizarse en un entorno con condensación, como una embarcación o el exterior, sellar los agujeros restantes con prensaestopas con tapón ciego. La figura siguiente muestra cómo se instala el tapón en los prensaestopas.

<figure markdown="span">
![](03_gland_plug.jpg){ width="50%" }
<figcaption>Tapón del prensaestopas.</figcaption>
</figure>

Y la figura siguiente muestra los prensaestopas instalados. Así la carcasa queda estanca.

<figure markdown="span">
![](04_conx_plugs.jpg){ width="50%" }
<figcaption>Prensaestopas instalados.</figcaption>
</figure>

A continuación se toman las piezas que se van a instalar en la carcasa y se colocan sobre la placa de montaje. La figura siguiente muestra las piezas que se van a instalar. Las piezas de plástico negro son los soportes verticales que mantienen la pila de placas en su sitio.

<figure markdown="span">
![](05_ingredients.jpg){ width="50%" }
<figcaption>Ingredientes.</figcaption>
</figure>

Primero se atornillan los separadores hexagonales de 6 mm en los soportes verticales. ¡Apretar solo a mano!

La figura siguiente muestra los soportes verticales con los separadores instalados.

<figure markdown="span">
![](06_vertical_mounts.jpg){ width="50%" }
<figcaption>Soportes verticales con separadores hexagonales.</figcaption>
</figure>

Después, los soportes pueden fijarse a la Raspberry Pi o a la placa portadora. Utilizar los tornillos M2.5 para fijar la placa junto a los pines GPIO y los separadores hexagonales M2.5 de 16 mm en el lado opuesto.

A continuación se instala el conector de pines pasante en el SH-RPi. Presionar con suavidad y de manera uniforme para no doblar los pines. La altura óptima del conector depende del orden de los HAT. Si el SH-RPi se coloca directamente sobre la Raspberry Pi, retirar el separador del conector de pines pasante. En cambio, el separador es necesario si el SH-RPi se instala sobre otro HAT de interfaz.

<figure markdown="span">
![](07_stack_thru_conx.jpg){ width="50%" }
<figcaption>Introducción del conector de pines pasante.</figcaption>
</figure>

La figura siguiente muestra el SH-RPi montado sobre la placa portadora.

<figure markdown="span">
![](08_shrpi_mounted.jpg){ width="50%" }
<figcaption>SH-RPi montado sobre la placa portadora.</figcaption>
</figure>

#### Cableado de alimentación

En este recorrido se instala además un CAN HAT para la conectividad NMEA 2000. La figura siguiente muestra el CAN HAT montado sobre el SH-RPi.

<figure markdown="span">
![](09_can_mounted.jpg){ width="50%" }
<figcaption>CAN HAT montado sobre el SH-RPi.</figcaption>
</figure>

El paso siguiente es instalar la pila de placas sobre la placa de montaje. Fijar la pila en su sitio con los tornillos M3 suministrados. No apretar los tornillos en exceso.

<figure markdown="span">
![](10_on_base_mount.jpg){ width="50%" }
<figcaption>Pila de placas instalada sobre la placa de montaje.</figcaption>
</figure>

A continuación, pelar los cables de los conectores. Si se utiliza un conector de alimentación independiente, el cable rojo del NMEA 2000 debe dejarse sin pelar o cortarse por completo. La figura siguiente muestra los cables pelados.

<figure markdown="span">
![](13_stripped_wires.jpg){ width="50%" }
<figcaption>Cables de alimentación y CAN pelados.</figcaption>
</figure>

El paso siguiente es conectar los cables a los conectores de la placa. El conector de alimentación se conecta a la clavija de terminales como se muestra en la figura siguiente.

Al insertar la clavija de terminales, hay que asegurarse _muy_ bien de conectarla al conector de entrada del SH-RPi. ¡Conectarla al conector de salida de 5 V puede dañar todos los dispositivos de la pila!

<figure markdown="span">
![](14_power_conx.jpg){ width="50%" }
<figcaption>Disposición de la clavija de terminales del conector de alimentación.</figcaption>
</figure>

Después, los cables CAN se conectan al conector «CAN0» del CAN HAT como se muestra a continuación. El negro es masa, el blanco es CAN high (H) y el azul es CAN low (L).

<figure markdown="span">
![](15_wires_plugged.jpg){ width="50%" }
<figcaption>Disposición final del cableado.</figcaption>
</figure>

#### Alimentación desde NMEA 2000

En una embarcación, el sistema también puede alimentarse desde la red NMEA 2000. En ese caso se utilizan todos los cables del conector NMEA 2000.

<figure markdown="span">
![](18_alt_can_wires.jpg){ width="50%" }
<figcaption>Cuando el dispositivo se alimenta desde la red NMEA 2000, se utilizan todos los cables del conector NMEA 2000.</figcaption>
</figure>

Los cables negro y rojo se conectan a la clavija de terminales de alimentación, con un trozo corto de cable negro empalmado al terminal «GND», como se muestra en la figura siguiente. El cable negro corto se conecta al terminal «GND» del conector «CAN0» del CAN HAT.

<figure markdown="span">
![](19_spliced_gnd.jpg){ width="50%" }
<figcaption>Conectar el cable «GND» del NMEA 2000 tanto a la clavija de terminales de alimentación como al conector «CAN0» del CAN HAT.</figcaption>
</figure>

La figura siguiente muestra la disposición final del cableado cuando el dispositivo se alimenta desde la red NMEA 2000.

<figure markdown="span">
![](20_can_power_wiring.jpg){ width="50%" }
<figcaption>Disposición final del cableado cuando el dispositivo se alimenta desde la red NMEA 2000.</figcaption>
</figure>

#### Fijación de la pila

Por último, el extremo libre de la pila puede fijarse a la placa de montaje con bridas pequeñas; como alternativa, unas bridas sencillas son una opción simple y fácil de utilizar. Las dos figuras siguientes muestran la instalación de las bridas.

<figure markdown="span">
![](11_tie_wraps.jpg){ width="50%" }
<figcaption>Bridas colocadas.</figcaption>
</figure>

<figure markdown="span">
![](12_tie_wraps_2.jpg){ width="50%" }
<figcaption>Instalación de las bridas terminada.</figcaption>
</figure>

#### Finalización del montaje

En este punto, la placa de montaje puede introducirse en la carcasa.

<figure markdown="span">
![](16_in_place.jpg){ width="50%" }
<figcaption>Placa de montaje colocada.</figcaption>
</figure>

Fijar la placa de montaje a la carcasa con los tornillos suministrados.

<figure markdown="span">
![](17_screw_base_mount.jpg){ width="50%" }
<figcaption>Atornillado de la placa de montaje a la carcasa.</figcaption>
</figure>

Con esto el montaje está terminado. La figura siguiente muestra el conjunto parpadeando alegremente dentro de la carcasa.

<figure markdown="span">
![](21_all_done.jpg){ width="50%" }
<figcaption>El conjunto terminado.</figcaption>
</figure>

La carcasa puede fijarse a una pared o a un mamparo a través de los orificios de las esquinas que se muestran en la figura siguiente.

<figure markdown="span">
![](22_mounting.jpg){ width="50%" }
<figcaption>Ubicación de los orificios de montaje.</figcaption>
</figure>


### Taladrado de los agujeros

Si se utiliza una carcasa sin orificios pretaladrados, hay que taladrar los agujeros.

Como mínimo se necesita un agujero para la entrada de alimentación y, en cualquier carcasa metálica, otro para una antena WiFi o un conector Ethernet por cable.

Planificar la colocación de los agujeros y los conectores según el lugar de instalación previsto.
Si la carcasa va a montarse en pared, colocar los conectores hacia abajo para minimizar las posibilidades de entrada de agua.

Tanto el aluminio como el policarbonato son relativamente blandos y pueden taladrarse con una broca escalonada (esa que parece un pequeño árbol de Navidad metálico).
Al taladrar plástico, las brocas normales para metal pueden morder con demasiada fuerza y agrietar la pared.

<figure markdown="span">
![](step_drill_bit.jpg){ width="50%" }
<figcaption>Un ejemplo de brocas escalonadas.</figcaption>
</figure>

Tamaños de agujero adecuados para los distintos conectores:

- SMA (antena WiFi): 6,5–7 mm o 1/4″
- prensaestopas PG7 y conector de panel M12 (NMEA 2000): 12,5 mm o 1/2″
- conectores de panel SP13 (conectores de plástico azul y negro): 13 mm.
- prensaestopas PG9: 16 mm o 5/8″
- conector de panel RJ45: 21–22 mm
- conector de panel USB tipo A: 21–22 mm

### Montaje de la Raspberry Pi

Las carcasas suministradas por Hat Labs incluyen adaptadores de montaje con los que se puede fijar la Raspberry Pi.

### Soldadura de los conectores de panel

Al soldar los cables internos a los conectores de panel, utilizar siempre tubo termorretráctil en cada uno de los cables.
Recordar siempre deslizar el termorretráctil sobre los cables _antes_ de soldar...
Normalmente se puede añadir primero estaño a la cavidad del pin del conector y después volver a fundir la soldadura e introducir el cable.

### Conexión de un ventilador

Se recomienda colocar un ventilador dentro de la carcasa para mejorar la circulación del aire y la transferencia de calor a través de las
superficies de la carcasa.
Un pequeño ventilador de 40 mm puede fijarse a la carcasa con cinta de doble cara o pegamento termofusible.

El ventilador se conecta al conector genérico de salida de 5 V del SH-RPi:

<figure markdown="span">
![](shrpi_5v_output.jpg){ width="50%" }
<figcaption>Conectar el ventilador al conector indicado por la flecha roja.</figcaption>
</figure>

### Finalización de la instalación

Una vez taladrados los agujeros, montada la Raspberry Pi, soldados los conectores de panel y conectado el ventilador, cerrar la carcasa para proteger el SH-RPi y la Raspberry Pi de la intemperie. Comprobar que todas las conexiones están firmes y que la carcasa queda bien sellada para evitar la entrada de agua.

### Prueba del sistema

Terminada la instalación, encender el sistema formado por la Raspberry Pi y el SH-RPi para comprobar que todo funciona correctamente. Verificar que la Raspberry Pi arranca, que el ventilador funciona y que el SH-RPi se comunica con la Raspberry Pi. Una vez comprobado que todo funciona, se puede continuar con la configuración del software y con la integración del sistema en el entorno previsto.

¡Enhorabuena! El montaje del hardware y la instalación en la carcasa del sistema formado por el SH-RPi y la Raspberry Pi están terminados.
