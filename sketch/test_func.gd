extends GodotP5

func setup() -> void:
	set_title("")
	set_viewport_mode(VIEWPORT_MODE.NEVER)
	createCanvas(640, 640)
	background(Color("black"))

func mousePressed():
	# do something when mouse is pressed
	pass

func _draw() -> void:
	fill(Color.DARK_MAGENTA)
	stroke(Color.BLUE_VIOLET)
	strokeWeight(2)
	triangle(300, 300, 350, 300, 350, 350)

	fill(Color.GOLD)
	stroke(Color.CORAL)
	strokeWeight(1)
	rect(30, 30, 200, 120)

	fill(Color.CORNFLOWER_BLUE)
	stroke(Color.DODGER_BLUE)
	strokeWeight(8)
	quad(50, 200, 150, 200, 200, 300, 100, 300)

	fill(Color.BROWN)
	stroke(Color.CRIMSON)
	strokeWeight(3)
	beginShape()
	vertex(400, 400)
	vertex(450, 400)
	vertex(450, 450)
	vertex(450, 500)
	vertex(350, 550)
	endShape(true)

	fill(Color.CHARTREUSE)
	noStroke()
	circle(400, 100, 80, 64)

	if mouseIsPressed:
		fill(Color.GHOST_WHITE)
		circle(mouseX, mouseY, 10)

