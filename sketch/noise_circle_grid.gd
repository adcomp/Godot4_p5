extends GodotP5

var noise = FastNoiseLite.new()
var step_x
var step_y
var hue
var offset
var radius
var x_size
var y_size

func setup() -> void:
	set_title("Noise Circle Grid")
	set_viewport_mode(VIEWPORT_MODE.NEVER)
	createCanvas(800, 800)
	background(Color("black"))
	noStroke()
	step_x = 40
	step_y = 40
	x_size = width/step_x
	y_size = height/step_y
	offset = 0
	radius = (x_size+y_size)/5
	noise.seed = randi() % 1000
	noise.frequency = 0.1
	noise.fractal_octaves = 3

func _draw() -> void:
	for i in range(1, step_x):
		for j in range(1, step_y):
			hue = noise.get_noise_2d(offset+i, offset+j)
			hue = remap(hue, -1, 1, 0, 1)
			fill(Color.from_hsv(hue, 1, 1))
			circle(x_size*i, y_size*j, radius)
	offset += .025
