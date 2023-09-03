extends GodotP5

var pts
var max_pt

class P:
	var x
	var y
	var size
	var vel
	var c # canvas ref
	
	func _init(c) -> void:
		self.c = c
		x = randf() * c.width
		y = randf() * c.height
		size = randf_range(1, 3)
		vel = Vector2.ONE.rotated(randf() * TAU) * randf_range(0.1, 1)

	func update():
		x += vel.x
		y += vel.y
		if x < 0 or x > c.width or y < 0 or y > c.height:
			vel = vel.rotated(PI/2)

func setup() -> void:
	set_title("Space Circle")
	set_viewport_mode(VIEWPORT_MODE.ALWAYS)
	createCanvas(800, 800)
	background(Color("black"))
	max_pt = 80
	pts = []
	for i in range(max_pt):
		pts.append(P.new(self))

func _draw() -> void:
	var dx
	var dy
	var alpha
	for i in range(max_pt):
		for j in range(max_pt):
			if i != j:
				dx = abs(pts[j].x - pts[i].x)
				dy = abs(pts[j].y - pts[i].y)
				if (dx < 100) and (dy < 100):
					alpha = remap(max(dx,dy), 0, 100, 0.65, 0)
					stroke(Color(Color.LIGHT_CYAN, alpha))
					line(pts[i].x, pts[i].y, pts[j].x, pts[j].y,)
		fill(Color.from_hsv(i/float(max_pt), 1, 1))
		circle(pts[i].x, pts[i].y, pts[i].size)
		pts[i].update()
