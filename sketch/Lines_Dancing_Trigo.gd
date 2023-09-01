extends GodotP5

var angle
var slow_rot
var num_lines = 13
var w2
var h2

func setup() -> void:
	set_title("Lines Dancing Trigo")
	set_viewport_mode(VIEWPORT_MODE.NEVER)
	createCanvas(640, 640)
	background(Color.BLACK, .75)
	strokeWeight(1)
	angle = 0
	slow_rot = 0
	w2 = width/2.0
	h2 = height/2.0

func _draw() -> void:
	m_translate(w2, h2)
	m_rotate(slow_rot)
	
	for i in range(num_lines):
		var rad = (angle + i*96) * TWO_PI / 360.0
		var x1 = sin(rad/10.0) * (w2-100)  + sin(rad/5.0) * 20
		var y1 = cos(rad/10.0) * (h2-100) + sin(rad)
		var x2 = sin(rad/10.0) * (w2-50) + sin(rad) * 2
		var y2 = cos(rad/20.0) * (h2-50) + sin(rad/12.0) * 20
		var n = i/float(num_lines)
		set_color(Color.from_hsv(slow_rot/10.0, n, n, n))
		line(x1, y1, x2, y2)

		x1 = sin(-rad/10.0) * (w2-100) - sin(-rad/5.0) * 20
		y1 = cos(-rad/10.0) * (h2-100) - sin(-rad)
		x2 = sin(-rad/10.0) * (w2-50) - sin(-rad) * 2
		y2 = cos(-rad/20.0) * (h2-50) - sin(-rad/12.0) * 20
		set_color(Color.from_hsv(.05+slow_rot/10.0, n, n, n))
		line(x1, x2, y1, y2)

		x1 = sin(PI+rad/10.0) * (w2-100) - sin(-rad/5.0) * 20
		y1 = cos(PI-rad/10.0) * (h2-100) - sin(-rad)
		x2 = sin(PI-rad/10.0) * (w2-50) - sin(-rad) * 2
		y2 = cos(PI+rad/20.0) * 250 - sin(-rad/12.0) * 20
		set_color(Color.from_hsv(.1+slow_rot/10.0, n, n, n))
		line(x1, x2, y1, y2)
		
		x1 = sin(PI/2.0-rad/10.0) * (w2-100) + sin(-rad/5.0) * 20
		y1 = cos(PI/4.0+rad/10.0) * (h2-100) + sin(-rad)
		x2 = sin(PI/4.0+rad/10.0) * (w2-50) + sin(-rad) * 2
		y2 = cos(PI/2.0-rad/20.0) * (h2-50) + sin(-rad/12.0) * 20
		set_color(Color.from_hsv(.15+slow_rot/10.0, n, n, n))
		line(x1, x2, y1, y2)

	angle += 10
	slow_rot += 0.001
