---
title: Italian translation glossary and style rules (SH-RPi)
date: 2026-08-05
category: translation
module: documentation
problem_type: reference
component: documentation
severity: medium
applies_when:
  - Translating any page from docs/en/ into Italian under docs/it/
  - Reviewing an Italian translation for consistency
  - Adding a new term that has no established Italian equivalent
tags:
  - translation
  - i18n
  - italian
  - terminology
  - mkdocs-static-i18n
---

# Italian translation glossary and style rules

## Context

The SH-RPi documentation is written in English under `docs/en/` and translated
into Italian under `docs/it/`, using the `mkdocs-static-i18n` folder structure.
Each language directory mirrors the same tree, so a translation keeps its
source's path and filename: `docs/en/hardware/index.md` becomes
`docs/it/hardware/index.md`. Only markdown lives under `docs/it/` — images and
other assets stay with the English source and are shared, including the nested
`assets/` directories under `revisions/` and `tutorials/openplotter-server/`.

**This file began as a copy of the HALPI2 Italian glossary and deliberately
keeps its decisions.** SH-RPi and HALPI2 are both Raspberry Pi power boards with
supercapacitors, a shutdown daemon and a hardware watchdog, so a reader who
knows one Hat Labs board should meet the same Italian words in the other.
`carrier board` → `scheda portante`, `watchdog` left in English, `daemon` →
`demone` and the six typography rules are that repository's calls and they stand
here too. Rows above the `## SH-RPi terms` heading are shared: **a shared row
changes in both repositories or in neither.** Terms under that heading are this
product's additions and are ours alone.

The HALMET glossary was not used as the base even though it is also a Hat Labs
board. Its additions are all sensor-input vocabulary — analog and digital
inputs, galvanic isolation, a constant current source — and not one of those
words occurs in the SH-RPi documentation. That was measured against
`docs/en/`, not assumed. HALPI2's additions, by contrast, are supercapacitors,
buck converters, current limiting, watchdog reboots and a shutdown daemon, which
is precisely this product.

Translations are produced page by page, at different times, potentially by
different people. Without a fixed terminology list the same English term drifts
across pages — *stack-through header* becomes `connettore passante` on one page
and `connettore a innesto` on the next — and the result reads as machine output
even when each individual sentence is correct.

This file is the reference that prevents that drift. It is a living document:
extend it when a page introduces a term that is not listed here, rather than
inventing a one-off translation.

The locale code is `it`. mkdocs-material ships built-in UI translations for it,
so nothing in the theme chrome needs a manual string.

Unlike the other files under `solutions/`, this one has no date in its filename
because it is meant to be edited in place, not superseded.

## Six rules where the siblings are wrong for Italian

Read this section before anything else. Every one of these is stated the
opposite way in at least one sibling glossary — the Finnish one in this
repository, and the French, German, Swedish and Finnish files in the HALPI2
repository that this file was copied from. The recorded failure mode over there
is exactly that: a rule from a neighbouring language carried across, or a rule
written once and then applied to the first three pages only. Both were caught by
*counting* the finished pages, never by rereading them. Each rule below is
therefore written so it can be counted; the commands are in
[Verification](#verification).

1. **Address the reader impersonally.** Instructions use the **infinitive**, which
   is the standard register of Italian installation and user manuals:

   > Collegare il cavo di alimentazione. Verificare la polarità con il multimetro
   > prima di dare tensione.

   Descriptive passages use the impersonal *si*, the passive, or a plain
   statement:

   > Il dispositivo si spegne automaticamente quando l'alimentazione viene
   > interrotta. È possibile accedere alla custodia dopo aver rimosso le quattro
   > viti del coperchio.

   **Never `tu`** (Finnish and Swedish address the reader directly), **never
   `Lei`** (German uses `Sie`), **never the second person plural** (French uses
   *vouvoiement*). Italian differs from all of them here, which makes this the
   rule most likely to drift. No `puoi`, `devi`, `il tuo`, `la Sua`, `potete`
   anywhere in `docs/it/`.

   The English source of SH-RPi is written in the second person throughout —
   *you can create*, *your Raspberry Pi*, *your SH-RPi*, *ensure you loosen
   them*. Recast every one; do not carry the pronoun over. *your SH-RPi* becomes
   `il proprio SH-RPi` or simply `SH-RPi`.

2. **Quotation marks are `"…"`** — U+201C opening, U+201D closing. **Not** the
   caporali `« … »`: those belong to French here, and choosing them would drag in
   the French no-break-space-inside habit with them. Not the German `„…"`, not
   the Finnish `"…"`, not straight `"…"`.

   Almost everything quoted in this corpus is a physical label on the board, a
   jumper position or a signal name — `"OFF"`, `"ON"`, `"3V3"`, `"2A"`, `"3A"`,
   `"heartbeat"`, `"house"` — and doppi apici are the Italian convention for
   exactly that. The label text itself stays in English; only the marks around it
   are Italian.

3. **No space before `; : ! ?`** — as in German, Finnish and Swedish, and unlike
   French, whose rule is the exact opposite and demands a no-break space. Write
   `Sintomi:`, never `Sintomi :`. The French rule cost a 334-site correction on
   its own branch in the HALPI2 repository; it must not cross into Italian.

   Italian's only no-break space (U+00A0) is between a number and its unit:
   `12 V`, `0,8 A`.

4. **Never hyphenate a product name into a compound.** German writes
   `NMEA-2000-Netzwerk`, Swedish writes `NMEA 2000-nätverk` and Finnish writes
   `NMEA 2000 -väylä`. Italian does none of these: the name follows the noun as a
   plain apposition.

   - `rete NMEA 2000`, `bus NMEA 2000`, `server Signal K`, `antenna Raspberry Pi`
   - `connettore GPIO`, `immagine Raspberry Pi OS`, `tastiera USB`, `scheda HAT`
   - `microcontrollore ATtiny1616`, `orologio PCF8563`, `connettore del CAN HAT`

   A hyphen between an English product name and an Italian noun is the single
   most visible marker that a rule was copied from the German, Swedish or Finnish
   page. Hyphens inside a name that already has one (`RS-485`, `T-connector` as a
   source term, `Micro-C`, `SH-RPi` itself) are untouched — the rule is about
   *joining* a name to an Italian word.

5. **Typographic apostrophe U+2019, and no apostrophe on `qual è`.** Italian
   elides constantly — `l'alimentazione`, `dell'involucro`, `un'antenna`,
   `all'interno` — and the character is always `'` (U+2019), never the straight
   `'` (U+0027). No sibling glossary states this because no sibling needs it.

   `qual è` is written **without** an apostrophe. `qual'è` is the classic Italian
   spelling error and it is trivially countable.

   Accents are not optional: `perché`, `poiché`, `affinché`, `né`, `sé`, `più`,
   `così`, `è`. The grave-for-acute mistakes (`perchè`, `poichè`) are the second
   trivially countable error.

6. **No English plural `-s` on a loanword.** Italian borrows the singular and
   leaves it invariable: `i jumper`, `i LED`, `gli HAT`, `i container`,
   `le dashboard`, `i firmware`, `i pin`, `gli overlay`, `i tutorial`. Writing
   `i jumpers` or `i LEDs` is the clearest tell of an unedited machine
   translation, and the English source is full of the plural forms that invite it
   — *jumpers*, *HATs*, *hats*, *standoffs*, *supercaps*, *zip ties*.

## Names that are never translated

Product names, protocol names, hardware standards and software UI strings stay
in English — the device's own interface is in English, so translating a menu
name would send the reader looking for something that does not exist on screen.

- **Products and software:** SH-RPi, Sailor Hat, HALPI2, Signal K, OpenPlotter,
  Raspberry Pi OS, Waveshare, PlatformIO, Node-RED, Grafana, InfluxDB, AvNav,
  OpenCPN, Hat Labs.
- **Hardware and standards:** Raspberry Pi, Compute Module 4 (CM4), HAT,
  ATtiny1616, PCF8563, MCP2515, MAX-M8Q, CAN, NMEA 2000, NMEA 0183, RS485,
  GNSS, GPS, GLONASS, BeiDou, Galileo, I2C, SPI, UART, UPDI, GPIO, USB, HDMI,
  eMMC, microSD, PoE, SMA, PG7, PG9, SP13, RJ45, DHCP, SSH, AWG.
  **The add-on boards keep their product names exactly: CAN HAT, RS485 HAT,
  GNSS HAT.**
- **Board labels and pin names are copied as printed**, inside `"…"` when the
  source quotes them: `PROG`, `RTC EN`, `GPIO4 Enable`, `BOOT`, `2A`, `3A`,
  `CAN0`, `CAN1`, `GND`, `3V3`, `OFF`, `ON`, `E`, `P`, `PB5`, `H`, `L`, `A`,
  `B`, `RX`, `TX`.
- **Commands, file paths and configuration keys** — `shrpi print`,
  `shrpi set watchdog 0`, `shrpi sleep 3600`, `systemctl enable shrpid`,
  `raspi-config`, `avrdude`, `rpiboot`, `/etc/shrpid.conf`,
  `/boot/firmware/config.txt`, `/var/run/shrpid.sock`, `/dev/ttyAMA0`,
  `/dev/ttySC0`, `blackout-time-limit`, `poweroff`, `dtoverlay=disable-bt`,
  `can0`.
- **Code fences and their contents**, including comments inside them, and all
  command output.
- **URLs and image filenames.**

Gender and article, fixed once so pages do not disagree with each other:

- **SH-RPi** takes the elided article, because `SH-` is read as letters and
  begins with a vowel sound: `l'SH-RPi`, `dell'SH-RPi`, `all'SH-RPi`. Never
  `il SH-RPi`.
- **Sailor Hat** is masculine: `il Sailor Hat`, `del Sailor Hat`.
- **CM4 / Compute Module 4** is masculine: `il CM4`, `del CM4`.
- **HAT** is masculine and invariable: `l'HAT`, `gli HAT`, `il CAN HAT`.
- **dashboard** is feminine: `la dashboard`, `dalla dashboard`.
- **jumper, container, firmware, pin, LED, watchdog, browser, overlay, socket,
  script, stack, heartbeat, tutorial** are masculine and invariable:
  `il jumper` / `i jumper`, `il LED` / `i LED`, `lo script` / `gli script`.
- **scheda portante** is feminine: `la scheda portante`.
- **API** is feminine: `l'API REST`, `le API`.

For bare acronyms, prefer putting an Italian noun in front rather than guessing
an article: `la porta USB`, `il bus I2C`, `il connettore RJ45`,
`la memoria eMMC`, `l'interfaccia UPDI`.

## Glossary

### Enclosure, mounting, and installation

| English | Italian | Note |
|:--------|:--------|:-----|
| carrier board | scheda portante | The accurate term, as in French, German and Swedish — see the note below |
| enclosure | custodia | Not *involucro*, the normative IEC word, which reads as a standards document |
| lid | coperchio | |
| gasket | guarnizione | |
| heat sink | dissipatore di calore | |
| waterproof | impermeabile | One word for the whole corpus; do not alternate with *stagno* |
| wall-mount | montaggio a parete | |
| mounting surface | superficie di montaggio | |
| pilot hole | foro pilota | A hole **the reader drills**: `Praticare i fori pilota per le viti` |
| pre-drilled hole | foro predisposto | A hole **the enclosure ships with** — see the warning below |
| mounting template | dima di foratura | |
| bilge water | acqua di sentina | |
| bulkhead | paratia | |
| cable gland | pressacavo | |
| cable routing | posa dei cavi | |
| service loop | riserva di cavo | Slack left at both cable ends; gloss `(service loop)` on first mention |
| cable tie | fascetta | |
| blind plug | tappo cieco | |
| breather plug | tappo di compensazione | Pressure equalisation; must not be removed |
| thermal pad | pad termico | |
| standoff | distanziale | |
| countersunk screw | vite svasata | |

**`foro pilota` and `foro predisposto` are two different things.** The English
source uses *pilot hole* for a hole the installer drills into the bulkhead, and
*pre-drilled* for openings the enclosure already has. Conflating them produced a
nonsense instruction on the Swedish branch of the HALPI2 repository — *drill the
pre-drilled holes*. The trap is live in this corpus too: `getting-started`
says *an enclosure without pre-drilled holes, you'll need to drill the holes
yourself* in a single sentence. Keep them apart — `praticare i fori` for the
reader's drilling step, `fori predisposti` for the factory openings.

**A note on `scheda portante`.** Italian takes the accurate term, like French
(`carte porteuse`), German (`Trägerplatine`) and Swedish (`bärkort`), and unlike
Finnish (`emolevy`, literally *motherboard*, chosen there for reader
familiarity). The divergence is deliberate, decided per language and per
audience. Do not harmonise them, and do not reach for `scheda madre`: it names
the wrong board and inverts the module/board relationship.

In this corpus the term is needed only on the Compute Module 4 page, where the
CM4 *plugs into a carrier board*. **SH-RPi itself is not a carrier board** — it
is a HAT that stacks onto a Raspberry Pi — so never apply `scheda portante` to
SH-RPi. Gloss `(carrier board)` in parentheses on first mention of the page,
because the English term is what the Raspberry Pi documentation the reader may
open next uses. See also `base board` under [SH-RPi terms](#sh-rpi-terms).

### Power and electrical

| English | Italian | Note |
|:--------|:--------|:-----|
| power supply | alimentazione | The unit itself: *alimentatore* |
| input voltage range | intervallo di tensione di ingresso | |
| polarity | polarità | |
| rail (3.3V rail) | linea | `la linea da 3,3 V`, `la linea da 5 V` |
| fuse | fusibile | `fusibile SMD da 4 A` |
| inline fuse | fusibile in linea | |
| circuit breaker | interruttore automatico | |
| current limiting | limitazione di corrente | The switch itself: *limitatore di corrente* |
| overcurrent | sovracorrente | |
| voltage drop | caduta di tensione | |
| grounding | messa a terra | |
| short circuit | cortocircuito | |
| wire gauge | sezione del conduttore | Italian uses mm², not AWG |
| marine-grade wire | cavo per uso nautico | |
| wire strippers | pinza spelafili | |
| crimping | crimpatura | |
| crimper | pinza crimpatrice | |
| heat-shrink tubing | guaina termorestringente | |
| heat gun | pistola termica | |
| multimeter | multimetro | |
| terminal block | morsettiera | |
| strain relief | scarico della trazione | |
| super-capacitor | supercondensatore | Also renders *supercapacitor*, written as one word in the English source |
| real-time clock | orologio in tempo reale | Keep `(RTC)` on first mention |
| backup battery | batteria tampone | |
| power loss | mancanza di alimentazione | |
| blackout | interruzione di corrente | `blackout timer` becomes `timer di interruzione di corrente` |

### Connectors and interfaces

| English | Italian | Note |
|:--------|:--------|:-----|
| connector | connettore | |
| barrel connector | connettore cilindrico | Gloss `(barrel)` on first mention |
| header | connettore a pettine | GPIO: `connettore GPIO a 40 pin` |
| pin | pin | Invariable: `i pin`, never `i pins` |
| pinout | piedinatura | |
| pitch | passo | `passo 3,81 mm` |
| jumper | jumper | Invariable; the word is on the silkscreen |
| backbone | dorsale | `dorsale NMEA 2000` |
| drop cable | cavo di derivazione | |
| T-connector | connettore a T | The source also says *T-adapter*; both become `connettore a T` |
| terminator | resistenza di terminazione | The jumper: `jumper di terminazione` |
| termination | terminazione | The act, or the state of the network |
| front panel | pannello frontale | |
| male / female | maschio / femmina | |
| receptacle | presa | |
| flexible flat cable | cavo piatto flessibile | Keep `(FFC)`; the acronym is used alone afterwards |
| board-to-board connector | connettore scheda-scheda | |

### Operation and system behaviour

| English | Italian | Note |
|:--------|:--------|:-----|
| boat computer | computer di bordo | |
| boot | avvio | The verb: *avviare* / *avviarsi* |
| first boot | primo avvio | |
| shutdown | spegnimento | The verb: *spegnere* |
| graceful shutdown | spegnimento controllato | |
| power management | gestione dell'alimentazione | |
| status LED | LED di stato | `i LED`, never `i LEDs` |
| monitoring | monitoraggio | |
| passive cooling | raffreddamento passivo | |
| filesystem | file system | Two words, masculine, invariable |
| unmount (filesystem) | smontare | `smontare il file system` |
| unmount (module or board) | rimuovere | Physical removal — `rimuovere la scheda dalla custodia` |
| reseat | reinserire | `reinserire il connettore` |
| watchdog | watchdog | Invariable |
| standby | standby | `modalità standby`; not *attesa* — it names a firmware state |
| power cycle | spegnere e riaccendere | Verb phrase; there is no good Italian noun |
| chart plotter | plotter cartografico | Gloss `(chartplotter)` on first mention |
| vessel | imbarcazione | Exception: *research vessels* is `navi da ricerca` |
| data logging | registrazione dei dati | |
| fleet management | gestione della flotta | |
| predictive maintenance | manutenzione predittiva | |
| remote monitoring | monitoraggio remoto | |
| compliance | conformità | |
| warranty | garanzia | |

### Software and networking

| English | Italian | Note |
|:--------|:--------|:-----|
| firmware | firmware | Invariable, masculine — matches the sibling decision to keep the trade term |
| daemon | demone | Established in Italian Linux usage |
| flash (firmware) | flashare | `flashare il firmware dell'ATtiny1616` |
| flash (an image) | scrivere | Writing an OS image: `scrivere l'immagine nella memoria eMMC` |
| system image | immagine di sistema | Also `immagine del sistema operativo` where the source spells it out |
| headless | senza monitor | First mention: `senza monitor (headless)` |
| container app | applicazione in container | |
| container image | immagine del container | |
| dashboard | dashboard | Feminine: `la dashboard`; not *cruscotto* |
| WiFi Access Point | access point WiFi | Standard Italian usage keeps *access point* |
| wired / wireless | via cavo / wireless | |
| credentials | credenziali | |
| default password | password predefinita | |
| single sign-on | autenticazione unica | Keep `(SSO)` on first mention, then `SSO` |
| Certificate Authority | autorità di certificazione | Keep `(CA)` on first mention, then `CA` |
| web interface | interfaccia web | |
| browser | browser | Invariable |
| remote access | accesso remoto | |
| update | aggiornamento | The verb: *aggiornare* |
| roll back | ripristinare | `ripristinare la versione precedente del firmware` |

## Units and numbers

The English source writes `12V` and `0.8A`, and both are wrong in Italian.
Convert every one. Numbers inside code fences and inline code are never touched.

| English source | Italian |
|:---------------|:--------|
| `12V`, `0.8A` | `12 V`, `0,8 A` |
| `5.5 x 2.1 mm` | `5,5 × 2,1 mm` |
| `-20°C to +60°C` | `−20 °C … +60 °C` |
| `120Ω` | `120 Ω` |
| `3-5A` | `3–5 A` (en dash for ranges) |
| `9-32V` | `9–32 V` |
| `3x20 F` | `3× 20 F` |
| `-167 dBm` | `−167 dBm` |
| `6mm`, `40mm` | `6 mm`, `40 mm` |
| `6.5-7 mm or 1/4"` | `6,5–7 mm o 1/4"` |

- **Decimal comma** everywhere in prose and tables: `0,8 A`, `3,81 mm`, `8,8 V`.
- **No-break space (U+00A0) between number and unit**, so the line never breaks
  between them.
- **Multiplication sign** `×` (U+00D7) for dimensions and quantities — `3× 20 F`,
  `2× 20 pin` — never the letter `x`. The source writes `2x20 pin` and `3x20 F`.
- **Minus sign** `−` (U+2212) for negative values, not a hyphen.
- **En dash** `–` (U+2013) for ranges. In running prose `da 9 a 32 V` reads
  better than the dash and is allowed; in tables use the dash form.
- **Inch marks** in drill sizes stay as written: `1/4"`, `1/2"`, `5/8"`,
  `0.15"`. They are measurements, not quotations, and are exempt from rule 2.
- **No thousands separator** in technical figures: `250 kbit/s`, not `250.000`.
- Every numeral in the English page must appear in the Italian page. A wrong
  voltage in an installation guide is a safety defect, not a typo.

## Links, images, admonitions, navigation

- Paths are copied from the English source unchanged and **never** carry an
  `en/` or `it/` segment. The language comes from the directory the file is in.
- Image captions and alt texts are translated; filenames are not.
- Screenshots stay English, because the reader's own screen is English. So does
  the embedded YouTube soldering video in `getting-started`.
- Standard admonition titles (`note`, `warning`, `tip`, `info`, `danger`,
  `example`) are translated centrally in `mkdocs.yml` under the i18n plugin's
  `admonition_translations`. A **custom** title is translated in the page:
  `!!! warning "Importante"`, `!!! danger "Attenzione"`.
- Navigation titles live in `mkdocs.yml` under `nav_translations` and that is the
  single source of truth; do not restate the full list here. Two entries are
  judgement calls worth recording:
    - `Errata` → **Errata corrige**, the standard Italian term, matching the
      HALPI2 decision. The page URL is unaffected — only the nav label changes.
    - `FAQ` → **Domande frequenti**. Italian documentation expands the acronym;
      the page's own H1 (`FAQ`) is a heading in the markdown and is translated
      there.
- When a new page is added to the nav in English, add its Italian title to
  `nav_translations` in the same change — an untranslated entry silently falls
  back to English and is easy to miss.
- Anchors derive from heading text, so a translated heading changes its slug.
  Rewrite every in-page `](#…)` link, and after building read the real ids out
  of the generated HTML rather than guessing. Slugs strip accents:
  `Risoluzione dei problemi` → `risoluzione-dei-problemi`; `Conformità` →
  `conformita`.

## SH-RPi terms

SH-RPi is a power management HAT, so its vocabulary is HALPI2's power and
shutdown language plus the mechanics of stacking boards on a Raspberry Pi.
Rows above this heading are shared with HALPI2 and are not to be changed here
alone.

### The board and the stack

| English | Italian | Note |
|:--------|:--------|:-----|
| HAT | HAT | Never translated; masculine and invariable (`l'HAT`, `gli HAT`). Rule 4 forbids a hyphen into an Italian noun: `scheda HAT`, `connettore HAT`, never `HAT-scheda`. The two-word product names stay intact: `il CAN HAT`, `l'RS485 HAT`, `il GNSS HAT` |
| add-on board | scheda aggiuntiva | The CAN, RS485 and GNSS HATs collectively. The source also writes *add-on card* and *add-on hardware*; all three render `aggiuntivo/a` so the nav title `Hardware aggiuntivo` and the body text agree |
| to stack (boards) | impilare | `impilare le schede`, `impilato sull'SH-RPi`. *Stackable* is `impilabile` |
| stack (the assembled boards) | stack | Masculine and invariable, like *jumper* and *watchdog*. **Not `pila`**: `pila` is also the ordinary Italian word for a battery cell, and the CR1220 and ML1220 cells are discussed on the same pages. `lo stack di schede`, `fissare lo stack alla piastra di base` |
| stack-through header | connettore a pettine passante | The tall 40-pin header supplied with the board that passes the GPIO signals through to a board above. The source spells it *stack-through header*, *stackthrough header* and *stack-through connector*; all three take this one rendering |
| stacking header | connettore a pettine passante | Same physical part as *stack-through header*; recorded so the two English spellings cannot produce two Italian terms |
| pass-through GPIO header | connettore GPIO passante | The 2×20 header on the SH-RPi itself, as opposed to the loose stack-through part |
| standoff / hex standoff | distanziale / distanziale esagonale | `standoff` is inherited from the enclosure table above; the hex variant is this product's. `distanziali esagonali da 6 mm`, `distanziali esagonali M2,5 da 16 mm` |
| mounting screw | vite di fissaggio | `viti M3 in dotazione`. Distinct from `vite svasata` (countersunk screw) in the inherited table |
| solder jumper | jumper a saldare | **Permanently closed or opened, not removable — see the warning below.** Inherited from the HALPI2 page translations; kept unchanged |
| jumper | jumper | Inherited above, invariable. **A removable link on a pin pair — see the warning below** |
| jumper header | connettore a pettine per i jumper | `il connettore a pettine per i jumper del limitatore di corrente`. Built from the inherited `header → connettore a pettine` |
| pin | pin | Inherited above, invariable. `connettore a 40 pin`, `il pin da tagliare`, `i pin PB5 e GPIO4` |
| pad | piazzola | The copper pad of a solder jumper: `le piazzole del jumper a saldare` |
| trace | pista | `tagliare le piste tra le piazzole`. Needed for the RTC EN and GPIO4 Enable instructions |
| base plate | piastra di base | The perforated plate in the medium and large enclosures on which the stack is mounted |
| base board | scheda base | The CM4 carrier board sold by Waveshare and others (*CM4-IO-BASE*). Distinct from `scheda portante` in the inherited table, which is the generic term; `scheda base` is what the CM4 page calls the specific product. Never used of SH-RPi |
| vertical mount | supporto verticale | The black plastic parts that hold the stack upright on the base plate |
| terminal plug | spina a morsetti | The pluggable screw-terminal part supplied loose. Distinct from `morsettiera` (terminal block) in the inherited table, which is the fixed part |
| panel connector | connettore da pannello | `connettore da pannello SP13`, `connettore da pannello RJ45`. Mounted through a hole in the enclosure wall |
| cable gland | pressacavo | Inherited above. `pressacavo PG7`, `pressacavo PG9`; the plugged variant is `pressacavo con tappo cieco` |

### Power, protection and the supercapacitors

| English | Italian | Note |
|:--------|:--------|:-----|
| supercapacitor / supercap | supercondensatore | Inherited as *super-capacitor*. The English source writes all three forms; Italian uses one word |
| supercapacitor bank | banco di supercondensatori | The three 20 F cells taken together |
| power reservoir | riserva di energia | What the supercapacitor bank is for |
| power management | gestione dell'alimentazione | Inherited above. `scheda di gestione dell'alimentazione` is what SH-RPi *is*, and is the phrase in `site_description` |
| buck converter | convertitore buck | Inherited from the HALPI2 page translations. *Buck* is kept as the trade term, as `jumper` and `watchdog` are |
| step-down converter | convertitore step-down | The source writes *step-down (buck) converter* for the first stage and *buck converter* for both stages. **Both stages step the voltage down.** The English text calls the second stage a *boost* converter twice (`hardware/index.md`, the paragraphs on enabling and disabling the 5 V output); that is an error in the source, raised as issue #25. Translate what the English says — `convertitore boost` where it says *boost* — and do not silently correct it. This row exists to record that the circuit is a step-down converter, so nobody "fixes" the Italian in the wrong direction |
| current limiter | limitatore di corrente | Inherited: the circuit and the header are `limitatore di corrente`. One name only; refer back with a pronoun rather than a second noun |
| current limit | limite di corrente | The *setting* — `il limite di corrente predefinito è 0,8 A`. Three related words that must not collapse: `limitazione di corrente` (the action, inherited), `limitatore di corrente` (the circuit, inherited), `limite di corrente` (the value) |
| transient voltage suppressor | soppressore di transitori di tensione | `soppressore di transitori di tensione da 33 V` |
| choke | induttore di filtro | Conducted-EMI filtering at the input, not a signal inductor |
| pi-filter | filtro a pi greco | Written out; `filtro a π` is not used in Italian running prose |
| reverse polarity protection | protezione contro l'inversione di polarità | The component: `diodo di protezione contro l'inversione di polarità` |
| undervoltage | sottotensione | `una condizione di sottotensione` below 10 V |
| overvoltage | sovratensione | Matches the inherited `overvoltage disconnect → disconnessione per sovratensione` |
| voltage threshold | soglia di tensione | The configurable 8,0 V and 5,0 V limits |
| charge / discharge | carica / scarica | Verbs `caricare` / `scaricare`. `stato di carica` for *charge state*; `i supercondensatori si stanno scaricando` for *depleting* |
| hold-up time | tempo di mantenimento | How long the supercapacitors keep the system running. Gloss `(hold-up time)` on first mention |
| brownout | abbassamento di tensione | Inherited from the HALPI2 page translations. Kept distinct from `caduta di tensione` (voltage drop) and from `interruzione di corrente` (blackout) |
| blackout | interruzione di corrente | Inherited above. The config keys `blackout-time-limit` and `blackout-voltage-limit` are never translated |
| power glitch | microinterruzione | *Power glitch resilience* is `immunità alle microinterruzioni`; *short-duration glitches* is `microinterruzioni di breve durata` |
| real-time clock (RTC) | orologio in tempo reale | Inherited above; keep `(RTC)` on first mention, then `RTC`. The board label `RTC EN` is never translated |
| backup battery | batteria tampone | Inherited above. Covers both the CR1220 on the SH-RPi and the ML1220 ephemeris cell on the GNSS HAT |
| rechargeable / non-rechargeable | ricaricabile / non ricaricabile | **Safety-critical opposition — see the warning below** |

### Shutdown, watchdog and status

| English | Italian | Note |
|:--------|:--------|:-----|
| safe shutdown | spegnimento sicuro | The product's headline feature. *Shut down safely* is `spegnersi in modo sicuro` |
| graceful shutdown | spegnimento controllato | Inherited above. `spegnimento sicuro` and `spegnimento controllato` name the same mechanism; each English form keeps its own rendering so the mapping stays checkable |
| to power down | spegnere | `spegnere il Raspberry Pi`. The state is `spento` — *when the system is powered off* is `quando il sistema è spento` |
| power-off | spegnimento | Same noun as the inherited `shutdown → spegnimento`; this is deliberate, not a second mechanism. The `poweroff` config key, the `/sbin/poweroff` command and the `gpio-poweroff` overlay are never translated |
| watchdog | watchdog | Inherited above, masculine and invariable. `il watchdog hardware`, `riavvio del watchdog` |
| watchdog timer | timer watchdog | Rule 4 word order; masculine and invariable. Not *temporizzatore*, which reads as an appliance timer |
| heartbeat | heartbeat | Masculine and invariable; the source quotes it as `"heartbeat"`. `segnale di heartbeat`, `l'SH-RPi non ha ricevuto un heartbeat per 10 s` |
| sleep / sleep state | sospensione / stato di sospensione | The LED state *Sleeping* is `In sospensione`. The `shrpi sleep` command is never translated |
| status LED array | barra di LED di stato | The four LEDs as a unit. The bar-graph reading is `barra`, matching the inherited `voltage bar → barra di tensione`; the blink patterns are `sequenze dei LED`, matching the inherited `LED pattern → sequenza dei LED` |

### Software

| English | Italian | Note |
|:--------|:--------|:-----|
| microcontroller | microcontrollore | Keeps its Italian form, unlike `controller` (inherited: `controller`, masculine and invariable). `il microcontrollore ATtiny1616` |
| daemon | demone | Inherited above. The daemon's own name is not translated: `il demone shrpid`, `il pacchetto SH-RPi-daemon` |
| service | servizio | The systemd unit. *Service software* is `software di servizio`; *system service* is `servizio di sistema` |
| installation script | script di installazione | `script` is masculine and invariable. *Automated installation script* is `script di installazione automatica` |
| configuration file | file di configurazione | `il file di configurazione /etc/shrpid.conf` |
| device tree overlay | overlay | Inherited from the HALPI2 page translations: kept in English, masculine and invariable, because it is the literal name of the `config.txt` mechanism. The source also writes *device overlay*; same rendering |
| firmware | firmware | Inherited above, masculine and invariable |
| to flash | flashare / scrivere | Inherited two-sense row. Firmware is `flashare` (`flashare il firmware dell'ATtiny1616`); an OS image is `scrivere` (`scrivere l'immagine nella memoria eMMC`). *Newly flashed Raspberry Pi OS* is the image sense: `Raspberry Pi OS appena installato` |
| headless | senza monitor | Inherited above; first mention `senza monitor (headless)`. **Exception:** OpenPlotter's *Headless image* is a product name and stays English — `l'immagine Headless di OpenPlotter` |
| image (OS image) | immagine di sistema | Inherited as *system image*; `immagine del sistema operativo` where the source spells it out |
| REST API | API REST | Inherited from the HALPI2 page translations. Italian inverts the order and treats API as feminine: `l'API REST` |
| file socket | socket su file | `socket` is masculine and invariable. `l'API è disponibile su un socket su file` |
| command-line interface | interfaccia a riga di comando | The `shrpi` script. *Command line* alone is `riga di comando` |

### Enclosure work and tools

| English | Italian | Note |
|:--------|:--------|:-----|
| step drill bit | punta a gradini | The source glosses it as *one that looks like a small metal Christmas tree*; translate the gloss too, it is what makes the tool recognisable |
| pilot hole | foro pilota | Inherited above, with the `foro predisposto` warning. `getting-started` puts both senses in one sentence |
| heat shrink tubing | guaina termorestringente | Inherited as *heat-shrink tubing*. The source also shortens it to *heat shrink*; same rendering |
| zip tie | fascetta | Inherited as *cable tie*. The source uses *zip ties*, *tie wraps* and *cable ties* for the same part; all three collapse to `fascetta`, and the plural is `le fascette` |
| double-sided tape | nastro biadesivo | For mounting the 40 mm fan |

### Three pairs that decide what the reader physically does

All three appear inside warnings, and all three are the kind of confusion that
costs hardware.

**`jumper a saldare` is not `jumper`.** A **jumper** is a removable link pushed
onto a pin pair — the current limiter header takes one to select 1,8 A or
2,8 A, and the PROG header takes several during firmware flashing, after which
*at least the third one must be removed*. A **solder jumper** is a pair of
copper pads on the board, closed at the factory and opened **by cutting the
traces between the pads with a sharp knife** (`RTC EN`), or opened at the
factory and closed by joining the pads (`GPIO4 Enable`). Getting the two
confused sends the reader for a knife they do not need, or has them try to pull
off something that is not removable. Keep `jumper a saldare` in full every time;
never shorten it to `jumper` in a sentence that also mentions the removable
kind, and never write `saldare il jumper` for the cutting operation — write
`tagliare le piste tra le piazzole`.

**`ricaricabile` and `non ricaricabile` must be unmistakable and clearly
opposed.** The GNSS HAT ships with a **rechargeable** ML1220 lithium cell on a
charging circuit. The source states that replacing it with a **non-rechargeable**
cell *will result in a risk of explosion and fire*. Both words appear in the same
paragraph, one negating the other, so the negation must be visible: write
`una pila al litio ricaricabile` and `una pila non ricaricabile`, keep the
`non` adjacent to the adjective, and do not paraphrase either half into
`monouso`, `primaria` or `secondaria`. Render the emphasis the source carries
(`must **not** be replaced` → `**non** deve essere sostituita`). The CR1220 on
the SH-RPi itself is a separate, non-rechargeable cell and is correct there —
the two boards must not be conflated.

**`convertitore buck` / `convertitore step-down` means the voltage goes down.**
Both converter stages on the SH-RPi step down: the first from the 9–32 V input
to 8,8 V for the supercapacitor bank, the second from the bank to the 5 V the
Raspberry Pi needs. The English source calls the second stage a *boost*
converter twice, which is wrong; it is recorded as issue #25 against the English
documentation. **Translate what the English says.** Do not fix it in the Italian
and do not leave a translator's note in the page — the correction belongs in the
English source, and a page that disagrees with its own source is worse than one
that inherits a known error. This glossary row is the record.

## Verification

A translated page is not done until:

1. `uv run mkdocs build --strict` passes — the same command CI runs.
2. `uv run python scripts/check_anchors.py site` passes.
3. `uv run python scripts/check_typography.py it` passes. The script already
   knows Italian: `QUOTES["it"]` is `("“", "”")`, Italian is **not** in
   `SPACE_REQUIRED`, and it is not in `CHAINS_ALLOWED`, so rules 2, 3 and 4 are
   machine-checked.
4. `uv run python scripts/check_glossary.py it` passes. `it` is already
   registered in the `GLOSSARIES` dict as `italian-glossary.md`, so no change to
   the script is needed — unlike the HALPI2 repository, where registering the
   language was a prerequisite for the Italian branch.
5. `uv run python scripts/translation_status.py` shows the page as current.
6. `uv run mkdocs serve` shows the page rendering correctly in the browser, with
   lists as lists (see
   `../best-practices/markdown-lists-need-blank-line-2026-05-16.md` — the
   blank-line rule applies identically to Italian pages).
7. Every term used on the page that appears in this glossary matches it.

8. **The six rules at the top are counted against the pages, not re-read.** A
   half-applied typography rule looks followed when you read it, because
   rereading your own text confirms whatever it already says. Both the French and
   German branches of the HALPI2 repository shipped one to review for that
   reason. Run these; every one must print `0`, and the two quote counts must be
   equal.

    ```bash
    # Rule 1 — address form: no tu, no Lei, no second person plural
    grep -rEoi '\b(tu|tuo|tuoi|tua|tue|puoi|devi|potrai|dovrai|potete|dovete|vostro|vostra|vostri|vostre)\b' docs/it | wc -l
    grep -rEo '\b(Lei|Suo|Sua|Suoi|Sue)\b' docs/it | wc -l

    # Rule 2 — quotation marks: these two must be EQUAL and non-zero
    grep -rFo '“' docs/it | wc -l
    grep -rFo '”' docs/it | wc -l
    # and these must be 0
    grep -rEo '[«»]' docs/it | wc -l
    grep -rEo '(„|‟)' docs/it | wc -l

    # Rule 3 — no space (ordinary or no-break) before ; : ! ?
    grep -rEn '( |\xc2\xa0)[;:!?]' docs/it | wc -l

    # Rule 4 — no product name hyphenated into an Italian compound
    grep -rEn 'NMEA-2000|Signal K-|Raspberry Pi-[a-z]|SH-RPi-[a-zàèéìòù]|HAT-[a-zàèéìòù]|CM4-[a-z]' docs/it | wc -l
    # SH-RPi-daemon, SH-RPi-firmware and CM4-IO-BASE are repository and product
    # names and are legitimate hits; everything else is a rule 4 violation.

    # Rule 5 — apostrophes and accents
    grep -rFo "'" docs/it | wc -l          # straight U+0027: must be 0
    grep -rEon "qual'è" docs/it | wc -l
    grep -rEoni '\b(perchè|poichè|benchè|affinchè|nè|sè)\b' docs/it | wc -l

    # Rule 6 — no English plural -s on a loanword
    grep -rEoi '\b(jumpers|LEDs|HATs|hats|containers|dashboards|firmwares|pins|headers|standoffs|supercaps|overlays|tutorials)\b' docs/it | wc -l
    ```

    Exclude code fences before counting rules 2, 3 and 5, since inline code and
    command output legitimately contain straight quotes, apostrophes and colons:

    ```bash
    python3 - <<'PY'
    import re, pathlib
    text = "\n".join(
        re.sub(r'`[^`\n]*`', ' ', re.sub(r'```.*?```', ' ', p.read_text(encoding='utf-8'), flags=re.S))
        for p in sorted(pathlib.Path('docs/it').rglob('*.md'))
    )
    checks = {
        'straight apostrophe': text.count("'"),
        'guillemets': len(re.findall(r'[«»]', text)),
        'space before ;:!?': len(re.findall(r'[  ][;:!?]', text)),
        'open quotes': text.count('“'),
        'close quotes': text.count('”'),
        'tu/Lei forms': len(re.findall(r'\b(tu|tuo|tuoi|tua|tue|puoi|devi|Lei|Suo|Sua|potete|dovete|vostr\w+)\b', text)),
    }
    for k, v in checks.items():
        print(f'{v:6}  {k}')
    print('quotes pair' if checks['open quotes'] == checks['close quotes'] else 'QUOTES DO NOT PAIR')
    PY
    ```

    Straight `"` is counted separately here, not folded into the check above:
    the drill-size table legitimately contains inch marks (`1/4"`, `1/2"`,
    `5/8"`, `0.15"`) outside code spans. Count them and confirm each hit is a
    measurement, rather than requiring zero.

9. **The two-sense terms are counted separately.** `foro pilota` must appear
   exactly where the English says *pilot hole* and nowhere else; `predispost*`
   exactly where it says *pre-drilled*. Same for `flashare` (firmware) versus
   `scrivere` (image), and for `jumper a saldare` versus bare `jumper` — the
   solder-jumper count must match the English *solder jumper* count exactly, in
   `hardware/index.md`, and never exceed it.

    ```bash
    for t in 'pilot hole' 'pre-drilled' 'solder jumper' flash; do
      printf '%-16s en=%s\n' "$t" "$(grep -rio "$t" docs/en | wc -l)"; done
    for t in 'foro pilota' predispost 'jumper a saldare' flashare scriver; do
      printf '%-16s it=%s\n' "$t" "$(grep -rio "$t" docs/it | wc -l)"; done
    ```

10. **Every numeral in the English page appears in the Italian page**, allowing
    for the decimal comma. Diff the extracted number lists rather than skimming.
    Voltages (`8,8 V`, `8,0 V`, `5,0 V`, `9–32 V`, `10 V`, `33 V`) and currents
    (`0,8 A`, `1,8 A`, `2,8 A`, `1,4 A`, `3 A`, `5 A`) carry safety meaning here.

11. `docs/en/tutorials/openplotter-server/index.md` is **deliberately left
    untranslated**. Its vocabulary is out of scope for this glossary; do not add
    terms from it, and do not create `docs/it/tutorials/openplotter-server/`.

## Related

- `finnish-glossary.md` — the sibling glossary in this repository, adapted from
  HALPI2 the same way and merged first
- `solutions/best-practices/markdown-lists-need-blank-line-2026-05-16.md`
- mkdocs-static-i18n documentation: <https://ultrabug.github.io/mkdocs-static-i18n/>

## Terms added during translation (inherited from HALPI2)

The record of terms the HALPI2 page translators reported, carried across with
the rest of the file. Some rows name pages that do not exist here
(`design-files.md`, `errata.md`, `interfaces.md`); those rows are kept anyway,
because a shared row changes in both repositories or in neither, and because the
term may still surface in a future SH-RPi page. Apply a row only where the
English term actually occurs.

| English | Translation | Note |
|:--------|:------------|:-----|
| Getting Started (page/guide title) | Guida introduttiva | H1 of the page and the link text to the equivalent guide. Standard Italian documentation title; 'Per iniziare' is the alternative but reads less well |
| Step (numbered procedure heading) | Passaggio | Needed a fixed choice so headings do not alternate between 'Passaggio', 'Fase' and 'Punto' |
| wire (individual conductor: red wire / black wire) | conduttore | The glossary covers 'wire gauge' and 'marine-grade wire' but not the countable conductor |
| cable grommet | passacavo | Appears alongside 'cable gland' (pressacavo, in glossary); needed a different word so the pair does not collapse into one term |
| mounting hardware (corrosion-resistant) | minuteria di fissaggio | Standard Italian for screws/washers/brackets as a class; a literal 'hardware di montaggio' would clash with 'hardware' used for electronics elsewhere |
| mounting clips | clip di fissaggio | Kept parallel to 'minuteria di fissaggio' |
| splash screen | schermata iniziale | Raspberry Pi OS boot screen. Established Italian rendering |
| rainbow pattern (LED) | sequenza arcobaleno | LED fault indication. Matched to 'sequenze dei LED di stato' so the two references agree |
| known-good device | dispositivo sicuramente funzionante | No idiomatic Italian noun phrase exists; a descriptive rendering is usual in Italian technical manuals |
| electrical codes | normative elettriche | 'Normative' rather than 'codici' — 'codice elettrico' is a calque |
| Automotive Installations | Installazioni su veicoli | 'automobilistiche' would wrongly exclude commercial vehicles |
| service loop (verb phrase) | prevedere una riserva di cavo | The verb collocation for the glossary noun 'riserva di cavo' |
| UART | UART (feminine: la UART, le UART) | The glossary warns against guessing articles for bare acronyms. Feminine is the prevailing Italian usage (implicitly 'porta') |
| device tree overlay | overlay | Kept in English, masculine and invariable, matching the glossary's treatment of jumper/HAT/container. It is the literal name of the config.txt mechanism |
| transceiver (RS-485) | transceiver | Kept in English, masculine. 'ricetrasmettitore' is not what Italian electronics documentation calls an RS-485 line driver IC |
| chip select | chip select | A signal name, not prose. Left in English like the silkscreen labels |
| SPI bus / I2C bus | bus SPI / bus I2C | Follows rule 4 (name as plain apposition after the noun). No hyphen |
| mass-storage gadget | gadget di archiviazione di massa | Linux USB gadget terminology; 'gadget' has no Italian equivalent in this sense |
| block device | dispositivo a blocchi | Standard Italian Linux usage |
| boot mode switch | selettore della modalità di avvio | Built from the glossary's 'boot → avvio'. The switch positions themselves stay English and quoted |
| login console | console di accesso | 'console' is feminine and invariable in Italian |
| REST API | API REST | Italian inverts the order and treats API as feminine (l'API REST) |
| port forwarding | port forwarding | Kept in English; the calque 'inoltro delle porte' is not what router UIs or Italian network documentation use |
| Hardware Guide (page title) | Guida all'hardware | Matches the pattern 'Guida introduttiva', 'Guida al software', 'Guida utente' |
| hardware flow control | controllo di flusso hardware | Standard Italian term; not in the glossary |
| device node | nodo di dispositivo | Used for the /dev/ttyAMA* entry |
| header pins (table column) | Pin del connettore | Derived from 'header → connettore a pettine' and 'pin → pin' (invariable) |
| taskbar | barra delle applicazioni | Standard Italian desktop terminology |
| update manager | gestore degli aggiornamenti | Descriptive, not a UI string the reader will see in English |
| pre-built images | immagini precompilate | Distinct from 'system image → immagine di sistema'; describes how Hat Labs ships them |
| solder jumper | jumper a saldare | The glossary fixes "jumper" as invariable but has no entry for the solder-bridge variant. "Jumper a saldare" keeps the glossary's loanword |
| backup power | alimentazione di riserva | The glossary has "backup battery = batteria tampone" but nothing for the supercapacitor-fed supply. "Batteria tampone" is wrong there (there is no battery) |
| mainboard | scheda principale del computer | The glossary forbids "scheda madre" because it names the wrong board |
| voltage bar (LED pattern) | barra di tensione | "barra" is the usual Italian word for a bar-graph indicator |
| power-loss detection | rilevamento della mancanza di alimentazione | Built from "power loss = mancanza di alimentazione"; recorded so the compound is spelled the same way on other pages |
| silk screen | serigrafia | The printed markings on the board. The glossary covers silkscreen *labels* staying English but not the surface itself |
| die-cast, powder-coated (enclosure) | pressofuso, verniciato a polvere | Standard Italian industrial terms |
| spudger | spudger | Tool name with no Italian equivalent in common use |
| single-sided / double-sided (SSD) | a singola faccia / a doppia faccia | M.2 form-factor description; recorded so the two halves of the contrast stay parallel |
| grace period (before automatic restart) | periodo di attesa | "Periodo di grazia" is a calque |
| carrier board controller | controller della scheda portante | 'controller' kept in English, masculine and invariable |
| supercapacitor backup | riserva a supercondensatori | The compound used as a section heading |
| kbps / Mbps / bps | kbit/s / Mbit/s / bit/s | Applied uniformly (250 kbit/s) |
| isolated ground / galvanically isolated | massa isolata / isolato galvanicamente | The glossary's 'grounding → messa a terra' is the protective-earth sense and wrong for a floating reference such as GND_CAN |
| ferrite bead | perlina di ferrite | The usual Italian catalogue term |
| threaded insert / solder nut | inserto filettato / dado da saldare | The glossary covers standoff and countersunk screw but not these two |
| powder-coated die-cast aluminium | alluminio pressofuso verniciato a polvere | Fixed once so the tables cannot disagree |
| depth sounder / wind instrument | ecoscandaglio / strumento del vento | Marine instrument names in the RS-485 applications section |
| use case | caso d'uso | Standard Italian software-engineering rendering, written with the typographic apostrophe |
| buck converter / overvoltage disconnect | convertitore buck / disconnessione per sovratensione | 'Buck' is kept as the trade term, as the glossary does for jumper/watchdog |
| controller (the RP2040 board controller) | controller | Aligned to 'controller' rather than 'controllore' |
| mounting ledge | sporgenza di appoggio | The cast ledge inside the enclosure that the PCB rests on |
| flash (casting defect) | bava | Homonym trap: the casting sense of 'flash', nothing to do with 'flashare il firmware' |
| inrush current | corrente di spunto | Standard Italian electrotechnical term; 'corrente di avviamento' would read as motor jargon |
| copper fill / copper pour | riempimento di rame | The source uses both for the same thing; both rendered identically |
| solder nut | dado da saldare | |
| test point | punto di test | |
| buck converter | convertitore buck | 'convertitore step-down' also exists but 'buck' is what Italian datasheets use |
| opamp | amplificatore operazionale | Spelled out; 'opamp' is not used in Italian running prose |
| footprint (component) | impronta | PCB land pattern sense |
| silkscreen | serigrafia | Distinct from the silkscreen *labels* themselves, which stay English per the glossary |
| brownout | abbassamento di tensione | Kept distinct from 'caduta di tensione' (voltage drop) and from 'interruzione di corrente' (blackout) |
| cross-compilation | compilazione incrociata | |
| thermal throttling | limitazione termica delle prestazioni | Kept clear of 'limitazione di corrente' (current limiting), a different mechanism |
| stray voltage | tensione parassita | |
| gigabit ethernet | ethernet gigabit | Noun-first Italian order; no hyphen, per rule 4 |
| errata | errata corrige | Page title. The standard Italian term |
| security hardening | rafforzamento della sicurezza | |
| cable plug (E7T cable plug) | spina volante | The free-hanging mating plug supplied loose, as opposed to the panel receptacle ('presa') |
| goodie bag | busta accessori | Image alt text |
| controller (any controller IC) | controller | Rival-term resolution. One rendering for all of them: `controller`, masculine and invariable, like jumper and watchdog. `controllore` reads as a human inspector. `microcontrollore` is a different English word (*microcontroller*) and keeps its Italian form |
| transceiver (RS-485 line driver) | transceiver | Rival-term resolution. `ricetrasmettitore` is the Italian for a *radio* transceiver, which on a boat means the VHF set — actively misleading in this corpus |
| LED pattern (table column and prose) | sequenza dei LED | Rival-term resolution. `sequenza` covers every use of *LED pattern* |
| current limit switch | limitatore di corrente | Rival-term resolution. One name only; refer back to it with a pronoun rather than a second noun. `interruttore` is reserved for circuit breakers and panel switches, `selettore` for the boot mode switch |
| community | comunità | Rival-term resolution. `comunità` matches the impersonal manual register of rule 1 |
| support (help from Hat Labs or the community) | assistenza | Rival-term resolution. Distinct from `supporto`, which stays for the capability sense — *external antenna support* is `supporto per antenne esterne` |
