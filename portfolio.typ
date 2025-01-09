#set page(
  paper: "a4",
  margin: (x: 0cm, y: 0cm),
  fill: black,
)

#let pinsky_three_csv = csv("pinsky_three.csv")

#let margin = 0.5cm


#align(image("pinsky_square.png", width: 50%), center + horizon)


#pagebreak()


#align(horizon)[
  #pad(
    x: margin*4, 
    y: margin,
  )[
    #pad(bottom: margin)[
      #image("pinsky_horizontal.png", width: 30%)
    ]
    #text(
      lorem(60),
      font: "JetBrains Mono",
      fill: white, 
    )
  ]
]
#pagebreak()

#for row in pinsky_three_csv.slice(1) {
  let description_parts = row.at(1).split("\n")
  let title = description_parts.at(0)
  let description = description_parts.slice(1).join("\n")
  
  align(grid(..row.at(3).split(",").map(image), columns: 2), center)

  pad(
    text(
      title, 
      size: 16pt,
      font: "JetBrains Mono",
      weight: "bold",
      fill: white,
    ),
    x: margin, 
    top: margin,
  )

  pad(
    text(
      description ,
      font: "JetBrains Mono",
      fill: white,
    ),
    x: margin, 
    y: margin,
  )

  pagebreak()

}