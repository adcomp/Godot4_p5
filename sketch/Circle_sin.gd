extends GodotP5

var num_circle = 6
var alpha

func setup() -> void:
	set_title("Circle Sin")
	set_viewport_mode(VIEWPORT_MODE.ALWAYS)
	createCanvas(1000, 400)
	background(Color("#101520"))
	strokeWeight(1)
	alpha = 0

func _draw() -> void:
	var x
	var y
	for i in range(1, num_circle):
		noFill()
		x = cos(alpha*i) * i*30
		y = sin(alpha*i) * i*30

		stroke(Color.from_hsv(i/float(num_circle), 1, 1, 0.25))
		line(x + 200, y + 200, 400, y + 200)
		
		stroke(Color.from_hsv(i/float(num_circle), 1, 1))
		circle(200, 200, i*30, i*32)
		
		circle(x + 200, y + 200, 6)
		circle(400, y + 200, 6)
		
#		noStroke()
		fill(Color.from_hsv(i/float(num_circle), 1, 1))
		for j in range(0, 560, 2):
			y = sin(alpha*i - j*TWO_PI/560) * i*30
			circle(400+j, y + 200, 2)
		
	alpha += 0.008
