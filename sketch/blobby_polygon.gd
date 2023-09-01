extends GodotP5

var radius = 240
var step = 128
var n = 0
var m = 0
var s1 : float = 12
var s2 : float = 32

func setup() -> void:
	set_title("Blobby")
	set_viewport_mode(VIEWPORT_MODE.NEVER)
	createCanvas(640, 640)
	background(Color("black"), 0.1)
	stroke(Color.CRIMSON)
	strokeWeight(8)
	fill(Color.CORAL)

func _draw() -> void:
	m_translate(width/2, height/2)
	var p0
	var m_step = TWO_PI / step
	beginShape()
	for i in range(step):
		p0 = Vector2(radius + cos(m+n/s1) * sin(m+n/s2) * 40, 0).rotated(TWO_PI/step*i)
		vertex(p0.x, p0.y)
		m += m_step
	n += 0.6
	endShape(true)
