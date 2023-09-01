extends GodotP5

### The Coding Train ###
# Additive Waves - The Nature of Code
# https://www.youtube.com/watch?v=okfZRl4Xw-c

class Wave:
	var amplitude : float
	var period : float
	var phase : float
	
	func _init(amp, period, phase) -> void:
		self.amplitude = amp
		self.period = period
		self.phase = phase

	func calculate(x):
		return sin(self.phase + 2*PI * x / self.period) * self.amplitude

var waves : Array
var step : int

func setup() -> void:
	set_title("Additive Waves")
	set_viewport_mode(VIEWPORT_MODE.ALWAYS)
	createCanvas(1000, 800)
	background(Color.BLACK)
	noStroke()
	step = 4
	waves = []
	for i in range(5):
		waves.append(Wave.new(randi_range(20,80), randi_range(100,600), randf_range(0, 2*PI)))

func _draw() -> void:
	for i in range(5):
		waves[i].phase += 0.01
	var y
	for x in range(0, width, step):
		y = 0
		for i in range(5):
			y += waves[i].calculate(x)
		fill(Color.from_hsv(x/width, 1,1))
		circle(x,y + height / 2, step)
