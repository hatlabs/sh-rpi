---
title: Software
translated_from: fde8306627421de6b86970b1032ab7a63699a495
---

# Software

## Introducción

El Sailor Hat for Raspberry Pi necesita software adicional en el sistema operativo de la Raspberry Pi para aprovechar todas las funciones del dispositivo. Se proporciona un script de instalación que instala automáticamente todo el software necesario en una instalación nueva de Raspberry Pi OS. El uso del script de instalación se describe en la [sección Primeros pasos](../getting-started/index.md). Las instrucciones de instalación manual solo son necesarias si no se desea que los scripts automatizados modifiquen la configuración del sistema o si hay que resolver problemas de la instalación.

Para la instalación manual, descargar el código en [github.com/hatlabs/SH-RPi-daemon](https://github.com/hatlabs/SH-RPi-daemon). A continuación se describen el software y los cambios de configuración necesarios, así como los detalles del firmware.

### Habilitar I2C y SPI

Es necesario habilitar las interfaces I2C y SPI. Esto puede hacerse ejecutando `raspi-config` o editando directamente `/boot/firmware/config.txt`.

Si se utiliza `raspi-config`, saltar hasta el final de este apartado.

```bash
sudo nano /boot/firmware/config.txt
```

Buscar la línea siguiente:

```ini
#dtparam=i2c_arm=on
```

y editarla eliminando el marcador de comentario del principio:

```ini
dtparam=i2c_arm=on
```

### Habilitar las nuevas interfaces

Editar de nuevo `/boot/firmware/config.txt`:

    sudo nano /boot/firmware/config.txt

Desplazarse hasta la sección `[all]`.

Hay que añadir tres líneas nuevas. En primer lugar, habilitar el reloj de tiempo real o RTC (si el dispositivo lo tiene):

    dtoverlay=i2c-rtc,pcf8563

Después, configurar el kernel para que avise al Sailor Hat en la desconexión de la alimentación:

    dtoverlay=gpio-poweroff,gpiopin=2,input,active_low=17

De nuevo, guardar el archivo pulsando Ctrl-O y salir de Nano pulsando Ctrl-X.

## Demonio de la Raspberry Pi

Para que Raspberry Pi OS conozca el estado de la alimentación, es necesario instalar un demonio (software de servicio).

Si se ha clonado el repositorio SH-RPi-daemon, el demonio puede instalarse con los comandos siguientes:

```bash
sudo apt install -y python3-pip
sudo pip3 install .
```

A continuación hay que instalar el archivo de definición del servicio y habilitar el servicio:

```bash
sudo install -o root shrpid.service /lib/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable shrpid
```

¡Y ya está! Tras un reinicio, el demonio se inicia automáticamente.

*Nota: el script de instalación automatizado descrito en la [sección Primeros pasos](../getting-started/index.md) realiza automáticamente todos los pasos de instalación del software descritos arriba.*

### Archivo de configuración del demonio

Los ajustes del demonio se configuran creando y editando el archivo de configuración `/etc/shrpid.conf`.
El archivo utiliza formato YAML.
Están disponibles las opciones siguientes:

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

Se puede crear un archivo de configuración nuevo ejecutando `nano /etc/shrpid.conf` y pegando en él el contenido anterior.
Comentar las líneas que no se quieran modificar.
Guardar el archivo pulsando Ctrl-O y salir de Nano pulsando Ctrl-X.

## Interfaz de línea de comandos

La interfaz de línea de comandos es un script de Python con el que se puede controlar el Sailor Hat for Raspberry Pi desde la línea de comandos de la Raspberry Pi. La instala el script de instalación descrito en la [sección Primeros pasos](../getting-started/index.md).

El script `shrpi` puede ejecutarse con la opción `--help` para obtener instrucciones sobre los distintos comandos. A continuación se describen algunos de los casos de uso principales.

```bash
shrpi print
```

Muestra el estado y la configuración actuales del Sailor Hat for Raspberry Pi.

```bash
shrpi set <option> <value>
```

Establece distintos valores de configuración. Por ejemplo,

```bash
shrpi set led 50
```

ajusta el brillo de los LED al 50 %.

```bash
shrpi sleep 3600
```

Apaga la Raspberry Pi y la vuelve a encender al cabo de 3600 segundos (1 hora).

```bash
shrpi sleep 15:00
```

Apaga la Raspberry Pi y la vuelve a encender a las 15:00 (las 3 de la tarde).

```bash
shrpi sleep 15:00:00
```

## API REST

`shrpid` implementa una API REST con la que se puede consultar el estado y la configuración actuales del Sailor Hat for Raspberry Pi y establecer valores de configuración.
La API está disponible en un socket de archivo en `/var/run/shrpid.sock`. A continuación se muestra una consulta de ejemplo con `curl`:

    curl --unix-socket /var/run/shrpid.sock http://localhost/state

Para más detalles sobre los comandos disponibles, consultar el [código fuente de SH-RPi-daemon](https://github.com/hatlabs/SH-RPi-daemon/).

## Firmware

El código que se ejecuta en el microcontrolador ATtiny1616 integrado en la placa se denomina firmware del SH-RPi.

El repositorio del firmware está en [https://github.com/hatlabs/SH-RPi-firmware](https://github.com/hatlabs/SH-RPi-firmware).

En los apartados siguientes se describe cómo actualizar el firmware para obtener nuevas funciones o para modificarlo uno mismo.

### Actualización del firmware

El firmware del SH-RPi puede actualizarse con la propia Raspberry Pi.
Para ello hacen falta unos puentes (jumpers) y un poco de configuración de software.

La grabación se realiza a través de la interfaz UPDI del ATtiny mediante [`avrdude`](https://github.com/SpenceKonde/AVR-Guidance/blob/master/UPDI/jtag2updi.md).

#### Configuración del hardware

Colocar puentes en todos los pines del conector «PROG», como se indica en rojo en la figura siguiente. Así se conectan a la Raspberry Pi el circuito programador del microcontrolador y la interfaz serie de depuración. Además, la salida de 5 V del controlador reductor se fuerza a encendido, de modo que la Raspberry Pi no se apague al iniciar el proceso de grabación.

<figure markdown="span">
![](SH-RPi-2.0.0-prog-conx.jpg){ width="50%" }
<figcaption>Colocar los puentes rojos para habilitar la autograbación.</figcaption>
</figure>

¡Atención! Para que el funcionamiento posterior sea correcto, es imprescindible retirar al menos el tercer puente del conector «PROG». De lo contrario, la Raspberry Pi no podrá apagarse a sí misma.

#### Cambios de configuración en la Raspberry Pi

El paso siguiente es habilitar las UART serie de la Raspberry Pi. Se utilizan tanto para la interfaz UPDI como para la de depuración serie.
En las Pi con Bluetooth, la UART está reservada normalmente por el circuito Bluetooth integrado. Por tanto, se deshabilita el Bluetooth.

Añadir las líneas siguientes al final de `/boot/firmware/config.txt`:

```ini
dtoverlay=disable-bt
dtoverlay=uart5
```

La primera deshabilita el módem Bluetooth. La segunda habilita la interfaz UART5 en los GPIO 12 y 13, situados en los pines 32 y 33. Esta es la interfaz serie que el firmware del SH-RPi utiliza para la depuración.

También hay que deshabilitar el servicio del sistema que inicializa el módem Bluetooth:

```bash
sudo systemctl disable hciuart
```

Por último, impedir que la consola serie del sistema se conecte al puerto serie. Eliminar la parte `console=serial0,115200` del principio de `/boot/cmdline.txt`.

Reiniciar para que los cambios surtan efecto.

#### Instalación del software de grabación

Gracias al framework [PlatformIO](https://platformio.org/), todas las herramientas necesarias pueden descargarse e instalarse automáticamente. Solo hay que obtener antes
el código fuente del firmware. Se instala el sistema de control de versiones `git` y se clona el repositorio del firmware:

```bash
sudo apt update
sudo apt -y install git
git clone git@github.com:hatlabs/SH-RPi-firmware.git
```

Ahora se puede instalar el framework PlatformIO:

```bash
sudo pip3 install -U platformio
```

Editar el archivo `platformio.ini` y cambiar `upload_port` a `/dev/ttyAMA0`:

```ini
[env]
...
upload_port = /dev/ttyAMA0
monitor_port = /dev/ttyAMA1
```

#### Grabación

Por último, se puede compilar y subir el firmware. La primera vez que se ejecuta este comando, descarga e instala las herramientas necesarias. Puede tardar un rato.

```bash
cd SH-RPi-firmware
pio run -t upload
```

Los LED de estado blancos se apagan durante la grabación. Al cabo de unos segundos vuelven a encenderse y la grabación ha terminado. En ese momento, retirar los puentes del conector «PROG».

#### Restauración del Bluetooth

Si se quiere seguir utilizando el Bluetooth, hay que deshacer los pasos realizados anteriormente. Para ello hay que revertir los cambios hechos en `/boot/firmware/config.txt` y `/boot/cmdline.txt`, y volver a habilitar el servicio `hciuart`:

1. Eliminar las líneas siguientes de `/boot/firmware/config.txt`:

```ini
dtoverlay=disable-bt
dtoverlay=uart5
```

2. Volver a añadir `console=serial0,115200` al principio de `/boot/cmdline.txt`.

3. Volver a habilitar el servicio `hciuart` ejecutando:

```bash
sudo systemctl enable hciuart
```

4. Reiniciar la Raspberry Pi para que los cambios surtan efecto.

¡Y ya está! El firmware del Sailor Hat for Raspberry Pi está actualizado y, si se deseaba, la funcionalidad Bluetooth queda restaurada.
