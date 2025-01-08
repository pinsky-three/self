#set page(
  paper: "a4",
  margin: (x: 1cm, y: 1cm),
)

#let pinsky_three_csv = csv("pinsky_three.csv")



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
    // x: 0.5cm, 
    top: 0.5cm,
  )

  pad(
    text(
      description ,
      font: "JetBrains Mono",
    ),
    // x: 0.5cm, 
    y: 0.0cm,
  )

  pagebreak()

}