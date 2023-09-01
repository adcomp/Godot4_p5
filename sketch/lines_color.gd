extends GodotP5

var step = 0.00001
var n

func setup() -> void:
	set_title("Lines Color")
	set_viewport_mode(VIEWPORT_MODE.ALWAYS)
	frameRate(30)
	createCanvas(800, 800)
	background(Color("black"))
	strokeWeight(4)
	n = 0

func _draw() -> void:
	var p1
	var p2
	var color
	for i in range(0, width, 16):
		p1 = Vector2(i,  height/4 + cos(.3*n*i) * sin(.5*n*i) * height/3)
		p2 = Vector2(i, height/2 + sin(.1*n*i) * cos(.25*n*i) * height/2)
		stroke(Color.from_hsv(i/width, 1, 1, 1))
		line(p1.x, p1.y, p2.x, p2.y)
		n += step
