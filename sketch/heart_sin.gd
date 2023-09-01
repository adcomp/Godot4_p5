extends GodotP5

var num_arc = 16
var diam
var t = 0

func setup() -> void:
	set_title("Heart Sin")
	set_viewport_mode(VIEWPORT_MODE.ALWAYS)
	createCanvas(600, 600)
	background(Color("black"))
	strokeWeight(num_arc - 2)
	setPointCount(64)
	diam = width/2 - num_arc

func _draw() -> void:
	m_translate(width/2, height/2)
	var start
	var d
	for i in range(num_arc):
		stroke(Color.from_hsv(i / float(num_arc), 1, 1))
		start = sin(t + PI * i / num_arc) * PI / 2;
		d = diam * (i + 1) / num_arc
		arc(0, 0, d, d, start, -start - PI)
	t += .02
