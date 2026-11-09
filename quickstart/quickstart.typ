// SH-RPi Quick Start Guide. README.md describes the sheet, the panel order
// and the folding.

// The source revision, e.g. "2026-10-28 11299c7", which ./run passes in so a
// printed guide can be traced to its source.
#let revision = sys.inputs.at("revision", default: none)
#let guides = sys.inputs.at("guides", default: "false") == "true"
// Replaces every panel with its name and orientation markers, for checking
// the duplex imposition.
#let labels = sys.inputs.at("labels", default: "false") == "true"

#let strip-length = 297mm
#let strip-height = 105mm
#let panel-count = 4
#let panel-width = strip-length / panel-count
#let panel-height = strip-height
// Keeps content clear of the printer's unprintable edge, the centre cut and
// the folds, with room for duplex misregistration.
#let margin = 6mm
#let content-width = panel-width - 2 * margin
#let content-height = panel-height - 2 * margin

#let ink = rgb("#2e2014")
#let band-grey = rgb("#b0b4bd")
#let link-blue = rgb("#2a5ea0")
#let guide-colour = rgb("#e0007a")

#set document(title: "SH-RPi Quick Start Guide", author: "Hat Labs Oy")
#set page(paper: "a4", margin: 0pt)
#set text(
  font: "IBM Plex Sans",
  size: 8pt,
  fill: ink,
  lang: "en",
  hyphenate: false,
)
#set par(leading: 0.62em, spacing: 0.9em)
// The source text uses straight apostrophes.
#set smartquote(enabled: false)
// Never break the product name at its hyphen.
#show "SH-RPi": box

#set heading(outlined: false, bookmarked: false)
#show heading: it => block(above: 1.1em, below: 0.75em, text(
  font: "IBM Plex Mono",
  size: 12pt,
  weight: "regular",
  it.body,
))

#let diamond = box(baseline: 0.2pt, polygon(
  stroke: 0.5pt + ink,
  (2.2pt, 0pt),
  (4.4pt, 2.2pt),
  (2.2pt, 4.4pt),
  (0pt, 2.2pt),
))
#set list(marker: diamond, indent: 0.3em, body-indent: 0.6em, spacing: 0.65em)

// A labelled web address. Print readers type the address, so it has no
// scheme, and the monospace face keeps characters such as l and 1 apart.
#let site(name, address) = block(above: 1.1em, below: 1.1em, {
  text(weight: "bold", name)
  linebreak()
  text(font: "IBM Plex Mono", size: 7.5pt, address)
})

#let email(address) = link("mailto:" + address, text(fill: link-blue, address))

#let label-body(name) = {
  place(top + left, text(size: 10pt)[#(name)TL])
  place(bottom + right, text(size: 10pt)[#(name)BR])
  place(center + horizon, align(center, text(size: 28pt)[↑ \ UP \ #name]))
}

// One panel is an independent block: its content must fit inside the
// margins, otherwise compilation fails instead of text silently spilling
// across a fold.
#let panel(name, body) = block(
  width: panel-width,
  height: panel-height,
  inset: margin,
  if labels { label-body(name) } else {
    context {
      let size = measure(block(width: content-width, body))
      assert(
        size.height <= content-height,
        message: "panel " + name + " overflows by " + repr(size.height - content-height),
      )
      body
    }
  },
)

// Front side.

#let f1 = [
  = Powering the SH-RPi

  Connect a power source to the connector labeled "9-32V IN". You can power the SH-RPi from any 12/24~V electrical system via a suitable electrical connector. Since terminal plugs provide no strain relief, it is recommended to have a separate panel connector on the enclosure.

  When installing in an automotive or marine environment, protect the power cable with a 1--4~A fuse at the source end. The fuse must be sized to protect the wiring; there is a separate fuse on the SH-RPi itself to protect the electronics.

  It is possible to power the SH-RPi via the NMEA 2000 bus. For details, see the documentation website.

  *NOTE:* Connecting an input voltage to the "5V OUT" socket can destroy both the SH-RPi and any boards connected to it. Plug an unused screw terminal connector to the "5V OUT" socket to avoid costly and annoying mistakes!
]

#let f2 = [
  *NOTE 2:* Do not power the Raspberry Pi using the standard USB-C port when the SH-RPi is connected.

  = Software Installation

  The automatic shutdown feature requires a service software to be installed on the Raspberry Pi. For installation instructions, refer to the SH-RPi documentation website.

  = Links

  For further information, visit the following sites:

  #site[Hat Labs][hatlabs.fi]
  #site[SH-RPi documentation][docs.hatlabs.fi/sh-rpi]
  #site[Discussion board][github.com/hatlabs/discussions]
]

// The back cover also carries Warranty and DoC: the SH-RPi text fills the
// other panels.
#let f3 = {
  [
    = Warranty and Support

    The SH-RPi comes with a two year manufacturer warranty. If you think your device is defective, contact Hat Labs at #email("info@hatlabs.fi") and we will help you out.

    = Declaration of Conformity

    SH-RPi is in conformity with the relevant European Union harmonisation legislation.
  ]
  v(1fr)
  align(center, {
    image("images/hat-labs-logo.svg", height: 12mm)
    v(3mm)
    [Hat Labs Oy \ hatlabs.fi \ #email("info@hatlabs.fi")]
  })
  v(1fr)
  if revision != none { place(bottom + right, text(size: 6pt, revision)) }
}

#let f4 = {
  block(width: 100%, fill: band-grey, inset: (x: 4mm, y: 3mm), grid(
    columns: (1fr, auto),
    align: top,
    text(size: 15pt, fill: white, top-edge: "cap-height")[SH-RPi v2 \ Quick Start \ Guide],
    image("images/hat-labs-logo.svg", height: 10mm),
  ))
  v(1fr)
  image("images/sh-rpi-board.jpg", width: 100%)
}

// Back side.

#let b1 = [
  = Introduction

  Congratulations on your new Sailor Hat for Raspberry Pi (SH-RPi) marine electronics headwear! SH-RPi is a smart power supply and reserve power board for the Raspberry Pi and compatible single-board computers.

  The SH-RPi protects and powers your Raspberry Pi when connected to noisy voltage sources common in marine and automotive environments. It also lets you treat the computer as an autonomous device or appliance: switch the power off, and the Pi will shut itself down automatically, with no data loss or disk corruption.

  This document will help you get started with SH-RPi. More detailed documentation is available at the SH-RPi documentation website, the address of which is provided in the Links section.
]

#let b2 = [
  = Package Contents

  Check that the package contains the following items:

  - SH-RPi board
  - A goodie bag with the following contents:
    - 40-pin stack-through connector
    - Green 3.81~mm terminal block plug connector for power input and output
    - Green 2.54~mm terminal block plug connector for optional 5~V output
    - 8 x 2.54~mm jumper headers
    - Assortment of fasteners
]

#let b3 = [
  = Assembly

  First, insert the provided 40-pin stack-through connector to the SH-RPi from the bottom side of the board. Apply even, gentle pressure to avoid bending any of the pins.

  Attach the Sailor Hat on top of the Raspberry Pi by plugging the SH-RPi stack-through connector on top of the Raspberry Pi GPIO header. For added mechanical stability, use the provided standoffs and pan head screws to attach the SH-RPi to the Raspberry Pi.

  #align(center, image("images/sh-rpi-assembly.jpg", height: 45mm))
]

#let b4 = [
  = Enclosure

  An enclosure is recommended for environmental and mechanical protection. When used indoors and in a non-condensing environment, a simple well ventilated enclosure is sufficient.

  If used outdoors, on a boat or in a car or in a vehicle, the Raspberry Pi computer and the SH-RPi hat should be placed in a protective waterproof enclosure. Humidity and water commonly present in these environments are harmful to electronics, and the circuit board connectors and wiring are not suited for being directly connected to the boat electrical system.

  Enclosures, mounting adapters and panel connectors are available on the Hat Labs online shop, or you can supply your own.
]

// A strip in reading orientation, panels left to right.
#let strip(panels) = stack(dir: ltr, ..panels.pairs().map(((name, body)) => panel(name, body)))

// Long-edge duplex backs sheet point (x, y) with (210 mm − x, y). With the
// front strip turned counterclockwise, that puts the back strip, as read
// after turning it over, turned clockwise.
#let side(angle, panels) = {
  let s = rotate(angle, reflow: true, strip(panels))
  // Rotated, a strip is as wide on the sheet as it is tall when read.
  grid(columns: (strip-height, strip-height), s, s)
}

#set page(foreground: if guides {
  for k in range(1, panel-count) {
    place(top + left, dy: k * panel-width, line(
      length: 2 * strip-height,
      stroke: (paint: guide-colour, thickness: 0.3pt, dash: "dashed"),
    ))
  }
  place(top + left, dx: strip-height, line(
    angle: 90deg,
    length: strip-length,
    stroke: 0.3pt + guide-colour,
  ))
})

#side(-90deg, (F1: f1, F2: f2, F3: f3, F4: f4))
#pagebreak()
#side(90deg, (B1: b1, B2: b2, B3: b3, B4: b4))
