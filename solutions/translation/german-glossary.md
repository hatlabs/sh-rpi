---
title: German translation glossary and style rules (SH-RPi)
date: 2026-08-05
category: translation
module: documentation
problem_type: reference
component: documentation
severity: medium
applies_when:
  - Translating any page from docs/en/ into German under docs/de/
  - Reviewing a German translation for consistency
  - Adding a new term that has no established German equivalent
tags:
  - translation
  - i18n
  - german
  - terminology
  - mkdocs-static-i18n
---

# German translation glossary and style rules

## Context

The SH-RPi documentation is written in English under `docs/en/` and translated
into German under `docs/de/`, using the `mkdocs-static-i18n` folder structure.
Each language directory mirrors the same tree, so a translation keeps its
source's path and filename: `docs/en/hardware/index.md` becomes
`docs/de/hardware/index.md`. Only markdown lives under `docs/de/` — images and
other assets stay with the English source and are shared, including the nested
`assets/` directories under `revisions/` and `tutorials/openplotter-server/`.

**This file began as a copy of the HALPI2 German glossary and deliberately keeps
its decisions.** SH-RPi and HALPI2 are both Raspberry Pi power boards with
supercapacitors, a shutdown daemon and a watchdog, so a reader who knows one Hat
Labs board should meet the same German words in the other. `carrier board` →
`Trägerplatine`, `watchdog` → `Watchdog` and `daemon` → `Daemon` are decisions
made there and they stand here too. Terms below the SH-RPi heading are this
product's additions; **a shared row changes in both repositories or in neither.**

The HALMET glossary was not used as the base even though it is also a Hat Labs
board: its additions are all sensor-input vocabulary — analog and digital inputs,
galvanic isolation, a constant current source — and none of those words occurs in
the SH-RPi documentation at all. That was measured against the English pages, not
assumed.

`finnish-glossary.md` is the sibling of this file in this repository, and
`french-glossary.md` in the HALPI2 repository is the third member of the family.
The general approach is the same in all of them; the rules below cover what is
specific to German — and in two places the sibling languages are actively wrong
for German. Those places are marked.

Translations are produced page by page, at different times, potentially by
different people. Without a fixed terminology list the same English term drifts
across pages, and the result reads as machine output even when each individual
sentence is correct. This file is the reference that prevents that drift. It is a
living document: extend it when a page introduces a term that is not listed here,
rather than inventing a one-off translation.

Unlike the other files under `solutions/`, this one has no date in its filename
because it is meant to be edited in place, not superseded.

## Names that are never translated

Product names, protocol names, hardware standards, and software UI strings stay
in English. The device's own interface is in English, so translating a menu name
would send the reader looking for something that does not exist on screen.

- **Products and software:** SH-RPi, Sailor Hat, HALPI2, Signal K, OpenPlotter,
  Raspberry Pi OS, Waveshare, PlatformIO, Node-RED, Grafana, Hat Labs
- **Hardware and standards:** Raspberry Pi, Compute Module 4 (CM4), HAT,
  ATtiny1616, PCF8563, CAN, NMEA 2000, NMEA 0183, RS485, GNSS, I2C, SPI, UPDI,
  GPIO, USB, microSD, PoE. The add-on boards keep their product names exactly:
  **CAN HAT**, **RS485 HAT**, **GNSS HAT**.
- **Board labels and pin names**, copied as printed on the silkscreen or in the
  figures: `PROG`, `RTC EN`, `GPIO4 Enable`, `BOOT`, `2A`, `3A`, `CAN0`, `CAN1`,
  `GND`, `3V3`. These are what the reader physically looks for on the board; a
  translated label is unfindable.
- **UI paths, commands, hostnames, file paths:** `raspi-config`, `shrpi`,
  `shrpid`, `avrdude`, `rpiboot`, `/boot/firmware/config.txt`,
  `/etc/shrpid.conf`, `/var/run/shrpid.sock`, `/dev/ttyAMA0`, `can0`, and every
  `dtoverlay=` / `dtparam=` line.

Code fences, command output, URLs and image filenames are never touched.

## Style rules

### No space before punctuation

**German does not put a space before `;` `:` `!` `?`** — write `Symptome:`, not
`Symptome :`.

This is stated explicitly because the French glossary requires the opposite, and
that rule cost a 334-site correction on its own branch. Do not carry the French
habit across. German's non-breaking spaces belong elsewhere: between a number
and its unit, and inside abbreviations like `z. B.`.

### Quotation marks

German uses `„…"` — low opening, high closing. Not `"…"`, and not the French
`« … »`.

### Address form

Instructions use the **Sie form imperative**, the standard register for German
consumer and installation manuals:

> Schließen Sie das Stromkabel an. Prüfen Sie die Polarität mit dem Multimeter,
> bevor Sie die Spannung einschalten.

Not the infinitive (*Kabel anschließen*), which reads as a parts list, and not
*du*.

Descriptive passages use a plain statement or the passive:

> Das Gerät schaltet sich automatisch ab, wenn die Stromversorgung getrennt wird.

The English SH-RPi pages slip into the first person plural in the enclosure
walkthrough (*We start with a bare enclosure*, *Next, we install the
stack-through header*). Do not carry that over as *wir*; turn it into the Sie
imperative or a plain statement: `Setzen Sie nun die Durchsteck-Stiftleiste ein.`

### Compound nouns

German compounds a multi-word proper name with hyphens throughout, which the
English source does not:

- `NMEA-2000-Netzwerk`, `NMEA-2000-Bus`, `Signal-K-Server`,
  `Raspberry-Pi-Anschluss`, `Compute-Module-4-Platine`
- `SH-RPi-Gehäuse`, `USB-Tastatur`, `HAT-Stapel`, `I2C-Bus`

A missing hyphen inside such a compound is the most visible marker of a
machine-translated German page.

**Exception — the two-word HAT product names.** `CAN HAT`, `RS485 HAT` and
`GNSS HAT` are product names and are reproduced exactly, with the space and
without internal hyphens. Do not build a German compound around them
(`CAN-HAT-Anschluss` alters the product name); rephrase instead — `der Anschluss
des CAN HAT`, `die Stiftleiste am RS485 HAT`. The single word `HAT` compounds
normally: `HAT-Stapel`, `HAT-Platine`, `HAT-Anschluss`.

### Units and numbers

Same handling as the other languages — the English source writes `12V` and
`0.9A`, and both are wrong in German.

| English source | German |
|:---------------|:-------|
| `12V`, `0.9A` | `12 V`, `0,9 A` |
| `5.5 x 2.1 mm` | `5,5 × 2,1 mm` |
| `-20°C to +60°C` | `−20 °C … +60 °C` |
| `120Ω` | `120 Ω` |
| `3-5A` | `3–5 A` (en dash for ranges) |
| `20F 3.0 V supercapacitors` | `Superkondensatoren mit 20 F und 3,0 V` |
| `3.81 mm (0.15")` | `3,81 mm (0,15")` |

Dimensions written as a single product spec keep the tight form: `200×130×60 mm`.

### Links, images, admonitions, navigation

Same as the sibling glossaries: paths are copied from the English source
unchanged and never carry an `en/`, `de/` or other language segment; image
captions and alt texts are translated but filenames are not; screenshots stay
English because the reader's own screen is English; standard admonition titles
are translated centrally in `mkdocs.yml`, custom ones in the page.

### Navigation titles

Section and page titles in the navigation live in `mkdocs.yml` under the i18n
plugin's `nav_translations`. That is the single source of truth; the full list is
not restated here. Three entries are judgement calls worth recording:

- `Errata` → **Bekannte Fehler**. *Errata* in German is a printing term for
  corrections to a text; this page lists known hardware defects, so plain German
  is clearer and honest about the content.
- `FAQ` → **FAQ**. Unlike Finnish, which has the established abbreviation *UKK*,
  German has fully naturalised *FAQ* — the same reasoning that keeps *Dashboard*
  and *Standby* in the glossary below.
- `Add-on Hardware` → **Zusatzhardware**, matching `add-on board` →
  `Zusatzplatine` in the glossary. Keep the two in step.

When a new page is added to the nav in English, add its German title to
`nav_translations` in the same change — an untranslated entry silently falls back
to English and is easy to miss.

## Glossary

Rows in this section are shared with HALPI2. Do not change one here alone.

### Enclosure, mounting, and installation

| English | German | Note |
|:--------|:-------|:-----|
| carrier board | Trägerplatine | The accurate term, as in French — see the note below |
| enclosure | Gehäuse | |
| heat sink | Kühlkörper | |
| waterproof | wasserdicht | |
| wall-mount | Wandmontage | |
| mounting surface | Montagefläche | |
| pilot hole | Vorbohrung | |
| mounting template | Bohrschablone | |
| bilge | Bilge | |
| bulkhead | Schott | |
| cable gland | Kabelverschraubung | |
| cable routing | Kabelführung | |
| service loop | Serviceschlaufe | |
| cable tie | Kabelbinder | |
| blind plug | Blindstopfen | |
| breather plug | Druckausgleichsstopfen | |

**A note on `Trägerplatine`.** German takes the accurate term, like French
(`carte porteuse`) and unlike Finnish (`emolevy`, literally *motherboard*, chosen
there for reader familiarity). The divergence between the three is deliberate,
decided per language and per audience. Do not harmonise them.

The practical consequence matches French: `Trägerplatine` carries the
module/board relationship on its own, so passages about reseating the compute
module or troubleshooting a board that will not boot need no extra explanation.
The Finnish glossary does need that warning.

In SH-RPi this row is what translates the CM4 page's **base board** — the board
the Compute Module 4 plugs into. It is *not* the enclosure's **base plate**; see
the note under the SH-RPi mechanical table.

### Electrical

| English | German | Note |
|:--------|:-------|:-----|
| power supply | Stromversorgung | The unit itself: *Netzteil* |
| input voltage range | Eingangsspannungsbereich | |
| polarity | Polarität | |
| fuse | Sicherung | |
| inline fuse | Leitungssicherung | |
| circuit breaker | Leitungsschutzschalter | |
| current limiting | Strombegrenzung | |
| overcurrent | Überstrom | |
| voltage drop | Spannungsabfall | |
| grounding | Erdung | |
| short circuit | Kurzschluss | |
| wire gauge | Leiterquerschnitt | German uses mm², not AWG |
| marine-grade wire | seewasserfeste Leitung | |
| wire strippers | Abisolierzange | |
| crimping | Crimpen | |
| crimper | Crimpzange | |
| heat-shrink tubing | Schrumpfschlauch | |
| heat gun | Heißluftpistole | |
| multimeter | Multimeter | |
| terminal block | Klemmenblock | |
| strain relief | Zugentlastung | |
| super-capacitor | Superkondensator | |
| real-time clock | Echtzeituhr | |
| backup battery | Pufferbatterie | But see `rechargeable` in the SH-RPi tables — the GNSS HAT's cell is an *Akku*, not a *Batterie* |

### Connectors and interfaces

| English | German | Note |
|:--------|:-------|:-----|
| connector | Stecker / Anschluss | *Anschluss* for a board-mounted socket |
| barrel connector | Hohlstecker | |
| header | Stiftleiste | `40-polige GPIO-Stiftleiste` |
| pin | Pin | |
| backbone | Backbone | Established in German NMEA 2000 usage |
| drop cable | Stichleitung | |
| T-connector | T-Stück | |
| termination (120 Ω) | Abschlusswiderstand | |
| front panel | Frontplatte | |
| jumper | Jumper | Removable link on a pin pair — never a `Lötbrücke`, see the SH-RPi note |
| male / female | Stecker / Buchse | |

### System behaviour and status

| English | German | Note |
|:--------|:-------|:-----|
| boat computer | Bordcomputer | |
| to boot | starten | |
| first boot | erster Start | |
| shutdown | Herunterfahren | |
| graceful shutdown | geordnetes Herunterfahren | |
| power loss | Spannungsausfall | |
| blackout | Stromausfall | |
| power management | Energieverwaltung | |
| status LED | Status-LED | |
| monitoring | Überwachung | |
| passive cooling | passive Kühlung | |
| filesystem | Dateisystem | |
| to unmount | aushängen | |
| watchdog | Watchdog | |
| standby | Standby | |

### Software and networking

| English | German | Note |
|:--------|:-------|:-----|
| firmware | Firmware | |
| daemon | Daemon | |
| to flash | flashen | |
| operating system image | Systemabbild | |
| headless | ohne Bildschirm | First mention: `ohne Bildschirm (headless)` |
| container app | Container-Anwendung | |
| container image | Container-Image | |
| dashboard | Dashboard | |
| WiFi Access Point | WLAN-Access-Point | German prose says *WLAN*; keep *WiFi* only where it names a UI string or a physical label |
| wired / wireless | kabelgebunden / drahtlos | |
| credentials | Zugangsdaten | |
| default password | Standardpasswort | |
| single sign-on (SSO) | Single Sign-on (SSO) | |
| Certificate Authority (CA) | Zertifizierungsstelle (CA) | |
| web interface | Weboberfläche | |
| browser | Browser | |

### Applications and use cases

| English | German | Note |
|:--------|:-------|:-----|
| chart plotter | Kartenplotter | |
| data logging | Datenaufzeichnung | |
| vessel | Schiff | |
| fleet management | Flottenmanagement | |
| predictive maintenance | vorausschauende Wartung | |
| remote monitoring | Fernüberwachung | |
| compliance | Konformität | |
| warranty | Garantie | |

## SH-RPi terms

SH-RPi is a power management HAT, so its vocabulary is HALPI2's power and
shutdown language plus the mechanics of stacking boards on a Raspberry Pi. Rows
above this heading are shared with HALPI2 and must not be changed here alone.

Rows marked *übernommen* repeat an inherited row unchanged, because the term is
frequent in the SH-RPi pages and a translator should not have to hunt for it.

### The board and the stack

| English | German | Note |
|:--------|:-------|:-----|
| HAT | HAT | Never translated. Compounds with a hyphen: `HAT-Stapel`, `HAT-Platine`, `HAT-Anschluss`. Two-word product names stay unhyphenated — see the note below |
| add-on board / add-on card | Zusatzplatine | The CAN, RS485 and GNSS HATs collectively; matches the nav title *Zusatzhardware* |
| to stack (boards) | stapeln | `HATs lassen sich auf den SH-RPi stapeln`; the PCB stack itself is `der Platinenstapel` |
| stack-through header | Durchsteck-Stiftleiste | The tall 40-pin header that passes GPIO through to the board above |
| stacking header | Durchsteck-Stiftleiste | Same physical part. The English source calls it *stackthrough header*, *stack-through header*, *stack-through connector* and *stacking header*; German uses one term throughout |
| standoff | Abstandsbolzen | |
| hex standoff | Sechskant-Abstandsbolzen | `M2,5-Sechskant-Abstandsbolzen, 16 mm` |
| mounting screw | Befestigungsschraube | `M3-Befestigungsschraube` |
| solder jumper | Lötbrücke | **Permanent.** On this board it is opened by cutting the traces between the pads with a sharp knife (`RTC EN`), or closed by joining the pads (`GPIO4 Enable`). Never `Jumper` — see the note below |
| jumper | Jumper | *übernommen.* Removable link pushed onto a pin pair; no tool needed |
| jumper header | Stiftleiste für Jumper | The current limiter header and the `PROG` header. `Strombegrenzer-Stiftleiste`, `PROG-Stiftleiste` |
| pin | Pin | *übernommen.* `40-polige Stiftleiste`, `2×20-polig` |
| base plate | Grundplatte | The perforated plate inside the enclosure. Not `Trägerplatine` — see the note below |
| vertical mount | Vertikalhalterung | The black plastic parts that hold the PCB stack upright in the enclosure |
| cable gland | Kabelverschraubung | *übernommen.* `PG7-Kabelverschraubung`, `PG9-Kabelverschraubung` |
| panel connector | Einbaustecker / Einbaubuchse | *Einbaubuchse* for a socket in the enclosure wall: `RJ45-Einbaubuchse`, `M12-Einbaubuchse` |
| terminal plug | Klemmenstecker | The pluggable screw terminal supplied with the board |

**A note on `HAT`.** `HAT` is the Raspberry Pi Foundation's term, it is printed on
the boards, and it is never translated. Compound it with a hyphen in the German
way — `HAT-Stapel`, `HAT-Platine`, `HAT-Anschluss` — but leave the two-word
product names exactly as they are: `CAN HAT`, `RS485 HAT`, `GNSS HAT`. Where
German would want a compound around one of them, rephrase: `der GPIO-Anschluss
des CAN HAT`, not `CAN-HAT-GPIO-Anschluss`.

**A note on `Lötbrücke` vs `Jumper`.** These are two different things and the
reader acts on the difference:

- A **Lötbrücke** (`solder jumper`) is a pair of pads on the board, permanently
  connected. `RTC EN` ships closed and is opened by **cutting the traces between
  the pads with a sharp knife**; `GPIO4 Enable` ships open and is closed by
  joining the pads with solder. Both are irreversible in practice.
- A **Jumper** is a small plug pushed onto a pin pair — the current limiter
  header and the `PROG` header. It is pulled off with the fingers.

Never write `Jumper` for a Lötbrücke or vice versa. Confusing them sends the
reader for a knife they do not need, or has them try to pull off something that
is soldered down. Both terms appear inside warnings, so the wrong word is a
safety defect, not a style defect.

**A note on `Grundplatte` vs `Trägerplatine`.** The English source uses *base
plate* and *base board* for two unrelated things, and German must keep them
apart. The enclosure's perforated `base plate` is the **Grundplatte**; the CM4
page's `base board` — the board the Compute Module 4 plugs into — is the
**Trägerplatine**, the inherited HALPI2 term. Do not let the shorter English
words merge them.

### Power and shutdown

| English | German | Note |
|:--------|:-------|:-----|
| supercapacitor / supercap | Superkondensator | *übernommen.* The English source writes it both ways and also *supercaps*; German uses the one word |
| supercapacitor bank | Superkondensatorbank | The set of three 20 F cells acting as one reservoir |
| power management | Energieverwaltung | *übernommen.* The product itself: `Energieverwaltungsplatine` |
| safe shutdown | sicheres Herunterfahren | The marketing-level promise on the index page |
| graceful shutdown | geordnetes Herunterfahren | *übernommen.* The technical sequence |
| to power down | abschalten | Cutting the supply voltage — not the same act as `herunterfahren` (the OS shutting itself down). `wenn der Raspberry Pi abgeschaltet ist` |
| power-off | Spannungsabschaltung | The config key `poweroff` and the path `/sbin/poweroff` stay untouched |
| watchdog | Watchdog | *übernommen*, left in English as in HALPI2 |
| watchdog timer | Watchdog-Timer | |
| heartbeat | Heartbeat | `Heartbeat-Signal` on first mention. The English source puts it in quotes; German does not need them |
| blackout | Stromausfall | *übernommen.* The config keys `blackout-time-limit` and `blackout-voltage-limit` stay untouched |
| brownout | Spannungseinbruch | A dip, not a break — deliberately a different word from `Stromausfall` |
| hold-up time | Überbrückungszeit | How long the supercapacitor bank keeps the system running |
| charge / discharge | laden / entladen | Nouns: `Ladung` / `Entladung`; the LED bar shows the `Ladezustand` |
| voltage threshold | Spannungsschwelle | The configurable 8,0 V and 5,0 V limits |
| undervoltage | Unterspannung | Below 10 V, to protect lead-acid batteries from deep discharge |
| overvoltage | Überspannung | The fault condition signalled by rapid blinking |
| reverse polarity protection | Verpolungsschutz | The diode: `Verpolungsschutzdiode` |
| buck converter / step-down converter | Abwärtswandler | Both stages step the voltage **down**. See the warning below about *boost* |
| current limiter | Strombegrenzer | The circuit. The header: `Strombegrenzer-Stiftleiste` |
| current limit | Stromgrenze | The value: `Die Stromgrenze beträgt standardmäßig 0,8 A`. The function is `Strombegrenzung` (inherited row) |
| transient voltage suppressor | TVS-Diode | First mention: `TVS-Diode (Überspannungsschutz)` |
| choke | Drossel | |
| pi-filter | Pi-Filter | |
| real-time clock (RTC) | Echtzeituhr (RTC) | *übernommen.* Introduce as `Echtzeituhr (RTC)`, then use `RTC`; the label `RTC EN` is never translated |
| backup battery | Pufferbatterie / Pufferakku | `Pufferbatterie` for the SH-RPi's CR1220, `Pufferakku` for the GNSS HAT's ML1220 — see the note below |
| rechargeable | wiederaufladbar | |
| non-rechargeable | nicht wiederaufladbar | See the note below; this pair carries a fire warning |

**A warning about `boost`.** The English hardware page calls the second stage a
*boost converter* twice (`enables the boost converter`, `disables the boost
converter`) while describing it correctly as a buck converter in the same
paragraph. This is an error in the English source and is tracked as issue #25.
**Translate what the English says** — write `Aufwärtswandler` where the source
writes *boost* — and do not silently correct it; the German page must not diverge
from the English one. This glossary row nevertheless means *step-down*:
`Abwärtswandler` is the correct term and is what the German page will say
everywhere the English says *buck* or *step-down*. When issue #25 is fixed in
English, the two remaining `Aufwärtswandler` become `Abwärtswandler` and this
paragraph can go.

**A warning about the GNSS HAT battery.** The GNSS HAT's ML1220 is a
**rechargeable** lithium cell. The documentation states that replacing it with a
non-rechargeable cell **risks explosion and fire**. German has a lexical
distinction English lacks — *Akku* is rechargeable, *Batterie* is not — and it
must be used, but it must not be relied on alone: spell the adjective out in the
warning.

- ML1220 → `ein wiederaufladbarer Lithium-Akku (ML1220)`. Never `Batterie`.
- The forbidden replacement → `eine nicht wiederaufladbare Batterie`. Never
  `Akku`.
- The SH-RPi's own RTC cell is a CR1220 and genuinely is a `Pufferbatterie`, non-
  rechargeable. Do not carry `Akku` across from the GNSS HAT page.

`nicht wiederaufladbar` must stay the exact negation of `wiederaufladbar` — do
not soften it to `Einwegbatterie` or `Primärzelle`, which a general reader may
not oppose to *Akku* at a glance.

### Software

| English | German | Note |
|:--------|:-------|:-----|
| microcontroller | Mikrocontroller | The ATtiny1616; the name itself is never translated |
| daemon | Daemon | *übernommen*, Hat Labs convention. The source's own gloss becomes `ein Daemon (Dienstprogramm im Hintergrund)` |
| service (systemd) | Dienst | `shrpid`, `hciuart` and every `systemctl` line stay untouched |
| installation script | Installationsskript | |
| configuration file | Konfigurationsdatei | `/etc/shrpid.conf`; the YAML keys and comments inside code fences are not translated |
| device tree overlay | Device-Tree-Overlay | Term kept in English, hyphenated in the German way; `dtoverlay=` lines untouched |
| firmware | Firmware | *übernommen* |
| to flash | flashen | *übernommen.* `die eMMC flashen`, `Selbst-Flashen` for the on-board procedure |
| headless | ohne Bildschirm | *übernommen.* First mention: `ohne Bildschirm (headless)`. But OpenPlotter's *Headless image* is a product name: `OpenPlotter-Headless-Image` |
| image (OS image) | Systemabbild | *übernommen.* `64-Bit-Systemabbild` |
| REST API | REST-API | Feminine: `die REST-API` |
| file socket | Datei-Socket | `Die API ist über einen Datei-Socket unter /var/run/shrpid.sock erreichbar` |

### Tools and consumables

| English | German | Note |
|:--------|:-------|:-----|
| step drill bit | Stufenbohrer | The one that looks like a small metal Christmas tree |
| pilot hole | Vorbohrung | *übernommen* |
| heat shrink tubing | Schrumpfschlauch | *übernommen.* The source also writes just *heat shrink*; German keeps the one word |
| zip tie / tie wrap | Kabelbinder | *übernommen* as `cable tie`. The source uses *zip ties* and *tie wraps* for the same part; German uses one word |
| double-sided tape | doppelseitiges Klebeband | |

## Verification

A translated page is not done until:

1. `uv run mkdocs build --strict` passes — the same command CI runs.
2. `uv run mkdocs serve` shows the page rendering correctly in the browser, with
   lists as lists — always leave a blank line before and after a list.
3. Every term used on the page that appears in this glossary matches it.
4. No space stands before `:` `;` `!` `?`, and quotation marks are `„…"`.

## Related

- `finnish-glossary.md` — the sibling glossary in this repository
- `../../../halpi2/solutions/translation/german-glossary.md` — the base this file
  was copied from; shared rows change in both or in neither
- mkdocs-static-i18n documentation: https://ultrabug.github.io/mkdocs-static-i18n/
