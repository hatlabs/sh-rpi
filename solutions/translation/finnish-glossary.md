---
title: Finnish translation glossary and style rules (SH-RPi)
date: 2026-08-03
category: translation
module: documentation
problem_type: reference
component: documentation
severity: medium
applies_when:
  - Translating any page from docs/en/ into Finnish under docs/fi/
  - Reviewing a Finnish translation for consistency
  - Adding a new term that has no established Finnish equivalent
tags:
  - translation
  - i18n
  - finnish
  - terminology
  - mkdocs-static-i18n
---

# Finnish translation glossary and style rules

## Context

The SH-RPi documentation is written in English under `docs/en/` and translated
into Finnish under `docs/fi/`, using the `mkdocs-static-i18n` folder structure.
Each language directory mirrors the same tree, so a translation keeps its
source's path and filename: `docs/en/hardware/index.md` becomes
`docs/fi/hardware/index.md`. Only markdown lives under `docs/fi/` — images and
other assets stay with the English source and are shared, including the nested
`assets/` directories under `revisions/` and `tutorials/openplotter-server/`.

**This file began as a copy of the HALPI2 glossary and deliberately keeps its
decisions.** SH-RPi and HALPI2 are both Raspberry Pi power boards with
supercapacitors, a shutdown daemon and a watchdog, so a reader who knows one
should meet the same Finnish words in the other. `carrier board` → `emolevy` is
Matti Airas's call there and stands here too. Terms below the SH-RPi heading are
this product's additions; a shared row should change in both repositories or in
neither.

The HALMET glossary was not used as the base even though it is also a Hat Labs
board: its additions are all sensor-input vocabulary — analog and digital
inputs, galvanic isolation, a constant current source — and none of those words
occurs in the SH-RPi documentation at all.

Translations are produced page by page, at different times, potentially by
different people. Without a fixed terminology list the same English term drifts
across pages — *drop cable* becomes `haarakaapeli` on one page and
`pudotuskaapeli` on the next — and the result reads as machine output even when
each individual sentence is correct.

This file is the reference that prevents that drift. It is a living document:
extend it when a page introduces a term that is not listed here, rather than
inventing a one-off translation.

Unlike the other files under `solutions/`, this one has no date in its filename
because it is meant to be edited in place, not superseded.

## Names that are never translated

Product names, protocol names, hardware standards, and software UI strings stay
in English. The device's own interface is in English, so translating a menu name
would send the reader looking for something that does not exist on screen.

- **Products and software:** SH-RPi, Sailor Hat, HALPI2, Signal K, OpenPlotter,
  Raspberry Pi OS, Node-RED, InfluxDB, Grafana, Hat Labs
- **Hardware and standards:** Raspberry Pi, Compute Module 4 (CM4), HAT, CAN,
  NMEA 2000, NMEA 0183, RS485, GNSS, I2C, GPIO, USB, microSD, PoE, DHCP, SSH,
  AWG. The add-on boards keep their product names exactly: **CAN HAT**, **RS485
  HAT**, **GNSS HAT**.
- **UI paths, commands, hostnames, file paths:** **Networking**, **WiFi
  (wlan0)**, **Add**, `raspi-config`, `passwd`, `shutdown`, `halos.local`,
  `can0`, `pi`, `halos`

Code blocks, command output, URLs, and image filenames are never touched.

## Style rules

### Units and numbers

Finnish follows SI spacing and uses a decimal comma. The English source does
not, so this requires an active conversion on nearly every technical page.

| English source | Finnish |
|:---------------|:--------|
| `12V`, `0.9A` | `12 V`, `0,9 A` |
| `5.5 x 2.1 mm` | `5,5 × 2,1 mm` |
| `-20°C to +60°C` | `−20 °C … +60 °C` |
| `1.5mm²`, `2m` | `1,5 mm²`, `2 m` |
| `120Ω` | `120 Ω` |
| `3-5A` | `3–5 A` (en dash for ranges) |

Dimensions written as a single product spec keep the tight form:
`200×130×60 mm`.

### Product names in compounds and inflections

Finnish compounds a multi-word proper name with a space and a hyphen; a
single-word name compounds directly:

- `NMEA 2000 -verkko`, `NMEA 2000 -väylä`, `Signal K -palvelin`,
  `Raspberry Pi -antenni`, `Compute Module 5 -moduuli`
- `HALPI2-kotelo`, `E7T-liitin`, `HaLOS-levykuva`, `USB-näppäimistö`

Case endings attach with a colon when the name ends in a digit or is read as
letters: `HALPI2:n`, `CM5:n`, `HaLOS:n`, `NMEA 2000:n`.

### Address form

Instructions use the **second person singular imperative** — the standard
register for Finnish consumer and installation manuals:

> Kytke virtajohto. Varmista napaisuus yleismittarilla ennen jännitteen
> kytkemistä.

Descriptive passages use the passive or a plain statement:

> Laite sammuu automaattisesti, kun virransyöttö katkaistaan.

Do not translate the English *you* literally into `sinä` — Finnish imperative
already carries it, and the explicit pronoun reads as clumsy translation.

### Admonitions

Standard admonition titles (`Note`, `Warning`, `Tip`, `Info`) are translated
centrally via the plugin's `admonition_translations` setting, not in the page
source. **Custom** titles written into the page — `!!! note "Shop Link"` — are
part of the content and must be translated: `!!! note "Linkki verkkokauppaan"`.

### Images

Image captions and alt texts are translated; filenames and paths are not.
Screenshots (`raspi-config-menu.jpg`, `networking-menu.jpg`,
`wifi-password.jpg`) show an English interface and are reused as-is. This is
intentional and correct — the reader will see English on their own screen too.

### Links

Relative links and image paths are copied from the English source unchanged. The
plugin merges the language trees, so `../user-guide/operation.md` resolves to the
Finnish page when one exists and falls back to English when it does not, and an
image path resolves to the single shared copy under `docs/en/`. Never add an
`en/` or `fi/` segment to a path inside a page — the language is decided by which
directory the file itself lives in, not by its links.

### Navigation titles

Section and page titles in the navigation are not part of any markdown file —
they live in `mkdocs.yml` under the i18n plugin's `nav_translations`. That is the
single source of truth; do not restate the full list here. Two entries are
judgement calls worth recording:

- `Errata` → **Tunnetut virheet**. The Latin term is opaque to a general reader;
  plain Finnish is clearer for a page listing known hardware defects.
- `FAQ` → **UKK** (*usein kysytyt kysymykset*). The established Finnish
  abbreviation.

When a new page is added to the nav in English, add its Finnish title to
`nav_translations` in the same change — an untranslated entry silently falls
back to English and is easy to miss.

## Glossary

### Enclosure, mounting, and installation

| English | Finnish | Note |
|:--------|:--------|:-----|
| carrier board | emolevy | Deliberate: not literally accurate, but the term readers know. Decided by Matti Airas, 2026-08-03 |
| enclosure | kotelo | |
| heat sink | jäähdytyselementti | |
| waterproof | vesitiivis | |
| rugged | kestäväksi rakennettu | Avoid the loan word *rugged* |
| wall-mount | seinäkiinnitys | |
| mounting surface | kiinnitysalusta | |
| pilot hole | esiporausreikä | |
| mounting template | porausmalline | Drill template |
| clearance | vapaa tila | |
| bilge | pilssi | |
| bulkhead | laipio | |
| cable gland | läpivientiholkki | PG7 cable gland → `PG7-läpivientiholkki` |
| cable routing | kaapelireititys | |
| service loop | johtolenkki | Slack left at both cable ends |
| chafing | hankautuminen | |
| cable tie | nippuside | |

**A note on `emolevy`.** The term was chosen for reader familiarity over literal
accuracy, and it carries one risk: *emolevy* normally means a motherboard, which
would imply the board is the computer and the CM5 an add-on — the reverse of how
HALPI2 is built. When translating passages where that relationship matters
(reseating the CM5, troubleshooting a board that will not boot), make the roles
explicit in the surrounding sentence rather than relying on the term to carry
them.

### Electrical

| English | Finnish | Note |
|:--------|:--------|:-----|
| power supply | virtalähde | Matti Airas's call, shared with HALPI2: `virtalähde` renders *power supply*, `virransyöttö` renders *power source*. Do not swap them and do not introduce `teholähde` as a third word. |
| power source | virransyöttö | See the row above.In an established compound the compound wins: *DC power source* is `tasavirtalähde`, since `tasavirransyöttö` is not a Finnish word. |
| input voltage range | syöttöjännitealue | |
| polarity | napaisuus | |
| positive (+) / negative (−) | plus (+) / miinus (−) | |
| fuse | sulake | |
| inline fuse | linjasulake | |
| circuit breaker | johdonsuojakatkaisija | Electrical panel breaker |
| current limiting | virranrajoitus | |
| overcurrent | ylivirta | |
| voltage drop | jännitehäviö | |
| grounding | maadoitus | |
| short circuit | oikosulku | |
| wire gauge | johtimen poikkipinta-ala | Finnish uses mm², not AWG |
| marine-grade wire | merikäyttöön hyväksytty johdin | |
| strip (a wire) | kuoria | |
| wire strippers | kuorintapihdit | |
| crimping | puristusliitos | Verb: *puristaa liitin kiinni* |
| crimper | puristuspihdit | |
| heat-shrink tubing | kutistesukka | |
| heat gun | kuumailmapuhallin | |
| multimeter | yleismittari | |
| continuity test | jatkuvuusmittaus | |
| terminal | liitin | |
| terminal block | riviliitin | |
| strain relief | vedonpoisto | |
| super-capacitor | superkondensaattori | |
| real-time clock | reaaliaikakello | |
| backup battery | varaparisto | |

### Connectors and interfaces

| English | Finnish | Note |
|:--------|:--------|:-----|
| connector | liitin | |
| barrel connector | DC-pyöröliitin | Add *(barrel)* on first mention |
| header (GPIO, button) | liitin | `40-nastainen GPIO-liitin` |
| pin | nasta | |
| backbone | runkokaapeli | NMEA 2000 backbone |
| drop cable | haarakaapeli | |
| T-connector / T-adapter | T-liitin | |
| termination (120 Ω) | päätevastus | The component; the act is *terminointi* |
| front panel | etupaneeli | |
| antenna | antenni | |
| extension cable | jatkokaapeli | |
| male / female | uros / naaras | Connector gender |

### System behaviour and status

| English | Finnish | Note |
|:--------|:--------|:-----|
| boat computer | venetietokone | |
| boot / to boot | käynnistyä | |
| first boot | ensikäynnistys | |
| shutdown | sammutus | |
| graceful shutdown | hallittu sammutus | |
| power loss | jännitteen menetys | |
| blackout | sähkökatko | |
| glitch immunity | häiriönsieto | |
| power management | virranhallinta | |
| status LED | tila-LED | |
| LED bar | LED-rivi | |
| monitoring | valvonta | |
| passive cooling | passiivinen jäähdytys | |
| filesystem | tiedostojärjestelmä | |
| unmount (filesystem) | irrottaa | *tiedostojärjestelmä irrotetaan turvallisesti* |
| reseat (a module) | asettaa uudelleen paikalleen | |

### Software and networking

| English | Finnish | Note |
|:--------|:--------|:-----|
| firmware | firmware | Not *laiteohjelmisto* — Hat Labs convention |
| daemon | daemon | Not *taustaprosessi* — Hat Labs convention |
| to flash | flashata | Established Hat Labs usage |
| operating system image | levykuva | |
| headless | ilman näyttöä | First mention: `ilman näyttöä (headless)` |
| deployment | käyttöönotto | |
| container app | konttisovellus | |
| container image | konttikuva | Not *levykuva* — that is a disk image |
| dashboard | koontinäyttö | Homarr's *dashboard* view |
| WiFi Access Point | WiFi-tukiasema | |
| wired / wireless | langallinen / langaton | |
| credentials | tunnukset | |
| username / password | käyttäjätunnus / salasana | |
| default password | oletussalasana | |
| single sign-on (SSO) | kertakirjautuminen (SSO) | |
| Certificate Authority (CA) | varmenteen myöntäjä (CA) | |
| to trust (a certificate) | luottaa | |
| web interface | verkkokäyttöliittymä | |
| browser | selain | |
| system administration | järjestelmänhallinta | |

### Applications and use cases

| English | Finnish | Note |
|:--------|:--------|:-----|
| chart plotter | karttaplotteri | |
| data logging | tiedonkeruu | |
| vessel | alus | |
| engine parameters | moottorin mittaustiedot | |
| fleet management | kalustonhallinta | |
| predictive maintenance | ennakoiva kunnossapito | |
| process monitoring | prosessivalvonta | |
| remote monitoring | etävalvonta | |
| electromagnetic interference (EMI/RFI) | sähkömagneettiset häiriöt (EMI/RFI) | |
| compliance | vaatimustenmukaisuus | |
| warranty | takuu | |

## SH-RPi terms

SH-RPi is a power management HAT, so its vocabulary is HALPI2's power and
shutdown language plus the mechanics of stacking boards on a Raspberry Pi. Rows
above this heading are shared with HALPI2 and should not be changed here alone.

### The board and the stack

| English | Finnish | Note |
|:--------|:--------|:-----|
| HAT | HAT | Never translated; compounds with a hyphen — `HAT-kortti`, `HAT-liitin`, `CAN HAT -kortti` for the two-word product name |
| add-on board | lisäkortti | The CAN, RS485 and GNSS HATs collectively |
| to stack (boards) | pinota | `pinota kortit päällekkäin` |
| stacking header | pinoamisliitin | The tall 40-pin header that passes GPIO through to a board above |
| standoff | välike | Same as HALPI2 |
| mounting screw | kiinnitysruuvi | |
| solder jumper | juotossilta | Closed with solder, not a removable link — the reader needs a soldering iron for one and not the other |
| jumper | hyppy | Removable, on a pin pair |
| pin | nasta | `40-nastainen liitin` |
| microSD card | microSD-kortti | |

### Power and shutdown

| English | Finnish | Note |
|:--------|:--------|:-----|
| supercapacitor / supercap | superkondensaattori | Matches HALPI2. The English source writes it both ways; Finnish uses one word |
| power management | virranhallinta | |
| safe shutdown | turvallinen sammutus | |
| graceful shutdown | hallittu sammutus | Inherited from HALPI2 |
| to power down | sammuttaa | |
| power-off | virrankatkaisu | |
| watchdog | watchdog | Left in English, as in HALPI2; `watchdog-ajastin` for the timer |
| to feed the watchdog | syöttää watchdogia | |
| blackout | sähkökatko | Inherited from HALPI2 |
| brownout | jännitekuoppa | A dip rather than a break |
| hold-up time | pitoaika | How long the supercapacitors keep the system running |
| charge / discharge | lataus / purkaus | |
| voltage threshold | jännitekynnys | |
| reverse polarity protection | napaisuussuojaus | |

### Software

| English | Finnish | Note |
|:--------|:--------|:-----|
| daemon | daemon | Not *taustaprosessi* — Hat Labs convention, matching HALPI2 |
| service (systemd) | palvelu | |
| to enable / disable (a service) | ottaa käyttöön / poistaa käytöstä | |
| installation script | asennusskripti | |
| configuration file | asetustiedosto | |
| device tree overlay | device tree -overlay | The term is used in English in Finnish Raspberry Pi practice |
| headless | ilman näyttöä | First mention: `ilman näyttöä (headless)` |
| image (OS image) | levykuva | |
| to flash | flashata | Hat Labs convention |

### A note on `HAT`

`HAT` occurs over two hundred times and is never translated: it is the Raspberry
Pi Foundation's term and it is printed on the boards. Compound it with a hyphen
in the Finnish way — `HAT-kortti`, `HAT-liitin`, `HAT-pino` — and keep the
two-word product names intact with a space before the hyphen, as Finnish
requires for multi-word proper names: `CAN HAT -kortti`, not `CAN HAT-kortti`.

## Verification

A translated page is not done until:

1. `uv run mkdocs build --strict` passes — the same command CI runs.
2. `uv run mkdocs serve` shows the page rendering correctly in the browser, with
   lists as lists (see `../best-practices/markdown-lists-need-blank-line-2026-05-16.md`
   — the blank-line rule applies identically to Finnish pages).
3. Every term used on the page that appears in this glossary matches it.

## Related

- `solutions/best-practices/markdown-lists-need-blank-line-2026-05-16.md`
- mkdocs-static-i18n documentation: https://ultrabug.github.io/mkdocs-static-i18n/

## Terms added during translation

Recorded while translating `tutorials/openplotter-server/`, the only page in
this repository with a full hardware-assembly walkthrough. None of these had an
entry, and each one recurs across the soldering and drilling steps.

| English | Translation | Note |
|:--------|:------------|:-----|
| solder cup | juotoskuppi | Liittimen nastan kuppi, joka täytetään tinalla ennen johtimen juottamista |
| pigtail (pre-wired lead) | johdinsarja | JST XH -johdinsarja; ei *lettu* |
| step drill bit | porrasterä | Erotettava tavallisesta metalliporanterästä, jolla reikä viimeistellään |
| centre punch | merkkipuikko | Reiän keskipisteen merkitsemiseen ennen poraamista |
| burr | purse | Monikko *purseet*; poraamisen jäljiltä reiän ympärillä |
| self-tapping screw | itsekierteittävä ruuvi |  |
| O-ring | O-rengas | Tiivistys liittimen ympärillä |
| time-series database | aikasarjatietokanta | InfluxDB |
