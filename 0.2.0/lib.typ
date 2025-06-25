// SORCK Symbols
#let cminus = $("C"^-)$
#let cminuslang = $("C"^-_"lang")$
#let cminuskurz = $("C"^-_"kurz")$
#let cplus = $("C"^+)$
#let cpluslang = $("C"^+_"lang")$
#let cpluskurz = $("C"^+_"kurz")$
#let cminusdurch = $(cancel("C")^-)$
#let cminusdurchlang = $(cancel("C")^-_"lang")$
#let cminusdurchkurz = $(cancel("C")^-_"kurz")$
#let cplusdurch = $(cancel("C")^+)$
#let cplusdurchlang = $(cancel("C")^+_"lang")$
#let cplusdurchkurz = $(cancel("C")^+_"kurz")$
#let remot = $("R"_"emot")$
#let rkog = $("R"_"kog")$
#let rmot = $("R"_"mot")$
#let rphys = $("R"_"phys")$
#let sit = $("S")$
#let citeparan(key) = [#cite(key, form: "author"), #cite(key, form: "year")]
#let citeprose(key) = [#cite(key, form: "prose")]


// Report for general patients
#let kvbericht(
  chiffre: none,
  datum: none,
  body,
) = {
  // General setup
  set text(lang: "de", font: "STIX Two Text", number-type: "lining", size: 10pt)
  show math.equation: set text(font: "STIX Two Math")
  set par(justify: true)
  set list(marker: [-])
  set heading(numbering: "1.1")
  show heading.where(level: 1): it => {
    set text(size: 11pt, font: "Fira Sans", weight: "semibold")
    block(counter(heading).display() + h(2mm) + it.body)
  }
  show heading.where(level: 2): it => {
    set text(size: 10pt, style: "italic", weight: "regular")
    block(it.body)
  }
  let datumfinal = if datum == none {
    datetime.today().display("[day].[month].[year]")
  } else {
    datum
  }

  // Chiffre auf der ersten Seite in der Kopfzeile, Seitennummern und Ränder
  set page(
    header: context if counter(page).get().at(0) == 1 {
      set text(size: 11pt, font: "Fira Sans", weight: "semibold")
      chiffre
    },
    margin: (left: 10mm, right: 10mm, top: 15mm, bottom: 15mm),
    numbering: (a, b) => [Seite #a von #b],
  )


  // Inhalt
  body


  // Literaturverzeichnis
  show heading: it => if it.body.text == "Literatur" {
    block(text(it.body, size: 11pt, font: "Fira Sans", weight: "semibold"))
  }
  show bibliography: set block(spacing: 0.7em)
  bibliography("refs.bib", style: "apa", title: "Literatur")


  // Signatur
  v(1em)
  grid(
    columns: (auto, 1fr, 1fr),
    column-gutter: 2em,
    row-gutter: 0.4em,
    align: bottom,
    box(width: 4cm, stroke: (bottom: 0.8pt), inset: (bottom: 0.2cm))[Dortmund, #datumfinal],
    line(length: 100%, stroke: (thickness: 0.8pt)),
    box(width: 100%, height: 7em, stroke: (bottom: 0.8pt, right: 0.8pt)),

    [Ort, Datum], [Dr. Benedikt Claus], [Stempel],
    [], [#text(size: 0.8em)[Psychologischer Psychotherapeut (VT)]],
  )
}
