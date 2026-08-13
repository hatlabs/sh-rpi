---
title: Dutch translation glossary and style rules (SH-RPi)
date: 2026-08-05
category: translation
module: documentation
problem_type: reference
component: documentation
severity: medium
applies_when:
  - Translating any page from docs/en/ into Dutch under docs/nl/
  - Reviewing a Dutch translation for consistency
  - Adding a new term that has no established Dutch equivalent
tags:
  - translation
  - i18n
  - dutch
  - terminology
  - mkdocs-static-i18n
---

# Dutch translation glossary and style rules

## Context

The SH-RPi documentation is written in English under `docs/en/` and translated
into Dutch under `docs/nl/`, using the `mkdocs-static-i18n` folder structure.
Each language directory mirrors the same tree, so a translation keeps its
source's path and filename: `docs/en/hardware/index.md` becomes
`docs/nl/hardware/index.md`. Only markdown lives under `docs/nl/`; images and
other assets stay with the English source and are shared, including the nested
`assets/` directories under `revisions/` and `tutorials/openplotter-server/`.

**This file began as a copy of the HALPI2 Dutch glossary and deliberately keeps
its decisions.** SH-RPi and HALPI2 are both Raspberry Pi power boards with
supercapacitors, a shutdown daemon and a hardware watchdog, so a reader who
knows one Hat Labs board should meet the same Dutch words in the other:
`carrierboard`, `supercondensator`, `watchdog`, `daemon`, `energiebeheer`,
`afsluiten`. Rows above the `## SH-RPi terms` heading are shared with HALPI2 and
**change in both repositories or in neither** — a row edited here alone is drift,
not a correction.

The HALMET glossary was not used as the base even though HALMET is also a Hat
Labs board. Its additions are all sensor-input vocabulary — analog and digital
inputs, galvanic isolation, a constant current source — and not one of those
words occurs anywhere in the SH-RPi documentation. That was measured against the
English pages, not assumed. HALPI2's additions are power, shutdown and
enclosure vocabulary, which is what SH-RPi's pages are made of.

The seven typography rules below are inherited unchanged. They are the places
where the sibling languages are *wrong* for Dutch, and nothing about a power
management HAT makes them less true than they were for a carrier board.

Translations are produced page by page, at different times, potentially by
different people. Without a fixed terminology list the same English term drifts
across pages — a *solder jumper* becomes `soldeerbrug` on one page and `jumper`
on the next, which on this board is the difference between reaching for a knife
and reaching for a pair of fingers.

This file is the reference that prevents that drift. It is a living document:
extend the `## SH-RPi terms` section when a page introduces a term that is not
listed here, rather than inventing a one-off translation.

Unlike the other files under `solutions/`, this one has no date in its filename
because it is meant to be edited in place, not superseded.

## Seven rules where the siblings are wrong for Dutch

Read this section before anything else. Every one of these is stated the
opposite way in at least one sibling glossary. Dutch sits closest to German and
Swedish — solid compounds, no space before punctuation — which is exactly why the
places where it diverges from them get carried across unnoticed.

1. **Address the reader as `u` / `uw`, never `je`, `jij`, `jouw` or `jullie`.**
   Dutch installation, safety and consumer manuals use `u`; Swedish uses `du`,
   and copying that register produces a page that reads as a hobby blog next to
   a warning about 32 V and short circuits.

   The trap is that the Dutch imperative is *identical* for both registers —
   `Sluit de voedingskabel aan.` `Controleer de polariteit met de multimeter
   voordat u de spanning inschakelt.` The register only surfaces in pronouns and
   possessives, so a page can be 90 % correct and still leak `je` in three
   places. That is why this is counted, not read.

   Write `u` and `uw` in lowercase. Capital `U` is an archaic reverential form
   and is wrong here.

2. **Quotation marks are `“…”` — U+201C opening, U+201D closing, two different
   characters.** Not German's `„…“`, not Swedish's `”…”` (the *same* character
   twice), not French's `« … »`, not straight `"…"`. A leaked Swedish habit is
   visible as a `”` count higher than the `“` count.

3. **Dutch does not capitalise common nouns.** German capitalises every noun;
   Dutch capitalises only proper names and the first word of a sentence or
   heading. Write `behuizing`, `voeding`, `carrierboard`, `afsluitweerstand`,
   `bestandssysteem` mid-sentence — never `Behuizing`, `Voeding`,
   `Carrierboard`. This is the single most likely German leak.

   The same rule flattens English title case in headings: `Permanent Power
   Installation` becomes `Vaste voedingsinstallatie`, not `Vaste
   Voedingsinstallatie`.

4. **Compounds are solid, but a compound with a proper name takes exactly one
   hyphen, at the junction.** Dutch writes `NMEA 2000-netwerk`, `Signal
   K-server`, `Raspberry Pi-antenne`, `HALPI2-behuizing`, `E7T-connector`,
   `PG7-kabelwartel`, `M.2-slot`, `CM5-module`. German writes
   `NMEA-2000-Netzwerk` — hyphens all the way through — and that pattern is
   wrong in Dutch.

   On SH-RPi's pages that gives `SH-RPi-connector`, `CM4-module`,
   `PCF8563-realtimeklok`, `ATtiny1616-microcontroller`, `PG7-kabelwartel`,
   `CR1220-knoopcel`. A two-word product name keeps its internal space and takes
   the single hyphen at the junction: `CAN HAT-connector`, `GNSS HAT-antenne`,
   `Raspberry Pi-voeding` — never `CAN-HAT-connector`.

   Ordinary Dutch compounds carry no hyphen and no space: `voedingskabel`,
   `kabelwartel`, `afsluitweerstand`, `supercondensator`, `frontpaneel`,
   `bestandssysteem`. English two-word terms adopted whole become one Dutch
   word: `carrier board` → `carrierboard`, `access point` → `accesspoint`.

5. **No space before `; : ! ?`** — as in German and Swedish, and unlike French,
   whose rule is the exact opposite and demands a no-break space.

6. **`led` is an ordinary lowercase Dutch word, not an abbreviation.** German
   writes `Status-LED` and Swedish `status-LED`; Dutch writes `status-led`,
   `rgb-led` → `RGB-led`, plural `leds`. Uppercase `LED` belongs only inside
   code, file paths and quoted silkscreen labels. Same for `wifi` (lowercase in
   prose; `WiFi (wlan0)` stays as written when it names the on-screen menu
   item).

7. **SH-RPi is a `de`-word, the carrierboard is a `het`-word.** Grammatical
   gender drifts between pages faster than terminology does, because nothing
   flags it. Fix it here:

   | Article | Nouns |
   |:--------|:------|
   | `de` | SH-RPi, HALPI2, HAT, Raspberry Pi, behuizing, voeding, zekering, connector, kabelwartel, aardlekbeveiliging, supercondensator, supercondensatorbank, afsluitweerstand, daemon, controller, microcontroller, watchdog, jumper, soldeerbrug, realtimeklok, backupbatterij, smoorspoel, stroombegrenzer, grondplaat, pinheader, service, trapboor |
   | `het` | carrierboard, frontpaneel, bestandssysteem, schot, klemmenblok, systeemimage, dashboard, energiebeheer, pi-filter, knipperpatroon, configuratiebestand, installatiescript |

   English possessives do not survive the crossing: `SH-RPi's supercapacitors`
   becomes `de supercondensatoren van de SH-RPi`, never `SH-RPi's
   supercondensatoren`. The apostrophe-`s` in Dutch marks the plural of a
   vowel-final word or an abbreviation (`schema's`, `SSD's`, `HAT's`), nothing
   else — and `HAT's` is the one that occurs constantly on these pages, so a
   hit on `SH-RPi's` needs reading rather than blind deletion.

## Names that are never translated

Product names, protocol names, hardware standards and software UI strings stay
in English.

- **Products and software:** SH-RPi, Sailor Hat, HALPI2, Signal K, OpenPlotter,
  Raspberry Pi OS, Waveshare, PlatformIO, Node-RED, Grafana, Hat Labs
- **Hardware and standards:** Raspberry Pi, Compute Module 4 (CM4), HAT,
  ATtiny1616, PCF8563, CAN, NMEA 2000, NMEA 0183, RS485, GNSS, I2C, SPI, UPDI,
  GPIO, USB, microSD, PoE
- **The add-on boards keep their product names exactly:** **CAN HAT**, **RS485
  HAT**, **GNSS HAT**. Not `CAN-HAT`, not `RS-485 HAT` in the product name — the
  bus itself is written `RS-485` in prose, but the board is the `RS485 HAT`, as
  Waveshare prints it.
- **Board labels and pin names are copied as printed**, in backticks, never
  translated and never re-cased: `PROG`, `RTC EN`, `GPIO4 Enable`, `BOOT`, `2A`,
  `3A`, `CAN0`, `CAN1`, `GND`, `3V3`. The surrounding sentence carries the
  meaning: `de bovenste rij (met opdruk 2A)`, `de soldeerbrug RTC EN`.

So does every **command name** (`shrpi`, `shrpid`, `raspi-config`, `avrdude`,
`rpiboot`, `systemctl`, `nano`, `curl`, `pio`), every **file path**
(`/etc/shrpid.conf`, `/var/run/shrpid.sock`, `/boot/firmware/config.txt`,
`/boot/cmdline.txt`, `/dev/ttyAMA0`, `/dev/ttySC0`), every **configuration key**
(`blackout-time-limit`, `blackout-voltage-limit`, `i2c-addr`, `socket-group`,
`poweroff`, `dtoverlay`, `dtparam`), every **interface and service name**
(`can0`, `shrpid`, `hciuart`, `gpsd`), and every **UI string the reader will see
in English on their own screen** (`OFF`, `ON`, `BOOT`, the OpenPlotter
**Headless** image name).

Code fences and their contents, command output, URLs and image filenames are
never touched.

## Units and numbers

The English source writes `12V` and `0.9A`. Both are wrong in Dutch and need an
active conversion on nearly every technical page.

| English source | Dutch |
|:---------------|:------|
| `12V`, `0.9A` | `12 V`, `0,9 A` |
| `5.5 x 2.1 mm` | `5,5 × 2,1 mm` |
| `-20°C to +60°C` | `−20 °C … +60 °C` |
| `120Ω` | `120 Ω` |
| `1.5mm²`, `2m` | `1,5 mm²`, `2 m` |
| `3-5A` | `3–5 A` (en dash for ranges) |
| `250 kbps` | `250 kbit/s` |

- **Decimal comma**, always: `0,9 A`, `5,5 mm`, `3,3 V-rail`, `10,8 V`.
- **A space between the number and its unit**, preferably a no-break space
  (U+00A0), including before `°C` and `Ω`.
- **No thousands separator** in technical values: `115200 bps`, not `115.200`.
- **Dimensions given as a single product spec keep the tight form:**
  `200 × 130 × 60 mm`, with `×` (U+00D7), not the letter `x`.
- **Version numbers, part numbers and addresses are identifiers, not numbers**:
  `v0.6.1`, `M.2`, `0x6d`, `2.54 mm` pitch keeps its decimal comma → `2,54 mm`,
  but `v0.6.1` keeps its points.

## Links, images, admonitions, navigation

Same as the sibling glossaries: paths are copied from the English source
unchanged and never carry an `en/` or `nl/` segment; image captions and alt
texts are translated but filenames are not; screenshots stay English because the
reader's own screen is English; standard admonition titles are translated
centrally in `mkdocs.yml`, custom ones — `!!! note "Shop Link"` →
`!!! note "Link naar de webshop"` — in the page.

Navigation titles live in `mkdocs.yml` under the i18n plugin's
`nav_translations`, which is the single source of truth; the full list is not
restated here. Three entries are judgement calls worth recording:

- `Errata` → **Bekende hardwarefouten**. The Latin term is opaque to a general
  reader, and the page lists known hardware defects, so plain Dutch is clearer.
  Finnish made the same call (`Tunnetut virheet`).
- `FAQ` → **Veelgestelde vragen**. Written out; the abbreviation `FAQ` is
  understood in Dutch but the full phrase is what Dutch product documentation
  uses in a navigation menu.
- `Overview` appears twice in the nav — once under `Add-on Hardware`, once under
  `Tutorials` — and `nav_translations` maps a title, not a path, so both get the
  one word **Overzicht**. That is correct for both places; do not try to split
  them.

`Hardware` is a section group and `Hardware Description` the page inside it.
They must not both become `Hardware`, or the sidebar shows the same word twice
on two levels: the group is **Hardware**, the page **Hardwarebeschrijving**.

When a new page is added to the English nav, add its Dutch title to
`nav_translations` in the same change — an untranslated entry silently falls
back to English and is easy to miss.

## Glossary

### Enclosure, mounting, and installation

| English | Dutch | Note |
|:--------|:------|:-----|
| carrier board | carrierboard | One word, lowercase, `het`-woord — see the note below |
| enclosure | behuizing | |
| lid | deksel | |
| gasket | afdichtingsrubber | Lid gasket |
| heat sink | koellichaam | Not *koelblok*, which is a cooling block on a chip |
| waterproof | waterdicht | |
| rugged | robuust | |
| wall-mount | wandmontage | |
| mounting surface | montageondergrond | What you drill into |
| pilot hole (to drill) | voorboren (verb) | `Boor de bevestigingsgaten voor.` Never `voorgeboorde gaten boren` |
| pre-drilled hole (already there) | voorgeboord gat | The holes the enclosure ships with |
| mounting template | boormal | |
| clearance | vrije ruimte | |
| bilge water | bilgewater | Also seen as *lenswater*; use `bilgewater` on every page |
| bulkhead | schot | `het schot`, plural `schotten` |
| cable gland | kabelwartel | `PG7-kabelwartel` |
| cable routing | kabelroute | The verb is *leggen* / *leiden* |
| service loop | servicelus | Slack left at both cable ends |
| chafing | schuren | |
| cable tie | kabelbinder | |
| blind plug | blindplug | |
| breather plug | ontluchtingsplug | For *pressure equalization* → *drukvereffening* |
| standoff | afstandsbus | |
| threaded insert | draadinzetstuk | |

**A note on `carrierboard`, and why it differs from the siblings.** French,
German and Swedish each coined an accurate native term (`carte porteuse`,
`Trägerplatine`, `bärkort`); Finnish took the familiar-but-inaccurate `emolevy`
(*motherboard*). Dutch takes neither route: the Dutch marine and Raspberry Pi
trade already says *carrier board*, and Dutch spelling turns an adopted English
two-word term into one word — `carrierboard`.

Do not "harmonise" the five. They differ on purpose, decided per language and
per audience.

Two consequences worth stating:

- **Never write `moederbord`.** That is the Finnish trade-off, and it inverts
  the CM5/board relationship: it would make the board the computer and the CM5
  an add-on, which is the reverse of how HALPI2 is built. `carrierboard` carries
  the relationship correctly on its own, so passages about reseating the CM5 or
  troubleshooting a board that will not boot need no extra explanation.
- **Never write `carrier board` with a space,** and never capitalise it
  mid-sentence. Those are the English and German habits respectively, and both
  are countable.

### Electrical

| English | Dutch | Note |
|:--------|:------|:-----|
| power supply | voeding | The unit itself: *voedingsadapter* |
| power source | voedingsbron | |
| input voltage range | ingangsspanningsbereik | |
| polarity | polariteit | |
| positive (+) / negative (−) | plus (+) / min (−) | |
| fuse | zekering | |
| inline fuse | kabelzekering | A fuse holder fitted in the positive lead |
| circuit breaker | installatieautomaat | The panel breaker; on a boat panel often just *automaat* |
| current limiting | stroombegrenzing | The switch is the *stroombegrenzer* |
| overcurrent | overstroom | |
| inrush current | inschakelstroom | |
| voltage drop | spanningsval | |
| grounding | aarding | |
| ground loop | aardlus | |
| short circuit | kortsluiting | |
| wire gauge | aderdoorsnede | Dutch uses mm², not AWG |
| marine-grade wire | kabel van maritieme kwaliteit | |
| to strip (a wire) | strippen | |
| wire strippers | striptang | |
| crimping | krimpen | Noun: *krimpverbinding* |
| crimper | krimptang | |
| crimp terminal | kabelschoen | |
| heat-shrink tubing | krimpkous | |
| heat gun | heteluchtpistool | |
| multimeter | multimeter | |
| continuity test | doorbelmeting | |
| terminal block | klemmenblok | The pluggable Phoenix MC connector |
| strain relief | trekontlasting | |
| super-capacitor | supercondensator | One word, lowercase |
| real-time clock | realtimeklok | Abbreviate as RTC after first mention |
| backup battery | backupbatterij | The cell itself is a `CR2032-knoopcel` |

### Connectors and interfaces

| English | Dutch | Note |
|:--------|:------|:-----|
| connector | connector / aansluiting | *aansluiting* for a board-mounted socket |
| barrel connector | DC-plug | Add *(barrel connector)* on first mention |
| header | pinheader | `40-pins GPIO-pinheader` |
| pin | pin | |
| pitch | steek | `3,81 mm steek` |
| backbone | backbone | Established in Dutch NMEA 2000 usage |
| drop cable | aftakkabel | |
| T-connector | T-stuk | Also renders *T-adapter* |
| terminator / termination (120 Ω) | afsluitweerstand | The component; the act is *afsluiten* |
| front panel | frontpaneel | |
| jumper | jumper | |
| male / female | male / female | Trade usage; use *stekker / bus* when the plug-socket pair is meant |
| antenna | antenne | |
| extension cable | verlengkabel | |
| flexible flat cable (FFC) | platte flexkabel (FFC) | Keep the abbreviation after first mention |

### Operation, system behaviour and status

| English | Dutch | Note |
|:--------|:------|:-----|
| boat computer | boordcomputer | |
| to boot | opstarten | |
| first boot | eerste start | |
| shutdown | afsluiten | The noun is *het afsluiten* |
| graceful shutdown | gecontroleerd afsluiten | |
| to power down | uitschakelen | Cutting power, as opposed to *afsluiten* |
| power loss | spanningsuitval | The input goes away |
| blackout | stroomuitval | The boat's supply goes away; the firmware timer stays `blackouttimer` |
| glitch immunity | storingsongevoeligheid | |
| power management | energiebeheer | |
| status LED | status-led | Lowercase *led*, plural *leds* |
| LED bar | ledbalk | |
| monitoring | bewaking | |
| passive cooling | passieve koeling | |
| thermal pad | thermisch pad | |
| filesystem | bestandssysteem | |
| to unmount (a filesystem) | ontkoppelen | `het bestandssysteem wordt veilig ontkoppeld` |
| to unmount (a board or module) | demonteren | The English source uses one word for both — this one is mechanical: `het carrierboard demonteren`, `de CM5-module losnemen` |
| to reseat (a module) | opnieuw plaatsen | |
| watchdog | watchdog | |
| standby | standby | `standbymodus`, one word |
| solo mode / co-op mode | solomodus / co-opmodus | Named firmware states; keep them recognisable |

### Software and networking

| English | Dutch | Note |
|:--------|:------|:-----|
| firmware | firmware | Not *bedrijfsprogrammatuur* — the trade term, as in every sibling |
| daemon | daemon | Not *achtergronddienst* |
| to flash | flashen | Past participle *geflasht* |
| system image / operating system image | systeemimage | |
| container image | containerimage | Not *systeemimage* — that is a disk image |
| container app | containerapp | |
| headless | zonder beeldscherm | First mention: `zonder beeldscherm (headless)` |
| deployment | ingebruikname | |
| dashboard | dashboard | Homarr's *dashboard* view; `het dashboard` |
| WiFi Access Point | wifi-accesspoint | `wifi` lowercase in prose; `WiFi (wlan0)` stays as written when naming the menu item |
| wired / wireless | bekabeld / draadloos | |
| credentials | inloggegevens | |
| username / password | gebruikersnaam / wachtwoord | |
| default password | standaardwachtwoord | |
| single sign-on (SSO) | single sign-on (SSO) | Kept in English; it names the Authelia concept |
| Certificate Authority (CA) | certificaatautoriteit (CA) | |
| to trust (a certificate) | vertrouwen | |
| web interface | webinterface | |
| browser | browser | |
| system administration | systeembeheer | |
| package | pakket | Debian package → `Debian-pakket` |

### Applications and use cases

| English | Dutch | Note |
|:--------|:------|:-----|
| chart plotter | kaartplotter | |
| data logging | dataregistratie | |
| vessel | vaartuig | |
| engine parameters | motorgegevens | |
| fleet management | wagenparkbeheer | The source uses this under *Automotive*; for ships it would be *vlootbeheer* |
| process monitoring | procesbewaking | |
| remote monitoring | bewaking op afstand | |
| predictive maintenance | voorspellend onderhoud | |
| electromagnetic interference (EMI/RFI) | elektromagnetische storing (EMI/RFI) | |
| compliance | conformiteit | |
| warranty | garantie | |

## SH-RPi terms

SH-RPi is a power management HAT, so its vocabulary is HALPI2's power, shutdown
and enclosure language plus the mechanics of stacking boards on a Raspberry Pi.
**Rows above this heading are shared with HALPI2 and are not changed here
alone.** Rows below it are this product's additions.

Three of these decide what the reader physically does, and all three appear
inside a warning. They are called out under the tables: solder jumper against
jumper, rechargeable against non-rechargeable, and the buck converter the
English source twice calls a boost converter.

### The board and the stack

| English | Dutch | Note |
|:--------|:------|:-----|
| HAT | HAT | Never translated — it is the Raspberry Pi Foundation's term and it is printed on the boards. `de HAT`, plural `HAT's` (rule 7). Compounds take one hyphen at the junction: `HAT-connector`, `HAT-stapel`; two-word product names keep their space: `CAN HAT-connector` |
| add-on board | uitbreidingsprint | The CAN, RS485 and GNSS HATs collectively. HALPI2's translators already coined `uitbreidingsprint` for *expansion board* (third-party HAT-compatible boards); SH-RPi's add-on boards are exactly those, so the word carries over rather than getting a second name |
| to stack (boards) | stapelen | `de HAT's op elkaar stapelen`, `bovenop de Sailor Hat gestapeld` |
| stack (of boards) | printstapel | The English *PCB stack*. `de printstapel op de grondplaat bevestigen` |
| stack-through header | doorsteekpinheader | The tall 40-pin header shipped with the board, whose pins pass through so another HAT can be stacked on top. The English source writes it three ways — *stack-through header*, *stackthrough header*, *stack-through connector* — and Dutch uses this one word for all three |
| stacking header | doorsteekpinheader | The same part under a second English name. Deliberately not given its own Dutch word: two Dutch words for one component is exactly the drift this file exists to stop |
| pass-through GPIO header | doorverbonden GPIO-pinheader | The 2×20 header on the SH-RPi itself, which passes the Raspberry Pi GPIO signals on. Distinct from the loose `doorsteekpinheader` that is pushed into it |
| spacer (on the header) | afstandsplaatje | The removable plastic spacer on the stack-through header. Not `afstandsbus`, which is the metal standoff |
| standoff | afstandsbus | Inherited from HALPI2 |
| hex standoff | zeskantafstandsbus | The M2.5 6 mm and 16 mm standoffs. Solid compound; after first mention `afstandsbus` alone is fine |
| mounting screw | montageschroef | HALPI2's translators already fixed `montageschroeven`; the M2.5 and M3 screws here are the same thing |
| solder jumper | soldeerbrug | `de soldeerbrug`. Permanent: on this board it is *opened* by cutting the traces between the pads with a sharp knife — `de sporen tussen de soldeerbrugpads doorsnijden met een scherp mes`. See the warning below |
| solder jumper pads | soldeerbrugpads | `RTC EN` and `GPIO4 Enable`; the labels stay as printed |
| jumper | jumper | Inherited from HALPI2. A removable link pushed onto a pin pair — the current limiter header, the `PROG` header. Removed with fingers, never with a knife. See the warning below |
| jumper header | jumperheader | The pin field a jumper is placed on. Named ones: `stroombegrenzerheader` (current limiter header), `PROG-header`, `programmeerheader` |
| pin | pin | Inherited from HALPI2. `40-pins GPIO-pinheader`, `de pin doorknippen` for the PPS pin on the GNSS HAT |
| base plate | grondplaat | The perforated plate in the enclosure. Not *basisplaat*, and not the same thing as the *base board* below |
| base board | carrierboard / onderste print | Two senses in the English source. On the Compute Module 4 page it means the board the CM4 plugs into — use the inherited `carrierboard`. In the enclosure walkthrough it means the bottom board of the stack — `de onderste print`. Do not merge them |
| vertical mount | verticale houder | The black plastic parts that hold the printstapel upright on the grondplaat. Not *verticale montage*, which is the orientation, not the part |
| cable gland | kabelwartel | Inherited from HALPI2. `PG7-kabelwartel`, `PG9-kabelwartel`; the blanked one is a `blindplug` per the inherited row |
| panel connector | paneelconnector | The chassis-mount connectors drilled into the enclosure wall: `SP13-paneelconnector`, `RJ45-paneelconnector`, `M12-paneelconnector` |
| terminal plug | klemmenstekker | The pluggable Phoenix MC half that the wires are screwed into. The board-mounted half stays `het klemmenblok` per the inherited row — the two must stay apart, because the warning is about plugging the klemmenstekker into the wrong klemmenblok |
| step drill bit | trapboor | `getrapte boor` also occurs in Dutch trade writing; use `trapboor`, the shorter and more common one |
| pilot hole | voorboren | Inherited from HALPI2 as a verb: `Boor het gat voor.` The enclosure that ships with holes has `voorgeboorde gaten`, also inherited |
| heat shrink tubing | krimpkous | Inherited from HALPI2 (*heat-shrink tubing*) |
| zip tie | kabelbinder | Inherited from HALPI2 (*cable tie*). The English source also says *tie wrap* for the same object in the same paragraph; all three become `kabelbinder`. Dutch trade also says `tiewrap`, which is why this row exists: pick one and keep it |
| double-sided tape | dubbelzijdige tape | For the 40 mm fan. `de tape` |
| silk screen / board label | opdruk | Inherited from HALPI2's translators. The label itself stays verbatim and quoted: `de rij met opdruk 2A` |

### Power and shutdown

| English | Dutch | Note |
|:--------|:------|:-----|
| supercapacitor / supercap | supercondensator | Inherited from HALPI2. The English source writes both the full word and *supercap*; Dutch uses one word throughout. Plural `supercondensatoren` |
| supercapacitor bank | supercondensatorbank | The three 20 F cells as one unit. Solid compound |
| power reservoir | energiebuffer | What the bank is for. Not *energiereservoir*, which reads as a fuel tank |
| power management | energiebeheer | Inherited from HALPI2. `het energiebeheer`; the board is a `kaart voor energiebeheer`, not a *power-managementkaart* |
| safe shutdown | veilig afsluiten | The board's whole purpose. Built on the inherited `afsluiten`; the noun is `het veilig afsluiten` |
| graceful shutdown | gecontroleerd afsluiten | Inherited from HALPI2. Distinct from `veilig afsluiten` only in emphasis; if the English uses both on one page, keep both Dutch forms so the distinction survives |
| to power down | uitschakelen | Inherited from HALPI2: cutting power, as opposed to `afsluiten`, which is the operating system stopping |
| power-off | uitschakelen (werkwoord) / uitgeschakeld (toestand) | `wanneer het systeem is uitgeschakeld`. The overlay `gpio-poweroff` and the configuration key `poweroff` stay verbatim |
| watchdog | watchdog | Inherited from HALPI2, left in English. `de watchdog` |
| watchdog timer | watchdogtimer | Solid compound. HALPI2's translators write `watchdog-time-out` for *watchdog timeout*, because `time-out` is hyphenated in Dutch; the timer itself is not |
| watchdog reboot | watchdogherstart | The 5 V output being cut for two seconds to restart the Pi |
| heartbeat | heartbeat | Kept in English; it names the signal the daemon sends and the English source itself quotes it. `het heartbeatsignaal`, `de SH-RPi ontving 10 s lang geen heartbeat` |
| blackout | stroomuitval | Inherited from HALPI2: the boat's supply goes away. The configuration keys `blackout-time-limit` and `blackout-voltage-limit` stay verbatim in the YAML |
| brownout | spanningsdip | A dip rather than a break. Not the inherited `spanningsval` (*voltage drop*), which is the loss along a cable — a different phenomenon that the glossary already names |
| power glitch | spanningsstoring | The short interruptions the supercapacitors ride out. The inherited `storingsongevoeligheid` (*glitch immunity*) is the property, this is the event |
| hold-up time | overbruggingstijd | How long the supercapacitors keep the Raspberry Pi running after the input goes away. The established Dutch UPS term |
| charge / discharge | laden / ontladen | Nouns `de lading` / `de ontlading`; the LED bar shows the `laadtoestand`. Deep discharge is `diepontlading` |
| voltage threshold | spanningsdrempel | The 8,0 V and 5,0 V switching points |
| undervoltage | onderspanning | Below 10 V is an `onderspanningssituatie` |
| overvoltage | overspanning | The fault the rapid blink pattern reports |
| reverse polarity protection | ompoolbeveiliging | Dutch trade term; the component is `de ompoolbeveiligingsdiode`. `polariteitsbeveiliging` is understood but less usual — do not alternate between them |
| buck converter / step-down converter | step-downconverter | One Dutch word for both English names. See the warning below about the two places the English says *boost* |
| current limiter | stroombegrenzer | Inherited from HALPI2 (*current limiting* → `stroombegrenzing`) |
| current limit | stroomlimiet | The numeric setting: `de standaard stroomlimiet is 0,8 A`. The circuit stays `de stroombegrenzer`, the act `de stroombegrenzing` |
| transient voltage suppressor | transientonderdrukker (TVS) | `33 V-transientonderdrukker`; after first mention `TVS-diode`, which is what a Dutch parts catalogue calls it |
| choke | smoorspoel | |
| pi-filter | pi-filter | Kept as printed, lowercase, with the hyphen. `het pi-filter` |
| real-time clock (RTC) | realtimeklok | Inherited from HALPI2; abbreviate as `RTC` after first mention. `de realtimeklok`, `het RTC-alarm` |
| backup battery | backupbatterij | Inherited from HALPI2. The cell here is a `CR1220-knoopcel` (HALPI2's note says CR2032 — different board, same word for the part) |
| rechargeable / non-rechargeable | oplaadbaar / niet-oplaadbaar | Safety-critical, see the warning below. Never `herlaadbaar`, never abbreviated, never left implicit |
| microcontroller | microcontroller | `de microcontroller`; `ATtiny1616-microcontroller` on first mention |
| status LED | status-led | Inherited from HALPI2: lowercase `led`, plural `leds`. The array is `de ledbalk` |
| blink pattern | knipperpatroon | `het knipperpatroon`; the table column of the Status LEDs section |
| sleep state | slaapstand | The state `shrpi sleep` puts the board into. `de SH-RPi staat in de slaapstand` |

### Software

| English | Dutch | Note |
|:--------|:------|:-----|
| daemon | daemon | Inherited from HALPI2. Not `achtergronddienst`; the reader types `shrpid` and reads `shrpid.service`, and the Dutch word breaks that link |
| service (systemd) | service | `de service`, `de systemd-service`, `het servicebestand`. Not `dienst`, which in Dutch reads as a commercial or public service; the reader runs `systemctl enable shrpid`, so the English word keeps the connection to the command |
| installation script | installatiescript | `het installatiescript`, `het geautomatiseerde installatiescript`. Distinct from HALPI2's `installatiewizard`, which is a graphical first-boot flow |
| configuration file | configuratiebestand | `het configuratiebestand /etc/shrpid.conf`. A *section* of such a file is `de sectie`, per HALPI2's translators; a section of the documentation is `het onderdeel` |
| device tree overlay | device tree overlay | Kept in English exactly as HALPI2 decided: the reader meets it verbatim in `config.txt` and in Raspberry Pi documentation |
| firmware | firmware | Inherited from HALPI2. Not `bedrijfsprogrammatuur` |
| to flash | flashen | Inherited from HALPI2; past participle `geflasht`. `het flashen van de eMMC` |
| headless | zonder beeldscherm | Inherited from HALPI2; first mention `zonder beeldscherm (headless)`. The OpenPlotter **Headless** image name stays as printed — it is what the reader downloads |
| image (OS image) | systeemimage | Inherited from HALPI2. `een 64-bits systeemimage` |
| REST API | REST-API | `de REST-API`. Abbreviation plus noun takes one hyphen at the junction, rule 4 |
| file socket | bestandssocket | The `/var/run/shrpid.sock` the REST API listens on. HALPI2's translators fixed `Unix-domainsocket` for *Unix domain socket*, which is the same object under a different English name — use whichever the English sentence uses, and never invent a third |
| command-line interface | opdrachtregelinterface | Built on HALPI2's `opdrachtregel`; the tool itself is `het opdrachtregelgereedschap shrpi`, per the inherited row |

### The three rows that decide what the reader does

**`soldeerbrug` is not `jumper`.** They are two different things and the English
source uses two different words for them; Dutch must too.

- A **jumper** is a removable link pushed onto a pair of pins. It sits on the
  current limiter header and on the `PROG` header, and the reader puts it on and
  takes it off with their fingers. `Plaats een jumper horizontaal op de bovenste
  rij (met opdruk 2A).`
- A **soldeerbrug** is a pair of pads on the board joined by a trace. `RTC EN` is
  closed from the factory and is opened by **cutting the traces between the pads
  with a sharp knife**; `GPIO4 Enable` is open and is closed by joining the pads.
  `Snijd de sporen tussen de soldeerbrugpads door met een scherp mes.`

Writing `jumper` for a soldeerbrug sends the reader looking for something to
pull off a board where nothing can be pulled off. Writing `soldeerbrug` for a
jumper sends them for a knife they do not need, on a board where a slipped knife
cuts a neighbouring trace — which is what the English page warns about.

**`oplaadbaar` and `niet-oplaadbaar` must be unmistakable and clearly
opposed.** The GNSS HAT ships with a rechargeable ML1220 lithium cell and the
English page says replacing it with a non-rechargeable cell **risks explosion
and fire**. Requirements for the Dutch sentence:

- Both words appear in full, in the same sentence as the battery type. Never
  `niet-` on its own across a clause boundary, where a skimming reader loses it.
- Keep the emphasis the English carries: `mag **niet** worden vervangen door een
  niet-oplaadbare batterij`.
- Do not alternate with `herlaadbaar`. One word for one concept, on every page.
- The exception in the same paragraph — removing R3 to disable charging so a
  non-rechargeable CR1220 *can* be used — stays clearly marked as at the
  reader's own risk (`op eigen risico`), so the two sentences cannot be read as
  contradicting each other.

**`step-downconverter`, and the two places the English says `boost`.** Both
converter stages on this board step voltage *down*: the first from the 9–32 V
input to 8,8 V for the supercapacitor bank, the second from the bank to 5 V for
the Raspberry Pi. The English hardware page names the second stage correctly as
a *second stage buck converter* and then calls the very same part a *boost
converter* twice in the next two sentences. That is an error in the English
source, raised as issue #25.

**Translate what the English says.** Where the source writes *boost converter*,
write `boostconverter`; where it writes *buck* or *step-down*, write
`step-downconverter`. Do not silently fix the English in the Dutch page — a
translation that disagrees with its source leaves the reader unable to tell
which of the two is wrong, and the fix belongs in `docs/en/`. This row is
recorded so that a later reviewer knows the Dutch `boostconverter` is faithful,
not a mistranslation, and so that it can be corrected in one pass once issue #25
is closed.

### Units in the SH-RPi source

The inherited units table applies unchanged. Four forms specific to these pages:

| English source | Dutch |
|:---------------|:------|
| `9-32V`, `10-32 V` | `9–32 V`, `10–32 V` |
| `20F`, `60F` | `20 F`, `60 F` |
| `3.81 mm (0.15")` | `3,81 mm (0,15")` |
| `-167 dBm` | `−167 dBm` (U+2212, not a hyphen) |

Fractional inch sizes in the drilling list stay as printed — `1/4"`, `1/2"`,
`5/8"` — because they are named drill and gland sizes, not measurements.

Board labels containing digits and unit letters (`2A`, `3A`, `3V3`) are silk
screen text, not values. Write them in backticks. That is not cosmetic: the
verification script below strips inline code before counting, so an unbacktick'd
`3V3` is reported as an unspaced unit and a real `12V` hides among the false
hits.

### A note on register in the enclosure walkthrough

The Getting Started page switches person: it instructs the reader (*Connect a
10-32 V power source*), and it narrates alongside them (*We start with a bare
enclosure*, *Next, we install the stack-through header*). Keep both in Dutch —
`u` for the instruction, `we` for the narration — exactly as rule 1 requires and
the English does. `we` is not the informal address rule 1 forbids; `je` and
`jouw` are.

## Verification

A translated page is not done until:

1. `uv run mkdocs build --strict` passes.
2. `uv run check-anchors site --base /sh-rpi/` passes. The
   script's default `--base` is `/halpi2/`, which is wrong in this repository —
   `site_url` here ends in `/sh-rpi`, so pass it explicitly or every
   root-absolute link is reported as broken.
3. `uv run translation-status` shows the page as current.
4. `uv run check-glossary nl` passes.
5. `uv run check-typography nl` passes.
6. Structure matches the source — see `.claude/skills/translate-page/SKILL.md`.
7. **The seven rules at the top are counted against the pages, not re-read.**

That last one is the point of this section. A half-applied typography rule looks
followed when you read it, because rereading your own text confirms whatever it
already says. The French and German branches each shipped one to review for
exactly that reason. Run this instead:

```bash
python3 - <<'PY'
import pathlib, re
def prose(p):
    t = re.sub(r'^---\n.*?\n---\n', '', p.read_text(encoding='utf-8'), flags=re.S)
    t = re.sub(r'```.*?```', ' ', t, flags=re.S)   # code fences
    return re.sub(r'`[^`\n]*`', ' ', t)            # inline code
text = '\n'.join(prose(p) for p in sorted(pathlib.Path('docs/nl').rglob('*.md')))
n = lambda pat: len(re.findall(pat, text))
report = [
    ('rule 1  informal address je/jij/jouw/jullie', n(r'\b[Jj](?:e|ij|ouw|ullie)\b')),
    ('rule 1  reverential capital U',               n(r'\bU\b')),
    ('rule 2  wrong quote characters „ « » "',      n(r'[„«»"]')),
    ('rule 2  unpaired “ vs ”',              abs(n('“') - n('”'))),
    ('rule 3  spaced "carrier board"',              n(r'(?i)carrier board')),
    ('rule 3  capitalised common noun mid-sentence',n(r'(?<![.!?]\s)(?<!^)\b(?:Carrierboard|Behuizing|Voeding|Zekering|Soldeerbrug|Jumper|Grondplaat)\b')),
    ('rule 4  German-style name compounds',         n(r'NMEA-2000|Signal-K|Raspberry-Pi|Sailor-Hat')),
    ('rule 4  hyphenated add-on product names',     n(r'CAN-HAT|RS485-HAT|GNSS-HAT')),
    ('rule 5  space before ; : ! ?',                n(r'\S [;:!?](?:\s|$)')),
    ('rule 6  uppercase LED outside code',          n(r'\bLED')),
    ('rule 7  wrong article "het SH-RPi"',          n(r'\bhet SH-RPi\b')),
    ("rule 7  English possessive SH-RPi's",         n(r"SH-RPi['’]s")),
    ('terms   rival word herlaadbaar',              n(r'(?i)herlaadb')),
    ('terms   rival word moederbord',               n(r'(?i)moederbord')),
    ('units   unspaced unit (12V, 0,9A, 120Ω)',     n(r'\d(?:V|A|W|F|Ω|°C|mm|kg)\b')),
    ('units   decimal point instead of comma',      n(r'(?<!v)\d\.\d')),
]
for label, count in report:
    print(f'{count:>4}  {label}')
print('\nevery count must be 0; inspect each hit, do not adjust the pattern')

# The opposite direction: three words whose *absence* is the defect. Each names
# something the reader physically does, and each is easy to lose by paraphrase.
present = [
    ('soldeerbrug (hardware page, RTC EN / GPIO4 Enable)', n(r'(?i)soldeerbrug')),
    ('niet-oplaadbaar (GNSS HAT battery warning)',         n(r'(?i)niet-oplaadbaar|niet-oplaadbare')),
    ('doorsteekpinheader (assembly on four pages)',        n(r'(?i)doorsteekpinheader')),
]
for label, count in present:
    print(f'{count:>4}  {label}')
print('these must be non-zero once the pages that use them are translated')
PY
```

Three of these need judgement rather than a blind zero: version numbers such as
`v2.0.0` are identifiers and legitimately contain points, a heading may
legitimately start with a capitalised common noun, and `SH-RPi's` is a
legitimate Dutch plural even though it is never a legitimate possessive. Read
the hits. Everything else is a defect.

Also confirm, as the skill requires, that every number in the English page
appears in the Dutch page. A wrong voltage in an installation guide is a safety
problem, not a typo. On these pages that includes 8,0 V, 5,0 V, 0,8 A, 1,8 A and
2,8 A — the thresholds and the three current limiter settings, which the reader
matches against a jumper position and a silk screen label.

## Related

- `finnish-glossary.md` — the sibling in this repository, adapted from HALPI2
  for SH-RPi the same way this file was
- `../../halpi2/solutions/translation/dutch-glossary.md` — the original this
  file was copied from. Shared rows change there and here together
- `.claude/skills/translate-page/SKILL.md` — the procedure
- `../best-practices/` — the markdown traps that survive `--strict`

## Terms added during HALPI2 translation

Inherited with the rest of the file. These were reported by the HALPI2 page
translators and consolidated in one place because several agents shared the
file. They are kept here whole rather than filtered: several name parts SH-RPi
does not have (CM5, NVMe SSD, Homarr, the E7T connector), but the rows that do
apply — `montageschroeven`, `device tree overlay`, `opdruk`, `opdracht`,
`gereedschap`, `onderdeel`, `bit/s`, `installatiewizard`, `uitbreidingsprint` —
carry over unchanged, and deleting the rest would silently break the promise
that a shared row reads the same in both repositories.

SH-RPi's own additions go under `## SH-RPi terms`, not here.

| English | Translation | Note |
|:--------|:------------|:-----|
| desktop setup | opstelling op het bureau | Heading and repeated body term for the pre-installation bench test. Avoided *desktopopstelling*, which collides with the graphical desktop meaning tha |
| graphical desktop / desktop interface | grafische werkomgeving | The Raspberry Pi OS GUI. Kept distinct from *opstelling op het bureau* so the two English senses of "desktop" do not merge in Dutch. |
| splash screen | opstartscherm | Raspberry Pi OS boot logo screen; no glossary entry. |
| cable management | kabelbeheer | Glossary has *kabelroute* for cable routing, but this is the wider planning/tidiness sense used in the mounting-orientation list. |
| cable grommet | doorvoertule | Appears alongside *cable gland* (kabelwartel), so it needs its own word rather than being folded into the gland. |
| mounting hardware | bevestigingsmateriaal | Corrosion-resistant screws/brackets in the marine list. |
| mounting screws | montageschroeven | Used in three mounting steps and the materials list. |
| transportation damage | transportschade | Appears twice in troubleshooting (unseated CM5, undetected NVMe SSD). |
| ambient (temperature) | omgevingstemperatuur | Renders "-20°C to +60°C ambient" as a single Dutch noun rather than a loose adjective. |
| cable tester | kabeltester | Ethernet troubleshooting step. |
| circuit / dedicated circuit | groep | Dutch electrical-panel usage for a breaker circuit; *circuit* alone would read as an electronic circuit. Glossary already fixes *installatieautomaat*  |
| wire (conductor in a multi-core cable) | ader | "Red wire / black wire" are cores inside one cable, so *ader*, not *draad* or *kabel*. Glossary covers *aderdoorsnede* but not the bare noun. |
| positive / negative terminal | plusklem / minklem | Extends the glossary's plus (+) / min (−) to the terminal at the power source. |
| community forums | communityforums | Hat Labs support channel; *community* is established in Dutch, solid compound per rule 4. |
| rainbow pattern (LED) | regenboogpatroon | Names the LED fault pattern for an unseated CM5. |
| boot mode switch | bootmodusschakelaar | The switch next to the USB Boot connector on software.md. Solid compound per rule 4; "modus" is the established Dutch noun and "boot" stays as the unt |
| amber LED | amberkleurige led | The indicator next to the boot mode switch. Glossary fixes `led` lowercase but not the colour word; "amberkleurig" keeps the distinction from the red/ |
| mass storage device | massaopslagapparaat | What the HALPI2 appears as after `rpiboot` runs. Standard Dutch computing term, solid compound. |
| command line tool | opdrachtregelgereedschap | Used throughout the `halpi` section and in the H2 heading. "opdrachtregel" is the Dutch term for command line; "gereedschap" rather than "tool" keeps  |
| block device | blockdevice | Adopted English two-word term becomes one Dutch word (rule 4), same treatment as carrierboard/accesspoint. "blokapparaat" is not trade usage. |
| device node | apparaatknooppunt | The `/dev/ttyAMA*` entry in the Verifying section of interfaces.md. |
| hardware flow control | hardwarematige flowcontrol | The `ctsrts` parameter in interfaces.md. "flowcontrol" is the trade term; "stromingsregeling" would read as fluid dynamics. |
| chip select | chipselect | The CAN FD conflict row in the CTS/RTS table. One word, adopted whole. |
| Unix domain socket | Unix-domainsocket | The REST API transport. Proper name Unix takes exactly one hyphen at the junction (rule 4); the rest is one adopted word. |
| setup wizard | installatiewizard | The Raspberry Pi OS first-boot flow. "wizard" is established in Dutch software UI language. |
| update manager | updatebeheer | The graphical updates section. Matches the glossary's "beheer" pattern (systeembeheer, energiebeheer, containerbeheer). |
| port forwarding | port forwarding | Kept in English in the VNC section. Dutch network documentation uses the English term; "poortdoorschakeling" exists but is not what a reader will find |
| login console | inlogconsole | The dedicated debug UART `/dev/ttyAMA10` in interfaces.md. |
| silk screen (board legend) | opdruk | Appears three times on hardware.md (the Contacts arrows, the CM5 module outline). The glossary fixes quoted silkscreen *labels* but has no word for th |
| computer mainboard | hoofdprint van de computer | The Internal Layout bullet calls the carrier board "the computer mainboard". The glossary forbids *moederbord* but offers no alternative; *hoofdprint* |
| device tree overlay | device tree overlay | Kept in English in three places. It names a Raspberry Pi OS mechanism and the reader will meet it verbatim in `config.txt` and in HAT documentation; a |
| board-to-board connector | board-to-boardconnector | The CM5 mounting connectors, named seven times. Adopted English term becomes one Dutch word per rule 4, with the internal hyphens of the English term  |
| expansion board | uitbreidingsprint | Third-party HAT-compatible boards in the compatibility section. Distinct from *carrierboard*, so it needs its own word. |
| spudger | spudger | The non-conductive prying tool for the CM5. No Dutch equivalent in trade usage; the reader searching for one will search for *spudger*. |
| guitar pick | plectrum | Listed alongside the spudger as an alternative tool. *Plectrum* is the ordinary Dutch word. |
| to pry / to rock (a connector loose) | wrikken | Used for both the CM5 removal and the HAT removal ("gentle rocking motion"). One verb covers both senses in Dutch and keeps the two procedures reading |
| socket (hex tool) | dop / dopsleutel | The 26 mm / 10 mm / 8 mm / 17 mm sockets in the connector-removal step. Needed to be kept apart from *aansluiting*, which the glossary already uses fo |
| surface-mounted component | SMD-component | The components near the CM5 connectors that metal tools can damage. SMD is the established Dutch trade abbreviation. |
| countersunk screw | verzonken schroef | The four M4×10 lid screws. Matches the existing Dutch technical-reference page, which already writes "4× M4×10 verzonken, PH2-kop". |
| heat spreading area | warmteafvoervlak | The areas in the enclosure bottom that the CM5 thermal pads meet during final assembly. |
| Blinkenlights | Blinkenlights | Heading left untranslated, matching what the German, Swedish and French pages already do — it is a joke term, not a description. |
| Load Equivalency Number (LEN) | belastingsgetal (LEN) | NMEA 2000 network loading in interfaces.md. Parallel to the siblings (Lastkennzahl / indice de charge / belastningstal); the abbreviation LEN is kept  |
| voltage bar (LED pattern) | spanningsbalk | Names the LED bar acting as a charge-level gauge in the operation.md status table. Glossary has ledbalk for the physical LED bar; this is the pattern  |
| power button | aan/uit-knop | The CM5 power button and the front-panel button on both pages, including "simulated power button presses" (gesimuleerde drukken op de aan/uit-knop). E |
| transmit enable (signal/mode) | zendvrijgave / zendvrijgavesignaal | RS-485 manual vs automatic transmit enable in interfaces.md. Solid compound per rule 4; "zendinschakeling" would read as switching the transmitter on  |
| watchdog timeout | watchdog-time-out | LED table row and the 30-second communication timeout in operation.md. The glossary keeps "watchdog"; "time-out" is the Dutch spelling and already car |
| grace period | wachttijd | The 5-second window before automatic restart in operation.md. "Respijtperiode" is legal register and wrong here. |
| normally-open (NO) momentary switch | drukknop met maakcontact (normally open, NO) | External button wiring in interfaces.md. Dutch electrical trade says maakcontact; the English abbreviation is kept because it is what the switch packa |
| Battery-Backed RAM (BBR) | batterijgebufferd RAM (BBR) | u-blox GNSS settings storage in interfaces.md. Abbreviation kept for the u-blox documentation the reader will consult. |
| half-duplex mode | halfduplexmodus | RS-485 single-pair operation. Solid compound, no hyphen. |
| multi-talker / single-talker network | multi-talkernetwerk / single-talkertoepassing | NMEA 0183 topology terms in interfaces.md; kept in English as trade usage, joined solid to the Dutch noun per rule 4. "single-talker-multiple-listener |
| baud rate / update rate | baudrate / updatesnelheid | u-blox configuration table. "baudrate" already appears in docs/nl/user-guide/troubleshooting.md, so this only records it; "updatesnelheid" is new. |
| progressive fill / solid / dim red (LED states) | oplopende vulling / continu / gedempt rood | The LED quick-reference table in operation.md has no glossary coverage for the pattern vocabulary. "continu" matches "Continu geel" already used in tr |
| wake-up event | wekgebeurtenis | Standby mode admonition in operation.md. |
| Data Browser (Signal K) | Data Browser | Left in English: it is a UI string the reader sees in the Signal K interface on their own screen. |
| bps / kbps / Mbps (bit rate) | bit/s / kbit/s / Mbit/s | Extends the units-table row `250 kbps → 250 kbit/s` to bare and serial-port rates: `38400 bit/s`, `115200 bit/s`, `10 Mbit/s`. The "no thousands separator" bullet writes `115200 bps` only to illustrate the separator, not to license `bps`. |
| Bluetooth | Bluetooth | Capitalised, unlike `wifi`. Dutch trade writing keeps the trademark capital while `wifi` has genericised to lowercase. In compounds it is a proper name and takes exactly one hyphen at the junction (rule 4): `Bluetooth-antenne`, `Bluetooth-verbindingen` — never `bluetoothantenne`. |
| tool / utility | gereedschap | One word for both English nouns: `het gereedschap rpiboot`, `het gebruikelijke Linux CAN-gereedschap`, `het gereedschap Data Browser`. Never *hulpmiddel*, which reads as an aid rather than a program. Matches `opdrachtregelgereedschap`. |
| command | opdracht | `de opdracht shutdown`, `de volgende opdrachten`. Never *commando*, which in Dutch reads as a military order or a commando soldier. Matches `opdrachtregel`. |
| section (of this documentation) | onderdeel | Cross-references between pages: `in het onderdeel Toegang tot de behuizing`. Not *gedeelte* and not *sectie* — *sectie* is reserved for a section of a configuration file, e.g. the `[all]` section of `config.txt`. |
| Ethernet port | ethernetaansluiting | The RJ45 socket on the carrier board and on the panel. It is a board-mounted socket, so the glossary's *aansluiting* branch applies; not *ethernetpoort*. Other ports stay *poort* (`USB-poort`, `HDMI-poort`, `seriële poort`). |
| USB Boot connector | USB-bootconnector | Solid compound per rule 4, matching `USB-bootmodus` and `bootmodusschakelaar`. The silkscreen label itself stays verbatim and quoted: `de USB-C-connector met het opschrift “USB Boot”`. |
