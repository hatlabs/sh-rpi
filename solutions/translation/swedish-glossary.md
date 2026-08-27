---
title: Swedish translation glossary and style rules (SH-RPi)
date: 2026-08-05
category: translation
module: documentation
problem_type: reference
component: documentation
severity: medium
applies_when:
  - Translating any page from docs/en/ into Swedish under docs/sv/
  - Reviewing a Swedish translation for consistency
  - Adding a new term that has no established Swedish equivalent
tags:
  - translation
  - i18n
  - swedish
  - terminology
  - mkdocs-static-i18n
---

# Swedish translation glossary and style rules

## Context

The SH-RPi documentation is written in English under `docs/en/` and translated
into Swedish under `docs/sv/`, using the `mkdocs-static-i18n` folder structure.
Each language directory mirrors the same tree, so a translation keeps its
source's path and filename: `docs/en/hardware/index.md` becomes
`docs/sv/hardware/index.md`. Only markdown lives under `docs/sv/`; images and
other assets stay with the English source and are shared, including the nested
`assets/` directories under `revisions/` and `tutorials/openplotter-server/`.

**This file began as a copy of the HALPI2 Swedish glossary and deliberately
keeps its decisions.** SH-RPi and HALPI2 are both Raspberry Pi power boards with
supercapacitors, a shutdown daemon and a hardware watchdog, so a reader who
knows one Hat Labs board should meet the same Swedish words in the other.
`carrier board` → `bärkort`, `watchdog` left in English, `daemon` left in
English: those are HALPI2's calls and they stand here too. Terms below the
SH-RPi heading are this product's additions; **a shared row changes in both
repositories or in neither.**

The HALMET glossary was not used as the base even though it is also a Hat Labs
board. Its additions are all sensor-input vocabulary — analog and digital
inputs, galvanic isolation, a constant current source — and not one of those
words occurs anywhere in the SH-RPi documentation. That was measured against the
pages, not assumed from the product description.

`finnish-glossary.md` is this file's sibling in this repository, adapted from
HALPI2 the same way and merged first. The French and German glossaries referred
to below live in the HALPI2 repository; they are named here because they are
what the four rules in the next section are guarding against.

Translations are produced page by page, at different times, potentially by
different people. Without a fixed terminology list the same English term drifts
across pages — *stack-through header* becomes `genomgående stiftlist` on one
page and `stapelkontakt` on the next — and the result reads as machine output
even when each individual sentence is correct.

This file is the reference that prevents that drift. It is a living document:
extend it when a page introduces a term that is not listed here, rather than
inventing a one-off translation. It has no date in its filename because it is
meant to be edited in place, not superseded.

## Four rules where the siblings are wrong for Swedish

Read this section before anything else. Every one of these is stated the
opposite way in at least one sibling glossary, and carrying the wrong habit
across has already cost two correction rounds on earlier branches.

1. **Address the reader as `du`, not formally.** Swedish technical and consumer
   documentation uses `du`. French uses *vouvoiement* and German uses *Sie* —
   both wrong here. `Anslut strömkabeln.` / `Kontrollera polariteten med
   multimetern innan du slår på spänningen.`

2. **Quotation marks are `”…”`** — the *same* character (U+201D) on both sides.
   Not German's `„…“`, not French's `« … »`, not straight `"…"`.

3. **No space before `; : ! ?`** — as in German, and unlike French, whose rule is
   the exact opposite and demands a no-break space.

4. **Compounding with a proper name takes one hyphen at the junction, not
   throughout.** Swedish writes `NMEA 2000-nätverk`, `Signal K-server`,
   `Raspberry Pi-antenn`. German writes `NMEA-2000-Netzwerk` — hyphens all the
   way through. Copying the German pattern into Swedish is wrong, and it is the
   single most likely way this glossary gets violated.

   The same junction rule governs the SH-RPi product names: `CAN HAT-kort`,
   `RS485 HAT-kontakt`, `SH-RPi-kort`, `OpenPlotter-server`. Note that Finnish
   solves this differently (`CAN HAT -kortti`, with a space) — do not copy the
   Finnish spacing into Swedish.

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
- **Board labels and pin names are copied as printed**, in the same case and
  without translation or explanation in place: `PROG`, `RTC EN`,
  `GPIO4 Enable`, `BOOT`, `2A`, `3A`, `CAN0`, `CAN1`, `GND`, `3V3`. The reader
  matches these against silkscreen on the board and against switch positions;
  a translated label matches nothing. Explain the label in the surrounding
  sentence if it needs explaining — never in the label.
- **UI paths, commands, hostnames, file paths:** `raspi-config`, `shrpi`,
  `shrpid`, `avrdude`, `/boot/firmware/config.txt`, `/etc/shrpid.conf`,
  `/var/run/shrpid.sock`, `can0`, `/dev/ttyAMA0`

Code fences, command output, URLs and image filenames are never touched.

## Units and numbers

Same handling as the other languages — the English source writes `12V` and
`0.9A`, and both are wrong in Swedish.

| English source | Swedish |
|:---------------|:--------|
| `12V`, `0.9A` | `12 V`, `0,9 A` |
| `5.5 x 2.1 mm` | `5,5 × 2,1 mm` |
| `-20°C to +60°C` | `−20 °C … +60 °C` |
| `120Ω` | `120 Ω` |
| `3-5A` | `3–5 A` (en dash for ranges) |
| `9-32V`, `10-32 V` | `9–32 V`, `10–32 V` |
| `20F`, `3.0 V` | `20 F`, `3,0 V` |

## Links, images, admonitions, navigation

Same as the sibling glossaries: paths are copied from the English source
unchanged and never carry a language segment; image captions and alt texts are
translated but filenames are not; screenshots stay English because the reader's
own screen is English; standard admonition titles are translated centrally in
`mkdocs.yml`, custom ones in the page.

Navigation titles live in `mkdocs.yml` under the i18n plugin's
`nav_translations`, which is their single source of truth — the full list is not
restated here. Three entries are judgement calls worth recording:

- `Errata` → **Kända fel**. The Latin term is opaque to a general reader; the
  page lists known hardware defects and plain Swedish says so.
- `FAQ` → **Vanliga frågor**. The established Swedish expansion; the English
  abbreviation is understood but reads as untranslated nav.
- `Hardware` (section) → **Hårdvara**, `Hardware Description` (the page inside
  it) → **Hårdvarubeskrivning**. Two keys, deliberately not the same string.

When a page is added to the nav in English, add its Swedish title in the same
change — an untranslated entry silently falls back to English and is easy to
miss.

## Glossary

### Enclosure, mounting, and installation

| English | Swedish | Note |
|:--------|:--------|:-----|
| carrier board | bärkort | The accurate term, as in French and German |
| enclosure | kapsling | |
| heat sink | kylfläns | |
| waterproof | vattentät | |
| wall-mount | väggmontage | |
| mounting surface | monteringsyta | |
| pilot hole (to drill) | förborra (verb) | `Förborra hålen` — never `borra förborrade hål` |
| pre-drilled hole (already there) | förborrat hål | The holes the enclosure ships with |
| mounting template | borrmall | |
| bilge water | slagvatten | |
| bulkhead | skott | |
| cable gland | kabelgenomföring | |
| cable routing | kabeldragning | |
| service loop | servicelänga | Slack left at both cable ends |
| cable tie | buntband | |
| blind plug | blindplugg | |
| breather plug | tryckutjämningsplugg | |

**A note on `bärkort`.** Swedish takes the accurate term, like French
(`carte porteuse`) and German (`Trägerplatine`), and unlike Finnish (`emolevy`,
literally *motherboard*, chosen there for reader familiarity). The divergence
between the four is deliberate, decided per language and per audience. Do not
harmonise them.

`bärkort` carries the module/board relationship on its own, so passages about
reseating the compute module or troubleshooting a board that will not boot need
no extra explanation. Only the Finnish glossary needs that warning.

In the SH-RPi documentation the term surfaces on the Compute Module 4 page,
where the English source writes **base board** for the board a CM4 plugs into.
That is the same thing and is `bärkort`. It is *not* the `bottenplatta` of the
enclosure, which the Getting Started page calls a **base plate** — two English
words one letter apart, two unrelated parts, and the SH-RPi assembly walkthrough
uses `base board` loosely for "the board underneath" as well. Read which one is
meant from the picture, not from the word.

### Electrical

| English | Swedish | Note |
|:--------|:--------|:-----|
| power supply | strömförsörjning | The unit itself: *nätaggregat* |
| input voltage range | inspänningsområde | |
| polarity | polaritet | |
| fuse | säkring | |
| inline fuse | linjesäkring | |
| circuit breaker | automatsäkring | |
| current limiting | strömbegränsning | |
| overcurrent | överström | |
| voltage drop | spänningsfall | |
| grounding | jordning | |
| short circuit | kortslutning | |
| wire gauge | ledararea | Swedish uses mm², not AWG |
| marine-grade wire | sjövattenbeständig ledare | |
| wire strippers | avisoleringstång | |
| crimping | krimpning | |
| crimper | krimptång | |
| heat-shrink tubing | krympslang | |
| heat gun | varmluftspistol | |
| multimeter | multimeter | |
| terminal block | kopplingsplint | |
| strain relief | dragavlastning | |
| super-capacitor | superkondensator | |
| real-time clock | realtidsklocka | |
| backup battery | backupbatteri | |

### Connectors and interfaces

| English | Swedish | Note |
|:--------|:--------|:-----|
| connector | kontakt / anslutning | *anslutning* for a board-mounted socket |
| barrel connector | hålkontakt | |
| header | stiftlist | `40-polig GPIO-stiftlist` |
| pin | stift | |
| backbone | backbone | Established in Swedish NMEA 2000 usage |
| drop cable | stickledning | |
| T-connector | T-koppling | |
| termination (120 Ω) | termineringsmotstånd | |
| front panel | frontpanel | |
| jumper | bygel | |
| male / female | hane / hona | |

### System behaviour and status

| English | Swedish | Note |
|:--------|:--------|:-----|
| boat computer | båtdator | |
| to boot | starta | |
| first boot | första start | |
| shutdown | avstängning | |
| graceful shutdown | kontrollerad avstängning | |
| power loss | spänningsbortfall | |
| blackout | strömavbrott | |
| power management | strömhantering | |
| status LED | status-LED | |
| monitoring | övervakning | |
| passive cooling | passiv kylning | |
| filesystem | filsystem | |
| to unmount | avmontera | |
| watchdog | watchdog | |
| standby | vänteläge | |

### Software and networking

| English | Swedish | Note |
|:--------|:--------|:-----|
| firmware | firmware | Not *fast programvara* — matches the sibling decision to keep the trade term |
| daemon | daemon | |
| to flash | flasha | |
| operating system image | systemavbild | |
| headless | utan skärm | First mention: `utan skärm (headless)` |
| container app | containerapp | |
| container image | containeravbild | |
| dashboard | instrumentpanel | Homarr's *dashboard* view |
| WiFi Access Point | WiFi-accesspunkt | |
| wired / wireless | trådbunden / trådlös | |
| credentials | inloggningsuppgifter | |
| default password | standardlösenord | |
| single sign-on (SSO) | enkel inloggning (SSO) | |
| Certificate Authority (CA) | certifikatutfärdare (CA) | |
| web interface | webbgränssnitt | |
| browser | webbläsare | |

### Applications and use cases

| English | Swedish | Note |
|:--------|:--------|:-----|
| chart plotter | kartplotter | |
| data logging | datalagring | |
| vessel | fartyg | |
| fleet management | flotthantering | |
| predictive maintenance | förebyggande underhåll | |
| remote monitoring | fjärrövervakning | |
| compliance | överensstämmelse | |
| warranty | garanti | |

## SH-RPi terms

SH-RPi is a power management HAT, so its vocabulary is HALPI2's power and
shutdown language plus the mechanics of stacking boards on a Raspberry Pi.
**Rows above this heading are shared with HALPI2 and must not be changed here
alone.** Where a row below repeats an inherited one, it is because the SH-RPi
pages use the term in a way that needs saying — the Swedish word is the same.

### The board and the stack

| English | Swedish | Note |
|:--------|:--------|:-----|
| HAT | HAT | Never translated. Compounds with one hyphen at the junction: `HAT-kort`, `HAT-kontakt`, `HAT-stapel`, and `CAN HAT-kort` for the two-word product name |
| add-on board | tilläggskort | The CAN, RS485 and GNSS HATs collectively; the nav calls the section `Tilläggshårdvara` |
| to stack (boards) | stapla | `stapla korten på varandra`; *stackable* → `stapelbar` |
| stack (of boards) | kortstapel | The English source says *PCB stack* and *the stack* for the same thing |
| stack-through header | genomgående stiftlist | The tall 40-pin header whose pins pass through to the board above |
| stacking header | genomgående stiftlist | Same physical part; the source spells it *stack-through*, *stackthrough* and *stacking* on different pages, and all three are one Swedish term |
| standoff | distans | |
| hex standoff | sexkantsdistans | `6 mm sexkantsdistanser`, `M2,5 16 mm sexkantsdistanser` |
| mounting screw | monteringsskruv | |
| solder jumper | lödbygel | **Not the same part as `bygel`** — see the note below |
| jumper | bygel | Inherited from HALPI2. Removable, sits on a pin pair |
| jumper header | bygellist | The current limiter header the byglar go on: `strömbegränsarens bygellist` |
| pin | stift | Inherited row; `40-polig GPIO-stiftlist`, and on the GNSS HAT page an actual pin the reader cuts off — `klipp av stiftet` |
| base plate | bottenplatta | The enclosure's perforated plate. Not `bärkort` — see the `bärkort` note above |
| vertical mount | vertikalfäste | The black plastic parts that hold the kortstapel upright |
| cable gland | kabelgenomföring | Inherited row; `PG7-kabelgenomföring`, `PG9-kabelgenomföring` |
| panel connector | panelkontakt | `SP13-panelkontakt`, `RJ45-panelkontakt` |
| terminal plug | plintkontakt | The pluggable screw terminal that mates with the power input |

**`lödbygel` vs `bygel` — the distinction that decides what the reader does.**
These are two different parts and the English *solder jumper* / *jumper* pair is
easy to flatten into one Swedish word. Do not.

- **`lödbygel`** (solder jumper) is permanent: two pads on the board, joined or
  separated. On the SH-RPi the `RTC EN` and `GPIO4 Enable` lödbyglar are changed
  by **cutting the traces between the pads with a sharp knife**, or by joining
  the pads. `Avaktivera RTC:n genom att skära av ledarna mellan lödbygelns pads
  med en vass kniv.`
- **`bygel`** (jumper) is removable: a small plastic link pushed onto a pin
  pair. The current limiter and the `PROG` header take byglar; they are placed,
  moved and pulled off by hand, with no tools.

Confusing the two sends a reader after a knife they do not need, or has them try
to pull off something that is soldered down. Both appear inside warnings, so
neither may be softened into a generic `bygel`.

### Power and shutdown

| English | Swedish | Note |
|:--------|:--------|:-----|
| supercapacitor / supercap | superkondensator | Matches HALPI2. The English source writes it both ways; Swedish uses one word |
| supercapacitor bank | superkondensatorbank | The three 20 F cells as a unit |
| power management | strömhantering | Inherited from HALPI2 |
| safe shutdown | säker avstängning | |
| graceful shutdown | kontrollerad avstängning | Inherited from HALPI2 |
| to power down | stänga av | |
| power-off | strömfrånslag | The supply being cut, as distinct from `avstängning`, which is the operating system shutting itself down: `håller tiden när systemet är strömlöst` |
| watchdog | watchdog | Left in English, as in HALPI2 |
| watchdog timer | watchdog-timer | |
| heartbeat | heartbeat | Left in English for the same reason as `watchdog` — it names a protocol signal, not a metaphor: `heartbeat-signal`, `SH-RPi fick ingen heartbeat på 10 s` |
| blackout | strömavbrott | Inherited from HALPI2 |
| brownout | spänningsdipp | A dip, not a break — the supercapacitors ride these out. Never `strömavbrott` |
| hold-up time | hålltid | How long the superkondensatorbank keeps the system running |
| charge / discharge | laddning / urladdning | Verbs: `ladda` / `ladda ur`. *Deep discharge* → `djupurladdning` |
| voltage threshold | spänningströskel | The 8,0 V and 5,0 V limits at which the 5 V output is enabled and disabled |
| undervoltage | underspänning | Below 10 V input is treated as underspänning |
| overvoltage | överspänning | The fault the rapid LED blink indicates |
| reverse polarity protection | skydd mot omvänd polaritet | The transparent form, chosen over the compact trade word `ompolningsskydd` because it appears where a reader is checking polarity. The component: `skyddsdiod mot omvänd polaritet` |
| buck converter | buckomvandlare | First mention: `spänningssänkande omvandlare (buck)`. See the note below |
| step-down converter | spänningssänkande omvandlare | The same component as `buckomvandlare`; the source writes *step-down (buck) converter* once and *buck converter* thereafter |
| current limiter | strömbegränsare | The circuit; the act is `strömbegränsning` (inherited) |
| current limit | strömgräns | `strömgränsinställning` for the setting; the header labels `2A` and `3A` stay as printed |
| transient voltage suppressor | transientskydd | `33 V transientskydd (TVS)` |
| choke | drossel | |
| pi-filter | pi-filter | |
| sleep state | viloläge | The state the board enters on `shrpi sleep` |
| to wake up | vakna / väcka | `vaknar automatiskt när strömmen kommer tillbaka` |
| status LED array | status-LED-rad | Four LEDs; `stapeldisplayen` for the charge-level bar they form |

**A note on `buck` and the `boost` error in the source.** Both converter stages
on the SH-RPi are step-down stages: the first drops the 9–32 V input to 8,8 V
for the superkondensatorbank, the second drops the supercapacitor voltage to
5 V. The English hardware page nevertheless calls the second stage a **boost
converter** twice, in the sentences about the microcontroller enabling and
disabling it (raised as issue #25). **Translate what the English says** — write
`boostomvandlare` at those two spots — and do not silently correct it; the
Swedish page must not disagree with the English page it is a translation of.
This row exists so that the row itself records the truth: the component is a
step-down stage, and when #25 lands the two spots change to `buckomvandlare`.

### Clock and battery

| English | Swedish | Note |
|:--------|:--------|:-----|
| real-time clock (RTC) | realtidsklocka (RTC) | Inherited row. The abbreviation `RTC` stays; case endings take a colon after it: `RTC:n` |
| backup battery | backupbatteri | Inherited row. The SH-RPi's is a CR1220, the GNSS HAT's an ML1220 — different batteries, and the difference is the next two rows |
| rechargeable battery | uppladdningsbart batteri | The GNSS HAT's ML1220 |
| non-rechargeable battery | ej uppladdningsbart batteri | On first mention in the warning, gloss it: `ej uppladdningsbart batteri (engångsbatteri)` |

**A note on the battery warning.** The GNSS HAT takes a rechargeable ML1220 and
the English page says that replacing it with a non-rechargeable cell **risks
explosion and fire**. In Swedish the two words differ by one syllable, so a
reader skimming can miss the negation. In that warning:

- write both words out in full — never shorten either to `batteri` and let
  context carry it;
- keep the opposition explicit in the same sentence:
  `ML1220 är ett uppladdningsbart litiumbatteri och får **inte** ersättas med
  ett ej uppladdningsbart batteri (engångsbatteri)`;
- keep the bolding the English source puts on **not**.

The SH-RPi's own CR1220 is the opposite case — non-rechargeable and correct
there — so the two pages say opposite things about nearly identical part
numbers. Check which board the page is about before reaching for either word.

### Software

| English | Swedish | Note |
|:--------|:--------|:-----|
| microcontroller | mikrokontroller | The ATtiny1616; the name itself is never translated |
| daemon | daemon | Not *bakgrundsprocess* — Hat Labs convention, inherited from HALPI2. The English source glosses it as *(service software)*: `daemon (systemtjänst)` on first mention |
| service (systemd) | tjänst | `systemd-tjänst`, `aktivera tjänsten` |
| installation script | installationsskript | `det automatiska installationsskriptet` |
| configuration file | konfigurationsfil | `/etc/shrpid.conf`; the path itself is never translated |
| device tree overlay | device tree-overlay | Kept in English, hyphenated at the junction. The source also writes *device overlay* for the same thing |
| firmware | firmware | Inherited from HALPI2 — not *fast programvara* |
| to flash | flasha | Inherited from HALPI2. `flasha eMMC-minnet` |
| headless | utan skärm | Inherited. First mention: `utan skärm (headless)`. OpenPlotter's **Headless** image is a product name and stays as printed |
| image (OS image) | systemavbild | Inherited from `operating system image` |
| REST API | REST-API | |
| file socket | filsocket | `/var/run/shrpid.sock`; `Unix-socket` is the same thing but the source says *file socket* |

### Enclosure work

| English | Swedish | Note |
|:--------|:--------|:-----|
| step drill bit | stegborr | The one shaped like a small metal Christmas tree |
| pilot hole | förborra | Inherited verb row. `pre-drilled holes` → `förborrade hål`: an enclosure that ships without them is `utan förborrade hål` |
| heat shrink tubing | krympslang | Inherited row. `trä krympslangen på ledaren *innan* du löder` |
| zip tie / tie wrap | buntband | Inherited from `cable tie`. The source uses *zip ties* and *tie wraps* for the same part; Swedish uses one word |
| double-sided tape | dubbelhäftande tejp | For mounting the 40 mm fan |

## Verification

A translated page is not done until:

1. `uv run mkdocs build --strict` passes — the same command CI runs.
2. `uv run python scripts/check_anchors.py site` passes.
3. `uv run python scripts/check_glossary.py sv` passes — it reads the tables in
   this file, so a row added here is checked from then on.
4. `uv run python scripts/check_typography.py sv` passes.
5. `uv run python scripts/translation_status.py` shows the page as current.
6. Every term used on the page that appears in this glossary matches it.
7. **The four rules at the top are tested against the pages, not re-read.** A
   half-applied typography rule looks followed when you read it. Both the French
   and German branches shipped one to review because it was read rather than
   measured.
8. `lödbygel`/`bygel` and `uppladdningsbart`/`ej uppladdningsbart` are checked by
   opening the two warnings and reading them, not by grepping. No script knows
   which of the pair a sentence should have said.

## Related

- `finnish-glossary.md` — the sibling in this repository, adapted the same way
- `../../halpi2/solutions/translation/swedish-glossary.md` — the source this
  file was copied from; shared rows change there too or not at all
- `.claude/skills/translate-page/SKILL.md` — the procedure
- mkdocs-static-i18n documentation: https://ultrabug.github.io/mkdocs-static-i18n/

## Terms added during translation

Recorded while translating `tutorials/openplotter-server/`, the only page in
this repository with a full hardware-assembly walkthrough. None of these had an
entry, and each one recurs across the soldering and drilling steps.

| English | Translation | Note |
|:--------|:------------|:-----|
| solder cup | lödkopp | Koppen i kontaktstiftet som fylls med tenn före lödning |
| pigtail (pre-wired lead) | kablage | JST XH-kablage |
| centre punch | körnare | För att märka ut hålcentrum före borrning |
| burr | grad | Plural *grader*; uppstår runt hålet vid borrning |
| self-tapping screw | självgängande skruv |  |
| O-ring | O-ring | Tätning runt kontakten |
| time-series database | tidsseriedatabas | InfluxDB |
