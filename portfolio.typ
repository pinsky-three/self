#set page(
  paper: "a4",
  margin: (x: 0cm, y: 0cm),
  fill: black,
)

#let pinsky_three_csv = csv("pinsky_three.csv")

#let margin = 0.5cm


#align(image("pinsky_square.png", width: 50%), center + horizon)


#align(bottom)[
  #pad(x: margin*2, y: margin*2)[ 
    #text(font: "JetBrains Mono", fill: gray)[
      #link("https://github.com/pinsky-three/self")
    ]
  ]
]


#pagebreak()


#align(horizon)[
  #pad(
    x: margin*4, 
    y: margin,
  )[
    #pad(bottom: margin*2)[
      #image("pinsky_horizontal.png", width: 30%)
    ]
    #text(
      font: "JetBrains Mono",
      fill: gray, 
    )[
      #text(fill: white)[ENGLISH:]

      As an artist, I explore the intersection of mathematics, computing, and art to challenge the boundaries of perception and reality. My work is deeply inspired by concepts from topology, set theory, and systems dynamics, which I translate into visual narratives that evoke both intellectual curiosity and emotional resonance. Through generative processes, recursion, and algorithmic design, I create pieces that reflect the complexity and beauty of abstract systems, transforming mathematical ideas into vivid, tangible experiences.
      
      For me, art is not just a means of expression but a method of discovery—a way to "excavate" the intricate structures that exist beneath our understanding of the universe. By merging traditional techniques with computational approaches, I aim to reveal connections between the organic and the geometric, the natural and the constructed, the human and the infinite.

      Ultimately, my goal is to invite viewers into a space where logic meets intuition, and where the language of mathematics becomes an universal medium for storytelling and connection.
      #v(margin)

      #text(fill: white)[ESPAÑOL:]

      Como artista, exploro la intersección entre las matemáticas, la computación y el arte para desafiar los límites de la percepción y la realidad. Mi trabajo se inspira profundamente en conceptos como la topología, la teoría de conjuntos y los sistemas dinámicos, que traduzco en narrativas visuales que evocan tanto curiosidad intelectual como resonancia emocional. A través de procesos generativos, la recursión y el diseño algorítmico, creo piezas que reflejan la complejidad y belleza de los sistemas abstractos, transformando ideas matemáticas en experiencias vívidas y tangibles.

      Para mí, el arte no es solo un medio de expresión, sino un método de descubrimiento: una forma de "desenterrar" las estructuras intrincadas que subyacen a nuestra comprensión del universo. Al fusionar técnicas tradicionales con enfoques computacionales, busco revelar las conexiones entre lo orgánico y lo geométrico, lo natural y lo construido, lo humano y lo infinito.

      En última instancia, mi objetivo es invitar al espectador a un espacio donde la lógica se encuentra con la intuición, y donde el lenguaje de las matemáticas se convierte en un medio universal para narrar historias y crear conexiones.
    ]
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