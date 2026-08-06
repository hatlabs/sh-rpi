---
title: Compute Module 4
translated_from: 2769961d8eba6a0a776d8bf6566816716c7c9cac
---

# Compute Module 4

El [Compute Module 4](https://www.raspberrypi.org/products/compute-module-4/) es un módulo de ordenador de formato reducido que se inserta en una placa portadora. Con un rendimiento de CPU idéntico al de la Raspberry Pi 4B, el CM4 es una solución potente, flexible y económica para aplicaciones embebidas. A la hora de construir ordenadores embebidos, el CM4 tiene varias ventajas frente a la Raspberry Pi 4B:

- Memoria flash eMMC integrada: las placas CM4 tienen, según el modelo, hasta 32 GB de memoria flash eMMC. Esta memoria es más fiable y más rápida que la tarjeta SD que utiliza la Raspberry Pi 4B.
- Posibilidad de antena WiFi externa: el CM4 tiene un conector específico para una antena WiFi externa. Resulta útil si la intensidad de señal de la antena WiFi interna no es suficiente.
- Conector M.2: muchas placas portadoras tienen un conector M.2 que permite conectar un SSD M.2 o un módulo WiFi M.2.
- Menor consumo: en pruebas informales se ha comprobado que un CM4 con una placa portadora consume más de un 20 % menos que una Raspberry Pi 4B.

Como inconveniente, la mayoría de las placas portadoras para CM4 no incluyen un concentrador USB 3.0, por lo que los puertos USB quedan limitados a la velocidad de USB 2.0. Además, grabar la eMMC es algo más complicado que grabar una tarjeta SD. El proceso se describe a continuación.

## Grabación de la memoria eMMC del CM4

Primero hay que descargar una imagen del sistema operativo adecuada. Como ejemplo se usa la imagen Headless de [OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/downloading.html), pero el proceso es el mismo para otras imágenes. **Nota:** ¡usar siempre una imagen de 64 bits! Algunos componentes de software dan problemas al ejecutarse en un sistema de 32 bits (InfluxDB, en particular).

La memoria eMMC se puede grabar con la misma imagen que la Raspberry Pi 4B. El proceso de grabación tiene dos pasos adicionales. En primer lugar, hay que poner el CM4 en un modo «BOOT» especial que en realidad *impide* que el dispositivo arranque y permite grabar la eMMC. En segundo lugar, en el ordenador utilizado para la grabación hay que instalar y ejecutar una pequeña utilidad, `rpiboot`, que permite montar la memoria eMMC en ese ordenador. Una vez completados estos pasos, el proceso de grabación es idéntico al de la Raspberry Pi 4B.

Para Windows, `rpiboot` está disponible como ejecutable precompilado, pero para Linux y MacOS hay que compilarlo a partir del código fuente. El proceso para cada plataforma se describe en los apartados siguientes.

Notas sobre el proceso de instalación:

1. Para grabar la eMMC hay que poner la placa portadora en modo «BOOT». En las placas Waveshare CM4-IO-BASE hay que girar el pequeño interruptor «BOOT» situado junto al conector HDMI0 a la posición «ON».
2. La placa portadora debe estar conectada a una fuente de alimentación externa durante el proceso de grabación. ¡Usar la placa SH-RPi para ello!

### Windows

1. Seguir las instrucciones de la [documentación de Raspberry Pi](https://www.raspberrypi.com/documentation/computers/compute-module.html#flashing-the-compute-module-emmc) para configurar el modo de grabación en el ordenador anfitrión.
2. Seguir las [instrucciones de instalación de OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html).
3. **Nota:** ¡no arrancar todavía el sistema! Antes hay que ajustar algunos parámetros, tal como se describe más abajo en la sección Configuración del CM4.
4. Después de cambiar los parámetros de configuración, volver a poner el interruptor «BOOT» en la posición «OFF» y reiniciar el sistema. Se puede continuar entonces con las instrucciones de OpenPlotter.

### Mac

En un Mac hay que compilar la utilidad `rpiboot` a partir del código fuente.

1. Para compilar la utilidad hay que tener [Homebrew](https://brew.sh/) instalado. Conviene hacerlo primero.
2. A continuación, seguir los [pasos indicados en el repositorio `usbboot`](https://github.com/raspberrypi/usbboot#macos). Al ejecutar `sudo ./rpiboot`, la placa portadora del CM4 debe estar conectada al ordenador y alimentada mediante el SH-RPi. Si aparece un mensaje de error, comprobar el cable USB y el interruptor «BOOT» de la placa portadora.
3. Seguir las [instrucciones de instalación de OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html). **Nota:** ¡no arrancar todavía el sistema! Antes hay que ajustar algunos parámetros, tal como se describe más abajo en la sección Configuración del CM4.
4. Después de cambiar los parámetros de configuración, volver a poner el interruptor «BOOT» en la posición «OFF» y reiniciar el sistema. Se puede continuar entonces con las instrucciones de OpenPlotter.

### Linux

Al igual que en un Mac, en Linux hay que compilar la utilidad `rpiboot` a partir del código fuente.

1. Para compilar la utilidad hay que tener [Homebrew](https://brew.sh/) instalado. Conviene hacerlo primero.
2. A continuación, seguir los [pasos indicados en el repositorio `usbboot`](https://github.com/raspberrypi/usbboot#linux--cygwin--wsl). Al ejecutar `sudo ./rpiboot`, la placa portadora del CM4 debe estar conectada al ordenador y alimentada mediante el SH-RPi. Si aparece un mensaje de error, comprobar el cable USB y el interruptor «BOOT» de la placa portadora.
3. Seguir las [instrucciones de instalación de OpenPlotter](https://openplotter.readthedocs.io/en/3.x.x/getting_started/installing.html). **Nota:** ¡no arrancar todavía el sistema! Antes hay que ajustar algunos parámetros, tal como se describe más abajo en la sección Configuración del CM4.
4. Después de cambiar los parámetros de configuración, volver a poner el interruptor «BOOT» en la posición «OFF» y reiniciar el sistema. Se puede continuar entonces con las instrucciones de OpenPlotter.

## Configuración del CM4

### Habilitación de los puertos USB

Antes del primer arranque del sistema hay que hacer algunos cambios en la configuración. De forma predeterminada, los puertos USB del CM4 están deshabilitados. Evidentemente, esto puede ser un problema importante si se quiere usar el sistema con teclado y ratón. Para habilitar los puertos USB hay que editar el archivo `config.txt` de la memoria eMMC. La partición Boot debería estar ya montada en el ordenador como una unidad USB. Abrir la unidad y editar el archivo `config.txt`. Añadir la siguiente línea al final del archivo:

    dtoverlay=dwc2,dr_mode=host

Guardar el archivo y cerrarlo.

### Habilitación de la antena WiFi externa

Si se dispone de una antena WiFi externa, hay que editar de nuevo el archivo `config.txt`. Añadir la siguiente línea al final del archivo:

    dtparam=ant2

Otros valores posibles son `ant1` para la antena del PCB y `noant` para desactivar ambas antenas. El valor predeterminado es `ant1`.
