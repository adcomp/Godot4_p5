extends GodotP5

### The Coding Train ###
# Coding Challenge #74: Clock
# https://www.youtube.com/watch?v=E4RyStef-gY

var hr
var mn
var sc
var time

func _process(_delta: float) -> void:
	queue_redraw()
	
func setup() -> void:
	set_title("Clock")
	set_viewport_mode(VIEWPORT_MODE.ALWAYS)
	createCanvas(800, 800)
	background(Color.BLACK)

func _draw() -> void:
	m_translate(width/2, height/2)
	hr = hour()
	mn = minute()
	sc = second()
	
	var end_h = remap(hr, 0, 24, 0, TWO_PI) - PI/2
	var end_m = remap(mn, 0, 60, 0, TWO_PI) - PI/2
	var end_s = remap(sc, 0, 60, 0, TWO_PI) - PI/2

	draw_arc(Vector2.ZERO, 260, -PI/2, end_h, 60, Color.AQUAMARINE, 8, true)
	draw_arc(Vector2.ZERO, 280, -PI/2, end_m, 60, Color.DARK_ORCHID, 8, true)
	draw_arc(Vector2.ZERO, 300, -PI/2, end_s, 60, Color.LIGHT_CORAL, 8, true)

	draw_line(Vector2.ZERO, Vector2(200,0).rotated(end_h), Color.AQUAMARINE, 8, true)
	draw_line(Vector2.ZERO, Vector2(160,0).rotated(end_m), Color.DARK_ORCHID, 6, true)
	draw_line(Vector2.ZERO, Vector2(240,0).rotated(end_s), Color.LIGHT_CORAL, 4, true)
