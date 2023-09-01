extends GodotP5

var radius = 250
var step = 128
var n = 0
var m = 0
var s1 : float = 24
var s2 : float = 48

func setup() -> void:
	set_title("Blobby")
	set_viewport_mode(VIEWPORT_MODE.NEVER)
	createCanvas(640, 640)
	background(Color("black"), 0.05)

func _draw() -> void:
	m_translate(width/2, height/2)
	var p0 = Vector2(radius + cos(m+n/s1) * sin(m+n/s2) * 30, 0)
	var p1
	var p2
	var color
	var m_step = TWO_PI / step
	for i in range(step):
		color = Color.from_hsv(i/(step*1.0), 1, 1, .65)
		p1 = Vector2(radius + cos(m+n/s1) * sin(m+n/s2) * 30, 0).rotated(TWO_PI/step*i)
		p2 = Vector2(radius + cos(m+m_step+n/s1) * sin(m+m_step+n/s2) * 30, 0).rotated(TWO_PI/step*(i+1))
		if i == step-1:
			draw_line(p1, p0, color, 4, true)
		else:
			draw_line(p1, p2, color, 4, true)
		m += m_step
	n += 0.6
	
	
