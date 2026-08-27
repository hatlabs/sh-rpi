---
title: Danish translation glossary and style rules (SH-RPi)
date: 2026-08-05
category: translation
module: documentation
problem_type: reference
component: documentation
severity: medium
applies_when:
  - Translating any page from docs/en/ into Danish under docs/da/
  - Reviewing a Danish translation for consistency
  - Adding a new term that has no established Danish equivalent
tags:
  - translation
  - i18n
  - danish
  - terminology
  - mkdocs-static-i18n
  - sh-rpi
---

# Danish translation glossary and style rules

## Context

The SH-RPi documentation is written in English under `docs/en/` and translated
into Danish under `docs/da/`, using the `mkdocs-static-i18n` folder structure.
Every page is an `index.md` inside its own section directory, so a translation
keeps its source's path and filename: `docs/en/hardware/index.md` becomes
`docs/da/hardware/index.md`. Only markdown lives under `docs/da/` — images and
other assets stay with the English source and are shared, including the nested
`assets/` directories under `revisions/` and `tutorials/openplotter-server/`.

`tutorials/openplotter-server/index.md` is deliberately left untranslated. Its
vocabulary is out of scope for this file; only its navigation title is
translated, in `mkdocs.yml`.

**This file began as a copy of the HALPI2 Danish glossary and deliberately keeps
its decisions.** SH-RPi and HALPI2 are both Raspberry Pi power boards with
supercapacitors, a shutdown daemon and a hardware watchdog, so a reader who
knows one Hat Labs board should meet the same Danish words in the other.
`carrier board` → `bærekort`, `watchdog` → `watchdog` and `daemon` → `dæmon` are
HALPI2's calls and stand here too. Terms below the `## SH-RPi terms` heading are
this product's additions; **a shared row changes in both repositories or in
neither.**

The HALMET glossary was not used as the base even though it is also a Hat Labs
board. Its additions are all sensor-input vocabulary — analog and digital
inputs, galvanic isolation, a constant current source — and not one of those
words occurs in the SH-RPi documentation. That was measured against
`docs/en/`, not assumed.

`dutch-glossary.md`, `finnish-glossary.md`, `french-glossary.md`,
`german-glossary.md`, `spanish-glossary.md` and `swedish-glossary.md` are the
siblings of this file in this repository. The general approach is the same in
all of them.

Translations are produced page by page, at different times, potentially by
different people. Without a fixed terminology list the same English term drifts
across pages, and the result reads as machine output even when each individual
sentence is correct. This file is the reference that prevents that drift. It is
a living document: extend it when a page introduces a term that is not listed
here, rather than inventing a one-off translation.

## Five rules where the siblings are wrong for Danish

Read this section before anything else. Every one of these is stated the
opposite way in at least one sibling glossary. Norwegian is the dangerous one:
it is close enough to Danish that a wrong form does not look wrong. There is no
Norwegian glossary in this repository, but there is one next to the HALPI2 file
this one was copied from, so the leak is one paste away.

Each rule ends with the count that proves it. Run the counts; do not reread the
prose. Every language branch so far shipped a typography rule that had been read
rather than measured, and it looked followed right up until a reviewer counted.

1. **Quotation marks are `»…«`, pointing outward.** Opening `»` (U+00BB),
   closing `«` (U+00AB). This is the exact reverse of Norwegian's `«…»`, and it
   is neither German's `„…"` nor Swedish's `"…"` nor French's spaced `« … »`.

   *Count:* `grep -roE '«[^»]{0,120}»' docs/da | wc -l` must be **0** — every hit
   is a Norwegian-order quote. `grep -roc '»' docs/da` and `grep -roc '«' docs/da`
   must give the same total.

2. **Address the reader as `du`.** Danish technical and consumer documentation
   uses `du` throughout; the polite `De` is archaic and reads as parody in a
   product manual. German's `Sie` and French's *vouvoiement* are both wrong here.
   Instructions take the imperative: `Tilslut strømkablet.` /
   `Kontrollér polariteten med multimeteret, før du tænder for spændingen.`

   *Count:* `grep -rnE '\b(De|Dem|Deres)\b' docs/da` must return **0** hits that
   are not sentence-initial `De` meaning *they*. Every page with instructions
   must have at least one `du`/`dig`/`din`/`dit`/`dine`.

3. **No space before `; : ! ?`** — as in German, Swedish and Norwegian, and
   unlike French, whose rule is the exact opposite and demands a no-break space.

   *Count:* with code fences stripped, `grep -rnE ' [;:!?]' docs/da` must return
   **0**.

4. **Compounding with a proper name takes one hyphen at the junction, not
   throughout.** Danish writes `NMEA 2000-netværk`, `Signal K-server`,
   `Raspberry Pi-antenne`, `Compute Module 4-kortet`. German writes
   `NMEA-2000-Netzwerk` — hyphens all the way through — and copying that pattern
   into Danish is wrong. Ordinary compounds are written **solid**, no hyphen and
   no space: `kabelforskruning`, `strømforsyning`, `superkondensatorbank`,
   `indgangsspændingsområde`. A space inside a compound is the most visible
   marker of a machine-translated Danish page.

   *Count:* `grep -rnE 'NMEA-2000|Signal-K|Raspberry-Pi|Compute-Module' docs/da`
   must return **0**. `grep -rnE 'NMEA 2000[a-zæøå]' docs/da` must return **0**
   (a Danish head word glued on without the hyphen).

5. **Danish is not Norwegian.** These are the forms that leak, in the order they
   leak. Left is Danish and correct; right is Norwegian and must not appear.

   | Write | Never write | Where it shows up |
   |:------|:------------|:------------------|
   | `af` | `av` | everywhere — the highest-frequency tell |
   | `-tion` (`installation`, `konfiguration`, `isolation`) | `-sjon` | every second page |
   | `netværk` | `nettverk` | NMEA 2000, Ethernet |
   | `spænding`, `spændingsfald` | `spenning`, `spenningsfall` | electrical sections |
   | `vand`, `vandtæt`, `lænsevand` | `vann`, `vanntett` | mounting, enclosure |
   | `kun` | `berre` | prerequisites, warnings |
   | `ikke` | `ikkje` | warnings |
   | `hvordan` | `korleis` | procedures |
   | `nedlukning` | `nedstenging` | shutdown sections |

   *Count:* `grep -rniwE 'av|ikkje|berre|korleis|vann|nettverk|spenning' docs/da`
   must return **0**, and `grep -rniE '[a-zæøå]sjon' docs/da` must return **0**.

## Names that are never translated

Product names, protocol names, hardware standards and software UI strings stay
in English. The device's own interface, its command output and the labels
printed on the board are English, so translating one of them sends the reader
looking for something that is not there.

- **Products and software:** SH-RPi, Sailor Hat, HALPI2, Signal K, OpenPlotter,
  Raspberry Pi OS, Waveshare, PlatformIO, Node-RED, Grafana, Hat Labs
- **Hardware and standards:** Raspberry Pi, Compute Module 4 (CM4), HAT,
  ATtiny1616, PCF8563, CAN, NMEA 2000, NMEA 0183, RS485, GNSS, I2C, SPI, UPDI,
  GPIO, USB, microSD, PoE. The add-on boards keep their product names exactly:
  **CAN HAT**, **RS485 HAT**, **GNSS HAT**.
- **Board labels and pin names, copied as printed:** `PROG`, `RTC EN`,
  `GPIO4 Enable`, `BOOT`, `2A`, `3A`, `CAN0`, `CAN1`, `GND`, `3V3`. A label is
  what the reader looks for with the board in hand; a translated label cannot be
  found.
- **Commands, file paths, configuration keys and package names:** `shrpi`,
  `shrpid`, `raspi-config`, `avrdude`, `rpiboot`, `gpsd`, `/etc/shrpid.conf`,
  `/boot/firmware/config.txt`, `/var/run/shrpid.sock`, `/dev/ttyAMA0`,
  `blackout-time-limit`, `dtoverlay`, `dtparam`, `hciuart`.

Everything inside a code fence stays exactly as the English source has it —
including comments inside fences. Command output is never touched. URLs and
image filenames are never touched.

Mode names stay English and the head noun is Danish, as in the sibling
glossaries: `BOOT-tilstand` (the CM4 flashing mode, spelled as the switch is
labelled), `boot-tilstand`.

## Units and numbers

Same handling as the other languages — the English source writes `12V` and
`0.9A`, and both are wrong in Danish.

| English source | Danish |
|:---------------|:-------|
| `12V`, `0.9A` | `12 V`, `0,9 A` |
| `5.5 x 2.1 mm` | `5,5 × 2,1 mm` |
| `-20°C to +60°C` | `−20 °C … +60 °C` |
| `120Ω` | `120 Ω` |
| `3-5A` | `3–5 A` (en dash for ranges) |
| `9-32V`, `10-32 V` | `9–32 V`, `10–32 V` |
| `250 kbps` | `250 kbit/s` |
| `2m`, `45mm`, `40mm fan` | `2 m`, `45 mm`, `40 mm-blæser` |
| `20F`, `3.0 V` supercapacitors | `20 F`, `3,0 V` |
| `3.81 mm (0.15")` pitch | `3,81 mm (0,15")` benafstand |
| `5000W` peak pulse | `5000 W` impulseffekt |
| `-167 dBm` | `−167 dBm` |

Decimal comma in every measured value. Version numbers, firmware versions and
file paths keep their dots: `v2.0.0`, `/dev/ttyAMA0`, `0x6d`. Times keep the
colon: `15:00`.

*Count:* outside code fences, `grep -rnE '[0-9](V|A|W|F|Hz|Ω|mm|m |kg|°C)' docs/da`
must return **0** (missing space before the unit), and
`grep -rnE '[0-9]+-[0-9]+ *(V|A|W|°C|mA)' docs/da` must return **0** (hyphen
instead of en dash in a range).

## Links, images, admonitions, navigation

Same as the sibling glossaries: paths are copied from the English source
unchanged and never carry a language segment; image captions and alt texts are
translated but filenames are not; screenshots stay English because the reader's
own screen is English; standard admonition titles are translated centrally in
`mkdocs.yml`, custom ones in the page.

Navigation titles live in `mkdocs.yml` under the i18n plugin's
`nav_translations`, not in any markdown file. That is the single source of
truth; do not restate the full list here. Three entries are judgement calls
worth recording:

- `Errata` → **Kendte fejl**. The Latin term is opaque to a general reader, and
  the page lists known hardware defects, so plain Danish is clearer.
- `FAQ` → **FAQ**. Unlike Finnish (*UKK*), Danish has no established
  abbreviation; Danish sites write `FAQ`, and the page's own H1 is `FAQ`.
- `Add-on Hardware` → **Udvidelseshardware**, matching `udvidelseskort` in the
  glossary below. `Overview` appears twice in the nav — once under the add-on
  section and once under the tutorials — and takes one translation,
  **Oversigt**, in both places.

## Glossary

### Enclosure, mounting, and installation

| English | Danish | Note |
|:--------|:-------|:-----|
| carrier board | bærekort | The accurate term, as in French, German and Swedish |
| enclosure | kabinet | |
| enclosure lid | kabinetlåg | |
| gasket | pakning | |
| heat sink | køleplade | |
| ingress protection (IP rating) | kapslingsklasse | `kapslingsklasse IP65` |
| waterproof | vandtæt | Not the Norwegian `vanntett` |
| wall-mount | vægmontering | |
| mounting surface | monteringsflade | |
| mounting screw | monteringsskrue | |
| countersunk screw | undersænket skrue | |
| standoff | afstandsbolt | |
| pilot hole (you drill it) | styrehul | `Bor styrehuller til monteringsskruerne` |
| pre-drilled hole (already in the enclosure) | forboret hul | `Kabinettet har forborede huller til panelstik` |
| mounting template | boreskabelon | |
| bilge water | lænsevand | `Monter over det forventede lænsevandsniveau` |
| bulkhead | skot | |
| cable gland | kabelforskruning | |
| cable routing | kabelføring | |
| service loop | servicesløjfe | Slack left at both cable ends |
| cable tie | kabelbinder | Not the colloquial `strips` |
| blind plug | blindprop | |
| breather plug | trykudligningsprop | |
| thermal pad | termisk pude | |
| silk screen | silketryk | |

**Two holes, two words.** `styrehul` is a hole *you* drill; `forboret hul` is a
hole the enclosure already ships with. Danish has one obvious root for both
(`forbore`), and using it for both produces the nonsense instruction *bor
forborede huller* — "drill pre-drilled holes" — which is exactly what happened
in Swedish. Keep the two words apart. SH-RPi needs both on the same page: the
getting-started section drills its own holes and also speaks of enclosures
*without* pre-drilled holes.

**A note on `bærekort`.** Danish takes the accurate term, like French
(`carte porteuse`), German (`Trägerplatine`) and Swedish (`bärkort`), and unlike
Finnish (`emolevy`, literally *motherboard*, chosen there for reader
familiarity). The divergence between the languages is deliberate, decided per
language and per audience. Do not harmonise them.

`bærekort` carries the module/board relationship on its own, so passages about
reseating the compute module or troubleshooting a board that will not boot need
no extra explanation. Only the Finnish glossary needs that warning.

### Power and electrical

| English | Danish | Note |
|:--------|:-------|:-----|
| power supply | strømforsyning | Both the function and the external unit |
| power rail | spændingsskinne | Later mentions: `3,3 V-skinnen` |
| input voltage range | indgangsspændingsområde | |
| polarity | polaritet | |
| reverse polarity protection | beskyttelse mod omvendt polaritet | |
| fuse | sikring | |
| inline fuse | ledningssikring | |
| circuit breaker | automatsikring | |
| current limiting | strømbegrænsning | |
| current limiter | strømbegrænser | |
| current limit switch | strømbegrænsningskontakt | |
| overcurrent | overstrøm | |
| voltage drop | spændingsfald | Not the Norwegian `spenningsfall` |
| grounding | jordforbindelse | |
| ground loop | jordsløjfe | |
| short circuit | kortslutning | |
| galvanic isolation | galvanisk adskillelse | |
| wire gauge | ledertværsnit | Danish uses mm², not AWG |
| marine-grade wire | marinegodkendt ledning | |
| wire strippers | afisoleringstang | |
| crimping | krimpning | |
| crimper | krimptang | |
| heat-shrink tubing | krympeflex | |
| heat gun | varmepistol | |
| multimeter | multimeter | |
| terminal block | klemrække | The pluggable Phoenix connector on the board |
| strain relief | trækaflastning | |
| super-capacitor | superkondensator | |
| real-time clock | realtidsur | |
| backup battery | backupbatteri | |

### Connectors and interfaces

| English | Danish | Note |
|:--------|:-------|:-----|
| connector | stik / tilslutning | `tilslutning` for a board-mounted socket |
| panel connector | panelstik | |
| barrel connector | DC-jackstik | First mention: `DC-jackstik (barrel)` |
| header | stikliste | `40-benet GPIO-stikliste` |
| pin | ben | `Kortslut benene` |
| pitch | benafstand | `3,81 mm benafstand` |
| jumper | jumper | |
| solder jumper | loddejumper | |
| switch (physical) | kontakt | |
| backbone | backbone | Established in Danish NMEA 2000 usage |
| drop cable | dropkabel | |
| T-connector | T-stik | |
| terminator | terminering | The function; the part is `termineringsmodstand` |
| termination resistor (120 Ω) | termineringsmodstand | |
| front panel | frontpanel | |
| flexible flat cable (FFC) | fladkabel (FFC) | |
| male / female | hanstik / hunstik | |
| port | port | |

### Operation and system behaviour

| English | Danish | Note |
|:--------|:-------|:-----|
| boat computer | bådcomputer | |
| to boot | starte | Booting: `opstart` |
| first boot | første opstart | |
| shutdown | nedlukning | Not the Norwegian `nedstenging` |
| to shut down | lukke ned | |
| graceful shutdown | kontrolleret nedlukning | |
| to power-cycle | slukke og tænde igen | Not a noun in Danish |
| reboot / restart | genstart | |
| power loss | strømsvigt | The loss of input power the controller detects |
| blackout | strømafbrydelse | Timer: `strømafbrydelsestimeren` — one solid compound |
| power management | strømstyring | |
| status LED | status-LED | |
| indicator | indikator | |
| monitoring | overvågning | |
| passive cooling | passiv køling | |
| filesystem | filsystem | |
| to unmount | afmontere | Both senses: a filesystem, and physically removing a module or the board |
| to reseat | genmontere | |
| watchdog | watchdog | |
| standby | standby | |
| mode | tilstand | `boot-tilstand` |
| controller | controller | The microcontroller on the board; also `mikrocontroller` |

### Software and networking

| English | Danish | Note |
|:--------|:-------|:-----|
| firmware | firmware | Not `fast programmel` — matches the sibling decision to keep the trade term |
| daemon | dæmon | First mention: `dæmon (baggrundstjeneste)` |
| to flash | flashe | |
| system image | systemimage | `et systemimage`, `systemimaget` — the trade says *image*, not *aftryk* |
| operating system image | styresystemimage | |
| container image | containerimage | |
| container app | containerapp | |
| headless | uden skærm | First mention: `uden skærm (headless)` |
| dashboard | dashboard | Kept: it is the name of the page the reader opens |
| web interface | webgrænseflade | |
| browser | browser | |
| credentials | loginoplysninger | |
| username | brugernavn | |
| default password | standardadgangskode | |
| single sign-on (SSO) | single sign-on (SSO) | |
| Certificate Authority (CA) | certifikatmyndighed (CA) | |
| WiFi Access Point | WiFi-adgangspunkt | Keep `WiFi Access Point` where it names a UI string |
| wired / wireless | kablet / trådløs | |
| remote access | fjernadgang | |
| setting | indstilling | |
| update | opdatering | |
| package | pakke | |
| command line tool | kommandolinjeværktøj | |

### Applications and use cases

| English | Danish | Note |
|:--------|:-------|:-----|
| chart plotter | kortplotter | |
| data logging | datalogning | |
| vessel | fartøj | `båd` only where the source says *boat* |
| depth sounder | ekkolod | |
| wind instrument | vindmåler | |
| GPS receiver | GPS-modtager | |
| fleet management | flådestyring | |
| predictive maintenance | forudsigende vedligeholdelse | |
| remote monitoring | fjernovervågning | |
| compliance | overensstemmelse | |
| warranty | garanti | |

## SH-RPi terms

SH-RPi is a power management HAT, so its vocabulary is HALPI2's power and
shutdown language plus the mechanics of stacking boards on a Raspberry Pi. Rows
above this heading are shared with HALPI2 and are not changed here alone.

### The board and the stack

| English | Danish | Note |
|:--------|:-------|:-----|
| HAT | HAT | Never translated. Definite `HAT'en`, plural `HAT'er`; compounds take the junction hyphen — `HAT-stikliste`, `CAN HAT-stiklisten` |
| add-on board / add-on card | udvidelseskort | The CAN, RS485 and GNSS HATs collectively; nav title `Add-on Hardware` → `Udvidelseshardware` |
| to stack (boards) | stable | `Yderligere HAT'er kan stables oven på Sailor Hat` |
| board stack (PCB stack) | kortstak | The assembled boards; `PCB stack` is the same thing |
| stack-through header / stacking header | stabelstikliste | One Danish word for both English forms: the tall 40-pin strip that carries GPIO through to the board above |
| pass-through GPIO header (on the board) | gennemgående GPIO-stikliste | The board's own 2×20 socket, not the loose strip — keep it distinct from `stabelstikliste` |
| spacer (on the stack-through header) | afstandsstykke | Removed when SH-RPi sits directly on the Raspberry Pi. Not `afstandsbolt`, which is the metal standoff |
| standoff | afstandsbolt | Inherited from HALPI2 |
| hex standoff | sekskantet afstandsbolt | Never `sekskanttop` — HALPI2 assigns that to the *tool* (a hex socket) |
| mounting screw | monteringsskrue | Inherited from HALPI2 |
| solder jumper | loddejumper | Inherited. See the note below: closed by default on SH-RPi and opened with a knife |
| jumper | jumper | Inherited. A removable link placed across a pin pair |
| jumper header | jumperstikliste | The header a jumper is placed on, e.g. the current limiter header |
| pin | ben | Inherited. `40-benet GPIO-stikliste`; `klip benet af` for the pin the GNSS HAT page has you cut |
| base board | bærekort | The CM4 carrier and, in the enclosure walkthrough, the lowest board of the stack |
| base plate | bundplade | The perforated plate in the enclosure — **not** `bærekort`; the two are one letter apart in English and unrelated in fact |
| vertical mount | lodret holder | The black plastic parts that hold the board stack upright |
| cable gland | kabelforskruning | Inherited from HALPI2 |
| panel connector | panelstik | Inherited from HALPI2 |
| microcontroller | mikrocontroller | The ATtiny1616; the chip name itself is never translated |

### Power and electrical

| English | Danish | Note |
|:--------|:-------|:-----|
| supercapacitor / supercap | superkondensator | HALPI2 has `super-capacitor`. The English source writes it three ways; Danish uses one word |
| supercapacitor bank | superkondensatorbank | Solid compound, per rule 4 |
| power reservoir | energireserve | What the supercapacitor bank is for |
| power management | strømstyring | Inherited from HALPI2 |
| buck converter / step-down converter | buckomformer | Solid compound, as in HALPI2's own added row. See the note on *boost* below — this row means step-down |
| boost converter | boostomformer | Only where the English says *boost*. It is a mistake in the source (issue #25) and is translated as written, not corrected |
| current limiter | strømbegrænser | Inherited from HALPI2 |
| current limit | strømgrænse | The setting: `strømgrænsen på 0,8 A`. The act stays `strømbegrænsning` |
| current limiter header | strømbegrænserstikliste | The jumper header with the rows labelled `2A` and `3A` — labels stay as printed |
| transient voltage suppressor (TVS) | transientbeskyttelse (TVS) | The part: `33 V transientbeskyttelsesdiode`. HALPI2 has `TVS-begrænsning` for the clamping action |
| choke | drosselspole | |
| pi-filter | pi-filter | |
| reverse polarity protection | beskyttelse mod omvendt polaritet | Inherited. The part: `beskyttelsesdiode mod omvendt polaritet` |
| voltage threshold | spændingstærskel | The enable/disable levels the microcontroller switches on (8,0 V / 5,0 V) |
| voltage limit (configuration) | spændingsgrænse | Where the source says *limit*, e.g. `blackout-voltage-limit`. Distinct from `spændingstærskel` |
| undervoltage | underspænding | The board's own defined condition: input below 10 V. See the note on *brownout* |
| overvoltage | overspænding | The supercapacitor fault the rapid blink pattern reports |
| charge / discharge | opladning / afladning | Verbs `oplade` / `aflade`; the source's *depleting* is `aflades` |
| hold-up time | holdetid | How long the supercapacitors keep the Raspberry Pi running after input power is lost |
| real-time clock (RTC) | realtidsur (RTC) | Inherited. The abbreviation `RTC` stays, as does the board label `RTC EN` |
| backup battery | backupbatteri | Inherited from HALPI2 |
| rechargeable / non-rechargeable | genopladeligt / ikke-genopladeligt | Safety-critical pair — see the note below |

### Shutdown, watchdog and status

| English | Danish | Note |
|:--------|:-------|:-----|
| safe shutdown | sikker nedlukning | The product's core promise; `nedlukning` is inherited |
| graceful shutdown | kontrolleret nedlukning | Inherited from HALPI2 |
| to power down | slukke | `slukke for Raspberry Pi'en` — the board cutting the 5 V rail. Distinct from `lukke ned`, which is the operating system shutting itself down |
| power-off | slukning | The act/state. The `poweroff` key and the `gpio-poweroff` overlay stay English |
| blackout | strømafbrydelse | Inherited. The configuration keys `blackout-time-limit` and `blackout-voltage-limit` stay English |
| brownout | spændingsdyk | A dip, not a break. See the note below — HALPI2's added row renders *brownout* as `underspænding`, which SH-RPi needs for *undervoltage* |
| power glitch | kortvarigt spændingsudfald | Matches HALPI2's `immunitet over for korte spændingsudfald` for *glitch immunity* |
| watchdog | watchdog | Left in English, as in HALPI2 |
| watchdog timer | watchdog-timer | Junction hyphen. `timer` is the Danish word — cf. `strømafbrydelsestimeren` |
| watchdog reboot | watchdog-genstart | |
| heartbeat | heartbeat | Kept English alongside `watchdog`, which it belongs with. First mention: `heartbeat-signal (livstegn)` |
| sleep / sleeping (board state) | dvale | `SH-RPi er i dvale`; waking is `vækning`, and the RTC alarm is `alarm` |
| status LED array | status-LED-række | `status-LED` is inherited |
| bar display (LED charge bar) | søjlevisning | Built on HALPI2's `spændingssøjle` for the same LED row |

### Software

| English | Danish | Note |
|:--------|:-------|:-----|
| daemon | dæmon | Inherited. First mention: `dæmon (baggrundstjeneste)`. `shrpid` is a name and stays |
| service | tjeneste | The systemd service; the unit file `shrpid.service` stays as written |
| installation script | installationsscript | Danish spells it `script`, and the compound is solid |
| configuration file | konfigurationsfil | `-tion`, never `-sjon` (rule 5). The path `/etc/shrpid.conf` stays |
| device tree overlay | device tree-overlay | Inherited. Kept English because it names the `dtoverlay` key the reader types |
| firmware | firmware | Inherited from HALPI2 |
| to flash | flashe | Inherited. Self-flashing: `selvflashning` |
| headless | uden skærm | Inherited. First mention `uden skærm (headless)`; the OpenPlotter *Headless image* keeps its English product name |
| image (OS image) | systemimage | Inherited. `64-bit systemimage` |
| REST API | REST-API | |
| file socket | filsocket | `/var/run/shrpid.sock`; the path itself stays |
| command-line interface | kommandolinjegrænseflade | HALPI2 has `kommandolinjeværktøj` for the tool |

### Enclosure work and tools

| English | Danish | Note |
|:--------|:-------|:-----|
| step drill bit | trinbor | The bit that looks like a metal Christmas tree |
| pilot hole | styrehul | Inherited — and keep it apart from `forboret hul`, which SH-RPi also uses |
| heat shrink tubing | krympeflex | Inherited from HALPI2 |
| zip tie / tie wrap | kabelbinder | Inherited as `cable tie`. The source uses three English words for one thing; Danish uses one |
| double-sided tape | dobbeltklæbende tape | For mounting the fan |
| terminal plug (screw terminal plug) | skrueklemme | The pluggable half you wire up. HALPI2's `klemrække` is the board-mounted socket it plugs into |
| cup terminal (solder cup) | loddekop | The soldering video in the getting-started page |
| fan | blæser | HALPI2's consistency-pass decision; keeps `ventilation` free for airflow |
| air circulation | luftcirkulation | Inherited from HALPI2 |

### Solder jumper is not a jumper

Two words that look alike and mean opposite actions, and both appear in
instructions the reader carries out with the board in hand.

- **`loddejumper`** is permanent. On SH-RPi the `RTC EN` solder jumper is closed
  from the factory, and you *open* it by cutting the traces between the pads
  with a sharp knife; `GPIO4 Enable` is the reverse, an open pair you join.
- **`jumper`** is removable. It sits across a pin pair on the current limiter
  header or the `PROG` header and is pulled off with fingers.

Using one word for both sends a reader for a knife they do not need, or has them
try to pull off something that is soldered down. Where the English says *solder
jumper pads*, write `loddejumperens loddeflader` — never `jumper` alone.

### Rechargeable is not non-rechargeable

The GNSS HAT ships with an ML1220 **genopladeligt** lithium cell, and the source
warns that replacing it with a **ikke-genopladeligt** battery risks explosion and
fire. Both words must appear in full and be opposed in the same sentence:

> ML1220-batteriet er **genopladeligt** og må **ikke** udskiftes med et
> **ikke-genopladeligt** batteri. Det medfører risiko for eksplosion og brand!

Do not shorten `ikke-genopladeligt` to `ikke genopladeligt` (two words reads as a
negated clause and can be skimmed past), and do not substitute `engangsbatteri` —
the same paragraph names a specific non-rechargeable type, `CR1220`, which the
reader must be able to match to the word. Note that SH-RPi's *own* RTC battery is
a CR1220, non-rechargeable, and that is correct there; only the GNSS HAT's ML1220
must not be swapped.

### Buck, and the source's `boost`

The SH-RPi has two step-down converters. The English hardware page names the
second stage a *buck converter* in its heading and then calls the same part a
*boost converter* twice in the following two sentences. That is an error in the
source, reported as issue #25.

Translate what the English says: `boostomformer` where it says *boost*,
`buckomformer` where it says *buck*. Do not silently correct it — a translation
that disagrees with the English page in front of the reader is harder to
diagnose than a bug that is already filed. **This row means step-down in both
cases**, so no descriptive Danish rendering may creep in that says the voltage
goes up (`opomformer`, `spændingsforøger`). When the issue is fixed in English,
the Danish page follows in the same change.

### A note on `brownout` and `underspænding`

HALPI2's added-terms table renders *brownout* as `underspænding`. That was safe
there. It is not safe here: the SH-RPi hardware page uses *undervoltage* as a
defined board condition — input below 10 V, which triggers deep-discharge
protection — so the two English words must stay apart in Danish.

- *undervoltage* → `underspænding` (the board's condition, one specific
  threshold)
- *brownout* → `spændingsdyk` (a sag the supercapacitors ride out; the
  introduction pairs it with *power glitches*)

The HALPI2 row is left as it stands; this is a divergence, recorded here rather
than resolved by editing a shared row.

### A note on `HAT`

`HAT` is never translated: it is the Raspberry Pi Foundation's term and it is
printed on the boards. Danish inflects it with an apostrophe — `HAT'en`,
`HAT'er`, `HAT'erne` — and compounds it with the junction hyphen, as rule 4
prescribes for a proper name: `HAT-stikliste`, `CAN HAT-stiklisten`,
`GNSS HAT-konfigurationen`. The product names `CAN HAT`, `RS485 HAT` and
`GNSS HAT` are never split, translated or reordered.

## Verification

A translated page is not done until:

1. `uv run mkdocs build --strict` passes.
2. `uv run python scripts/check_anchors.py site` passes.
3. `uv run python scripts/translation_status.py` shows the page as current.
4. `uv run python scripts/check_glossary.py da` passes.
5. `uv run python scripts/check_typography.py da` passes.
6. Structure matches the source — see `.claude/skills/translate-page/SKILL.md`.
7. Every number in the English text appears in the translation. A wrong voltage
   or current in an installation guide is a safety problem, not a typo.
8. The three safety pairs above are checked by eye on the pages that carry them:
   `loddejumper` vs `jumper` (hardware), `genopladeligt` vs `ikke-genopladeligt`
   (GNSS HAT), and the warning that the power input must never go to the 5 V
   output connector (getting-started).
9. **The five rules at the top are counted against the pages, not re-read.**
   Every count below must come out at zero:

```bash
# 1 — Norwegian-order quotes
grep -roE '«[^»]{0,120}»' docs/da | wc -l
# 1 — » and « must balance
grep -ro '»' docs/da | wc -l; grep -ro '«' docs/da | wc -l
# 2 — polite address
grep -rnE '\b(De|Dem|Deres)\b' docs/da
# 3 — French spacing
grep -rnE ' [;:!?]' docs/da
# 4 — German hyphen chains, and missing junction hyphen
grep -rnE 'NMEA-2000|Signal-K|Raspberry-Pi|Compute-Module|NMEA 2000[a-zæøå]' docs/da
# 5 — Norwegian forms
grep -rniwE 'av|ikkje|berre|korleis|vann|nettverk|spenning' docs/da
grep -rniE '[a-zæøå]sjon' docs/da
# units
grep -rnE '[0-9](V|A|W|F|Hz|Ω|mm|kg|°C)' docs/da
grep -rnE '[0-9]+-[0-9]+ *(V|A|W|mA|°C)' docs/da
# compounds that must be solid
grep -rniE 'kabel forskruning|strøm forsyning|bære kort|super kondensator|superkondensator bank' docs/da
# the two-word form of the safety word
grep -rn 'ikke genopladelig' docs/da
```

Strip code fences before running the spacing, unit and hyphen counts — commands,
paths and configuration keys legitimately contain all of them:

```bash
python3 - <<'PY'
import re, pathlib
for p in sorted(pathlib.Path('docs/da').rglob('*.md')):
    t = re.sub(r'^---\n.*?\n---\n', '', p.read_text(encoding='utf-8'), flags=re.S)
    t = re.sub(r'```.*?```', ' ', t, flags=re.S)
    t = re.sub(r'`[^`\n]*`', ' ', t)
    print(p, len(re.findall(r' [;:!?]', t)), len(re.findall(r'[0-9](V|A|W|F|mm|°C)', t)))
PY
```

A non-zero count is the finding. A rule that was read looks followed.

## Related

- `dutch-glossary.md`, `finnish-glossary.md`, `french-glossary.md`,
  `german-glossary.md`, `spanish-glossary.md`, `swedish-glossary.md` — siblings
  in this repository
- `../../../halpi2/solutions/translation/danish-glossary.md` — the file this one
  was copied from. Shared rows change in both or in neither
- `.claude/skills/translate-page/SKILL.md` — the procedure

## Terms added during translation

Rows below were added while translating the **HALPI2** pages, and their page
references are HALPI2's. They are kept because they are Danish terminology
decisions, not HALPI2 decisions, and several of them — `buckomformer`, `HAT`,
`device tree-overlay`, `blæser`, `enkeltkortcomputer` — are needed on the SH-RPi
pages too. Append SH-RPi's own discoveries to the same table, naming the page.

| English | Translation | Note |
|:--------|:------------|:-----|
| apt repository | apt-pakkearkiv | ubuntu-installation.md heading and body; glossary has 'package' but not 'repository'. 'pakkearkiv' is the standard Danish term for a Debian/apt repo;  |
| schematic | kredsløbsdiagram | design-files.md title and body; mkdocs.yml nav_translations already fixes 'Design Files and Schematics' -> 'Designfiler og kredsløbsdiagrammer', so th |
| PCB layout | print-layout | design-files.md; 'print' is the established Danish word for a printed circuit board, and 'layout' is the trade term |
| component footprint | komponent-footprint | design-files.md 0.6.0 changelog; Danish PCB practice keeps 'footprint' untranslated — 'fodaftryk' would not be understood |
| buck converter | buckomformer | design-files.md 0.6.0 changelog; solid compound per rule 4, junction hyphen only against the number: '10 V-buckomformeren' |
| opamp / operational amplifier | operationsforstærker | design-files.md 0.6.0 changelog |
| solder nut | loddemøtrik | design-files.md 0.5.0 changelog |
| copper pour / copper fill | kobberflade / kobberudfyldning | design-files.md and errata.md; 'kobberflade' for the plural pours in the changelog, 'kobberudfyldning' for the errata heading |
| power plane | forsyningsplan | errata.md; later mention shortened to '3,3 V-planet' as the glossary does for spændingsskinne |
| mounting ledge | monteringsafsats | errata.md; the cast ledges inside the enclosure that the board rests on |
| flash (casting residue) | grat / gratkant | errata.md; the English source quotes "flashes" as leftover casting aluminium — unrelated to 'to flash' firmware, which stays 'flashe' |
| solder mask | loddemaske | errata.md |
| inrush current | indkoblingsstrøm | errata.md; distinct from 'overstrøm' in the glossary |
| thermal throttling | termisk nedregulering | troubleshooting.md, CPU temperature section |
| stray voltage | vildfaren spænding | troubleshooting.md rainbow-LED section |
| rollback (firmware) | tilbagerulning / rulle tilbage | troubleshooting.md firmware section |
| single-board computer | enkeltkortcomputer | index.md; solid compound, distinct from 'bærekort' |
| glitch immunity | immunitet over for korte spændingsudfald | index.md hardware feature list; rendered descriptively since Danish has no single trade term |
| cross-compilation | krydskompilering | integration.md placeholder bullet |
| security hardening | sikkerhedshærdning | advanced-config.md placeholder bullet |
| brownout | underspænding | power-supply.md placeholder bullet; 'strømafbrydelse' in the glossary is the full blackout, so a separate word was needed. **SH-RPi diverges** — see the note in the SH-RPi section |
| wall wart (plug-in mains power supply) | netadapter | "What You'll Need" list, DC barrel connector bullet. The glossary has 'power supply' -> 'strømforsyning' but nothing for the scare-quoted colloquial ' |
| peripherals | perifere enheder | Heading 'Step 1: Connect Essential Peripherals' and the 'high-current peripherals' sentence in the current-limiting section. Standard Danish IT term;  |
| terminals (crimp-on ring/spade terminals) | kabelsko | 'Heat-shrink tubing and terminals' and 'Install terminals using proper crimping technique'. The glossary's 'terminal block' -> 'klemrække' is the boar |
| cable grommet | gennemføringstyl | 'Install cable glands or cable grommets if routing through bulkheads'. The glossary covers 'cable gland' -> 'kabelforskruning' but not the rubber grom |
| splash screen | startskærm | 'Raspberry Pi OS splash screen' in the First Boot section. |
| mounting hardware | monteringsbeslag | 'Use corrosion-resistant mounting hardware' under Marine Installations. Glossary has 'mounting screw' and 'standoff' but no collective term. |
| chafing | skamfiling | 'Protect cable from chafing and damage' in Cable Preparation; the standard Danish marine word for line/cable wear. |
| electrical code | elregler | 'Ensure compliance with local electrical codes' / 'Comply with local electrical codes'. Glossary has 'compliance' -> 'overensstemmelse' but not the co |
| flow control (hardware flow control) | flowkontrol (hardwarestyret flowkontrol) | technical-reference/interfaces.md, ctsrts paragraph. 'flowkontrol' is the established Danish trade term; 'strømningsstyring' would read as fluid mecha |
| chip select | chip select | technical-reference/interfaces.md CTS/RTS conflict table ('CAN FD chip-select'). Kept English, as Danish PCB/embedded practice does; rendered as 'Chip |
| transceiver (RS-485 transceiver) | transceiver | technical-reference/interfaces.md, rs485 parameter paragraph. Kept English; 'sendemodtager' exists but is not what Danish RS-485 documentation says. N |
| device node | enhedsnode | technical-reference/interfaces.md 'Verifying' section. Solid compound, standard Danish Linux usage. |
| block device | blokenhed | user-guide/software.md step 6 of the USB-boot procedure. Solid compound. |
| mass storage device / mass-storage gadget firmware | masselagerenhed / firmwaren til masselagerenheden | user-guide/software.md steps 4-6. 'masselager' is the standard Danish term; the English 'gadget' is dropped because Danish has no equivalent and it ad |
| port forwarding | portviderestilling | user-guide/software.md, VNC-over-internet paragraph. Solid compound; 'port forwarding' is also heard but the Danish form is unambiguous. |
| marine apps | marineapplikationer | user-guide/software.md image-variant table and Homarr dashboard bullet. Solid compound. Distinct from the glossary's 'containerapp', which names the C |
| login console | loginkonsol | technical-reference/interfaces.md UART intro. Solid compound, consistent with the glossary's 'loginoplysninger'. |
| setup wizard | opsætningsguide | user-guide/software.md, Raspberry Pi OS configuration section. |
| HAT (Raspberry Pi HAT) | HAT / HAT'er | hardware.md, whole 'Using HATs' section. The glossary lists no form for it; kept English as a hardware-standard name and inflected with apostrophe-s i |
| spudger | spudger (åbnerpind) | hardware.md, CM5 removal. No Danish trade word exists; first mention glosses it, following the glossary's own 'dæmon (baggrundstjeneste)' / 'uden skær |
| socket (the tool: 26mm socket, hex socket) | top / sekskanttop | hardware.md, connector removal. Must not collide with 'stik', which the glossary already assigns to the electrical connector sense — a reader meeting  |
| board-to-board connector | kort-til-kort-stik | hardware.md, CM5 replacement. Phrase compound, so hyphens throughout are correct Danish here and do not conflict with rule 4, which governs proper-nam |
| threaded insert | gevindindsats | hardware.md, HAT installation ('pre-installed M2.5 threaded inserts'). Distinct from 'afstandsbolt' (standoff), which the glossary already has and whi |
| device tree overlay | device tree-overlay | hardware.md, interface sharing and software configuration. Kept English because it names the `dtoverlay` config key the reader types; junction hyphen  |
| clearance (vertical clearance above the board) | frihøjde | hardware.md, physical constraints and standoff sizing. The standard Danish term for the free space above a component. |
| voltage bar (LED pattern) | spændingssøjle | operation.md, LED status quick-reference table — the LED row acting as a bar-graph readout of super-capacitor charge. Derived from the glossary's 'spæ |
| grace period | henstandsperiode | operation.md, automatic restart behaviour ('5-second grace period'). |
| wake-up event | opvækningshændelse | operation.md, standby mode feature-status admonition. |
| amber (LED colour) | ravgul | hardware.md, status LED table. Needed a distinct word from 'gul' (yellow), which the same table already uses for LED 3. |
| TVS clamping | TVS-begrænsning | technical-reference/hardware.md, input protection sentence. The glossary has no entry for clamping; 'begrænsning' matches 'strømbegrænsning' already i |
| thermal management | termisk styring | technical-reference/hardware.md H2. Chosen over the more literal 'varmeafledning' because docs/da/user-guide/hardware.md already renders the same Engl |
| load equivalency number (LEN) | Load Equivalency Number (LEN) | user-guide/interfaces.md, NMEA 2000 network loading. Kept in English as an NMEA 2000 standard designation, like the other protocol names; later mentio |
| transmit enable (RS-485) | sendetilladelse | user-guide/interfaces.md, RS-485 hardware configuration. No glossary entry; 'sendetilladelse' is the standard Danish description and avoids leaving an |
| multi-talker / single-talker network | multi-talker- / single-talker-anvendelser, netværk med flere talere / med én taler og flere lyttere | user-guide/interfaces.md. The adjectival compounds keep the NMEA 0183 trade terms; the descriptive form is used where the source spells out 'single-ta |
| form factor (M.2) | formfaktor | technical-reference/hardware.md, M.2 NVMe slot ('formfaktorerne 2230 til 2280'). |
| die-cast aluminium | trykstøbt aluminium | technical-reference/hardware.md, enclosure material rows. Note docs/da/user-guide/hardware.md paraphrases the same English as 'støbt aluminium' withou |
| ferrite bead filtering | filtrering med ferritperler | technical-reference/hardware.md, USB 3.0 ports. |
| normally-open (NO) momentary switch | momentkontakt af typen normalt åben (NO) | user-guide/interfaces.md, button header. The glossary has 'switch (physical) = kontakt' but nothing for the momentary/NO qualifiers. |
| pinout | benforbindelser | technical-reference/hardware.md H2 'Stikkenes benforbindelser' and user-guide/interfaces.md H3 'Benforbindelser på knapstiklisten'. Built on the gloss |
| fan (CM5 / PWM fan) | blæser | Consistency pass. 'ventilator' had appeared in user-guide/hardware.md while technical-reference/hardware.md used 'blæser'. 'blæser' is the Danish trade word for a CPU/PWM fan, and it keeps 'ventilation' free for the airflow-around-the-enclosure sense the getting-started page uses. |
| airflow / air circulation | luftcirkulation | Consistency pass. 'luftstrøm' had appeared once in getting-started.md. Treated as one concept: the same physical thing whether the source says 'airflow' or 'air circulation'. Distinct from 'ventilation', which renders the source's own 'ventilation'. |
| web-managed interface | webstyret grænseflade | Consistency pass. 'webadministreret grænseflade' had appeared in getting-started.md. 'webstyret' is the compact compound and avoids 'webadministreret grænseflade til systemadministration' in user-guide/software.md. Distinct from 'web interface' -> 'webgrænseflade' and 'web-based' -> 'webbaseret'. |
| baud rate | baudhastighed | Consistency pass. 'baudrate' had appeared once in troubleshooting.md. 'baudhastighed' matches the other rate compounds already in use ('opdateringshastighed', 'datahastigheder'). |
| repository (Git/GitHub) | repositorium (bestemt form: repositoriet) | Consistency pass. 'GitHub-arkivet' had appeared in design-files.md. 'arkiv' is reserved for the apt sense ('pakkearkiv'), so the source-code repository takes 'repositorium' — what Danish developers say. |
| diagnostics / diagnostic | diagnostik | Consistency pass. 'diagnose' had appeared once in index.md. In Danish 'diagnose' is the result, 'diagnostik' the activity — the latter is what the source means. |
| solder cup | loddekop | Koppen i stikbenet, der fyldes med tin før lodning |
| pigtail (pre-wired lead) | ledningssæt | JST XH-ledningssæt |
| step drill bit | trinbor | Adskilt fra metalboret, der efterbehandler hullet |
| centre punch | kørner | Til at markere hullets centrum før boring |
| burr | grat | Flertal *grater*; opstår rundt om hullet ved boring |
| self-tapping screw | selvskærende skrue |  |
| O-ring | O-ring | Tætning omkring stikket |
| time-series database | tidsseriedatabase | InfluxDB |
</content>
