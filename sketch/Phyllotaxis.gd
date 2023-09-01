extends GodotP5

### The Coding Train ###
# Coding Challenge #30: Phyllotaxis
# https://www.youtube.com/watch?v=KWoJgHFYWxY

var n
var radius
var angle

### Play with these variables 
var angle_deg = 137.5
var step = 1

func setup() -> void:
	set_title("Phyllotaxis")
	set_viewport_mode(VIEWPORT_MODE.NEVER)
	createCanvas(600, 600)
	background(Color.BLACK)
	noStroke()
	n = 0
	radius = 8
	angle = deg_to_rad(137.5)

func _draw() -> void:
	m_translate(width/2, height/2)
	var a = n * angle
	var r = radius * sqrt(n)
	var x = r * cos(a)
	var y = r * sin(a)
	var hue = int(a) % 128 / 127.0
	fill(Color.from_hsv(hue, 1, 1))
	circle(x, y, radius)
	n += step
