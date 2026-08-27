---
title: Instalación del servidor OpenPlotter
translated_from: 69cd214b5911c56a3544b6ab748a0ad149ba04e9
---

!!! warning
    Esta sección todavía no se ha actualizado a los cambios del hardware v2.

<div style="-moz-filter: opacity(30%); -webkit-filter: opacity(30%); filter: opacity(30%);">

## Introducción

En este tutorial se construye un servidor OpenPlotter con [Sailor Hat for Raspberry Pi](https://docs.hatlabs.fi/sh-rpi/) ([enlace de compra](https://hatlabs.fi/product/sh-rpi-enclosure-kit/)) y el software OpenPlotter.
El servidor es compacto y estanco, y se alimenta con facilidad desde la instalación de 12/24 V de la embarcación.
También se integra sin problemas con la electrónica de a bordo existente.

El software incluido registra todo el tráfico NMEA 2000 esencial de la embarcación y permite visualizar el comportamiento de los distintos valores tanto en tiempo real como en el histórico, mediante paneles de instrumentos integrados y paneles de control de Grafana.
Además, el servidor puede recibir y procesar información de otras fuentes, por ejemplo de los [dispositivos sensores SH-ESP32](https://docs.hatlabs.fi/sh-esp32/) o de diversos servicios de Internet.

Algunos ejemplos de visualización:

<figure markdown="span">
![](assets/screenshots/001_examples.jpg){ width="75%" }
<figcaption>Ejemplos de visualización.</figcaption>
</figure>

## Piezas necesarias

Para completar este tutorial se necesitan las siguientes piezas:

- [Kit de carcasa SH-RPi](https://hatlabs.fi/product/sh-rpi-enclosure-kit/)

  La SH-RPi es el ingrediente secreto que aporta a la Raspberry Pi las interfaces de hardware que exigen los sistemas de la embarcación. La placa incluye una alimentación de 12/24 V integrada y protegida, con apagado seguro, y una interfaz CAN aislada y compatible con NMEA 2000.

  En este tutorial se usa la carcasa de plástico y la Pi se alimenta a través de un conector de panel NMEA 2000. Además se emplea un conector de panel USB tipo A para facilitar las conexiones cuando hagan falta, y se añade un ventilador para mejorar la disipación del calor. Cada cual puede adaptar su propia configuración.

  También se utiliza un adaptador WiFi USB adicional, porque simplifica la instalación (esa interfaz de red de más puede resultar útil a bordo). Quien no quiera el adaptador WiFi USB puede conectar la Pi a una red Ethernet por cable y obtener el mismo resultado.

- Una Raspberry Pi 4B

  Basta con el modelo de 4 GB de memoria. Amazon suele tener precios inmejorables, o se puede consultar la lista de distribuidores en el sitio web de Raspberry Pi:

    * [amazon.com](https://www.amazon.com/Raspberry-Model-2019-Quad-Bluetooth/dp/B07TC2BK1X/)
    * [amazon.de](https://www.amazon.de/-/en/Raspberry-ARM-Cortex-A72-WLAN-ac-Bluetooth-Micro-HDMI-Single/dp/B07TC2BK1X/)
    * [amazon.co.uk](https://www.amazon.co.uk/Raspberry-Pi-ARM-Cortex-A72-Bluetooth-Micro-HDMI/dp/B07TC2BK1X/)
    * [Lista de distribuidores de Raspberry Pi](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/?variant=raspberry-pi-4-model-b-4gb)

- Tarjeta de memoria MicroSD

  En la tarjeta MicroSD residen el sistema operativo y los archivos de datos de la Raspberry Pi. Con las tarjetas Samsung Evo Plus he obtenido buenos resultados. Las tarjetas de memoria son baratas y las de mayor capacidad resultan más fiables en la Raspberry Pi, así que conviene adquirir al menos una de 64 GB:

  * [amazon.com](https://www.amazon.com/Samsung-MicroSDXC-Memory-Adapter-MB-MC64GA/dp/B06XFWPXYD/)
  * [amazon.de](https://www.amazon.de/-/en/Samsung-Flash-Memory-MicroSDXC-Class/dp/B08BKCB4JW/)
  * [amazon.co.uk](https://www.amazon.co.uk/Samsung-MicroSDXC-Class-UHS-I-Memory/dp/B08BKCB4JW/)

- Cinta de doble cara o pegamento termofusible

  Para montar el ventilador hace falta un trozo corto de cinta de doble cara o una gota de pegamento termofusible.

- Tubo termorretráctil, 3 mm de diámetro interior

  Sin ser imprescindible, el tubo termorretráctil de 3 mm de diámetro interior resulta útil para asegurar los cables soldados del conector de panel.

- [Conector hembra NMEA 2000](https://hatlabs.fi/product/nmea-2000-cable-plug/)

  Si la primera instalación se hace en casa, viene bien disponer de un conector NMEA 2000 micro adicional para llevar la tensión de alimentación al equipo.

## Montaje del hardware

### Taladrado de los agujeros para los conectores

Como siempre que se taladra una carcasa en perfecto estado, conviene planificar con mucho cuidado. Los conectores de panel ocupan sorprendentemente espacio y un agujero no se tapa con facilidad, y menos aún se cambia de sitio.

Personalmente prefiero tomar las medidas de la carcasa y crear una plantilla de taladrado en un programa de dibujo vectorial. Un dibujo ayuda a ver las dimensiones máximas que exigen el conector y la tuerca.

Si no se sabe qué programa usar, [Inkscape](https://inkscape.org) es una buena herramienta polivalente. Para quien tenga un perfil más técnico, también puede servir un programa CAD como [LibreCAD](https://librecad.org).

Yo quería tres agujeros en el lado corto de la carcasa de plástico. Esta es la plantilla que preparé:

<figure markdown="span">
![](assets/plastic-enclosure-end-template.svg){ width="50%" }
<figcaption><a href="assets/plastic-enclosure-end-template.svg">Ejemplo de plantilla de taladrado.</a></figcaption>
</figure>

La [plantilla](assets/plastic-enclosure-end-template.svg) es un archivo SVG, es decir, vectorial, de modo que se puede guardar y modificar a voluntad.
Si no se sabe qué programa emplear, se puede probar por ejemplo el [Inkscape](https://inkscape.org) citado antes. Yo uso Affinity Designer, un programa de diseño comercial y económico disponible para MacOS.

Si abrir el SVG da problemas, la plantilla también está disponible en [versión PDF](assets/plastic-enclosure-end-template.pdf).

Una vez terminada la plantilla, marcar el punto central en la carcasa y fijar la plantilla con cinta de modo que los puntos centrales coincidan.

<figure markdown="span">
![](assets/photos/01_drill-template.jpg){ width="50%" }
<figcaption>Plantilla de taladrado sobre la caja.</figcaption>
</figure>


Para taladrar con precisión conviene marcar los centros de los agujeros con un granete (también valen un clavo afilado y un golpe suave de martillo).

Taladrar agujeros guía con una broca pequeña (de unos 3 mm). Usar después una broca escalonada para los agujeros definitivos. Ir despacio y a baja velocidad. Los agujeros pequeños de medidas poco habituales, como el de 6,5 mm, conviene rematarlos con una broca para metal del tamaño correspondiente.

Taladrar plástico deja muchas rebabas alrededor de los agujeros. Se quitan con un cuchillo afilado.

Por último, en la carcasa de plástico los separadores integrados pueden estorbar los agujeros taladrados. Yo tuve que quitar uno. Usé una herramienta Dremel, aunque unos alicates robustos seguramente también sirvan.

Así queda el resultado en mi caso.

<figure markdown="span">
![](assets/photos/02_drilled_holes.jpg){ width="50%" }
<figcaption>Agujeros taladrados.</figcaption>
</figure>


### Conexión de los cables al conector de panel NMEA 2000

A continuación se sueldan los latiguillos JST XH al conector de panel NMEA 2000. El mismo procedimiento vale para soldar los conectores de alimentación SP13 si se prefiere usar uno de ellos.
Se empieza rellenando de estaño las copas del conector.

<figure markdown="span">
![](assets/photos/021_soldered_cups.jpg){ width="50%" }
<figcaption>Copas estañadas.</figcaption>
</figure>


Se quiere alimentar tanto la propia placa como la interfaz CAN a través del conector NMEA 2000. Hay más de una manera de hacerlo, pero conviene seguir el método evidente y conectar ambos latiguillos al conector de panel NMEA.

Pelar un tramo corto de los cables rojo y negro y trenzarlos juntos.

<figure markdown="span">
![](assets/photos/022_spliced_wires.jpg){ width="50%" }
<figcaption>Cables empalmados.</figcaption>
</figure>


Se recomienda emplear tubo termorretráctil para aislar los pines del conector y dar apoyo mecánico a las soldaduras. Cortar trozos cortos de tubo y pasarlos por los cables. (Adivinen quién volvió a olvidarse de este paso mientras preparaba las fotos de este tutorial.)

Soldar los cables al conector, tanto los cables de señal individuales como los cables de alimentación trenzados.

El diagrama siguiente muestra el patillaje correcto. Sí, es un conector macho, pero como se mira por el extremo equivocado se usa el diagrama del género opuesto. (Sí, resulta algo confuso.)

<figure markdown="span">
![](assets/nmea_2000_female_pinout.png){ width="50%" }
<figcaption>Patillaje del conector hembra NMEA 2000 micro C.</figcaption>
</figure>


Soldar primero el pin central. Ahora resulta más fácil, mientras los demás cables no estorban todavía. El color normalizado del cable CAN_L es el azul, pero en nuestro latiguillo es amarillo.

<figure markdown="span">
![](assets/photos/023_soldered_L.jpg){ width="50%" }
<figcaption>Pin central soldado.</figcaption>
</figure>


Soldar después los otros tres cables. La malla queda sin conectar.

En este punto el conector debería tener este aspecto:

<figure markdown="span">
![](assets/photos/024_all_soldered.jpg){ width="50%" }
<figcaption>Todo soldado.</figcaption>
</figure>


Doy por supuesto, con cierta osadía, que los trozos de tubo termorretráctil se colocaron antes de soldar los cables. Es el momento de deslizarlos sobre las soldaduras y contraerlos con una pistola de aire caliente (o con la llama de un mechero). El resultado debería ser aproximadamente este:

<figure markdown="span">
![](assets/photos/025_heat_shrink.jpg){ width="50%" }
<figcaption>Tubo termorretráctil aplicado.</figcaption>
</figure>


Atornillar a la carcasa el conector de panel NMEA 2000 ya terminado.

Otra foto más de un conector terminado y del patillaje:

<figure markdown="span">
![](assets/photos/n2k_connector_wiring_photo.jpg){ width="50%" }
<figcaption>Conector terminado.</figcaption>
</figure>


### Conexión de los demás conectores de panel

Ahora que la parte difícil está hecha, los demás conectores se pueden atornillar en su sitio. Para mejorar la estanqueidad del conector de la antena WiFi se puede añadir una junta tórica o una arandela de estanqueidad alrededor del conector antes de montarlo.

Al final se debería tener esto:

<figure markdown="span">
![](assets/photos/03_connectors_in_place.jpg){ width="50%" }
<figcaption>Conectores colocados.</figcaption>
</figure>


### Montaje de la SH-RPi

Ahora toca montar la Raspberry Pi en la carcasa.
Se usan la carcasa de plástico y los adaptadores de montaje que deberían haber llegado con ella.

Primero se fijan los separadores cortos a los adaptadores de montaje con las tuercas M2,5. Apretarlos bien.

<figure markdown="span">
![](assets/photos/04_adapters_with_standoffs.jpg){ width="50%" }
<figcaption>Adaptadores con separadores.</figcaption>
</figure>


Una vez colocados los separadores, los adaptadores se montan en la carcasa con los tornillos autorroscantes.

<figure markdown="span">
![](assets/photos/05_adapters_in_place.jpg){ width="50%" }
<figcaption>Adaptadores montados.</figcaption>
</figure>


La Raspberry Pi se coloca sobre los separadores. Fijar los separadores superiores con los tornillos M2,5 y los inferiores con dos separadores hexagonales de 16 mm.

<figure markdown="span">
![](assets/photos/06_rpi_mounted.jpg){ width="50%" }
<figcaption>Raspberry Pi montada.</figcaption>
</figure>


Después va la Sailor Hat. Presionarla sobre el conector GPIO de la Raspberry Pi. Asegurarla con dos tornillos M2,5.

**NOTA**: cuando alguna vez haya que retirar la placa HAT, la tentación es moverla de lado a lado. Funciona bien, pero también hay un pequeño riesgo de doblar los pines del conector de la Pi en sus dos extremos. Conviene moverla en cambio hacia arriba y hacia abajo mientras se tira con suavidad. Es algo más lento, pero la placa se suelta con mucho menos riesgo de doblar los pines.

En este punto se pueden conectar también todos los dispositivos USB y los cables de alimentación y CAN de la SH-RPi. Si se usa un ventilador, montarlo igualmente. Fijarlo con cinta de doble cara o un poco de pegamento termofusible junto a la Raspberry Pi, con la cara de la pegatina hacia la Pi.

Así queda el montaje terminado:

<figure markdown="span">
![](assets/photos/07_sh-rpi_mounted.jpg){ width="50%" }
<figcaption>Sailor Hat montada.</figcaption>
</figure>


No cerrar todavía la tapa. Falta introducir la tarjeta de memoria en la Pi.

## Software

En esta sección se instala el software OpenPlotter en la Raspberry Pi. OpenPlotter es una distribución de software especializada para el ámbito náutico, basada en Raspberry Pi OS. Existe en varias versiones; en este tutorial se usa una versión sin pantalla (headless), es decir, sin ningún monitor conectado directamente a la Raspberry Pi. Para la visualización se emplean en su lugar navegadores o conexiones de escritorio remoto, lo que permite situar el servidor de forma más segura y las pantallas donde hagan falta.

### Instalación de OpenPlotter

OpenPlotter se instala grabando una imagen del sistema operativo en una tarjeta MicroSD e insertando esa tarjeta en la Raspberry Pi.

Descargar primero [Raspberry Pi Imager](https://www.raspberrypi.org/software/). Imager es un programa sencillo de manejar que graba en la tarjeta de memoria el archivo de imagen descargado.

**AVISO:** Imager solo se puede descargar para macOS, Windows y Ubuntu Linux. Con otro sistema operativo u otra distribución de Linux hará falta otro programa para grabar la tarjeta (aunque a esas alturas se supone que se sabe perfectamente cómo hacerlo).

Una vez descargado, instalar Imager.

Descargar después la [imagen de OpenPlotter](https://openplotter.readthedocs.io/en/latest/getting_started/downloading.html). En este tutorial uso la imagen Headless. Quien prefiera conectar una pantalla a la Pi puede tomar la imagen Starting. Tras la descarga puede ser necesario descomprimir la imagen antes de grabarla. La imagen del sistema operativo es bastante grande, así que conviene disponer de algunos gigabytes libres en el disco.

Grabar la imagen en la tarjeta MicroSD. Insertar primero la tarjeta en un lector conectado al ordenador. Muchos portátiles llevan además un lector de tarjetas SD integrado; para usarlo se emplea el adaptador SD que viene con la tarjeta. Abrir después Imager. En el menú del sistema operativo, seleccionar «Use custom» al final de la lista y elegir a continuación el archivo de imagen descargado.

[![](assets/screenshots/01_imager.jpg){ width="50%" }](assets/screenshots/01_imager.jpg)

Seleccionar después la tarjeta MicroSD correcta con el botón Storage. Para evitar errores costosos conviene desconectar del ordenador cualquier otro soporte extraíble. Hacer clic en Write. En este punto puede ser necesario introducir la contraseña para autorizar a Imager a escribir en la tarjeta MicroSD.

[![](assets/screenshots/02_imager_in_progress.jpg){ width="50%" }](assets/screenshots/02_imager_in_progress.jpg)

Grabar y verificar la tarjeta MicroSD lleva un rato. Ese tiempo se puede aprovechar para descargar e instalar [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/). VNC Viewer es un programa de escritorio remoto con el que se accederá a OpenPlotter en las secciones siguientes.

Cuando la tarjeta MicroSD esté lista, insertarla en la ranura MicroSD de la Raspberry Pi. Para ello puede ser necesario retirar temporalmente la placa HAT. (Sí, lo siento, el tutorial no es coherente al 100 %.)

Por último, encender el equipo. Es cierto que se puede enchufar un cable USB-C de 5 V a la Raspberry Pi, pero eso dará problemas al instalar más adelante el demonio de la SH-RPi. Conviene usar por tanto una alimentación de 12 V (en realidad vale cualquier valor entre 10–32 V) y cablearla a un conector NMEA 2000. También se pueden introducir cables puente hembra cortos directamente en los conectores JST XH y unir los cables a una fuente de alimentación con pinzas de cocodrilo pequeñas. Basta con echarle imaginación.

### Configuración inicial de OpenPlotter

Llegados a este punto se tiene un equipo con muchas luces parpadeando pero sin forma de comunicarse con él. Por suerte hay una vía. Al mirar las redes Wi-Fi disponibles alrededor debería aparecer una red llamada «openplotter»:

[![](assets/screenshots/03_select_wifi.jpg){ width="50%" }](assets/screenshots/03_select_wifi.jpg)

Conectarse a esa red (la contraseña es `12345678`).

Ya se está al alcance de la Pi. Para acceder a ella se usa el VNC Viewer instalado antes.

[![](assets/screenshots/04_vnc_viewer.jpg){ width="50%" }](assets/screenshots/04_vnc_viewer.jpg)

En la pantalla de inicio, escribir `openplotter.local` en la barra de direcciones (si no funciona, probar con la dirección IP `10.10.10.1`). Si se encontró el servidor, aparece una pantalla de credenciales:

[![](assets/screenshots/05_vnc_credentials.jpg){ width="50%" }](assets/screenshots/05_vnc_credentials.jpg)

Introducir el nombre de usuario `pi` y la contraseña `raspberry`.

Si todo ha ido bien, aparece un escritorio de OpenPlotter intacto:

[![](assets/screenshots/06_vnc_connected.jpg){ width="50%" }](assets/screenshots/06_vnc_connected.jpg)

Estupendo. Conviene recorrer el asistente de bienvenida de la Pi. Primero hay que introducir una contraseña nueva y elegir el país, el idioma y otros ajustes básicos.

Si se ha conectado un adaptador WiFi USB compatible, habrá que elegir una red WiFi a la que conectarse. Resulta muy práctico, porque da acceso a Internet para descargar actualizaciones y demás.

[![](assets/screenshots/07_pick_raspi_wifi.jpg){ width="50%" }](assets/screenshots/07_pick_raspi_wifi.jpg)

Conviene tener en cuenta que, sin un adaptador WiFi conectado, la configuración inicial puede diferir algo de lo que se describe a continuación.

Durante la configuración inicial la Pi actualiza el software del sistema. Lleva un rato, así que es buen momento para tomar un café o jugar con la pareja, los hijos o las mascotas.

[![](assets/screenshots/08_update.jpg){ width="50%" }](assets/screenshots/08_update.jpg)

Cuando termine la configuración, reiniciar la Pi. La conexión estaba establecida con el punto de acceso WiFi de la Pi, de modo que la conexión de red del ordenador vuelve ahora a la red WiFi habitual. Con el adaptador WiFi USB y la Pi configurada en esa misma red, se sigue llegando a ella por la misma dirección `openplotter.local`. ¿Se entiende ahora por qué recomendaba el adaptador WiFi adicional? En caso contrario habrá que volver a conectarse a la red «openplotter» en cuanto vuelva a estar disponible.

[![](assets/screenshots/09_basic_setup_complete.jpg){ width="50%" }](assets/screenshots/09_basic_setup_complete.jpg)

En cualquier caso. Volver a VNC Viewer y conectarse a `openplotter.local`. La contraseña del usuario `pi` se cambió durante la configuración inicial, así que en VNC Viewer hay que introducir la nueva.

Una vez dentro de nuevo, se modifican los ajustes de red de la instalación de OpenPlotter. En el menú Raspberry, seleccionar OpenPlotter -> Network.

(Al abrir la aplicación Network puede avisar de que quiere reconfigurar el sistema. Conviene dejarla y volver a abrir la aplicación cuando termine.)

[![](assets/screenshots/11_open_openplotter_network.jpg){ width="50%" }](assets/screenshots/11_open_openplotter_network.jpg)

En el panel de red aparecen a la izquierda los dispositivos de red disponibles y a la derecha los ajustes del punto de acceso.

Quien no quiera un punto de acceso debe seleccionar «none» en el menú de la izquierda. Quien prefiera conservarlo (y es recomendable, porque ofrece un acceso de reserva a la Pi) debe cambiar sin falta la contraseña de la red:

[![](assets/screenshots/14_openplotter_network_password.jpg){ width="50%" }](assets/screenshots/14_openplotter_network_password.jpg)

Los ajustes del cliente WiFi se encuentran bajo el símbolo de WiFi, en la esquina superior derecha del escritorio de OpenPlotter. Ahí se configuran otras redes, como el punto de acceso WiFi de la embarcación.

[![](assets/screenshots/16_wifi_client_settings.jpg){ width="50%" }](assets/screenshots/16_wifi_client_settings.jpg)

Tras modificar los ajustes de red, reiniciar OpenPlotter.

### Instalación del demonio SH-RPi

Resuelto lo más urgente, toca instalar el demonio SH-RPi. (Los [demonios](https://en.wikipedia.org/wiki/Daemon_(computing)#Etymology) son espíritus benévolos que ayudan a definir el carácter o la personalidad de una persona. O, en este caso, servicios en segundo plano de los sistemas operativos descendientes de UNIX.) Se podría usar VNC Viewer abriendo Accessories -> Terminal en el menú Raspberry, y eso es lo que recomiendo a quienes usan Windows, pero a quienes usan Mac y Linux les muestro cómo acceder al equipo OpenPlotter por SSH.

Antes, una pequeña digresión. En lugar de entrar por ssh sin más, conviene copiar primero la clave pública SSH al equipo con `ssh-copy-id`. Así los inicios de sesión posteriores se hacen sin contraseña.

En Mac puede ser necesario instalar antes `ssh-copy-id`. Está disponible a través de [Homebrew](https://brew.sh/); quien no lo tenga aún, que lo instale, porque es excelente. Después:

    brew install ssh-copy-id

En Linux, en cambio, están mimados y `ssh-copy-id` ya viene preinstalado.

Copiar a continuación la clave pública:

    ssh-copy-id pi@openplotter.local

Y ya está. Ahora se puede iniciar sesión en la Pi sin contraseña. Recomiendo este método en todos los sistemas a los que se accede en remoto: es más seguro que usar contraseñas.

[![](assets/screenshots/18_ssh.jpg){ width="50%" }](assets/screenshots/18_ssh.jpg)

Una vez iniciada la sesión con `ssh pi@openplotter.local`, pegar la orden de instalación en el símbolo del sistema:

    curl -L \
    https://raw.githubusercontent.com/hatlabs/SH-RPi-daemon/main/install.sh \
    | sudo bash

En un sistema relativamente poco modificado, esta orden aplica los cambios de configuración necesarios e instala el software del demonio de forma automática. Solo tarda unos segundos. Basta con reiniciar a mano cuando termine la instalación:

    sudo reboot

Durante el reinicio conviene fijarse en los LED de la SH-RPi. El LED RX estaba en verde fijo y el LED de estado en rojo fijo; tras el reinicio, el LED RX parpadea alegremente (siempre que haya tráfico en el bus NMEA 2000) y el LED de estado sigue en rojo pero parpadea brevemente cada segundo. Estos cambios indican que la interfaz CAN y el watchdog del demonio están activos.

Al conectarse por VNC después del reinicio aparece el siguiente mensaje:

[![](assets/screenshots/20_after_reboot.jpg){ width="50%" }](assets/screenshots/20_after_reboot.jpg)

Esto indica que ya hay una interfaz CAN activa, pero que todavía no está configurada en [Signal K](https://signalk.org). Eso se hará en la sección siguiente.

### Configurar Signal K para recibir el tráfico NMEA 2000

Para procesar los datos NMEA 2000 hay que configurar Signal K de modo que los reciba. Abrir el panel de control de Signal K en [http://openplotter.local:3000/](http://openplotter.local:3000/).

Para poder hacer algo en el servidor hay que habilitar la seguridad y crear un usuario administrador. Hacer clic en el botón «Login» de la esquina superior derecha:

[![](assets/screenshots/21_sk_server_dashboard.jpg){ width="50%" }](assets/screenshots/21_sk_server_dashboard.jpg)

Se pide crear un nuevo usuario administrador. Yo prefiero `admin` como nombre de usuario y, a continuación, una contraseña adecuada, fácil de recordar y de teclear. Solo se accede desde la red interna.

Después conviene actualizar el servidor SK:

[![](assets/screenshots/23_update_server.jpg){ width="50%" }](assets/screenshots/23_update_server.jpg)

Hecho eso, se puede ir al grano y habilitar `can0` en el servidor. Ir a Data Connections y hacer clic en el botón Add:

[![](assets/screenshots/26_data_connections_add.jpg){ width="50%" }](assets/screenshots/26_data_connections_add.jpg)

Configurar después la conexión como se indica, desplazarse hacia abajo y hacer clic en Submit:

[![](assets/screenshots/28_correct_settings.jpg){ width="50%" }](assets/screenshots/28_correct_settings.jpg)

Tras añadir la conexión de datos, reiniciar de nuevo el servidor. Ahora el panel de control debería mostrar algo de actividad:

[![](assets/screenshots/30_can0_activity.jpg){ width="50%" }](assets/screenshots/30_can0_activity.jpg)

Bien. Es momento de felicitarse: se ha llegado lejos.

Si se desea, también se puede abrir Data Browser en el menú de la izquierda y ver qué datos se están recibiendo.

### Crear paneles de instrumentos

Si llegan datos, ya se pueden visualizar abriendo SK Instrument Panel:

[![](assets/screenshots/301_sk_plugins.jpg){ width="50%" }](assets/screenshots/301_sk_plugins.jpg)

Con el botón de la llave inglesa se pueden configurar algunas rutas. El tamaño y la posición de los indicadores se ajustan haciendo clic en el botón del candado.

Mi laboratorio de pruebas está justo bajo un tejado metálico sin ninguna cobertura GPS, y los únicos datos interesantes de mi red proceden del [sensor de temperatura 1-Wire](https://docs.hatlabs.fi/sh-esp32/pages/tutorials/onewire-temperature/). Así que mi panel de instrumentos consta ahora de tres valores de temperatura:

[![](assets/screenshots/302_sk_instrument_panel.jpg){ width="50%" }](assets/screenshots/302_sk_instrument_panel.jpg)

Un poco triste, pero emocionante al mismo tiempo.

Además del Instrument Panel estándar, existen muchas aplicaciones de panel de control muy buenas para Signal K. Merece la pena probar [KIP](https://github.com/mxtommy/Kip) (está en la tienda de aplicaciones del servidor SK) o [Wilhelm SK](https://www.wilhelmsk.com/) (solo para dispositivos iOS, disponible en la App Store).

### Instalación de InfluxDB y Grafana

En los últimos pasos de este tutorial se instalan y configuran InfluxDB y Grafana para crear un registro histórico y visualizaciones de los datos de la embarcación. Quedan unos pasos más y algunas pantallas de aspecto recargado, pero el pequeño esfuerzo merece la pena.

InfluxDB es una base de datos de series temporales en la que se almacenarán los datos. Grafana es un conjunto de herramientas de visualización que suele emplearse para supervisar el estado de sistemas informáticos pero que, por su versatilidad, sirve igualmente para nuestros datos náuticos.

Para instalar InfluxDB y Grafana, volver a VNC Viewer y abrir OpenPlotter -> Dashboards en el menú Raspberry:

[![](assets/screenshots/31_openplotter_dashboards.jpg){ width="50%" }](assets/screenshots/31_openplotter_dashboards.jpg)

Seleccionar InfluxDB y hacer clic en Install. Tarda un rato, pero al terminar hay que volver a la pestaña Apps, seleccionar Grafana y hacer clic en Install. Eso es todo.

[![](assets/screenshots/32_install.jpg){ width="50%" }](assets/screenshots/32_install.jpg)

Después hay que crear una base de datos nueva en InfluxDB. Abrir Chronograf, la interfaz web de InfluxDB, en el navegador: [http://openplotter.local:8889/](http://openplotter.local:8889/).

[![](assets/screenshots/34_open_chronograf.jpg){ width="50%" }](assets/screenshots/34_open_chronograf.jpg)


Recorrer la configuración inicial. La conexión de InfluxDB en Chronograf usa el nombre de usuario `admin` y la contraseña `admin`. Se pueden omitir la creación de paneles y la configuración de Kapacitor.

Crear a continuación la base de datos nueva desde la pantalla InfluxDB Admin:

[![](assets/screenshots/37_create_signalk_db.jpg){ width="50%" }](assets/screenshots/37_create_signalk_db.jpg)

Dar a la base de datos el nombre `signalk` y, por lo demás, continuar. Listo.

Ahora que la base de datos espera, toca alimentarla. Volver al panel de control de Signal K para configurar el complemento de escritura en InfluxDB:

[![](assets/screenshots/39_sk_plugin_config.jpg){ width="50%" }](assets/screenshots/39_sk_plugin_config.jpg)

Dejar vacíos el nombre de usuario y la contraseña. Nuestra base de datos era `signalk`. Si se desea, se pueden modificar el intervalo de escritura por lotes y la resolución de los datos. El intervalo es de 10 segundos de forma predeterminada, pero para ver los datos más cerca del tiempo real se puede introducir 2. La resolución determina cada cuánto se escribe una medición en la base de datos. El valor predeterminado de 200 ms seguramente basta, pero yo quería más y elegí 100 ms. Marcar también las casillas que se muestran abajo.

[![](assets/screenshots/40_settings.jpg){ width="50%" }](assets/screenshots/40_settings.jpg)

Desplazarse hacia abajo y hacer clic en Submit para aplicar la configuración. A estas alturas deberían estar entrando mediciones en la base de datos. Conviene comprobarlo. Volver a Chronograf y elegir la vista Explore. Abajo debería aparecer una fuente llamada `signalk.autogen`. Al seleccionarla deberían mostrarse los nombres de las mediciones individuales. Estupendo.

[![](assets/screenshots/41_verify_data.jpg){ width="50%" }](assets/screenshots/41_verify_data.jpg)

Solo queda visualizar los datos históricos.

### Crear un panel de Grafana de ejemplo

Se usará Grafana para mostrar algunas gráficas vistosas. Abrir Grafana en el navegador: [http://openplotter.local:3001](http://openplotter.local:3001).

[![](assets/screenshots/42_open_grafana.jpg){ width="50%" }](assets/screenshots/42_open_grafana.jpg)

Grafana exige introducir una contraseña nueva, así que hay que hacerlo. Al llegar a la pantalla de inicio, configurar el origen de datos InfluxDB:

[![](assets/screenshots/44_grafana_data_sources.jpg){ width="50%" }](assets/screenshots/44_grafana_data_sources.jpg)

En la configuración, la URL predeterminada aparece en gris oscuro, pero comprobé que había que escribirla expresamente. Por lo demás, se trata otra vez de la misma base de datos `signalk` y de un nombre de usuario y una contraseña vacíos. Hacer clic en «Save and Test» para comprobar que el origen de datos funciona.

[![](assets/screenshots/46_config_data_source.jpg){ width="50%" }](assets/screenshots/46_config_data_source.jpg)

Conviene recapitular lo que se tiene. Signal K recibe los datos de NMEA 2000, InfluxDB los almacena y Grafana está conectado a InfluxDB. Por fin se puede crear un panel de Grafana y añadirle nuevos paneles de datos.

El editor de paneles resulta algo recargado, pero los pasos básicos son sencillos.

[![](assets/screenshots/54_panel_title.jpg){ width="50%" }](assets/screenshots/54_panel_title.jpg)

Editar la consulta. Seleccionar primero una medición en la fila FROM. En segundo lugar, hay que añadir un modificador matemático para convertir las unidades de medida (Grafana apenas conoce las unidades, así que de forma predeterminada muestra siempre los datos en las unidades del SI en las que están almacenados). Por ejemplo, para pasar de kelvin a grados Celsius hay que restar 273,15. O para pasar de m/s a nudos, multiplicar por 3600 y dividir por 1852.

Terminar el panel dándole un título y aplicando los cambios.

Ahora debería verse un único panel con algunos datos temporales en el tablero. Añadir un par de paneles más con el botón Add Panel. Los paneles se pueden colocar y redimensionar arrastrando sus títulos y sus esquinas. Por último, se puede elegir un intervalo de tiempo adecuado en la barra superior y guardar el panel.

Así queda mi panel de temperaturas del motor:

[![](assets/screenshots/56_two_more_panels.jpg){ width="50%" }](assets/screenshots/56_two_more_panels.jpg)

Eso es todo. Ahora toca crear paneles espectaculares y enseñarlos a los amigos del puerto y del club náutico. Conviene compartirlos también en el [foro de discusión de Hat Labs](https://github.com/hatlabs/discussions/discussions) para inspirar a los demás.


</div>
