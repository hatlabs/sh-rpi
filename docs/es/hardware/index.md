---
title: Descripción del hardware
translated_from: 257eeaa16d90da32404917c6093ffa709b5400f8
---

# Descripción del hardware

## Recorrido por la placa

A continuación se describen los distintos bloques funcionales del Sailor Hat for Raspberry Pi.

<figure markdown="span">
![](SH-RPi-2.0.0-func.jpg){ width="60%" }
<figcaption>Bloques funcionales del SH-RPi.</figcaption>
</figure>

1. Entrada de alimentación y protección.
   La alimentación se introduce mediante un conector compatible con Phoenix MC de 3,81 mm (0,15″) de paso.
   El rango de tensión permitido es de 9–32 V.
   El circuito de protección de la entrada incluye:
    - Fusible SMD de 4 A
    - Supresor de transitorios de tensión de 33 V (capacidad de potencia de pulso de pico de 5000 W)
    - Diodo de protección contra inversión de polaridad
    - Una bobina de choque y un filtro en pi para controlar las interferencias electromagnéticas conducidas
2. Convertidor reductor (buck) de primera etapa con limitación de corriente.
   El convertidor reductor transforma la tensión de entrada en un potencial de 8,8 V que el banco de supercondensadores puede soportar.
   El circuito del convertidor reductor incluye además un limitador de corriente independiente que restringe la corriente de entrada a 0,8 A (con la configuración predeterminada).
3. Tres supercondensadores de 20 F y 3,0 V.
   El banco de supercondensadores actúa como reserva de energía para la Raspberry Pi.
   Puede alimentar una Raspberry Pi 4B durante hasta 70 segundos (dependiendo, por supuesto, de la cantidad de periféricos adicionales) y los modelos de menor consumo durante mucho más tiempo.
   El supercondensador también permite alimentar la Raspberry Pi desde una interfaz de baja potencia como el bus NMEA 2000, que limita la corriente máxima de cada nodo a 1,0 A.
4. Microcontrolador.
   El funcionamiento del SH-RPi está controlado por un microcontrolador ATtiny1616.
   El microcontrolador realiza las siguientes funciones:
    - Mide la tensión de entrada
    - Mide la corriente de entrada
    - Mide la tensión de los supercondensadores
    - Controla el conjunto de LED de estado
    - Controla la salida de 5 V
    - Recibe la información de interrupción del reloj de tiempo real
    - Comunica el estado del SH-RPi al servicio de la Raspberry Pi por I2C
5. Convertidor reductor de segunda etapa.
   El convertidor reductor convierte el potencial del banco de supercondensadores en la tensión de entrada de 5 V de la Raspberry Pi. La capacidad máxima de corriente de salida instantánea es de 5 A, y se pueden alcanzar al menos 3 A como corriente continua sin refrigeración activa.
   El microcontrolador controla el funcionamiento del convertidor reductor. El microcontrolador activa el convertidor elevador cuando la tensión de los supercondensadores ha superado los 8,0 V.
   Durante el apagado del sistema o un reinicio por watchdog (temporizador de vigilancia), el microcontrolador desactiva el convertidor elevador para cortar la tensión de entrada de la Raspberry Pi.
6. Conjunto de LED de estado.
   Los cuatro LED de estado indican el estado de funcionamiento de la placa, tal como se describe en la sección [LED de estado](#led-de-estado).
7. Reloj de tiempo real.
   La placa incluye un reloj de tiempo real PCF8563 que mantiene la hora con precisión incluso sin conexión a internet ni a GPS.
   El RTC se comunica con la Raspberry Pi por I2C.

## Conectores

<div class="row">
  <div class="col-sm-6">

<figure markdown="span">
![](SH-RPi-2.0.0-conx.jpg){ width="100%" }
<figcaption>Conectores del SH-RPi, cara superior.</figcaption>
</figure>

   </div>
   <div class="col-sm-6">

<figure markdown="span">
![](SH-RPi-2.0.0-conx-back.jpg){ width="100%" }
<figcaption>Conectores del SH-RPi, cara inferior.</figcaption>
</figure>

   </div>
</div>

1. Conector de entrada de alimentación.

   El conector de alimentación es un conector compatible con Phoenix MC de 3,81 mm (0,15″) de paso.
   El paquete de venta incluye una clavija de terminales de tornillo compatible.
2. Conector de salida de 5 V.
   A este conector se pueden conectar periféricos externos de 5 V. El conector de salida de 5 V es también un conector compatible con Phoenix MC de 3,81 mm (0,15″) de paso.
3. Conector GPIO pasante de la Raspberry Pi.
   Es un conector GPIO estándar de Raspberry Pi de 2×20 pines. Para conectar el SH-RPi a una Raspberry Pi hay que insertar el conector de pines pasante (stack-through) suministrado.
   Se pueden apilar otros HAT sobre el Sailor Hat.
4. Conector de pines de programación y depuración del ATtiny1616.
   Este conector permite programar el microcontrolador con un programador externo o habilitar la programación en la propia placa.
5. Conector de puentes del limitador de corriente.
   Se pueden colocar puentes (jumpers) en el conector de puentes del limitador de corriente para cambiar el límite de corriente a 1,8 A o 2,8 A (el valor predeterminado es 0,8 A).
   Colocar un puente en horizontal en la fila superior (marcada «2A») para fijar el límite de corriente en 1,8 A. Colocar un puente en horizontal en la fila inferior (marcada «3A») para fijar el límite de corriente en 2,8 A.
6. Conector de pines de interrupción externa. No funcional en el hardware v2.0.0.
7. Conector de la pila CR1220 del reloj de tiempo real (en la cara inferior).
   El reloj de tiempo real necesita una pila de respaldo CR1220 para mantener la hora cuando el sistema está sin alimentación.
   La pila debe orientarse con el lado positivo (el más plano) en sentido opuesto a la placa.
8. Puente de soldadura «RTC Enable».
   El reloj de tiempo real está activado de forma predeterminada.
   Para desactivar el RTC, cortar las pistas entre los contactos del puente de soldadura con un cuchillo afilado.
   Hay que tener cuidado de no cortar ninguna pista cercana.
9. «GPIO4 Enable». Unir los contactos para conectar el GPIO4 de la Raspberry Pi al puerto PB5 del microcontrolador de la placa.
   Para que resulte útil, se requiere una funcionalidad de firmware personalizada.

## Fuente de alimentación

El SH-RPi incluye un subsistema de alimentación integrado que proporciona una alimentación limpia a la Raspberry Pi a partir de una fuente ruidosa, como las fuentes de alimentación no reguladas o el sistema de baterías «de servicio» de una embarcación. La fuente de alimentación admite tensiones de entrada de 9–32 V, aunque un potencial inferior a 10 V se considera una situación de subtensión, para evitar daños por descarga profunda en las baterías de plomo-ácido habituales.

El diagrama de funcionamiento del subsistema de alimentación se muestra en la imagen siguiente.

La corriente máxima de entrada está restringida para proteger las fuentes de alimentación y el cableado aguas arriba. El límite de corriente predeterminado es de 0,8 A, pero puede aumentarse a 1,8 A o 2,8 A colocando puentes en el conector de puentes del limitador de corriente.

El convertidor reductor de primera etapa reduce la tensión de entrada para cargar el banco de supercondensadores hasta una tensión de 8,8 V. Los supercondensadores proporcionan una reserva de energía a la Raspberry Pi, tanto para microcortes de corta duración como para alimentar el sistema como último recurso durante un apagado.

El convertidor reductor de segunda etapa convierte la tensión de los supercondensadores en la tensión de entrada de 5 V de la Raspberry Pi. El microcontrolador activa la salida de 5 V cuando la tensión de los supercondensadores está por encima de 8,0 V y la desactiva cuando esa tensión cae por debajo de 5,0 V. El usuario puede configurar estos umbrales de tensión.

La corriente de salida de pico máxima hacia la Raspberry Pi es de 5 A. La corriente de salida media máxima depende del ajuste del limitador de corriente de entrada y de la temperatura ambiente. Con un límite de corriente de entrada de 0,8 A, la corriente de salida sostenida máxima es de unos 1,4 A. Con un límite de corriente de entrada de 2,8 A, la corriente de salida media máxima queda limitada por las características térmicas del sistema. En un espacio abierto y a temperatura ambiente, la corriente
   de salida media de 5 V es de al menos 3,0 A. Con refrigeración activa de la placa SH-RPi son posibles valores más altos.

Con una corriente de salida de 1,4 A, la eficiencia total de la fuente de alimentación es del 79 %.

<figure markdown="span">
![](psu_diagram.svg){ width="70%" }
<figcaption>Diagrama de funcionamiento de la fuente de alimentación con valores de corriente y tensión de ejemplo.</figcaption>
</figure>

## LED de estado

El conjunto de LED del SH-RPi situado en el lado izquierdo de la placa indica el estado de funcionamiento de la placa.
La barra de LED indica el estado de carga del banco de supercondensadores. El primer LED empieza a encenderse cuando la tensión supera los 5 V, y todos los LED están completamente encendidos con un potencial de 9 V en los supercondensadores.

Superpuestos a la barra de LED, distintos patrones de parpadeo indican el estado de la placa de la manera siguiente.

| Patrón | Descripción |
|---------|-------------|
| Sin parpadeo | Carga/funcionamiento normal (1) |
| Breve apagado cada 4 s | Watchdog activo (2)  |
| Desplazamiento hacia la izquierda | Sin tensión de entrada (3) |
| Dos apagados breves con pausa de 1 s| Apagándose (4) |
| Dos destellos con pausa de 2 s | En reposo (5) |
| LED parpadeando alternativamente| Reinicio por watchdog (6) |
| Parpadeo rápido | Fallo: contactar con el fabricante (7) |

A continuación se describen los estados en detalle:

1. Los supercondensadores se están cargando y, si su tensión está por encima de 8,0 V, la salida de 5 V está activada.
   El demonio de Raspberry Pi OS no está activo.
2. El demonio está activo y el watchdog está habilitado. El sistema operativo ha arrancado y funciona con normalidad.
3. Se ha perdido la alimentación de entrada y los supercondensadores se están descargando. La salida de 5 V está activada.
4. El demonio ha iniciado un apagado. El SH-RPi espera a que la Raspberry Pi se apague.
5. El SH-RPi está en estado de reposo. La salida de 5 V está desactivada y la placa espera una alarma del reloj de tiempo real para despertar.
6. El SH-RPi no ha recibido ninguna señal de latido («heartbeat») del demonio durante 10 s, lo que indica que la Pi se ha bloqueado.
   La Raspberry Pi se reinicia desconectando los 5 V durante dos segundos.
7. El SH-RPi ha detectado una situación de sobretensión en los supercondensadores. Contactar con el fabricante para obtener más ayuda.


## Funcionalidad de reinicio por watchdog

Además de la fuente de alimentación, el Sailor Hat for Raspberry Pi incorpora un temporizador watchdog por hardware que permite reiniciar la Raspberry Pi en caso de bloqueo del software o del hardware. El temporizador watchdog está activado de forma predeterminada y, si es necesario, puede desactivarse aplicando el comando `shrpi set watchdog 0` en la línea de comandos del dispositivo. Cuando está activado, el temporizador watchdog reinicia la Raspberry Pi si no recibe una señal de latido de la Raspberry Pi dentro de un intervalo de tiempo predeterminado (normalmente 10 segundos).

La Raspberry Pi debe ejecutar un servicio que envíe periódicamente una señal de latido al SH-RPi. El servicio se puede instalar desde el paquete de software suministrado.

Si el temporizador watchdog provoca un reinicio, el SH-RPi desactiva la salida de 5 V durante un breve periodo para forzar el reinicio de la Raspberry Pi. A continuación, el SH-RPi vuelve a activar la salida de 5 V para que la Raspberry Pi pueda arrancar de nuevo.

## Reloj de tiempo real

El SH-RPi incluye un reloj de tiempo real (RTC) PCF8563 que mantiene la hora con precisión incluso cuando la Raspberry Pi no está conectada a internet o no hay señal GPS disponible. El RTC está conectado a la Raspberry Pi a través del bus I2C.

Para usar el RTC hay que instalar una pila de respaldo CR1220 en la cara inferior de la placa. El lado positivo (el más plano) de la pila debe quedar orientado en sentido opuesto a la placa.

Al usar la placa SH-RPi con un RTC integrado, las direcciones I2C de los RTC pueden entrar en conflicto.
En ese caso, el RTC del SH-RPi se puede desactivar cortando las pistas entre los contactos del puente de soldadura «RTC EN».

## Configuración del hardware

El usuario puede configurar el Sailor Hat for Raspberry Pi para adaptarlo a casos de uso concretos. Las opciones de configuración incluyen:

1. Ajuste del limitador de corriente.
   El limitador de corriente de entrada se puede fijar en 0,8 A (predeterminado), 1,8 A o 2,8 A colocando puentes en el conector de puentes del limitador de corriente.
2. Activación del reloj de tiempo real.
   El RTC se puede activar o desactivar con un puente de soldadura.
3. Activación de GPIO4.
   Unir los contactos para conectar el GPIO4 de la Raspberry Pi al puerto PB5 del microcontrolador de la placa. Para que resulte útil, se requiere una funcionalidad de firmware personalizada.

## I2C

El Sailor Hat se comunica con la Raspberry Pi
mediante el bus I2C 1 en los pines GPIO 3 y 5. (GPIO2 y GPIO3, respectivamente).
La dirección I2C es 0x6d.

El reloj de tiempo real PCF8563 reserva además la dirección I2C 0x51 en el mismo bus.
