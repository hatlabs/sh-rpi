---
title: French translation glossary and style rules (SH-RPi)
date: 2026-08-05
category: translation
module: documentation
problem_type: reference
component: documentation
severity: medium
applies_when:
  - Translating any page from docs/en/ into French under docs/fr/
  - Reviewing a French translation for consistency
  - Adding a new term that has no established French equivalent
tags:
  - translation
  - i18n
  - french
  - terminology
  - mkdocs-static-i18n
---

# French translation glossary and style rules

## Context

The SH-RPi documentation is written in English under `docs/en/` and translated
into French under `docs/fr/`, using the `mkdocs-static-i18n` folder structure.
Each language directory mirrors the same tree, so a translation keeps its
source's path and filename: `docs/en/hardware/index.md` becomes
`docs/fr/hardware/index.md`. Only markdown lives under `docs/fr/` — images and
other assets stay with the English source and are shared, including the nested
`assets/` directories under `revisions/` and `tutorials/openplotter-server/`.

**This file began as a copy of the HALPI2 French glossary and deliberately keeps
its decisions.** SH-RPi and HALPI2 are both Raspberry Pi power boards with
supercapacitors, a shutdown daemon and a watchdog, so a reader who knows one Hat
Labs board should meet the same French words in the other. `carrier board` →
`carte porteuse`, `daemon` → `démon` and `watchdog` → `chien de garde
(watchdog)` were decided for HALPI2 and stand here too. Terms below the
[SH-RPi terms](#sh-rpi-terms) heading are this product's additions; **a shared
row changes in both repositories or in neither.**

The HALMET glossary was not used as the base even though it is also a Hat Labs
board: its additions are all sensor-input vocabulary — analog and digital
inputs, galvanic isolation, a constant current source — and none of those words
occurs in the SH-RPi documentation at all. That was measured against
`docs/en/`, not assumed.

Translations are produced page by page, at different times, potentially by
different people. Without a fixed terminology list the same English term drifts
across pages — *stack-through header* becomes `connecteur traversant` on one
page and `connecteur d'empilage` on the next — and the result reads as machine
output even when each individual sentence is correct.

This file is the reference that prevents that drift. It is a living document:
extend it when a page introduces a term that is not listed here, rather than
inventing a one-off translation.

Unlike the other files under `solutions/`, this one has no date in its filename
because it is meant to be edited in place, not superseded.

## Names that are never translated

Product names, protocol names, hardware standards, and software UI strings stay
in English — the device's own interface is in English, so translating a menu
name would send the reader looking for something that does not exist on screen.

- **Products and software:** SH-RPi, Sailor Hat, HALPI2, Signal K, OpenPlotter,
  Raspberry Pi OS, Waveshare, PlatformIO, Node-RED, Grafana, Hat Labs
- **Hardware and standards:** Raspberry Pi, Compute Module 4 (CM4), HAT,
  ATtiny1616, PCF8563, CAN, NMEA 2000, NMEA 0183, RS485, GNSS, I2C, SPI, UPDI,
  GPIO, USB, microSD, PoE. The add-on boards keep their product names exactly:
  **CAN HAT**, **RS485 HAT**, **GNSS HAT**.
- **Board labels and pin names are copied as printed on the board**, in the
  original case: `PROG`, `RTC EN`, `GPIO4 Enable`, `BOOT`, `2A`, `3A`, `CAN0`,
  `CAN1`, `GND`, `3V3`. The reader is looking at the silkscreen while reading —
  a translated label matches nothing. The same applies to jumper positions
  written as `OFF` / `ON`.
- **UI paths, commands, hostnames, file paths:** `raspi-config`, `shrpi`,
  `shrpid`, `/etc/shrpid.conf`, `/boot/firmware/config.txt`, `can0`,
  `/dev/ttyAMA0`, and every option name inside `shrpid.conf`
  (`blackout-time-limit`, `poweroff`, …).

Code fences, command output, URLs and image filenames are never touched.

## Style rules

### Address form

Instructions use **the second person plural imperative** (*vouvoiement*):

> Branchez le câble d'alimentation. Vérifiez la polarité au multimètre avant de
> mettre sous tension.

Not the infinitive (*Brancher le câble*), which reads as a parts list rather
than guidance, and not *tu*.

Descriptive passages use a plain statement or the passive:

> L'appareil s'éteint automatiquement lorsque l'alimentation est coupée.

### Typography

French typography is stricter than English and this is the most common source of
sloppy-looking translated pages. The space before `; : ! ?` is not decoration:
an ordinary space lets the line break in front of the punctuation, which is the
first thing a French reader notices.

U+00A0 rather than U+202F (narrow no-break): U+202F is the typographically
precise character but renders inconsistently across fonts, while U+00A0 is
universally supported and is what French technical documentation uses in
practice.

- **No-break space (U+00A0) before** `;` `:` `!` `?` and inside `« »`
- **Guillemets** `« … »` for quotations, not `"…"`
- **Decimal comma**, as in Finnish: `0,9 A`, `5,5 × 2,1 mm`
- **Space before the unit**: `12 V`, `250 kbit/s`, `−20 °C`
- **En dash for ranges**: `3–5 A`

The SH-RPi pages are full of warnings, and a warning is where the no-break space
matters most — `Ne branchez jamais l'alimentation sur le connecteur de sortie
5 V !` must not wrap before the exclamation mark.

### Units and numbers

Identical handling to Finnish — the English source writes `12V` and `0.9A`, and
both are wrong in French. Convert every one.

| English source | French |
|:---------------|:-------|
| `12V`, `0.9A` | `12 V`, `0,9 A` |
| `5.5 x 2.1 mm` | `5,5 × 2,1 mm` |
| `-20°C to +60°C` | `−20 °C … +60 °C` |
| `120Ω` | `120 Ω` |
| `9-32V`, `3-5A` | `9–32 V`, `3–5 A` (en dash for ranges) |
| `20F`, `3.81 mm`, `40mm` | `20 F`, `3,81 mm`, `40 mm` |

Imperial sizes quoted from the source (`0.15"`, `1/2"`) are kept, because they
are how the parts are sold; the metric value stays first, as in the English.

### Links, images, admonitions, navigation

Same rules as the Finnish glossary: paths are copied from the English source
unchanged and never carry an `en/` or `fr/` segment; image captions and alt
texts are translated but filenames are not; screenshots stay English because the
reader's own screen is English; standard admonition titles are translated
centrally in `mkdocs.yml`, custom ones in the page.

Two navigation entries are judgement calls worth recording:

- `Errata` → **Défauts connus**. The Latin term survives in French publishing
  but means *corrections to a printed text*; this page lists known hardware
  defects, and the plain phrase says so.
- `FAQ` → **FAQ**. Unlike Finnish, the English abbreviation is the established
  French form; *foire aux questions* is the expansion, not a replacement.

## Glossary

### Enclosure, mounting, and installation

| English | French | Note |
|:--------|:-------|:-----|
| carrier board | carte porteuse | Deliberately *not* the Finnish approach — see the note below |
| enclosure | boîtier | |
| heat sink | dissipateur thermique | |
| waterproof | étanche | |
| wall-mount | fixation murale | |
| mounting surface | surface de fixation | |
| pilot hole | avant-trou | |
| mounting template | gabarit de perçage | |
| bilge | cale | |
| bulkhead | cloison | |
| cable gland | presse-étoupe | |
| cable routing | cheminement des câbles | |
| service loop | boucle de service | |
| cable tie | collier de serrage | |
| blind plug | bouchon obturateur | |
| breather plug | bouchon d'équilibrage de pression | |

**A note on `carte porteuse`, and why it differs from Finnish.** Finnish
translates `carrier board` as `emolevy` — literally *motherboard* — chosen for
reader familiarity over accuracy. French deliberately does **not** follow that:
`carte porteuse` says what the board actually is.

Do not "harmonise" the two. They differ on purpose, decided per language and per
audience, and the divergence is the decision rather than an oversight in either
one.

The practical consequence is that French needs *less* care than Finnish here.
`emolevy` inverts the module/board relationship and the Finnish glossary tells
translators to write the roles out explicitly in passages where that matters.
`carte porteuse` carries the relationship on its own, so the surrounding sentence
does not have to.

On SH-RPi the row applies only to the Compute Module 4 page: the SH-RPi itself
is a HAT, not a carrier board, and the CM4 sits on someone else's board.

### Electrical

| English | French | Note |
|:--------|:-------|:-----|
| power supply | alimentation | |
| input voltage range | plage de tension d'entrée | |
| polarity | polarité | |
| fuse | fusible | |
| inline fuse | fusible en ligne | |
| circuit breaker | disjoncteur | |
| current limiting | limitation de courant | |
| overcurrent | surintensité | |
| voltage drop | chute de tension | |
| grounding | mise à la terre | |
| short circuit | court-circuit | |
| wire gauge | section du conducteur | French uses mm², not AWG |
| marine-grade wire | conducteur de qualité marine | |
| wire strippers | pince à dénuder | |
| crimping | sertissage | |
| crimper | pince à sertir | |
| heat-shrink tubing | gaine thermorétractable | |
| heat gun | pistolet à air chaud | |
| multimeter | multimètre | |
| terminal block | bornier | |
| strain relief | serre-câble | |
| super-capacitor | supercondensateur | |
| real-time clock | horloge temps réel | |
| backup battery | pile de sauvegarde | But see the rechargeable-battery note under SH-RPi terms |

### Connectors and interfaces

| English | French | Note |
|:--------|:-------|:-----|
| connector | connecteur | |
| barrel connector | connecteur cylindrique | Add *(barrel)* on first mention |
| header | connecteur | `connecteur GPIO 40 broches` |
| pin | broche | |
| backbone | dorsale | NMEA 2000 backbone |
| drop cable | câble de dérivation | |
| T-connector | connecteur en T | |
| termination (120 Ω) | résistance de terminaison | |
| front panel | panneau avant | |
| jumper | cavalier | |
| male / female | mâle / femelle | |

### System behaviour and status

| English | French | Note |
|:--------|:-------|:-----|
| boat computer | ordinateur de bord | |
| to boot | démarrer | |
| first boot | premier démarrage | |
| shutdown | arrêt | |
| graceful shutdown | arrêt propre | |
| power loss | perte d'alimentation | |
| blackout | coupure de courant | |
| power management | gestion de l'alimentation | |
| status LED | LED d'état | |
| monitoring | surveillance | |
| passive cooling | refroidissement passif | |
| filesystem | système de fichiers | |
| to unmount | démonter | |
| watchdog | chien de garde (watchdog) | Keep the English in parentheses once |
| standby | veille | |

### Software and networking

| English | French | Note |
|:--------|:-------|:-----|
| firmware | firmware | Not *micrologiciel* — matches the Finnish decision to keep the term the trade uses |
| daemon | démon | Established in French Linux usage, unlike Finnish |
| to flash | flasher | |
| operating system image | image système | |
| headless | sans écran | First mention: `sans écran (headless)` |
| container app | application conteneurisée | |
| container image | image de conteneur | |
| dashboard | tableau de bord | |
| WiFi Access Point | point d'accès WiFi | |
| wired / wireless | filaire / sans fil | |
| credentials | identifiants | |
| default password | mot de passe par défaut | |
| single sign-on (SSO) | authentification unique (SSO) | |
| Certificate Authority (CA) | autorité de certification (CA) | |
| web interface | interface web | |
| browser | navigateur | |

### Applications and use cases

| English | French | Note |
|:--------|:-------|:-----|
| chart plotter | traceur de cartes | |
| data logging | enregistrement de données | |
| vessel | navire | |
| fleet management | gestion de flotte | |
| predictive maintenance | maintenance prédictive | |
| remote monitoring | surveillance à distance | |
| compliance | conformité | |
| warranty | garantie | |

## SH-RPi terms

SH-RPi is a power management HAT, so its vocabulary is HALPI2's power and
shutdown language plus the mechanics of stacking boards on a Raspberry Pi. Rows
above this heading are shared with HALPI2 and are not changed here alone.

### The board and the stack

| English | French | Note |
|:--------|:-------|:-----|
| HAT | HAT | Never translated. Masculine: `le HAT`, `un HAT`. Write `la carte HAT` when a noun is needed, and keep two-word product names intact and in order: `le CAN HAT`, never *le HAT CAN* |
| add-on board | carte d'extension | The CAN, RS485 and GNSS HATs collectively. English also writes *add-on card* and *add-on hardware*; one French term for all three |
| to stack (boards) | empiler | `empiler les cartes sur le Raspberry Pi`. The assembled stack is `la pile de cartes` — never *la pile* alone, which reads as a battery |
| stack-through header | connecteur traversant | The tall 40-pin header whose pins pass through to a board above. The source also spells it *stackthrough*; one French term for every spelling |
| stacking header | connecteur traversant | The same physical part under its generic name. Do not introduce a second French name for it |
| standoff | entretoise | |
| hex standoff | entretoise hexagonale | `entretoises hexagonales de 6 mm`, `de 16 mm` |
| mounting screw | vis de fixation | `vis M2,5`, `vis M3` — decimal comma in the size too |
| solder jumper | pont à souder | **Not** *cavalier*. See the warning note below |
| jumper | cavalier | Inherited from HALPI2. Removable, sits on a pin pair |
| jumper header | connecteur à cavaliers | The pin field a jumper sits on — current limiter header, `PROG` header |
| pin | broche | Inherited. `connecteur 2x20 broches`, `broche GPIO4` |
| base plate | plaque de base | The perforated plate inside the enclosure. Not the CM4 *base board*, which is `carte de base` (a `carte porteuse` in the general sense) — the English source uses both words on the same page |
| vertical mount | support vertical | The black plastic part that holds the stack upright |

### Enclosure work

| English | French | Note |
|:--------|:-------|:-----|
| cable gland | presse-étoupe | Inherited. `presse-étoupe PG7`, `presse-étoupe PG9` |
| panel connector | connecteur de panneau | Mounted through a drilled hole in the enclosure wall |
| step drill bit | foret étagé | The source's "small metal Christmas tree" comparison translates literally and is worth keeping |
| pilot hole | avant-trou | Inherited |
| heat shrink tubing | gaine thermorétractable | Inherited (`heat-shrink tubing`); the source drops the hyphen in places |
| zip tie / tie wrap | collier de serrage | Same part as the inherited `cable tie` row — the English source uses three names for one thing. Do not invent three French ones |
| double-sided tape | ruban adhésif double face | |

### Power and shutdown

| English | French | Note |
|:--------|:-------|:-----|
| supercapacitor / supercap | supercondensateur | Matches HALPI2's `super-capacitor`. The English writes it three ways; French uses one word |
| supercapacitor bank | banc de supercondensateurs | The three cells acting as one reservoir |
| power management | gestion de l'alimentation | Inherited |
| safe shutdown | arrêt sécurisé | The product promise: the Pi shuts down before the power runs out |
| graceful shutdown | arrêt propre | Inherited. Distinct from `arrêt sécurisé`: this one is about the operating system's own orderly exit |
| to power down | mettre hors tension | |
| power-off | mise hors tension | The config key `poweroff` and the overlay `gpio-poweroff` stay as written |
| watchdog | chien de garde (watchdog) | Inherited: keep the English in parentheses on first mention per page, then `chien de garde` alone. Finnish keeps the English throughout — the divergence is deliberate |
| watchdog timer | temporisateur chien de garde | |
| heartbeat | signal de vie (heartbeat) | The periodic signal the daemon sends; its absence for 10 s triggers a reboot |
| blackout | coupure de courant | Inherited. Covers a total loss of input, however brief |
| brownout | creux de tension | A dip rather than a break. **Not** *chute de tension*, which this glossary already uses for `voltage drop` — a different phenomenon |
| hold-up time | temps de maintien | How long the supercapacitors keep the system running |
| charge / discharge | charge / décharge | |
| voltage threshold | seuil de tension | The 8,0 V and 5,0 V switching points |
| undervoltage | sous-tension | Below 10 V, to protect lead-acid batteries from deep discharge |
| overvoltage | surtension | The supercapacitor fault condition, LED pattern 7 |
| reverse polarity protection | protection contre l'inversion de polarité | |
| buck converter | convertisseur abaisseur (buck) | See the buck/boost note below |
| step-down converter | convertisseur abaisseur | Same component as `buck converter`; the source alternates between the two names |
| current limiter | limiteur de courant | The component |
| current limit | limite de courant | The setting — 0,8 A, 1,8 A or 2,8 A. The act is `limitation de courant`, inherited |
| transient voltage suppressor | suppresseur de transitoires (TVS) | The 33 V part at the input |
| choke | self | `une self` — the inductor in the input filter, not *étranglement* |
| pi-filter | filtre en pi | |
| real-time clock (RTC) | horloge temps réel (RTC) | Inherited; keep `RTC` for later mentions, as the source does |
| backup battery | pile de sauvegarde | Inherited, and correct for the CR1220 on the SH-RPi. **Wrong for the GNSS HAT's ML1220** — see the note below |
| rechargeable / non-rechargeable | rechargeable / non rechargeable | Never abbreviate or drop the adjective. See the note below |

### Software

| English | French | Note |
|:--------|:-------|:-----|
| microcontroller | microcontrôleur | The onboard ATtiny1616 |
| daemon | démon | Inherited from HALPI2. Finnish keeps `daemon`; French does not need to |
| service (systemd) | service | `le service shrpid`, `activer le service` |
| installation script | script d'installation | |
| configuration file | fichier de configuration | `/etc/shrpid.conf` |
| device tree overlay | overlay de device tree | Left in English, as French Raspberry Pi practice does. `dtoverlay=` lines are copied verbatim |
| firmware | firmware | Inherited. Not *micrologiciel* |
| to flash | flasher | Inherited. `flasher la mémoire eMMC`, `le flashage` for the process |
| headless | sans écran | Inherited. First mention: `sans écran (headless)`. The OpenPlotter *Headless image* keeps its English product name |
| image (OS image) | image système | Inherited |
| REST API | API REST | `API` is feminine: `une API REST` |
| file socket | socket fichier | `un socket` (masculine). The path `/var/run/shrpid.sock` is never translated |

### A note on `HAT`

`HAT` is the Raspberry Pi Foundation's term and it is printed on the boards, so
it is never translated. It is treated as masculine in French — `le HAT`, `ce
HAT` — and when a noun is wanted, `la carte HAT` reads better than `le HAT` on
its own. The two-word product names stay in English word order: `le CAN HAT`,
`le RS485 HAT`, `le GNSS HAT`, never *le HAT CAN*. Do not add a hyphen inside
them either; that is the German convention and it is wrong in French.

### A note on `header` and `connecteur`

The inherited glossary maps both `connector` and `header` to `connecteur`. That
was harmless on HALPI2 but SH-RPi leans on the distinction: the same page tells
the reader to place jumpers on the *current limiter header* and never to plug
power into the *5V output connector*. Keep the inherited row, and where a
sentence would be ambiguous, qualify it — `le connecteur à cavaliers du
limiteur de courant`, `le connecteur d'entrée d'alimentation` — rather than
inventing a rival term for `header`.

### A note on `pont à souder` versus `cavalier`

These are two different objects and the reader acts on them with different
tools. Confusing them sends someone looking for a knife they do not need, or
trying to pull off a link that is soldered down.

- A **`pont à souder`** (solder jumper) is a pair of pads on the board,
  permanently joined. On the SH-RPi the `RTC EN` jumper is closed from the
  factory and is opened **by cutting the traces between the pads with a sharp
  knife**; `GPIO4 Enable` is the opposite case, opened from the factory and
  closed by bridging the pads. Both are irreversible in practice.
- A **`cavalier`** (jumper) is a removable shunt that sits on a pin pair. The
  current limiter header takes them, the `PROG` header takes them, and the CAN
  and RS485 HATs use them for the termination resistors. They come off with
  fingers.

Never write `cavalier` for a solder jumper, and never write `pont à souder`
where the reader is meant to move a removable one. When the source says *cut the
traces*, translate it as *coupez les pistes* — `piste` is the trace on the
board, not the pad (`plage`, `pastille`).

### A note on the rechargeable backup battery

French `pile` means a primary, non-rechargeable cell. The inherited `backup
battery` → `pile de sauvegarde` row is therefore right for the SH-RPi's own
CR1220 — but **actively wrong for the GNSS HAT**, whose ML1220 is a rechargeable
lithium cell sitting on a charging circuit.

On the GNSS HAT page write `batterie de sauvegarde rechargeable ML1220` or
`accumulateur ML1220`, never `pile`. The warning there is a safety warning, not
a preference: replacing the ML1220 with a non-rechargeable cell risks explosion
and fire, and the source states it in those words.

Keep the opposition unmistakable in every sentence that carries it:

> La pile de sauvegarde est de type ML1220. Il s'agit d'un accumulateur au
> lithium **rechargeable** ; elle ne doit **jamais** être remplacée par une pile
> **non rechargeable**. Risque d'explosion et d'incendie !

Write `non rechargeable` in two words without a hyphen, and keep both adjectives
in bold where the source emphasises them. Do not compress the pair into
something like *pile classique* — the contrast is the entire content of the
warning.

### A note on `buck` and `boost`

Every converter on the SH-RPi is a step-down converter. The English source names
the second stage a **boost converter twice** in `hardware/index.md` ("enables
the boost converter", "disables the boost converter") where it means the buck
converter — an error raised in issue #25.

**Translate what the English says.** Where the source writes *boost*, write
`convertisseur élévateur`; do not silently correct it, because a corrected
translation and an uncorrected source disagree in a way no reviewer can trace.
This row exists to record that the intended sense is *step-down*
(`convertisseur abaisseur`), so that when issue #25 is fixed the French page is
updated in the same change rather than looking like a translation error.

## Verification

A translated page is not done until:

1. `uv run mkdocs build --strict` passes — the same command CI runs.
2. `uv run check-typography` passes for `fr`. French is the
   one language that *requires* the space before `; : ! ?`, and the checker
   knows it — a plain U+0020 there is reported.
3. `uv run check-glossary fr` passes: every term this glossary
   prescribes and the English pages actually use appears in the French.
4. `uv run check-anchors site` passes.
5. `uv run mkdocs serve` shows the page rendering correctly, with lists as lists
   — always leave a blank line before and after a list.
6. Every term used on the page that appears in this glossary matches it.

## Related

- `finnish-glossary.md` — the sibling glossary and the general approach
- `../../check-glossary`, `../../check-typography` — the
  two checks that read this file
- mkdocs-static-i18n documentation: https://ultrabug.github.io/mkdocs-static-i18n/
