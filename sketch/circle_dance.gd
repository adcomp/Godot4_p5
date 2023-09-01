extends GodotP5

var n
var m
var x
var y
var radius = 8

func setup() -> void:
	set_title("")
	set_viewport_mode(VIEWPORT_MODE.NEVER)
	createCanvas(800, 800)
	background(Color("black"), 0.15)
	n = 0
	m = 0

func _draw() -> void:
	m_translate(width/2, height/2)
	noFill()
	stroke(Color(.1,.1,.2))
	circle(0, 0, width*.47, 64)

	for i in range(1, 17):
		var ii = .2 + .0001*i
		var phase = i/10.0
		x = cos(phase+ii*n + m*TWO_PI/width) * sin(phase+ii*m + n*TWO_PI/width) * width/3
		y = cos(phase+ii*m*(m-n)*TWO_PI/height) * sin(phase + ii*m + n*TWO_PI/height) * height/3
		set_color(Color.from_hsv(1-phase/4, 1, 1, .5))
		circle(x,y, radius)
		circle(y,x, radius)
	n += 0.05
	m += 0.1
