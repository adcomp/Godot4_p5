extends GodotP5

func setup() -> void:
	set_title("Draw With Mouse")
	set_viewport_mode(VIEWPORT_MODE.NEVER)
	createCanvas(640, 640)
	background(Color("black"))

func _draw() -> void:
	if mouseIsPressed:
		circle(mouseX, mouseY, 10)
