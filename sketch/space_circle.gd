extends GodotP5

# based on "space prompt from Genuary 2022" by hbyhadeel
# https://www.youtube.com/watch?v=Q6XMoFjbjSs

var pts

class P:
	var x
	var y
	var size
	var r
	var t
	var col
	var c # canvas ref
	
	func _init(c) -> void:
		self.c = c
		r = randf() * c.width/2
		t = randf() * TWO_PI
		x = c.width/2 + cos(t) * r
		y = c.height/2 + sin(t) * r
		size = randf_range(0.5, 3)
		col = Color.from_hsv(randf_range(0.65, 0.85), 1, 1, .5)

	func update():
		r = remap(sin(t*50), -1, 1, 0, c.width/2 - 20)
		x = c.width/2 + cos(t) * r
		y = c.height/2 + sin(t) * r
		t += 0.0002

func setup() -> void:
	set_title("Space Circle")
	set_viewport_mode(VIEWPORT_MODE.ALWAYS)
	createCanvas(800, 800)
	background(Color("black"))
	noStroke()
	pts = []
	for i in range(200):
		pts.append(P.new(self))

func _draw() -> void:
	for i in range(200):
		fill(pts[i].col)
		circle(pts[i].x, pts[i].y, pts[i].size)
		pts[i].update()
