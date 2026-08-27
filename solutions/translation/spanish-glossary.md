---
title: Spanish translation glossary and style rules (SH-RPi)
date: 2026-08-05
category: translation
module: documentation
problem_type: reference
component: documentation
severity: medium
applies_when:
  - Translating any page from docs/en/ into Spanish under docs/es/
  - Reviewing a Spanish translation for consistency
  - Adding a new term that has no established Spanish equivalent
tags:
  - translation
  - i18n
  - spanish
  - terminology
  - mkdocs-static-i18n
---

# Spanish translation glossary and style rules

## Context

The SH-RPi documentation is written in English under `docs/en/` and translated
into Spanish under `docs/es/`, using the `mkdocs-static-i18n` folder structure.
Each language directory mirrors the same tree, so a translation keeps its
source's path and filename: `docs/en/hardware/index.md` becomes
`docs/es/hardware/index.md`. Only markdown lives under `docs/es/` — images and
other assets stay with the English source and are shared, including the nested
`assets/` directories under `revisions/` and `tutorials/openplotter-server/`.

**This file began as a copy of the HALPI2 glossary and deliberately keeps its
decisions.** SH-RPi and HALPI2 are both Raspberry Pi power boards with
supercapacitors, a shutdown daemon and a watchdog, so a reader who knows one
Hat Labs board should meet the same Spanish words in the other. `carrier board`
→ `placa portadora` and `daemon` → `demonio` were decided there and stand here
too. Terms below the SH-RPi heading are this product's additions; a shared row
changes in both repositories or in neither.

The HALMET glossary was not used as the base even though HALMET is also a Hat
Labs board: its additions are all sensor-input vocabulary — analog and digital
inputs, galvanic isolation, a constant current source — and not one of those
words occurs in the SH-RPi documentation. That was measured, not assumed.

The locale is a single generic `es`. There is no `es-ES` and no `es-419` build,
so every regional choice below is made once, for both audiences, and recorded
here.

Translations are produced page by page, at different times, potentially by
different people. Without a fixed terminology list the same English term drifts
across pages — *stack-through header* becomes `conector pasante` on one page and
`conector de apilamiento` on the next — and the result reads as machine output
even when each individual sentence is correct.

This file is the reference that prevents that drift. It is a living document:
extend it when a page introduces a term that is not listed here, rather than
inventing a one-off translation.

Unlike the other files under `solutions/`, this one has no date in its filename
because it is meant to be edited in place, not superseded.

## Six rules where the siblings are wrong for Spanish

Read this section before anything else. Every one of these is stated the
opposite way in at least one sibling glossary. Each is written so it can be
counted in the finished page rather than nodded at.

1. **The reader is never addressed.** French uses *vouvoiement*, German uses
   *Sie*, Finnish and Swedish use the second person singular. All four are wrong
   here. Spanish technical documentation is impersonal:

   > La unidad se apaga automáticamente cuando se interrumpe la alimentación.

   Procedure steps take the **infinitive**, not an imperative:

   > Conectar el cable de alimentación. Comprobar la polaridad con el multímetro
   > antes de aplicar tensión.

   This is also the only register that survives a generic `es` build: `usted`
   sounds commercial in Spain, `tú` sounds wrong in an installation manual
   anywhere, and `vosotros` does not exist in Latin America. The impersonal has
   no regional split at all.

   *Count:* `usted`, `ustedes`, `tú`, `ti`, `vosotros`, `vosotras` appear **zero**
   times. Every numbered and bulleted procedure step begins with an infinitive —
   count the steps, count the infinitives, the two numbers are equal.

2. **Inverted opening marks are mandatory.** `¿` and `¡` do not exist in the
   English source, so a missing one is never a copy error — it is always an
   omission, and it is the defect a Spanish reader sees first. Headings that are
   questions carry both marks: `## ¿Qué es el SH-RPi?` The FAQ page is written
   entirely as questions, so it is where a missing `¿` is most likely and most
   visible.

   *Count:* the number of `¿` equals the number of `?` outside code. Exclamations
   in prose are rare here; when one is used it opens with `¡`. Do not count the
   `!` in `!!! warning` or in `![image]` — those are markdown syntax.

3. **Quotation marks are `«…»`** — angular marks, the RAE first level. Not
   German's `„…"`, not Swedish's `”…”`, not straight `"…"`. Use them for quoted
   hardware labels and UI strings that stay in English: `la posición «OFF»`,
   `el conector «PROG»`, `la señal de latido («heartbeat»)`.

   **Unlike French, there is no space inside the marks.** `«RTC EN»`, never
   `« RTC EN »`. A French translator's muscle memory puts a no-break space
   there and it is invisible in review.

   *Count:* `«` and `»` occur the same number of times. `"`, `”`, `„` and `“`
   occur zero times outside code. The sequences `« ` and ` »` occur zero times,
   including with U+00A0.

4. **No space before `; : ! ?`** — as in German and Swedish, and the exact
   opposite of French, whose rule demands a no-break space there.

   *Count:* zero occurrences of a space (U+0020 **or** U+00A0) immediately before
   `;`, `:`, `!` or `?` outside code. Check U+00A0 explicitly: it is invisible,
   and it is what arrives when a French sentence pattern is carried across.

5. **A proper name never takes a hyphen in a compound.** German writes
   `NMEA-2000-Netzwerk`, Swedish `NMEA 2000-nätverk`, Finnish `NMEA 2000 -verkko`.
   Spanish uses a plain noun phrase or a preposition:

   - `red NMEA 2000`, `bus NMEA 2000`, `servidor Signal K`, `antena Raspberry Pi`
   - `carcasa del SH-RPi`, `conector CAN0`, `imagen de Raspberry Pi OS`,
     `teclado USB`, `placa CAN HAT`, `conector GPIO de la Raspberry Pi`

   *Count:* `NMEA-2000`, `Signal-K`, `Raspberry-Pi`, `CAN-HAT`, `RS485-HAT`,
   `GNSS-HAT` and `Sailor-Hat` occur zero times outside code. `SH-RPi-` is the
   one hyphenated form that is legitimate, because it is part of repository and
   image filenames — `SH-RPi-daemon`, `SH-RPi-firmware`,
   `SH-RPi-2.0.0-func.jpg` — and those are never touched; `SH-RPi-` in running
   prose is the error.

6. **One Spanish, no mixing.** No sibling language has a regional split, so no
   sibling glossary warns about this. Three decisions, made once:

   | Use | Never | Why |
   |:----|:------|:----|
   | ordenador | computadora, computador | One form must win; `ordenador` is chosen for the whole site |
   | supercondensador | supercapacitor | `capacitor` is an Americanism; `condensador` is the general term |
   | supervisión | monitoreo, monitorización | Both alternatives are regionally marked; `supervisión` is not |

   *Count:* each banned word appears zero times.

   `supercapacitor` is the highest-risk of the three on this product. The
   English source writes both *supercapacitor* and *supercap*, hundreds of
   times, and the calque `supercapacitor` is exactly what a hurried translator
   reaches for. One Spanish word covers both: `supercondensador`.

## Names that are never translated

Product names, protocol names, hardware standards and software UI strings stay
in English — the device's own interface is in English, so translating a menu
name sends the reader looking for something that is not on the screen.

- **Products and software:** SH-RPi, Sailor Hat, HALPI2, Signal K, OpenPlotter,
  Raspberry Pi OS, Waveshare, PlatformIO, Node-RED, Grafana, Hat Labs
- **Hardware and standards:** Raspberry Pi, Compute Module 4 (CM4), HAT,
  ATtiny1616, PCF8563, CAN, NMEA 2000, NMEA 0183, RS485, GNSS, I2C, SPI, UPDI,
  GPIO, USB, microSD, PoE. The add-on boards keep their product names exactly:
  **CAN HAT**, **RS485 HAT**, **GNSS HAT**
- **Board labels and pin names, copied as printed:** `PROG`, `RTC EN`,
  `GPIO4 Enable`, `BOOT`, `2A`, `3A`, `CAN0`, `CAN1`, `GND`, `3V3`. These are
  silkscreen the reader has to find with a finger; per rule 3 they are quoted
  with `«…»` when they appear in running prose — `la fila superior («2A»)`
- **Commands, file paths, configuration keys, hostnames and code:**
  `raspi-config`, `shrpi print`, `shrpi set watchdog 0`, `shrpid`,
  `/boot/firmware/config.txt`, `/etc/shrpid.conf`, `/var/run/shrpid.sock`,
  `/dev/ttyAMA0`, `/dev/ttySC0`, `can0`, `dtoverlay=i2c-rtc,pcf8563`,
  `blackout-time-limit`, `avrdude`, `rpiboot`, `hciuart`

Code fences, command output, URLs and image filenames are never touched.

## Units and numbers

The English source writes `12V` and `0.9A`. Both are wrong in Spanish: SI
spacing and a decimal comma are required, and this needs an active conversion on
nearly every technical page.

| English source | Spanish |
|:---------------|:--------|
| `12V`, `0.9A` | `12 V`, `0,9 A` |
| `5.5 x 2.1 mm` | `5,5 × 2,1 mm` |
| `-20°C to +60°C` | `−20 °C … +60 °C` |
| `120Ω` | `120 Ω` |
| `3-5A` | `3–5 A` (en dash for ranges) |
| `1.5mm²`, `2m` | `1,5 mm²`, `2 m` |

Dimensions written as a single product spec keep the tight form:
`200×130×60 mm`.

**No thousands separator anywhere on this site.** Spanish forbids the English
comma (`115,200` reads as a decimal), and the alternatives — a period or a thin
space — buy nothing at the magnitudes used here. Baud rates, port numbers and
firmware versions are identifiers, not measurements: `115200 bps`, `9600`,
`puerto 2947`, `3.1.0` are copied unchanged.

## Links, images, admonitions, navigation

Same as the sibling glossaries: paths are copied from the English source
unchanged and never carry an `en/`, `es/` or other language segment; image
captions and alt texts are translated but filenames are not; screenshots stay
English because the reader's own screen is English; standard admonition titles
are translated centrally in `mkdocs.yml`, custom ones in the page.

Nearly every figure on the SH-RPi hardware and getting-started pages carries a
`<figcaption>` inside a `<figure markdown="span">` block. Those captions are
prose and are translated; the `![](…)` filename beside them is not, and the
`markdown="span"` attribute is not.

Translated headings change their anchors, and `¿` and the accents are stripped
by the slugifier — `## ¿Qué es el SH-RPi?` does **not** become
`#¿que-es-el-sh-rpi`. Do not guess: build the site and read the real ids out of
the generated HTML. `hardware/index.md` links to its own `#status-leds` anchor,
so that page breaks its own cross-reference if the anchor is guessed.

## Glossary

### Enclosure and mounting

| English | Spanish | Note |
|:--------|:--------|:-----|
| carrier board | placa portadora | The accurate term, as in French, German and Swedish |
| enclosure | carcasa | |
| heat sink | disipador térmico | The enclosure doubles as one |
| waterproof | estanco | `carcasa estanca (IP65)` |
| rugged | robusto | |
| wall-mount | montaje en pared | |
| mounting surface | superficie de montaje | |
| pilot hole (to be drilled) | agujero guía | `Taladrar los agujeros guía para los tornillos` |
| pre-drilled hole (already there) | orificio pretaladrado | The holes the enclosure ships with |
| mounting template | plantilla de taladrado | |
| clearance | espacio libre | |
| bilge water | agua de sentina | The compartment alone: *sentina* |
| bulkhead | mamparo | |
| cable gland | prensaestopas | `prensaestopas PG7` |
| cable routing | tendido de cables | |
| service loop | bucle de servicio | Slack left at both cable ends |
| cable tie | brida | |
| blind plug | tapón ciego | |
| breather plug | tapón compensador de presión | Must never be removed |

**Two rows, not one, for the holes.** `pilot hole` is a hole that does not exist
yet and has to be drilled; `pre-drilled hole` is one the enclosure arrives with.
The English source uses both, three sections apart. Collapsing them produced a
nonsense instruction in Swedish — *drill the pre-drilled holes* — so never write
`taladrar los orificios pretaladrados`. Both senses occur on the SH-RPi
getting-started page: *an enclosure without pre-drilled holes* is the
`orificio pretaladrado` sense, and the holes drilled with a step bit are the
`agujero guía` sense.

**A note on `placa portadora`.** Spanish takes the accurate term, like French
(`carte porteuse`), German (`Trägerplatine`) and Swedish (`bärkort`), and unlike
Finnish (`emolevy`, literally *motherboard*, chosen there for reader
familiarity). The divergence between the five is deliberate, decided per
language and per audience. Do not harmonise them.

`placa portadora` carries the module/board relationship on its own, so passages
about reseating the compute module or troubleshooting a board that will not boot
need no extra explanation. Only the Finnish glossary needs that warning.

On SH-RPi the module is a **CM4**, not HALPI2's CM5, and the English source says
*base board* rather than *carrier board* throughout `add-ons/cm4/index.md`. It
is the same object and it takes the same Spanish: `placa portadora`. Do not
render *base board* as `placa base` — that reads as *motherboard* in Spanish.
See `base plate` under the SH-RPi terms for the other half of this trap.

### Power and electrical

| English | Spanish | Note |
|:--------|:--------|:-----|
| power supply | alimentación | The unit itself: *fuente de alimentación* |
| power source | fuente de alimentación | |
| input voltage range | rango de tensión de entrada | |
| polarity | polaridad | |
| positive (+) / negative (−) | positivo (+) / negativo (−) | |
| fuse | fusible | |
| inline fuse | fusible en línea | |
| circuit breaker | interruptor automático | Neutral; not *magnetotérmico* or *disyuntor* |
| electrical panel | cuadro eléctrico | |
| current limiting | limitación de corriente | |
| current limiter | limitador de corriente | The circuit |
| current limit | límite de corriente | The `0,9 A` / `2,5 A` setting |
| overcurrent | sobrecorriente | |
| voltage drop | caída de tensión | |
| grounding | puesta a tierra | |
| short circuit | cortocircuito | |
| wire gauge | sección del conductor | Spanish uses mm², not AWG |
| marine-grade wire | cable de calidad náutica | |
| to strip (a wire) | pelar | |
| wire strippers | pelacables | |
| crimping | crimpado | Verb: *crimpar*. Established trade usage, like `firmware` |
| crimper | tenaza de crimpar | |
| heat-shrink tubing | tubo termorretráctil | Two r's |
| heat gun | pistola de aire caliente | |
| multimeter | multímetro | Not *polímetro* |
| continuity test | prueba de continuidad | |
| terminal | terminal | |
| terminal block | bloque de terminales | Not *bornera* or *regleta* |
| strain relief | descarga de tracción | Its absence is why the screw-terminal barrel plug is temporary only |
| super-capacitor | supercondensador | |
| real-time clock | reloj de tiempo real | |
| backup battery | pila de respaldo | The CR2032 for the RTC |

### Connectors and interfaces

| English | Spanish | Note |
|:--------|:--------|:-----|
| connector | conector | |
| barrel connector | conector cilíndrico | Add *(barrel)* on first mention |
| header | conector de pines | `conector GPIO de 40 pines` |
| pin | pin | |
| jumper | puente | Add *(jumper)* on first mention |
| backbone | cable troncal | The NMEA 2000 trunk; the network as a whole: *red troncal* |
| drop cable | cable de derivación | |
| T-connector | conector en T | Also for the source's *T-adapter* |
| terminator | terminador | The bus terminator enabled by the jumper |
| termination resistor | resistencia de terminación | The 120 Ω component |
| termination | terminación | The act, and the network property |
| front panel | panel frontal | |
| antenna | antena | |
| extension cable | cable alargador | |
| male / female | macho / hembra | |

### Operation and system behaviour

| English | Spanish | Note |
|:--------|:--------|:-----|
| boat computer | ordenador de a bordo | See rule 6 on `ordenador` |
| to boot | arrancar | Noun: *arranque* |
| first boot | primer arranque | |
| shutdown | apagado | |
| graceful shutdown | apagado controlado | |
| power loss | pérdida de alimentación | |
| blackout | corte de corriente | `temporizador de corte de corriente` |
| glitch immunity | inmunidad a microcortes | |
| power management | gestión de la alimentación | |
| status LED | LED de estado | |
| LED bar | barra de LED | |
| monitoring | supervisión | Never *monitoreo* or *monitorización* |
| passive cooling | refrigeración pasiva | |
| watchdog | watchdog | Gloss once as *(temporizador de vigilancia)*, then keep the term |
| standby | modo de reposo | The planned state where the CM5 is off and the controller waits |
| filesystem | sistema de archivos | |
| to unmount (a filesystem) | desmontar | `el sistema de archivos se desmonta de forma segura` |
| to unmount (a board or module) | retirar | The source says *unmount* for the carrier board and the CM5 too; `desmontar` there reads as *dismantle* |
| to reseat (a module) | volver a asentar | |

### Software and networking

| English | Spanish | Note |
|:--------|:--------|:-----|
| firmware | firmware | Not *microprogramación* — matches the sibling decision to keep the trade term |
| daemon | demonio | Established in Spanish Linux usage, as in French |
| to flash (firmware or an image) | grabar | Noun: *grabación*. Never *flashear* |
| to flash (an LED) | parpadear | A machine translator renders both English senses the same way; these are different words in Spanish |
| system image | imagen del sistema | |
| operating system image | imagen del sistema operativo | |
| headless | sin pantalla | First mention: `sin pantalla (headless)` |
| deployment | puesta en marcha | |
| container app | aplicación en contenedor | |
| container image | imagen de contenedor | Not *imagen del sistema* |
| dashboard | panel de control | Homarr's *dashboard* view |
| WiFi Access Point | punto de acceso WiFi | |
| wired / wireless | por cable / inalámbrico | |
| credentials | credenciales | |
| username / password | nombre de usuario / contraseña | |
| default password | contraseña predeterminada | |
| single sign-on (SSO) | inicio de sesión único (SSO) | |
| Certificate Authority (CA) | autoridad de certificación (CA) | |
| to trust (a certificate) | confiar en | |
| web interface | interfaz web | Feminine: *la interfaz* |
| browser | navegador | |
| system administration | administración del sistema | |

### Applications and use cases

| English | Spanish | Note |
|:--------|:--------|:-----|
| chart plotter | plóter cartográfico | |
| data logging | registro de datos | |
| vessel | embarcación | Not *buque*, which implies a ship |
| engine parameters | parámetros del motor | |
| fleet management | gestión de flotas | |
| predictive maintenance | mantenimiento predictivo | |
| process monitoring | supervisión de procesos | |
| remote monitoring | supervisión remota | |
| electromagnetic interference (EMI/RFI) | interferencias electromagnéticas (EMI/RFI) | |
| compliance | conformidad | |
| warranty | garantía | |

## SH-RPi terms

SH-RPi is a power management HAT, so its vocabulary is HALPI2's power and
shutdown language plus the mechanics of stacking boards on a Raspberry Pi. Rows
above this heading are shared with HALPI2 and are not changed here alone; rows
below are this product's additions.

Where a row repeats an inherited term, it repeats it **unchanged** and the note
says why the term needed restating on this product. Nothing below contradicts
anything above.

### The board and the stack

| English | Spanish | Note |
|:--------|:--------|:-----|
| HAT | HAT | Never translated. Per rule 5 it takes a plain noun phrase, never a hyphen: `la placa HAT`, `el conector HAT`, `la pila de HAT`. The product names keep their space: `CAN HAT`, `RS485 HAT`, `GNSS HAT` |
| add-on board / add-on card | placa adicional | The CAN, RS485 and GNSS HATs collectively. The source says both *board* and *card* for the same thing; Spanish uses one word |
| to stack (boards) | apilar | `apilar otros HAT sobre el Sailor Hat`. Adjective *stackable*: `apilable`. See the gender note at the end of this section |
| PCB stack | pila de placas | The assembled column of boards. Not `pila` alone — that is a battery in Spanish; always with `de placas` |
| stack-through header | conector de pines pasante | Gloss once as `conector de pines pasante (stack-through)`. Built on the inherited `header` → `conector de pines`. *Pasante* is what does the work: the pins pass through so a board above still reaches GPIO |
| stacking header | conector de pines pasante | The same physical part. The English source calls it *stack-through header*, *stackthrough header* and *stack-through connector* on three pages; Spanish uses one name for all of them |
| standoff | separador | Inherited from HALPI2's translation notes; restated because SH-RPi uses it in every assembly step |
| hex standoff | separador hexagonal | `separadores hexagonales de 6 mm`, `separadores hexagonales M2.5 de 16 mm` |
| mounting screw | tornillo de montaje | `los tornillos M3 suministrados`. Do not over-tighten: `no apretar en exceso` |
| solder jumper | puente de soldadura | **Never shortened to `puente`.** See the warning below |
| jumper | puente | Inherited, unchanged: removable, placed on a pin pair. Gloss as *(jumper)* on first mention, exactly as the inherited row says. See the warning below |
| jumper header | conector de puentes | The pin block a `puente` is placed on: `el conector de puentes del limitador de corriente`. Not `regleta`, which the inherited glossary rejects for `terminal block` |
| pin | pin | Inherited. `conector GPIO de 40 pines`, `cortar el pin correspondiente` in the GNSS HAT procedure |
| pin header (PROG, external interrupt) | conector de pines | Inherited `header` row. `el conector PROG`, `el conector de pines de 2x2` |
| base plate | placa de montaje | The perforated plate inside the enclosure. **Not `placa base`**, which means *motherboard* in Spanish; see the note on `placa portadora` for the mirror-image trap with the CM4 *base board* |
| vertical mount | soporte vertical | The black plastic parts that hold the board stack upright |
| mount adapter | adaptador de montaje | Shipped with the medium and large enclosures |
| cable gland | prensaestopas | Inherited, unchanged. `prensaestopas PG7`, `prensaestopas PG9`. A plugged gland: `prensaestopas con tapón ciego`, reusing the inherited `blind plug` |
| panel connector | conector de panel | `conector de panel SP13`, `conector de panel RJ45`, `conector de panel M12 (NMEA 2000)` |
| terminal plug | clavija de terminales | The pluggable screw-terminal plug in the sales package. Distinct from `conector` (the fixed socket on the board) and from the inherited `clavija de cable` |
| pass-through GPIO header | conector GPIO pasante | The 2x20 header on the SH-RPi itself |

**The `solder jumper` / `jumper` pair is the most dangerous row in this file.**
They are two different objects and both appear in instructions:

- A **`puente de soldadura`** is permanent. `RTC EN` ships closed and is opened
  by *cutting the traces between the pads with a sharp knife*; `GPIO4 Enable`
  ships open and is closed by joining its pads. Neither can be pulled off, and
  neither change is reversible by hand.
- A **`puente`** (glossed *(jumper)* once) is a removable link placed across a
  pin pair — the current limiter setting on the SH-RPi, the `PROG` header during
  firmware flashing, and the termination and `3V3` jumpers on the CAN and RS485
  HATs.

Writing `puente` where the source says *solder jumper* sends the reader looking
for something to pull off a board where nothing comes off; writing
`puente de soldadura` where the source says *jumper* sends them for a knife they
must not use. On any page where both occur, `puente de soldadura` is written in
full every single time, including in headings and admonitions.

### Power, supercapacitors and shutdown

| English | Spanish | Note |
|:--------|:--------|:-----|
| supercapacitor / supercap | supercondensador | Inherited. This is the word rule 6 bans the calque `supercapacitor` for. The source writes both English forms; Spanish uses one |
| supercapacitor bank | banco de supercondensadores | The three 20 F cells as one unit. `el banco de supercondensadores se carga hasta 8,8 V` |
| power management | gestión de la alimentación | Inherited, unchanged. It is this product's whole purpose, so it recurs on every page |
| safe shutdown | apagado seguro | The feature as the source names it — the Pi is told about the power failure and comes down before the caps run out. Verb form: `se apaga de forma segura` |
| graceful shutdown | apagado controlado | Inherited, unchanged. The same event described from the operating system's side. Both renderings are kept because the source keeps both words; do not swap one for the other mid-page |
| to power down | apagar | Impersonal per rule 1: `el sistema se apaga`, `apagar la Raspberry Pi` |
| power-off | desconexión de la alimentación | The board cutting its 5 V output. Distinct from `apagado` (the OS shutting down) and from `corte de corriente` (an external blackout). The state *powered off*: `sin alimentación` |
| watchdog | watchdog | Inherited, unchanged. Gloss once as *(temporizador de vigilancia)*, then keep the English term |
| watchdog timer | temporizador watchdog | No hyphen, per rule 5. `el temporizador watchdog está activado de forma predeterminada` |
| watchdog reboot | reinicio por watchdog | The LED pattern and the section title in `hardware/index.md` |
| heartbeat | señal de latido («heartbeat») | Gloss on first mention per rule 3, then `latido`. `si el SH-RPi no recibe un latido durante 10 s` |
| blackout | corte de corriente | Inherited, unchanged. The daemon's `blackout-time-limit` key stays English as code |
| brownout | caída de tensión | Inherited from HALPI2, where it deliberately reuses `voltage drop` → `caída de tensión`. See the note below before using it |
| hold-up time | tiempo de autonomía | How long the supercapacitors keep the system running — `hasta 70 segundos`. Not `tiempo de retención` |
| charge / discharge | carga / descarga | `estado de carga`, `los supercondensadores se descargan`. Deep discharge: `descarga profunda` |
| voltage threshold | umbral de tensión | The 8,0 V enable and 5,0 V disable limits, both user-configurable |
| undervoltage | subtensión | `una tensión inferior a 10 V se considera una situación de subtensión` |
| overvoltage | sobretensión | The fault state behind the rapid-blink LED pattern. Distinct from `sobrecorriente`, which the inherited glossary already fixes |
| reverse polarity protection | protección contra inversión de polaridad | The diode at the input: `diodo de protección contra inversión de polaridad` |
| buck converter | convertidor reductor | Inherited from HALPI2. See the note below on what the English source gets wrong |
| step-down converter | convertidor reductor | The same circuit; the source alternates the two English names within one paragraph |
| current limiter | limitador de corriente | Inherited, unchanged. The circuit |
| current limit | límite de corriente | Inherited, unchanged. The `0,8 A` / `1,8 A` / `2,8 A` setting |
| transient voltage suppressor | supresor de transitorios de tensión | `supresor de transitorios de tensión de 33 V`. The acronym TVS, if used, stays English |
| choke | bobina de choque | Part of the input filter |
| pi-filter | filtro en pi | `una bobina de choque y un filtro en pi` |
| real-time clock (RTC) | reloj de tiempo real (RTC) | Inherited, unchanged. The acronym stays English because it is on the silkscreen as `RTC EN` |
| backup battery | pila de respaldo | Inherited, and correct for the SH-RPi's own CR1220, which is non-rechargeable. **Not** correct for the GNSS HAT — see the next two rows |
| rechargeable (battery) | recargable | `batería recargable de litio ML1220` |
| non-rechargeable (battery) | no recargable | `pila no recargable CR1220` |
| power reservoir | reserva de energía | What the supercapacitor bank is for |
| glitch (power) | microcorte | Reuses the inherited `glitch immunity` → `inmunidad a microcortes` |
| fan | ventilador | The 40 mm enclosure fan on the 5 V output |
| status LED array | conjunto de LED de estado | Built on the inherited `status LED` and `LED bar` (`barra de LED`) |
| blink pattern | patrón de parpadeo | The LED state table in `hardware/index.md`. Verb `to blink`: `parpadear`, matching the inherited split between `grabar` and `parpadear` for *to flash* |
| sleep state | estado de reposo | `shrpi sleep`. Consistent with the inherited `standby` → `modo de reposo` |
| to wake up | despertar | `se despierta automáticamente cuando se restablece la alimentación` |

**A note on `brownout`.** HALPI2 decided that *brownout* and *voltage drop* both
become `caída de tensión`, and that decision is kept here rather than re-opened.
It costs more on this product than on HALPI2: a brownout is precisely what the
supercapacitors exist to ride out, and `caída de tensión` also names the
ordinary loss along a conductor. Where both senses could be read into one
sentence, make the sag explicit in the surrounding words — `una caída de tensión
momentánea en la alimentación` — rather than inventing a second term. Raise it
in both repositories at once if it should change.

**A note on `buck converter`, and an error in the English source.** This row
means a **step-down** converter, and only that: the input is stepped down to
8,8 V for the capacitor bank, and the capacitor bank is stepped down again to
5 V for the Pi. Section 5 of `hardware/index.md` calls the second stage a *boost
converter* twice — "the microcontroller enables the boost converter", "the
microcontroller disables the boost converter" — in the same paragraph that
describes it converting 8,8 V down to 5 V. That is an error in the English,
raised as issue #25. **Translate what the English says**, exactly as it says it,
and do not quietly correct it: the Spanish page must not diverge from the source
it is stamped against. This row is recorded so that a reviewer who spots
`convertidor elevador` in the Spanish knows it mirrors a known source defect and
not a translation mistake, and so both are fixed in the same change when #25 is.

**A note on the ML1220 and the CR1220.** The GNSS HAT's backup battery is a
**rechargeable** ML1220 lithium cell, and the source warns that replacing it
with a non-rechargeable cell "will result in a risk of explosion and fire". The
SH-RPi's own RTC battery is a **non-rechargeable** CR1220. The two words must be
unmistakable and visibly opposed in the Spanish — `recargable` and
`no recargable`, in full, in the warning itself. Spanish also carries the
distinction lexically, `batería` being a secondary cell and `pila` a primary
one, which is why the inherited `pila de respaldo` is right for the CR1220 and
wrong for the ML1220. Never lean on that alone: a reader who does not know the
`pila`/`batería` split must still be unable to misread the sentence.

### Software

| English | Spanish | Note |
|:--------|:--------|:-----|
| microcontroller | microcontrolador | The onboard ATtiny1616. The chip name stays English |
| daemon | demonio | Inherited, unchanged. Established in Spanish Linux usage. The Finnish glossary keeps `daemon` for the same product; the divergence is per language and deliberate. The program name `shrpid` is code and stays English |
| service (systemd) | servicio | `el servicio shrpid`, `habilitar el servicio`. The source's "service software" for the daemon: `software de servicio` |
| installation script | script de instalación | `script` is the established Spanish trade term, like `firmware`; not `secuencia de comandos`, not `guion` |
| configuration file | archivo de configuración | Never `fichero` — the inherited `sistema de archivos` fixes `archivo` for the whole site |
| device tree overlay | overlay | Inherited, unchanged; the source also says just *device overlay*. `habilitar el overlay del reloj de tiempo real` |
| firmware | firmware | Inherited, unchanged |
| to flash (firmware or an image) | grabar | Inherited, unchanged. Never `flashear`. `grabar la memoria eMMC`, `grabar el firmware` |
| to flash (an LED) | parpadear | Inherited. It earns its keep here: the LEDs and the eMMC are flashed in the same document |
| headless | sin pantalla | Inherited. First mention `sin pantalla (headless)`. OpenPlotter's *Headless image* is a product name and stays English: `la imagen Headless de OpenPlotter` |
| image (OS image) | imagen del sistema operativo | Inherited, unchanged. Short form on later mentions: `la imagen` |
| REST API | API REST | Feminine — `la API REST` — because it is an *interfaz* |
| file socket | socket de archivo | `la API está disponible en un socket de archivo`. `socket` stays English; do **not** reuse `zócalo`, which the inherited glossary assigns to the physical M.2 card socket |
| command-line interface | interfaz de línea de comandos | Feminine: *la interfaz*. Built on the inherited `herramienta de línea de comandos` |
| serial console | consola serie | Disabled during firmware flashing. Distinct from the inherited `consola de inicio de sesión` |
| to reboot | reiniciar | Noun: `reinicio`. Distinct from the inherited `arrancar` / `arranque` for *boot* |

### Installation and tools

| English | Spanish | Note |
|:--------|:--------|:-----|
| step drill bit | broca escalonada | `las brocas escalonadas` — the source's "small metal Christmas tree" |
| pilot hole | agujero guía | Inherited, unchanged; see the two-rows note in the enclosure section |
| heat shrink tubing | tubo termorretráctil | Inherited, unchanged. Two r's. Short form: `el termorretráctil` |
| zip tie / tie wrap | brida | Inherited `cable tie` → `brida`. The source uses three English words — *cable tie*, *zip tie*, *tie wrap* — for one object; Spanish uses one |
| double-sided tape | cinta de doble cara | For mounting the fan. Hot glue: `pegamento termofusible` |
| to strip (a wire) | pelar | Inherited, unchanged. `los cables pelados` |
| to solder | soldar | Noun: `soldadura`. `soldar los cables a los conectores de panel` |
| water ingress | entrada de agua | `minimizar las posibilidades de entrada de agua` |

### A note on `HAT`

`HAT` occurs throughout the documentation and is never translated: it is the
Raspberry Pi Foundation's term and it is printed on the boards. Rule 5 governs
how it combines — a plain noun phrase, never a hyphen. Write `la placa HAT`,
`el conector HAT`, `la pila de HAT`, and keep the two-word product names intact
and unhyphenated: `el CAN HAT`, `el RS485 HAT`, `el GNSS HAT`.

Gender: **masculine**, `el HAT`, `los HAT`, `el CAN HAT`. Both genders can be
argued — `la placa HAT` is feminine because `placa` is — but the bare initialism
has to be one thing on every page, and `el HAT` is what Spanish-speaking
Raspberry Pi users write. Plural is invariable: `los HAT`, not `los HATs`. Fix
this on the first page translated and keep it; `el HAT` and `la HAT` on facing
pages is exactly the drift this file exists to prevent.

## Verification

A translated page is not done until:

1. `uv run mkdocs build --strict` passes — the same command CI runs.
2. `uv run python scripts/check_anchors.py site` passes.
3. `uv run python scripts/translation_status.py` shows the page as current.
4. `uv run python scripts/check_glossary.py es` passes.
5. `uv run python scripts/check_typography.py es` passes — it walks the `«…»`
   marks in order and measures the space-before-punctuation rule with code
   fences removed, which a naive grep cannot do.
6. Structure matches the source — see `.claude/skills/translate-page/SKILL.md`.
7. Every term used on the page that appears in this glossary matches it.
8. **The six rules at the top are measured against the pages, not re-read.** A
   half-applied typography rule looks followed when you read it, because
   rereading your own text confirms whatever it already says. The French and
   German branches each shipped one to review for exactly this reason. Every
   rule above carries a *Count:* line; run the counts.

The four that catch the most on a Spanish page, as one command from the repo
root:

```bash
python3 - <<'PY'
import re, pathlib
text = "\n".join(
    re.sub(r"`[^`\n]*`", " ", re.sub(r"```.*?```", " ", p.read_text(encoding="utf-8"), flags=re.S))
    for p in sorted(pathlib.Path("docs/es").rglob("*.md"))
)
print("¿ vs ?          ", text.count("¿"), text.count("?"))
print("« vs »          ", text.count("«"), text.count("»"))
print("stray quotes    ", sum(text.count(c) for c in '"”„“'))
print("space before ;:!?", len(re.findall(r"[  ][;:!?]", text)))
print("reader addressed", len(re.findall(r"\b(usted|ustedes|tú|ti|vosotr[oa]s)\b", text, re.I)))
print("regional mixing ", len(re.findall(r"\b(computador[a]?|supercapacitor|monitoreo|monitorizaci[óo]n)\b", text, re.I)))
PY
```

Every number on the right must be zero except the first two pairs, which must be
equal within each pair.

## Related

- `finnish-glossary.md` — the sibling in this repository, adapted from the same
  HALPI2 base and for the same reasons
- `../../halpi2/solutions/translation/spanish-glossary.md` — the base this file
  was copied from. A row shared with it changes in both repositories or in
  neither
- `.claude/skills/translate-page/SKILL.md` — the procedure
- mkdocs-static-i18n documentation: <https://ultrabug.github.io/mkdocs-static-i18n/>

## Terms added during the HALPI2 translation

Inherited. These were reported by the HALPI2 page translators and consolidated
into the base glossary; the page names in the notes — `interfaces.md`,
`software.md`, `errata.md`, `design-files.md` — are **HALPI2 pages**, not SH-RPi
ones. They are kept because the terminology decisions are shared between the two
products even where the pages are not, and several of them are load-bearing
here: `standoff`, `solder jumper`, `buck converter`, `brownout`, `power rail`,
`pitch`, `pinout`, `hub` and `VDC` all recur in the SH-RPi source.

| English | Translation | Note |
|:--------|:------------|:-----|
| Getting Started (page/section title) | Primeros pasos | Page H1 and the HaLOS guide link text. Standard Spanish docs heading; avoids turning a noun phrase into a question that would need ¿…? |
| desktop setup (on a desk/bench, as opposed to permanent installation) | configuración de sobremesa | Recurs six times on this page as the counterpart of `instalación permanente`. Not the GUI desktop — `escritorio` would be wrong here. |
| wall wart (power supply) | «wall wart» (transformador de enchufe) | Quoted colloquial English in the source. Kept in guillemets per rule 3 with a short gloss on first and only mention; there is no established Spanish t |
| splash screen | pantalla de inicio | Raspberry Pi OS boot screen; needed a fixed rendering so it does not drift to `pantalla de bienvenida` on other pages. |
| cable grommet | pasacables | Appears alongside `cable gland` (prensaestopas) in the same sentence; the two must stay distinct, as with the pilot-hole / pre-drilled-hole pair. |
| mounting hardware (screws, brackets) | herrajes de montaje | "Corrosion-resistant mounting hardware" — `hardware` alone would read as electronics in a hardware manual. |
| cable tie / mounting clip | brida / clip de sujeción | `brida` is already in the glossary; `mounting clip` is not and is paired with it in the materials list. |
| rainbow pattern (LED fault indication) | patrón de arcoíris | Diagnostic LED pattern for an unseated CM5; a fixed wording matters because it is the symptom a reader searches for. |
| cable tester | comprobador de cables | Troubleshooting tool, distinct from `multímetro` which the glossary already fixes. |
| over-torque (verb) | excederse en el par (de apriete) | Mounting-screw instruction; `sobrepar` is not idiomatic Spanish. |
| Container Apps store (Cockpit) | tienda de aplicaciones en contenedor | Built on the glossary's `aplicación en contenedor`. Cockpit's own label is English, but the source uses it descriptively rather than as a quoted butto |
| known-good device | dispositivo que se sepa que funciona | Troubleshooting idiom with no compact Spanish equivalent; a literal `dispositivo bueno conocido` is meaningless. |
| device tree overlay | overlay | interfaces.md, 3 occurrences. Kept as the trade term, consistent with the glossary's decision to keep `firmware`. `superposicion de arbol de dispositi |
| chip-select | chip-select | interfaces.md table, `CAN FD chip-select`. A signal name on the board, not prose; `seleccion de chip` would not match anything the reader can look up. |
| transceiver | transceptor | interfaces.md, `an RS-485 transceiver's enable line`. Standard Spanish electronics term. |
| hardware flow control | control de flujo por hardware | interfaces.md, introduces the `ctsrts` parameter. |
| mass storage device | dispositivo de almacenamiento masivo | software.md, USB-boot procedure, 3 occurrences. The state the HALPI2 presents itself in during `rpiboot` flashing. |
| block device | dispositivo de bloques | software.md step 6, `any other tool that can write to a block device`. |
| boot mode switch | interruptor de modo de arranque | software.md, 3 occurrences in the USB-boot steps. Built on the glossary's `arranque`; the associated silkscreen labels stay English as `«Normal»` / `« |
| power cycle (noun) / to power-cycle | ciclo de alimentacion / realizar un ciclo de alimentacion | software.md, 3 occurrences including the admonition title. Distinct from `apagado` and from `reinicio`, and the firmware-update section depends on the |
| marine apps | aplicaciones náuticas | software.md image-variant table and Homarr description, 4 occurrences. The glossary has `vessel -> embarcacion` but no adjective for the application c |
| firewall | cortafuegos | software.md, VNC and Raspberry Pi Connect sections. |
| port forwarding | redireccion de puertos | software.md VNC section, alongside VPN. |
| taskbar | barra de tareas | software.md, Graphical Updates section. |
| update manager | gestor de actualizaciones | software.md, Graphical Updates section. |
| hostname | nombre de host | software.md, Raspberry Pi Imager customisations. Kept close to the English because the Imager field itself reads `hostname`. |
| to roll back (firmware) | volver a la version anterior | software.md Firmware Safety Features. Verbal phrase rather than a noun, so it composes with the impersonal register required by rule 1. |
| login console | consola de inicio de sesion | interfaces.md, the dedicated debug UART. Reuses the glossary's `inicio de sesion` from `single sign-on`. |
| power rail (3.3V rail, 5V rail) | línea (línea de 3,3 V, línea de 5 V) | Not in the glossary and it occurs eight times across both pages. Chose «línea» over the calque «raíl»/«riel» because it is regionally neutral (rule 6) |
| flange (wide flange required on inside) | reborde | The obvious equivalent «brida» is already assigned to *cable tie* in the glossary, so using it here would collide. «Reborde» names the wide collar of  |
| standoff | separador | HAT mounting hardware; appears five times in the HAT installation section and had no glossary entry. |
| spudger | espátula (spudger) | No Spanish equivalent in common trade use; glossed on first mention and the English kept in parentheses, following the glossary's `sin pantalla (headl |
| solder jumper | puente de soldadura | Distinct from the removable `jumper` already in the glossary (`puente`); this one is a PCB trace that has to be cut. |
| Solo Mode / Co-op Mode | modo solo / modo cooperativo (co-op) | Firmware operating modes, not UI strings the reader sees on screen, so translated. «co-op» kept in parentheses on first mention because `halpi status` |
| VDC (11-32 VDC, 100 VDC) | V CC (11–32 V CC, 100 V CC) | SI/Spanish convention for direct-current voltage; the glossary sets unit spacing but does not cover the DC suffix. |
| chip select | selección de chip (chip select) | SPI signal name; translated with the English glossed once because the table row abbreviates it as `SPI CS`. |
| watchdog timeout | tiempo de espera del watchdog agotado | The glossary fixes `watchdog` itself but not `timeout`; «tiempo de espera» is used consistently for all four timeout occurrences across both pages. |
| blinkenlights | Blinkenlights | Left untranslated. It is a jargon in-joke, not a technical term, and any Spanish rendering loses the joke while gaining nothing; flagged here so a rev |
| rail (power rail: 5V rail, 3.3V rail) | línea (línea de 5 V, línea de 3,3 V) | Not in the glossary but already used in docs/es/user-guide/operation.md:121 ("La línea de 5 V se desactiva") and hardware.md:92. Adopted for consisten |
| pitch (connector pitch) | paso | Appears constantly in hardware.md (3.81 mm, 2.54 mm, 0.5 mm). Already established in docs/es/user-guide/hardware.md ("tipo Phoenix MC, paso de 3,81 mm |
| hub (USB hub) | concentrador | Already established in docs/es/user-guide/hardware.md:114-116 and appendices/design-files.md ("concentrador USB3"). |
| pinout | asignación de pines | Heading term in both pages. Already established in docs/es/user-guide/hardware.md:185,247. Chosen over "patillaje", which is Spain-marked. |
| VDC | V CC | Unit form, not a protocol name, so it is translated. Already established in docs/es/index.md:30, operation.md:43 and troubleshooting.md:11. |
| Load Equivalency Number (LEN) | número de equivalencia de carga (LEN) | NMEA 2000 term. Acronym kept in English because it is what the reader sees on cabling datasheets; the expansion is glossed once on first mention. |
| multi-talker / single-talker / single-talker-multiple-listener | multiemisor / de un solo emisor / de un emisor y varios receptores | RS-485 and NMEA 0183 topology terms used three times in interfaces.md. "Talker" has no established Spanish loan here; "emisor"/"receptor" is the stand |
| normally-open (NO) momentary switch | pulsador momentáneo normalmente abierto (NA) | Switch specification, not a UI string, so the abbreviation is translated (NO → NA) per Spanish electrical convention. |
| thermal pad | almohadilla térmica | Thermal management table in hardware.md. Distinct from "disipador térmico" (heat sink), which the glossary already covers. |
| half-duplex | semidúplex | RAE-accepted form; used once in the RS-485 section. |
| flexible flat cable (FFC) | cable plano flexible (FFC) | Used for the HDMI and MIPI connectors; the acronym stays English because it is the part-ordering term. |
| buck converter | convertidor reductor | Power supply table. "Convertidor buck" is also common but the Spanish form is unambiguous and needs no gloss. |
| receptacle (USB receptacle) / socket (M.2 Socket M) | conector hembra / zócalo | Two different English words for connector openings in hardware.md; kept distinct because the M.2 one is a card slot and the USB one is a cable port. |
| pigtail (panel connector) | latiguillo | Product name in the shop link in the RS-485 wiring section. |
| threaded insert / countersunk / gasket | inserto roscado / avellanado / junta | Mechanical specifications table; none appear in the glossary's enclosure section. |
| VDC (unit suffix, e.g. 32 VDC) | V CC | The glossary's units table covers V, A, Ω, °C, mm² but not the DC suffix. Spanish writes corriente continua, so the SI-spaced form is `32 V CC`. Appea |
| mounting ledge | resalte de montaje | errata.md, twice. Distinct from `punto de montaje` (mounting point, design-files.md) and from `superficie de montaje` (mounting surface, already in th |
| inrush current | corriente de irrupción | errata.md. The glossary has `overcurrent` → sobrecorriente and `current limiting` → limitación de corriente, but not the power-up surge. `corriente de |
| copper pour / copper fill | vertido de cobre | design-files.md and errata.md. PCB-layout term; `relleno de cobre` used for the errata heading where the source says "Copper Fill", `vertidos de cobre |
| power plane / rail | plano de alimentación / línea | errata.md (`3.3V power plane` → plano de alimentación de 3,3 V) and design-files.md (`3.3V rail` → la línea de 3,3 V). Kept distinct because the sourc |
| solder nut | tuerca soldable | design-files.md, twice. |
| footprint (PCB component) | huella | design-files.md. Established KiCad terminology in Spanish. |
| opamp (operational amplifier) | amplificador operacional | design-files.md. |
| test point | punto de prueba | design-files.md. |
| silkscreen | serigrafía | design-files.md. The glossary already refers to "the board's own silkscreen labels" in the what-stays-English section but does not give the Spanish no |
| PCB layout | trazado del PCB | design-files.md. Verb form for `to re-route`: volver a trazar. |
| signal integrity | integridad de señal | design-files.md, twice. |
| cable plug (the loose connector supplied for custom wiring) | clavija de cable | index.md (`E7T cable plug` → Clavija de cable E7T). Distinct from `conector` (the mating connector on the enclosure) and from `conector cilíndrico (ba |
| cutout (in the enclosure, for an extra connector) | troquel | index.md (`cutouts for 2 extra SMA connectors`). Not the same as `orificio pretaladrado`, which the glossary reserves for holes the enclosure already  |
| thermal throttling | limitación térmica | troubleshooting.md. |
| runaway process | proceso desbocado | troubleshooting.md. |
| stray voltage | tensión parásita | troubleshooting.md, twice. The source says "stray voltages" injected by a connected device. |
| bus contention | contención en el bus | troubleshooting.md. |
| baud rate / bit rate (prose) | velocidad de transmisión | troubleshooting.md (`incorrect baud rate`). The glossary's number rules cover how to write `115200 bps` but not the prose noun. |
| differential signaling | señalización diferencial | troubleshooting.md (RS-485 A/B lines). |
| differential pair | par diferencial | design-files.md (`USB3 hub RX differential pairs`). |
| USB hub | concentrador | design-files.md. |
| clock oscillator | oscilador de reloj | design-files.md. |
| balancing circuit (super-capacitor) | circuito de equilibrado | design-files.md, twice. Verb/noun: equilibrado, not balanceo. |
| 3rd party | de terceros | ubuntu-installation.md (3rd party operating systems) and resources.md (third-party software compatibility). Used consistently across both. |
| user space | espacio de usuario | ubuntu-installation.md (`the user space halpid daemon`). |
| prebuilt package | paquete precompilado | ubuntu-installation.md. |
| command line tool | herramienta de línea de comandos | ubuntu-installation.md. The glossary keeps command names in English but does not give the phrase. |
| cross-compilation | compilación cruzada | integration.md. |
| custom image building | creación de imágenes personalizadas | integration.md. Built on the glossary's `imagen del sistema`. |
| security hardening | refuerzo de la seguridad | advanced-config.md. |
| backup and recovery (data, not power) | copia de seguridad y recuperación | advanced-config.md. Deliberately not `respaldo`, which the glossary assigns to the super-capacitor and RTC battery senses (`pila de respaldo`, `respal |
| performance tuning | ajuste del rendimiento | advanced-config.md. |
| power-on/off sequencing | secuenciación de encendido y apagado | power-supply.md. |
| brownout | caída de tensión | power-supply.md. Reuses the glossary's `voltage drop` → caída de tensión; kept distinct from `corte de corriente` (blackout), which the glossary alrea |
| load management | gestión de la carga | power-supply.md. |
| status reporting | notificación del estado | controller.md. Paired with the glossary's `monitoring` → supervisión in the same bullet. |
| CE marking | marcado CE | compliance.md. Official EU term. |
| environmental rating | clasificación ambiental | compliance.md. |
| chart plotter (plural) | plóteres cartográficos | index.md. Confirms the plural of the glossary's `plóter cartográfico`; plóteres, not plóters. |
| single-board computer | ordenador de placa única | index.md. Follows rule 6 on ordenador. |
| in-vehicle infotainment | infoentretenimiento a bordo | index.md. |
| telematics | telemática | index.md. |
| environmental sensing | detección ambiental | index.md. |
| quick start guide | guía de inicio rápido | index.md. Note this is the printed leaflet in the box, distinct from the nav section `Getting Started` → `Primeros pasos`, which mkdocs.yml already fi |
| goodie bag | bolsa de accesorios | index.md, image alt text only. |
| clean shutdown | apagado controlado | troubleshooting.md. The source varies its wording (`clean shutdown` here, `graceful shutdown` elsewhere) for one concept; Spanish keeps the single rendering the glossary already assigns to `graceful shutdown`. Not `apagado limpio`. |
| power connector / power socket | conector de alimentación | The English source alternates the two words for the same E7T port; Spanish uses one. `toma` is reserved for nothing here — see `receptacle / socket` above for the connector-opening senses. |

## Terms added during translation

Recorded while translating `tutorials/openplotter-server/`, the only page in
this repository with a full hardware-assembly walkthrough. None of these had an
entry, and each one recurs across the soldering and drilling steps.

| English | Translation | Note |
|:--------|:------------|:-----|
| solder cup | copa | La copa del pin, que se estaña antes de soldar el cable |
| pigtail (pre-wired lead) | latiguillo | Latiguillo JST XH |
| step drill bit | broca escalonada | Distinta de la broca para metal que remata el agujero |
| centre punch | granete | Para marcar el centro del agujero antes de taladrar |
| burr | rebaba | Queda alrededor del agujero al taladrar |
| self-tapping screw | tornillo autorroscante |  |
| O-ring | junta tórica | Estanqueidad alrededor del conector |
| time-series database | base de datos de series temporales | InfluxDB |
