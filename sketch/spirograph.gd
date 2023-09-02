extends GodotP5

var r1
var r2
var a1 = 0
var a2 = 0
var a1_step
var a2_step
var lastX
var lastY

func setup() -> void:
	set_title("SpiroGraph")
	set_viewport_mode(VIEWPORT_MODE.NEVER)
	createCanvas(800, 800)
	background(Color("black"))
	r1 = randi_range(100, 200)
	r2 = randi_range(100, 200)
	a1_step = randf_range(0.1, 5)
	a2_step = randf_range(0.1, 5)
	lastX = 0
	lastY = 0

func _draw() -> void:
	m_translate(width/2, height/2)
	for i in range(20):
		var x = r1 * cos(deg_to_rad(a1)) + r2 * cos(deg_to_rad(a2))
		var y = r1 * sin(deg_to_rad(a1)) + r2 * sin(deg_to_rad(a2))
		var hue = remap(cos(frameCount/200.0), -1, 1, 0, 1)
		stroke(Color.from_hsv(hue, 1, 1))
		line(lastX, lastY, x, y)
		lastX = x
		lastY = y
		a1 += a1_step
		a2 += a2_step
