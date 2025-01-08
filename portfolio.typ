#set page(
  paper: "a4",
  margin: (x: 0cm, y: 0cm),
)

#let pinsky_three_csv = csv("pinsky_three.csv")


#let margin = 0.5cm

#for row in pinsky_three_csv.slice(1) {
  // image(row.at(3))
  // row.at(3) + "\n"

  let description_parts = row.at(1).split("\n")
  let title = description_parts.at(0)
  let description = description_parts.slice(1).join("\n")
  
  // stack(dir: ltr, ..row.at(3).split(",").map(image))
  align(grid(..row.at(3).split(",").map(image), columns: 2), center)

  pad(
    text(
      title, 
      size: 16pt,
      font: "JetBrains Mono",
      weight: "bold"
    ),
    x: margin, 
    top: margin,
  )

  pad(
    text(
      description ,
      font: "JetBrains Mono",
    ),
    x: margin, 
    y: margin,
  )

  pagebreak()

}