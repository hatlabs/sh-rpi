---
title: Norwegian Bokmål translation glossary and style rules (SH-RPi)
date: 2026-08-05
category: translation
module: documentation
problem_type: reference
component: documentation
severity: medium
applies_when:
  - Translating any page from docs/en/ into Norwegian Bokmål under docs/nb/
  - Reviewing a Norwegian Bokmål translation for consistency
  - Adding a new term that has no established Norwegian Bokmål equivalent
tags:
  - translation
  - i18n
  - norwegian
  - bokmal
  - terminology
  - mkdocs-static-i18n
---

# Norwegian Bokmål translation glossary and style rules

## Context

The SH-RPi documentation is written in English under `docs/en/` and translated
into Norwegian Bokmål under `docs/nb/`, using the `mkdocs-static-i18n` folder
structure. Each language directory mirrors the same tree, so a translation keeps
its source's path and filename: `docs/en/hardware/index.md` becomes
`docs/nb/hardware/index.md`. Nearly every page is a section directory with a
single `index.md` in it. Only markdown lives under `docs/nb/`; images and other
assets stay with the English source and are shared, including the nested
`assets/` directories under `revisions/` and `tutorials/openplotter-server/`.

**This file began as a copy of the HALPI2 Norwegian Bokmål glossary and
deliberately keeps its decisions.** SH-RPi and HALPI2 are both Raspberry Pi
power boards with supercapacitors, a shutdown daemon, a watchdog and a
real-time clock, so a reader who knows one should meet the same Norwegian words
in the other. `carrier board` → `bærekort`, `watchdog` → `watchdog` and
`daemon` → `daemon` are decisions made there and they stand here unchanged.
Everything above the `## SH-RPi terms` heading is shared with HALPI2: **a shared
row changes in both repositories or in neither.** Terms below that heading are
this product's own additions and are edited here alone.

The HALMET glossary was not used as the base even though HALMET is also a Hat
Labs board: its additions are all sensor-input vocabulary — analog and digital
inputs, galvanic isolation, a constant current source — and not one of those
words occurs in the SH-RPi documentation. That was measured against the English
pages, not assumed. HALPI2's additions, by contrast, are the supercapacitor,
shutdown, watchdog and firmware vocabulary this product is made of.

Translations are produced page by page, at different times, potentially by
different people. Without a fixed terminology list the same English term drifts
across pages — *stack-through header* becomes `gjennomgående pinneliste` on one
page and `stablekontakt` on the next — and the result reads as machine output
even when each individual sentence is correct. This file is the reference that
prevents that drift, and it is a living document: extend it when a page
introduces a term that is not listed here, rather than inventing a one-off
translation.

Unlike a dated solution note, this file has no date in its filename because it
is meant to be edited in place, not superseded.

## Six rules where the siblings are wrong for Norwegian Bokmål

Read this section before anything else. Every one of these is stated the
opposite way in at least one sibling glossary. Danish is the dangerous
neighbour: it is close enough to read as correct and is being written against
the same English source, so a Danish habit that slips in will not look wrong to
anyone who is not counting. `scripts/check_glossary.py` already registers `da`
alongside `nb`, and machine translation produces Danish-shaped Norwegian on its
own, so the rule holds whether or not a Danish page exists yet.

1. **Quotation marks are `«…»`, pointing inward.** Norwegian opens with `«` and
   closes with `»`. **Danish is the exact opposite** — Danish opens with `»` and
   closes with `«`. Not Swedish's `”…”`, not German's `„…“`, not straight
   `"…"`. And unlike French, **no space inside the guillemets**: write
   `«hjerteslag»`, never `« hjerteslag »`.

2. **Address the reader as `du`.** Norwegian technical and consumer
   documentation uses `du`. French uses *vouvoiement* and German uses *Sie* —
   both wrong here. `Koble til strømkabelen.` / `Kontroller polariteten med
   multimeteret før du slår på spenningen.` The formal `De`/`Dem`/`Deres` must
   not appear at all.

3. **No space before `; : ! ?`** — as in German and Swedish, and unlike French,
   whose rule is the exact opposite and demands a no-break space.

4. **Compounds are written solid, as one word.** `strømforsyning`,
   `kabelgjennomføring`, `superkondensator`, `bærekort`, `spenningsfall`,
   `nedstenging`. Splitting a compound in two (*særskriving*, `strøm
   forsyning`) is the single most visible error in written Norwegian and is what
   English word order invites. English `power supply` is two words; Norwegian is
   one.

5. **Compounding with a proper name takes one hyphen at the junction, not
   throughout.** Norwegian writes `NMEA 2000-nettverk`, `Signal K-server`,
   `Raspberry Pi-antenne`, `SH-RPi-kortet`, `CAN HAT-kontakten`. German writes
   `NMEA-2000-Netzwerk` — hyphens all the way through. Copying the German
   pattern is wrong, and copying English spacing (`NMEA 2000 nettverk`) is also
   wrong.

6. **Norwegian spelling, not Danish.** The pairs below are the ones this corpus
   actually produces. Left is Norwegian and required; right is Danish and must
   not appear.

   | Norwegian Bokmål | Danish — never write this |
   |:-----------------|:--------------------------|
   | konfigurasjon, installasjon, informasjon, funksjon, terminering | konfiguration, installation, information, funktion |
   | å koble til (infinitive marker `å`) | at tilslutte (infinitive marker `at`) |
   | bare | kun |
   | nå | nu |
   | noen | nogen |
   | mye | meget |
   | enn | end |
   | etter | efter |
   | sette, hjelp, endre | sætte, hjælp, ændre |
   | sjekk | tjek |
   | forbindelsene, kablene (definite plural `-ene`) | forbindelserne, kablerne (`-erne`) |
   | bærekort | bæreprint |

   `kun` is not ungrammatical in Bokmål, but it is the Danish default. Banning
   it here costs nothing and makes a leak from the Danish branch visible in one
   `grep`.

## Names that are never translated

Product names, protocol names, hardware standards and software UI strings stay
in English — the device's own interface is in English, so translating a menu
name would send the reader looking for something that does not exist on screen.

- **Products and software:** SH-RPi, Sailor Hat, HALPI2, Signal K, OpenPlotter,
  Raspberry Pi OS, Waveshare, PlatformIO, Node-RED, Grafana, Hat Labs
- **Hardware and standards:** Raspberry Pi, Compute Module 4 (CM4), HAT,
  ATtiny1616, PCF8563, CAN, NMEA 2000, NMEA 0183, RS485, GNSS, I2C, SPI, UPDI,
  GPIO, USB, microSD, PoE. The add-on boards keep their product names exactly:
  **CAN HAT**, **RS485 HAT**, **GNSS HAT**.

**Board labels and pin names are copied as printed on the board**, in the case
the silk screen uses: `PROG`, `RTC EN`, `GPIO4 Enable`, `BOOT`, `2A`, `3A`,
`CAN0`, `CAN1`, `GND`, `3V3`. A reader comparing the page against the board is
looking for those exact characters. Name the function in Norwegian around the
label if it helps — `loddebroen RTC EN`, `raden merket 2A` — but never
translate the label itself.

**Commands, file paths, configuration keys and code stay in English**, verbatim:
`shrpi print`, `shrpi set watchdog 0`, `shrpi sleep 3600`, `shrpid`,
`/etc/shrpid.conf`, `/var/run/shrpid.sock`, `raspi-config`,
`/boot/firmware/config.txt`, `/boot/cmdline.txt`, `dtoverlay`, `dtparam`,
`can0`, `/dev/ttyAMA0`, `/dev/ttySC0`, `hciuart`, `avrdude`, `rpiboot`,
`platformio.ini`. Code fences, command output, URLs and image filenames are
never touched.

## Units and numbers

Same handling as the other languages — the English source writes `12V` and
`0.9A`, and both are wrong in Norwegian.

| English source | Norwegian Bokmål |
|:---------------|:-----------------|
| `12V`, `0.9A` | `12 V`, `0,9 A` |
| `5.5 x 2.1 mm` | `5,5 × 2,1 mm` |
| `-20°C to +60°C` | `−20 °C … +60 °C` |
| `120Ω` | `120 Ω` |
| `3-5A` | `3–5 A` (en dash for ranges) |
| `9-32V`, `10-32 V` | `9–32 V`, `10–32 V` |
| `200×130×60 mm` | `200 × 130 × 60 mm` |
| `2m`, `45mm`, `2kg` | `2 m`, `45 mm`, `2 kg` |
| `20F`, `3.0 V` | `20 F`, `3,0 V` |

**Do not insert a thousands separator.** `115200 bps` and `3600` stay exactly as
in the source. Norwegian typography would allow a no-break space, but the
verification step compares every number in the English text against the
translation, and `115 200` no longer matches `115200`. Digits are copied, not
reformatted — only the decimal separator and the unit spacing change.

Decimal comma everywhere in prose, decimal point never — except inside inline
code and version numbers, which are copied verbatim (`v2.0.0`, `M2.5`, `M3`,
`0x6d`).

## Links, images, admonitions, navigation

Same as the sibling glossaries: paths are copied from the English source
unchanged and never carry an `en/`, `nb/` or other language segment; image
captions and alt texts are translated but filenames are not; screenshots stay
English because the reader's own screen is English; standard admonition titles
are translated centrally in `mkdocs.yml`, custom ones in the page.

Admonition titles used centrally: `note` → Merk, `warning` → Advarsel, `tip` →
Tips, `info` → Informasjon, `danger` → Fare, `example` → Eksempel.

Navigation titles live in `mkdocs.yml` under the i18n plugin's
`nav_translations` and are the single source of truth; the list is not restated
here. Two entries are judgement calls worth recording: `Errata` → **Kjente
feil**, the same rendering HALPI2 uses for its errata page, so the H1 and the
sidebar agree; and `FAQ` → **Ofte stilte spørsmål**, spelled out, because the
abbreviation `OSS` is far less established in Norwegian than `FAQ` is in
English and reads as a pronoun on a sidebar.

## Glossary

### Enclosure, mounting, and installation

| English | Norwegian Bokmål | Note |
|:--------|:-----------------|:-----|
| carrier board | bærekort | The accurate term, as in Swedish, French and German — see the note below |
| enclosure | kabinett | Not *hus*; *kabinett* is what an electronics box is called |
| lid | lokk | |
| gasket | pakning | |
| heat sink | kjøleribbe | |
| waterproof | vanntett | |
| wall-mount | veggmontering | |
| mounting surface | monteringsflate | |
| pilot hole (to drill) | forbore (verb) | `Forbor hullene for monteringsskruene` — an action the reader performs |
| pre-drilled hole (already there) | ferdigboret hull | The holes the enclosure ships with. Never write `forbor de ferdigborede hullene` — that is the nonsense the Swedish branch shipped |
| mounting template | boremal | |
| bilge water | lensevann | As in *lensepumpe*; not *bunnvann* |
| bulkhead | skott | |
| cable gland | kabelgjennomføring | The PG7 parts specifically may be called `kabelnippel` when the physical part is meant |
| cable routing | kabelføring | |
| service loop | servicesløyfe | Slack left at both cable ends |
| cable tie | kabelstrips | |
| blind plug | blindplugg | |
| breather plug | trykkutjevningsplugg | |
| standoff | avstandsbolt | |
| threaded insert | gjengeinnsats | |
| thermal pad | varmeledende pute | |
| spudger | plastspade | Non-conductive prying tool |

**A note on `bærekort`.** Norwegian takes the accurate term, like Swedish
(`bärkort`), French (`carte porteuse`) and German (`Trägerplatine`), and unlike
Finnish (`emolevy`, literally *motherboard*, chosen there for reader
familiarity). The divergence between the languages is deliberate, decided per
language and per audience. Do not harmonise them.

`bærekort` carries the module/board relationship on its own, so passages about
a Compute Module that will not boot need no extra explanation. Only the Finnish
glossary needs that warning.

Danish would form this as `bæreprint` (Danish uses *print* for a circuit board).
Norwegian does not: the Norwegian word for a circuit board is `kretskort`, so
the compound is `bærekort`.

### Power and electrical

| English | Norwegian Bokmål | Note |
|:--------|:-----------------|:-----|
| power supply | strømforsyning | The external unit itself: *strømadapter* |
| input voltage range | inngangsspenningsområde | |
| polarity | polaritet | |
| fuse | sikring | |
| inline fuse | linjesikring | |
| circuit breaker | automatsikring | The panel breaker on the boat's electrical panel |
| current limiting | strømbegrensning | `strømbegrensningsbryter` for the switch |
| overcurrent | overstrøm | |
| voltage drop | spenningsfall | |
| grounding | jording | |
| short circuit | kortslutning | |
| wire gauge | ledertverrsnitt | Norwegian uses mm², not AWG |
| marine-grade wire | kabel av marin kvalitet | |
| wire strippers | avisoleringstang | |
| crimping | krimping | See the note below — *not* `krymping` |
| crimper | krimptang | |
| heat-shrink tubing | krympestrømpe | |
| heat gun | varmepistol | |
| multimeter | multimeter | |
| terminal block | koblingsklemme | In this documentation always the pluggable screw terminal on the board, not a DIN-rail *rekkeklemme* |
| strain relief | strekkavlastning | |
| super-capacitor | superkondensator | |
| real-time clock | sanntidsklokke | |
| backup battery | reservebatteri | On HALPI2 the CR2032 for the RTC; on SH-RPi the CR1220, and the ML1220 on the GNSS HAT |
| backup power | reservestrøm | What the super-capacitors deliver |
| voltage rail | spenningsskinne | `3,3 V-skinnen`, `5 V-skinnen` |

**A note on `krimping` versus `krymping`.** Norwegian trade usage says both, and
that is exactly the problem: `krympe` also means *to shrink*, and this
documentation talks about heat-shrink tubing (`krympestrømpe`) two lines from
where it talks about crimping terminals. `krimping`/`krimptang` for the crimp
and `krymping`/`krympestrømpe` for the heat-shrink keeps the two apart on the
page. Do not "correct" one into the other.

### Connectors and interfaces

| English | Norwegian Bokmål | Note |
|:--------|:-----------------|:-----|
| connector | kontakt / tilkobling | *kontakt* for the physical part, *tilkobling* for the act of connecting |
| barrel connector | DC-plugg | First mention: `DC-plugg (barrel)` |
| header | pinneliste | `40-pinners GPIO-pinneliste` |
| pin | pinne | |
| pitch | senteravstand | `3,81 mm senteravstand` |
| backbone | backbone | Established in Norwegian NMEA 2000 usage |
| drop cable | stikkledning | Dealer catalogues also say *dropkabel*; this documentation uses *stikkledning* throughout |
| T-connector | T-kobling | The source also writes *T-adapter*; translate both as `T-kobling` |
| terminator (the component) | termineringsmotstand | The 120 Ω resistor and its jumper |
| termination (the state) | terminering | `Kontroller at nettverket er riktig terminert` |
| front panel | frontpanel | |
| jumper | jumper | The physical shunt; `loddebro` for a solder jumper |
| male / female | hann / hun | `hannkontakt`, `hunkontakt` |
| flexible flat cable (FFC) | flatkabel | Keep `(FFC)` on first mention |
| silk screen | silketrykk | |

### Operation and system behaviour

| English | Norwegian Bokmål | Note |
|:--------|:-----------------|:-----|
| boat computer | båtdatamaskin | |
| to boot | starte opp | |
| first boot | første oppstart | |
| shutdown | nedstenging | |
| graceful shutdown | kontrollert nedstenging | |
| to shut down | slå av / stenge ned | |
| power loss | strømbortfall | The event: input power disappears |
| blackout | strømbrudd | The interval the blackout timer measures: `strømbruddstimer` |
| power management | strømstyring | |
| status LED | status-LED | |
| monitoring | overvåking | Not the Swedish *övervakning* |
| passive cooling | passiv kjøling | |
| filesystem | filsystem | |
| to unmount (a filesystem) | avmontere | `filsystemene avmonteres trygt` |
| to unmount (hardware, remove a module) | demontere | Removing a module or the board is *demontering*, never *avmontering* |
| watchdog | watchdog | `watchdog-tidsavbrudd` |
| standby | ventemodus | The computer is off while the controller stays awake — not *hvilemodus*, which is sleep |
| power button | strømknapp | |
| reset button | resetknapp | |
| solo mode / co-op mode | solomodus / samspillsmodus | Keep the English in parentheses on first mention |

### Software and networking

| English | Norwegian Bokmål | Note |
|:--------|:-----------------|:-----|
| firmware | firmware | Not *fastvare* — matches the sibling decision to keep the trade term |
| daemon | daemon | `shrpid`-daemonen; not *tjeneste*, which is a systemd service |
| to flash | flashe | `flashe systembildet til microSD-kortet` |
| system image | systembilde | Also for *operating system image* |
| container image | containerbilde | |
| container app | containerapp | |
| headless | uten skjerm | First mention: `uten skjerm (headless)` |
| dashboard | dashbord | The UI itself says *Dashboard* in English — keep that when naming the on-screen label |
| WiFi Access Point | WiFi-aksesspunkt | |
| wired / wireless | kablet / trådløs | |
| credentials | påloggingsinformasjon | |
| default password | standardpassord | |
| single sign-on (SSO) | enkel pålogging (SSO) | |
| Certificate Authority (CA) | sertifikatutsteder (CA) | |
| web interface | webgrensesnitt | |
| browser | nettleser | |
| to log in | logge på | |
| update | oppdatering | |
| device tree overlay | device tree-overlay | Keep the English term; it names a file the reader edits |

### Applications and use cases

| English | Norwegian Bokmål | Note |
|:--------|:-----------------|:-----|
| chart plotter | kartplotter | |
| data logging | datalogging | |
| vessel | fartøy | |
| fleet management | flåtestyring | |
| predictive maintenance | prediktivt vedlikehold | |
| remote monitoring | fjernovervåking | |
| compliance | samsvar | As in *samsvarserklæring* |
| warranty | garanti | |

## SH-RPi terms

SH-RPi is a power management HAT, so its vocabulary is HALPI2's power, shutdown
and firmware language plus the mechanics of stacking boards on a Raspberry Pi
and building them into an enclosure. Rows above this heading are shared with
HALPI2 and are not changed here alone; rows below are this product's own.

### The board and the stack

| English | Norwegian Bokmål | Note |
|:--------|:-----------------|:-----|
| HAT | HAT | Never translated — the Raspberry Pi Foundation's term, printed on the boards. Compounds with a junction hyphen: `HAT-kort`, `HAT-kontakt`, `HAT-stabelen`, and `CAN HAT-kontakten` for the two-word product names (Norwegian hyphenates at the junction where Finnish needs a space) |
| add-on board | tilleggskort | The CAN, RS485 and GNSS HATs collectively. The nav section *Add-on Hardware* is `Tilleggsmaskinvare` |
| to stack (boards) | stable | `kortene stables oppå hverandre`; `stables oppå Sailor Hat-kortet` |
| PCB stack | kortstabel | The assembled column of boards the enclosure procedure handles as one object |
| stack-through header | gjennomgående pinneliste | The tall 40-pin header that carries GPIO through to the board above. First mention: `gjennomgående pinneliste (stack-through)`. The source spells it *stack-through*, *stackthrough* and *stack-through connector*; all three are the same supplied part and take this rendering |
| stacking header | stablebar pinneliste | The generic category. Use it only where the English distinguishes it from the supplied stack-through part; do not let the two renderings suggest two different components |
| spacer (of the stack-through header) | avstandsstykke | The removable plastic body on the stack-through header, removed when SH-RPi sits directly on the Raspberry Pi. Not the same part as `avstandsbolt` (standoff) |
| standoff | avstandsbolt | Inherited from HALPI2 |
| hex standoff | sekskantet avstandsbolt | The M2.5 6 mm and 16 mm parts; `sekskantet` is what tells the reader which one is in the bag |
| mounting screw | monteringsskrue | The M2.5 and M3 screws; `monteringsskruene` in the plural |
| solder jumper | loddebro | Inherited from HALPI2's connector table. **Permanent**: on SH-RPi it is opened by cutting the traces between the pads with a sharp knife, or closed by joining them. See the note below |
| jumper | jumper | Inherited: the removable shunt placed across a pin pair. See the note below |
| jumper header | jumperliste | The pin rows a jumper sits on. Name the specific one by function or label: `pinnelisten for strømbegrensning`, `PROG-listen` |
| pin | pinne | Inherited. `40-pinners GPIO-pinneliste`; `2×20 pinner` |
| pad (solder pad) | loddeflate | The exposed copper the knife works between |
| trace | ledningsbane | `kutt ledningsbanene mellom loddeflatene`; plain `bane` on repetition |
| to cut (a trace or a pin) | kutte | Also for the stack-through pin cut on the GNSS HAT page. Not *skjære* |
| terminal plug | skrueplugg | The pluggable Phoenix MC screw plug in the box; the socket on the board is the inherited `koblingsklemme` |
| base plate | bunnplate | The perforated plate in the enclosure that the stack is screwed to. **Not** *base board* — see the note below |
| vertical mount | vertikalfeste | The black plastic parts that hold the stack on edge |
| single-board computer | enkortsdatamaskin | Raspberry Pi and its equivalents, in the introduction |
| isolated (interface) | galvanisk skilt | The CAN and RS485 HATs; the property is `galvanisk skille` |
| eMMC flash memory | eMMC-flashminne | The CM4's onboard storage, opposed to the microSD card |

### Enclosure and installation

| English | Norwegian Bokmål | Note |
|:--------|:-----------------|:-----|
| cable gland | kabelgjennomføring | Inherited. The physical PG7/PG9 part may be `kabelnippel`; the plug that seals an unused one is `blindplugg` |
| panel connector | panelkontakt | The SP13, M12, RJ45 and USB parts mounted through the enclosure wall |
| pilot hole / pre-drilled hole | forbore (verb) / ferdigboret hull | Inherited pair. `kabinett uten ferdigborede hull`; never `forbor de ferdigborede hullene` |
| step drill bit | trinnbor | The stepped bit for aluminium and polycarbonate |
| water ingress | vanninntrengning | What the downward-facing connectors are meant to prevent |
| heat shrink tubing | krympestrømpe | Inherited. Slide it on **before** soldering — `krymping`, never `krimping`; see the crimping note above |
| zip tie / tie wrap | kabelstrips | The source uses both English words for the same part; Norwegian uses one |
| double-sided tape | dobbeltsidig tape | For the 40 mm fan; `varmlim` for the hot glue alternative |

### Power, protection and shutdown

| English | Norwegian Bokmål | Note |
|:--------|:-----------------|:-----|
| supercapacitor / supercap | superkondensator | Inherited (`super-capacitor`). The source writes it both long and short; Norwegian uses one word |
| supercapacitor bank | superkondensatorbank | The three 20 F cells taken together — a single reservoir, as the source treats it |
| power management | strømstyring | Inherited. `strømstyringskort` for the board itself |
| safe shutdown | trygg nedstenging | The product promise in the introduction |
| graceful shutdown | kontrollert nedstenging | Inherited from HALPI2 |
| to power down | slå av | The act of removing power, as opposed to the operating system's `stenge ned` |
| power-off | strømutkobling | The moment the 5 V output is cut. Matches HALPI2's `utkoblingsterskel`; the `poweroff` key and `gpio-poweroff` overlay are code and stay as written |
| watchdog | watchdog | Inherited: kept in English |
| watchdog timer | watchdog-timer | `timer` as the Norwegian noun, as in HALPI2's `strømbruddstimer`. `watchdog-tidsavbrudd` for the timeout, `watchdog-omstart` for the reboot it triggers |
| heartbeat | hjerteslag | The periodic signal the daemon sends. The English sets it in quotes as jargon; keep that on first mention inside Norwegian guillemets — `«hjerteslag» (heartbeat)` — then write `signalet`. Avoid the compound *hjerteslagsignal*, which collapses two s-sounds and reads badly |
| blackout | strømbrudd | Inherited. The measured interval is `strømbruddstid`; `blackout-time-limit` and `blackout-voltage-limit` are configuration keys and stay in English |
| brownout | spenningsdipp | A dip, not a break. Deliberately **not** `spenningsfall`, which the inherited table already assigns to voltage drop across a conductor |
| power glitch | kortvarig strømbortfall | The short interruptions the supercapacitors ride out. Built on HALPI2's `strømbortfall` |
| hold-up time | holdetid | How long the supercapacitors keep the system running — the 70 seconds for a Pi 4B |
| charge / discharge | lading / utlading | Verbs `lade` / `utlade`; `ladetilstand` for the LED bar's charge state |
| voltage threshold | spenningsterskel | The 8,0 V and 5,0 V limits; `innkoblingsterskel` / `utkoblingsterskel` for the pair, as in HALPI2 |
| undervoltage | underspenning | Below 10 V, to protect lead-acid batteries from deep discharge |
| overvoltage | overspenning | The supercapacitor fault the rapid blink pattern reports |
| deep discharge | dyputlading | The lead-acid damage the undervoltage limit prevents |
| reverse polarity protection | beskyttelse mot omvendt polaritet | The component is `diode for beskyttelse mot omvendt polaritet`. Written as a phrase; the solid compound is unreadable |
| buck converter | buck-omformer | Inherited from HALPI2, where it names the SiC463ED. See the note below |
| step-down converter | step-down-omformer | The first stage, `step-down (buck)` in the source. See the note below — the English also says *boost* twice, and that is a source error, not a second component |
| current limiter | strømbegrenser | The circuit; `strømbegrensning` is the inherited term for the function |
| current limit | strømgrense | The value: 0,8 A, 1,8 A, 2,8 A. Inherited from HALPI2's USB table |
| transient voltage suppressor | transientbeskyttelse | The 33 V part at the input; `TVS-diode` when the component itself is meant |
| choke | drosselspole | The inductor in the input filter |
| pi-filter | pi-filter | Kept as written, like `device tree-overlay` |
| electromagnetic interference | elektromagnetisk støy | What the choke and pi-filter suppress; `ledningsbundet støy` for the conducted kind |
| sleep / sleeping (board state) | hvilemodus | The state the LED table calls *Sleeping*: 5 V off, waiting for an RTC alarm. HALPI2 reserves `ventemodus` for standby and says explicitly that `hvilemodus` means sleep — here the state really is sleep, so the two rows agree rather than clash |
| to wake up | våkne / vekke | `våkner automatisk når strømmen kommer tilbake`; the event is `oppvåkning` |
| LED bar / bar display | LED-søyle | The four LEDs read as a charge indicator. HALPI2 calls the same pattern `spenningssøyle`; use `LED-søyle` where the source says *bar display* and keep `søyle` as the shared word |
| blink pattern | blinkemønster | The column heading in the status LED table; `lyser fast` for a steady LED, as in HALPI2 |

### Timekeeping and battery

| English | Norwegian Bokmål | Note |
|:--------|:-----------------|:-----|
| real-time clock (RTC) | sanntidsklokke (RTC) | Inherited. Keep `(RTC)` on first mention, because the board label is `RTC EN` and the overlay is `i2c-rtc` |
| backup battery | reservebatteri | Inherited. CR1220 on SH-RPi, ML1220 on the GNSS HAT |
| coin cell | knappcelle | What the reader is holding when the orientation matters |
| rechargeable | oppladbart | The ML1220 on the GNSS HAT. See the note below |
| non-rechargeable | ikke-oppladbart | The CR1220 that must **not** go in the GNSS HAT holder. See the note below |
| ephemeris data | efemeridedata | What the GNSS backup battery preserves |
| GNSS fix | GNSS-posisjon | `tiden det tar å få GNSS-posisjon` |

### Software and firmware

| English | Norwegian Bokmål | Note |
|:--------|:-----------------|:-----|
| microcontroller | mikrokontroller | The ATtiny1616; the name itself is never translated |
| daemon | daemon | Inherited from HALPI2 — not *tjeneste*. `shrpid`-daemonen |
| service (systemd) | tjeneste | The systemd unit that runs the daemon. The English also writes *service software* for the package; that is the daemon, so keep the two words apart in Norwegian |
| to enable / disable (a service) | aktivere / deaktivere | `systemctl enable` and its argument stay in code |
| installation script | installasjonsskript | The `install-online.sh` the reader pipes to `sudo bash` |
| configuration file | konfigurasjonsfil | `/etc/shrpid.conf`; the option lines inside it are code |
| device tree overlay | device tree-overlay | Inherited: kept in English, because it names a line the reader types |
| firmware | firmware | Inherited: not *fastvare* |
| to flash | flashe | Inherited. Both the microcontroller over UPDI and the eMMC/microSD image |
| headless | uten skjerm | Inherited. First mention: `uten skjerm (headless)`. The OpenPlotter *Headless image* keeps its English product name |
| image (OS image) | systembilde | Inherited (`system image`). Also for the 64-bit OpenPlotter image |
| REST API | REST-API | Junction hyphen, as with any abbreviation compounded onto a noun |
| file socket | filsocket | `socket` stays English, as `firmware` does; the path `/var/run/shrpid.sock` and the `socket` / `socket-group` keys are code |
| command-line interface | kommandolinjegrensesnitt | The `shrpi` script; the commands themselves are never translated |
| serial console | seriekonsoll | What `console=serial0,115200` attaches, and what the UPDI procedure disables |
| boot mode | oppstartsmodus | Inherited from HALPI2. The CM4's switch label `BOOT` is copied as printed |

### A note on `loddebro` versus `jumper`

These two are not variants of the same thing, and the pages that use them are
warnings.

- **`loddebro` (solder jumper)** is permanent. `RTC EN` and `GPIO4 Enable` are
  solder jumpers: the reader disables the RTC by **cutting the traces between
  the pads with a sharp knife**, and enables GPIO4 by joining the pads. Write
  the action out — `kutt ledningsbanene mellom loddeflatene på loddebroen
  RTC EN` — so the tool is unmistakable.
- **`jumper`** is removable, a shunt pushed onto a pin pair: the current limiter
  header, the `PROG` header during firmware flashing, and the termination
  jumpers on the CAN and RS485 HATs. It is placed and pulled off with fingers.

Getting these two confused sends a reader for a knife they do not need, or has
them trying to pull a soldered link off the board. Never render `loddebro` as
`jumper` for brevity, and never write `loddebro` where the English says plain
*jumper*.

### A note on `oppladbart` versus `ikke-oppladbart`

The GNSS HAT's backup battery is a **rechargeable** ML1220, and the source says
that replacing it with a **non-rechargeable** cell carries a risk of explosion
and fire. The two words must be visibly opposed on the page: `oppladbart` and
`ikke-oppladbart`, differing by the prefix and nothing else. Do not reach for
`engangsbatteri` or `primærcelle` as the opposite of `oppladbart` — a synonym
weakens the contrast exactly where the reader must not skim. Keep the emphasis
the English has (`må **ikke** erstattes med et ikke-oppladbart batteri`), and
keep the battery designations `ML1220` and `CR1220` as printed, since they are
what the reader compares against the cell in their hand.

### A note on `buck`, `step-down` and the source's `boost`

Both converter stages on SH-RPi step voltage **down**: the first from the
9–32 V input to 8,8 V for the supercapacitor bank, the second from the
supercapacitor bank to 5 V for the Raspberry Pi.

The English hardware page nevertheless calls the second stage a *boost
converter* twice — "the microcontroller enables the boost converter" and
"disables the boost converter". That is an error in the English source, raised
as issue #25. **Translate what the English says** — `boost-omformer` — and do
not silently correct it; a translation that disagrees with its source in
technical content is a second defect, and it hides the first. Note it in the
pull request instead, and update this row when the English is fixed.

`buck-omformer` is HALPI2's inherited rendering and is the one to use where the
English says *buck*; `step-down-omformer` where it says *step-down*. Both rows
describe a step-down stage.

### A note on `bunnplate` versus `bærekort`

The English uses *base plate* and *base board* on pages a few paragraphs apart,
and they are different objects:

- **`bunnplate`** is the perforated metal plate inside the enclosure that the
  stack is screwed to (`getting-started`).
- **`bærekort`** is the carrier board a Compute Module 4 plugs into — the
  inherited HALPI2 row. The CM4 page's *base board* is this, not the plate.

In the assembly walkthrough, *base board* sometimes means simply the board below
in the stack; render that as `kortet under` rather than as either term above.

## Verification

A translated page is not done until:

1. `uv run mkdocs build --strict` passes — the same command CI runs.
2. `uv run python scripts/check_anchors.py site` passes.
3. `uv run python scripts/translation_status.py` shows the page as current.
4. `uv run python scripts/check_glossary.py nb` passes.
5. `uv run python scripts/check_typography.py nb` passes.
6. Structure matches the source — see `.claude/skills/translate-page/SKILL.md`.
7. Every term used on the page that appears in this glossary matches it.

Both `check_glossary.py` and `check_typography.py` already register `nb`
(`"nb": "norwegian-glossary.md"` and `"nb": ("«", "»")`), so no script change is
needed before the first page — unlike in the HALPI2 repository, where the first
translator had to add that line.

### The six rules are measured, not reread

**A rule that was read looks followed.** Rereading your own page confirms
whatever it already says. Both the French and German branches shipped a
half-applied typography rule to review for exactly this reason, and Danish is
close enough to Norwegian that a leak from a parallel branch will read as fine.
`check_typography.py nb` does the counting properly, with code fences stripped;
the greps below are for spot checks while writing. Act on any non-zero count.

| Rule | Command | Expected |
|:-----|:--------|:---------|
| Guillemets pair and point inward | `grep -o '«' -r docs/nb \| wc -l` and the same for `»` | equal counts |
| No Danish outward quotes | `grep -rnE '»[^«»]*«' docs/nb` | no output |
| No space inside guillemets | `grep -rnE '« \| »' docs/nb` | no output |
| Reader is `du` | `grep -rowiE '\b(du\|deg\|din\|ditt\|dine)\b' docs/nb \| wc -l` | well above zero |
| No formal address | `grep -rnE '\b(De\|Dem\|Deres)\b' docs/nb` | no output outside sentence-initial `De` |
| No space before `;:!?` | `grep -rnE ' [;:!?]' docs/nb` | no output |
| No `-tion` (Danish/English) | `grep -rniE '[a-zæøå]{3,}tion(en\|er\|ene\|s)?\b' docs/nb` | no output |
| Infinitive marker is `å` | `grep -rnE '\bat [a-zæøå]+e\b' docs/nb` | no output |
| No Danish function words | `grep -rniwE '(kun\|nu\|nogen\|meget\|end\|efter\|sætte\|hjælp\|ændre\|tjek)' docs/nb` | no output |
| No `-erne` plurals | `grep -rniE '[a-zæøå]{3,}erne\b' docs/nb` | no output |
| No split compounds | `grep -rniE '(strøm forsyning\|kabel gjennomføring\|bære kort\|super kondensator\|status LED-\|spennings fall\|bunn plate\|kort stabel)' docs/nb` | no output |
| German hyphen chain | `grep -rn 'NMEA-2000\|Signal-K\|Raspberry-Pi' docs/nb` | no output |
| Junction hyphen present | `grep -rn 'NMEA 2000-\|Signal K-\|SH-RPi-\|CAN HAT-' docs/nb` | matches wherever the name is compounded |
| Board labels untranslated | `grep -rn 'RTC EN\|PROG\|CAN0\|CAN1\|3V3\|BOOT' docs/nb` | present wherever the English has them |
| Unit spacing | `grep -rnE '[0-9](V\|A\|W\|F\|Ω\|mm\|kg\|m)\b' docs/nb` | no output |
| Decimal comma | `grep -rnE '[0-9]\.[0-9]' docs/nb` | no output outside version numbers |
| En dash in ranges | `grep -rnE '[0-9]-[0-9] ?(V\|A)' docs/nb` | no output |
| Numbers did not drift | every number in the English page appears in the Norwegian page | all present |

A wrong voltage or current in an installation guide is a safety problem, not a
typo. The last row is not optional.

## Related

- `finnish-glossary.md`, `french-glossary.md`, `german-glossary.md`,
  `swedish-glossary.md`, `spanish-glossary.md`, `dutch-glossary.md` — siblings
  in this repository
- `../../../halpi2/solutions/translation/norwegian-glossary.md` — the upstream
  file this one was copied from. Shared rows are changed there and here
  together, or not at all
- `.claude/skills/translate-page/SKILL.md` — the procedure

## Terms added during translation

Inherited from the HALPI2 pages, where the page translators reported them and
they were consolidated here rather than written by each of them. They are kept
because the vocabulary is shared; a row whose English term does not occur in the
SH-RPi pages simply goes unchecked by `check_glossary.py`. **New SH-RPi terms
belong under `## SH-RPi terms`**, not here, so the two products' additions stay
distinguishable.

| English | Translation | Note |
|:--------|:------------|:-----|
| guitar pick | gitarplekter | Named as an alternative non-conductive prying tool next to the spudger in the CM5 removal procedure. The glossary lists spudger -> plastspade but not  |
| board-to-board connector | kort-til-kort-kontakt | The two high-density connectors joining the CM5 to the carrier board. Central to the CM5 replacement section and its warranty warning, so it needs one |
| amber (LED colour) | ravgul | LED colour column in the status-LED table. Norwegian trade usage also says gul, which would collide with the yellow Ethernet-speed LED two rows above; |
| voltage bar (LED pattern) | spenningssøyle | The LED pattern name in the operation.md quick-reference table, where the five LEDs form a bar-graph charge indicator. |
| hex socket / socket size (tool) | pipe / pipestørrelse | The connector-removal step lists 26 mm, 10 mm, 8 mm and 17 mm sockets. pipe (pipenøkkel) is the Norwegian tool word; nøkkel alone would read as a span |
| countersunk screw | senkeskrue | The four M4x10 lid screws. Appears in the very first procedure on the page. |
| boot mode | oppstartsmodus | USB boot mode / Abnormal boot mode, in the connector table, the LED table and the SSD section. The glossary has to boot -> starte opp but not this com |
| single-sided / double-sided (SSD) | ensidig / tosidig | The M.2 2230-2280 compatibility rule turns on this distinction, so it is load-bearing rather than decorative. |
| chip select | chip select | Kept in English in the GPIO conflict table and prose, like the other SPI signal names (MISO, MOSI, SCK) which are already never-translate. |
| transceiver | transceiver | RS-485 transceiver, in the interface-disabling section. The Norwegian trade term is the English one, consistent with the glossary keeping firmware and |
| grace period | venteperiode | The 5-second window before HALPI2 restarts itself after a manual shutdown. naadeperiode is a legal term and wrong here. |
| feeding the watchdog | mating av watchdogen | The source sets it in quotes as jargon; kept as jargon inside Norwegian guillemets so it still reads as a quoted idiom. |
| heat spreading area | varmespredende flate | The areas on the enclosure bottom the CM5 thermal pads must meet, in the CM5 final-assembly step. |
| solid (LED state) | lyser fast | Opposed to blinker (flashing) throughout the operation.md LED table; needed one fixed rendering to keep the table columns parallel. |
| pressure equalization | trykkutjevning | The stated purpose of the breather plug. The glossary gives the part (trykkutjevningsplugg) but not the function, which the panel-connector list state |
| terminals (crimp-on cable terminals) | kabelsko | Appears twice in the permanent-installation materials list and in "Install terminals using proper crimping technique". The glossary covers terminal bl |
| cable grommet | gummigjennomføring | "Install cable glands or cable grommets if routing through bulkheads" lists it alongside cable gland (kabelgjennomføring). Needed a distinct word so t |
| "wall wart" (power supply type) | «wall wart» (kept English in guillemets) | Jargon in the optional-items list. No idiomatic Norwegian equivalent; kept as a quoted English idiom inside «…», the same treatment the glossary gives |
| mounting clips | monteringsklips | Last item of the materials list, next to cable ties (kabelstrips). Recording it so the next page that mentions clips does not invent klemmer or festek |
| known-good device | en enhet du vet fungerer | NMEA 2000 troubleshooting bullet. Rendered as a relative clause rather than a compound; noting it so the phrase stays the same if it recurs. |
| Load Equivalency Number (LEN) | Load Equivalency Number (LEN) | NMEA 2000 standard term for how much bus power a device draws. Norwegian marine dealers and the standard itself use the English name and the LEN abbre |
| multi-talker / single-talker-multiple-listener | multi-talker / single-talker-multiple-listener | NMEA 0183 / RS-485 topology terms. Kept English but glossed once on first use: 'nettverk med flere sendere (multi-talker)' and 'nettverk med én sender |
| half-duplex | halv dupleks | The RS-485 mode that lets one wire pair both transmit and receive. Two words in Norwegian (halv dupleks) rather than a solid compound, matching establ |
| normally-open (NO) momentary switch | normalt åpen (NO) momentbryter | The switch type required for the external Power/Reset/User buttons. Load-bearing: the wrong switch type makes the button behave inverted. 'momentbryte |
| Battery-Backed RAM (BBR) | batteribackup-RAM (BBR) | Where the u-blox GNSS receiver stores its settings. Explains why the configuration is re-run on every boot, so it needs a stable rendering. Abbreviati |
| PLC (programmable logic controller) | PLS | Industrial RS-485 device listed under common applications. PLS is the standard Norwegian abbreviation (programmerbar logisk styring); writing PLC woul |
| buck converter | buck-omformer | Names the SiC463ED regulating the 10 V intermediate rail in the power-supply table. Norwegian trade usage keeps 'buck' and compounds it with a junctio |
| ferrite bead | ferrittperle | USB 3.0 port filtering in technical-reference/hardware.md. Standard Norwegian component name. |
| pull-up (resistor) | pull-up-motstand | The 2,2 kΩ pull-ups on the controller I2C bus. Norwegian keeps the English 'pull-up' and compounds it, as with the glossary's device tree-overlay. |
| ingress protection | inntrengningsbeskyttelse | The IP65 row in the specifications summary. The separate 'IP rating' row in the enclosure table is rendered 'IP-klasse' — the two English phrasings ar |
| solder nut | loddemutter | The 4× M2.5 fasteners holding the CM5, in the mounting list. Distinct from the glossary's gjengeinnsats (threaded insert), which is the HAT mounting m |
| current limit (the value) | strømgrense | Column header in the USB 3.0 port table, where each cell is a number (0,93 A). The glossary has current limiting -> strømbegrensning for the function  |
| depth sounder / wind instrument | ekkolodd / vindmåler | NMEA 0183 instrument types listed under common applications for RS-485. Both are the ordinary Norwegian boating words. |
| recessive state | resessiv tilstand | The bus state an RS-485 multi-talker interface must hold when not transmitting. Direct loan, as in the CAN literature. |
| power-on / power-off threshold | innkoblingsterskel / utkoblingsterskel | The 8,0 V and 5,5 V supercapacitor thresholds. Chosen as a matched pair so the two table rows read parallel; UVLO is kept as the English abbreviation  |
| user space | brukerrommet (user space) | ubuntu-installation.md describes halpid as a user space daemon that talks to the power-management hardware over I2C. The glossary fixes daemon -> daem |
| thermal throttling | termisk struping | troubleshooting.md, the 'System runs slowly or freezes' step about CPU temperature above 80 °C. The glossary covers passiv kjøling but not the throttl |
| rollback (of a firmware update) | tilbakerulling / rulle tilbake | The whole 'Firmware Update Failed or Rolled Back' section turns on this word, and the LED/firmware sections of software.md already describe the same 3 |
| login prompt | påloggingsledetekst | troubleshooting.md tells the reader to attach HDMI and look for boot errors or a login prompt. The glossary has to log in -> logge på but not the on-s |
| bus contention | konflikt på bussen | The CAN error-counter step in troubleshooting.md lists it alongside wiring problems and wrong baud rate. No single-word Norwegian equivalent is in use |
| 3rd party (operating systems) | tredjeparter | The warning admonition at the top of ubuntu-installation.md. Spelled out as a word rather than kept as a digit, so the numeric-drift check will report |
| errata / known hardware issues | kjente feil | Page title of appendices/errata.md. Taken from the nb nav_translations block in mkdocs.yml ("Errata": "Kjente feil") so the H1 and the sidebar agree,  |
| mounting ledge | monteringsknast | The cast aluminium ledges inside the enclosure that the PCB rests on. Central to the second errata item (heading plus three prose mentions); knast is  |
| solder mask | loddemaske | The PCB coating a casting flash can penetrate, in the errata short-circuit description. |
| copper pour / power plane | kobberflate / spenningsplan | Both appear: copper pours in the v0.5.0 changelog and a 3,3 V power plane in errata. Kept apart because the errata text names the plane as a net, not  |
| inrush current / initial current spike | startstrom | The errata compliance item turns on this quantity (1,1 A against the NMEA 2000 limit of 1 A), so it needed one fixed rendering rather than an ad-hoc p |
| through-hole (THT) | gjennomhullsmontering (THT) | The v0.5.0 jumper-header changelog entry. Abbreviation kept in parentheses as the source has it. |
| footprint (component) | komponentfotavtrykk | Last v0.6.0 changelog entry. Fotavtrykk alone would read as a carbon/disk footprint in a marine document. |
| signal integrity | signalintegritet | Appears twice in design-files (v0.6.1 summary and the v0.6.0 re-routing entry). |
| security hardening | sikkerhetsherding | Bullet in software-development/advanced-config.md. Sikring would collide with the glossary entry fuse -> sikring, which is the reason for choosing her |
| cross-compilation | krysskompilering | Bullet in software-development/integration.md. |
| kernel module | kjernemodul | Bullet in software-development/integration.md; kernel is otherwise never translated in the glossary, but the compound reads badly in English here. |
| goodie bag | tilbehørspose | The bag of extras shipped in the box. Appears only as the index.md image alt text, so nothing else in the corpus pins it down; recorded here so the next page that mentions it does not invent godtepose or tilbehørspakke. |
| layout | oppsett / oppbygning / plassering / kretskortlayout | Four senses the English word covers and Norwegian splits; they are not rivals and must not be harmonised. A set of items chosen from options is oppsett (standardoppsettet, tastaturoppsett, standardoppsettet med 40 pinner). How something is built up internally is oppbygning (the Intern oppbygning heading, and the carrier-board alt text Bærekortets oppbygning, oversiden). Where parts sit on a face is plassering (Kontaktplassering på HALPI2, the index.md alt text). PCB design files are kretskortlayout, the trade loan. |
| solder cup | loddekopp | Koppen i kontaktpinnen som fylles med tinn før lodding |
| pigtail (pre-wired lead) | ledningssett | JST XH-ledningssett |
| centre punch | kjørner | For å merke av hullsenteret før boring |
| burr | grad | Flertall *grader*; oppstår rundt hullet ved boring |
| self-tapping screw | selvskjærende skrue |  |
| O-ring | O-ring | Tetning rundt kontakten |
| time-series database | tidsseriedatabase | InfluxDB |
