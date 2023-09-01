extends GodotP5

var n; var m
var x1; var y1
var x2; var y2
var radius = 2
var step = 32.0
var rot 

func setup() -> void:
	set_title("Sincos Trigo Dance")
	set_viewport_mode(VIEWPORT_MODE.NEVER)
	frameRate(30)
	createCanvas(640, 640)
	background(Color(0.05,0.05,0.1), 0.3)
	n = 0
	m = 0
	rot = 0

func _draw() -> void:
	m_translate(width/2, height/2)
	var a
	var n_rot = 0
	for i in range(step):
		a = TWO_PI / step * i
		m_rotate(-(rot + n_rot)/100.0)
		x1 = cos(a+m-n) * 20 + sin(.8*a+m*n) * width * 5 / 16
		y1 = sin(a+n-m) * 20 + cos(2*a+m*n) * height * 5 / 16
		x2 = cos(0.25 * a+(m*n)) * 15 + cos(.5*a+m*n) * width * 5 / 14.3
		y2 = sin(0.25 * a+(m*n)) * 15 + sin(.5*a+n) * height * 5 / 14.3
		
		set_color(Color(0.2,0.2,0.4,0.05))
		line(x1, y1, x2, y2)
		line(y1, x1, y2, x2)
		line(x2, y1, x1, y2)
		line(y2, x1, y1, x2)

		set_color(Color.from_hsv(a/TWO_PI, 1, 1, .9))
		circle(x1, y1, radius)
		circle(y1, x1, radius)
		
		set_color(Color.from_hsv(1-a/TWO_PI, 1, 1, .9))
		circle(x2, y2, radius)
		circle(y2, x2, radius)
		
		set_color(Color.from_hsv(1-a/TWO_PI/2, 1, 1, .9))
		circle(x1, y2, radius)
		circle(y1, x2, radius)
		
		set_color(Color.from_hsv(a/TWO_PI/2, 1, 1, .9))
		circle(x2, y1, radius)
		circle(y2, x1, radius)

		rot += n/step
		n_rot += n/step
		n += (0.000314 / step) * 3.14
	m += (0.0628 / step) *6.28
