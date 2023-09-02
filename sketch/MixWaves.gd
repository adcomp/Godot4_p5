extends GodotP5

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
	set_title("Mix Waves")
	set_viewport_mode(VIEWPORT_MODE.ALWAYS)
	createCanvas(1000, 800)
	background(Color.BLACK)
	strokeWeight(1)
	step = width / 50
	waves = []
	for i in range(1, 4):
		waves.append(Wave.new(i*40 + randi_range(20,40), i*300 + randi_range(100, 300), i*PI/8 + randi_range(0, 4) * PI/4))

func _draw() -> void:
	var hue
	var y_sum
	for i in range(3):
		waves[i].phase += 0.0125
	for x in range(step, width, step):
		y_sum = 0
		for i in range(3):
			y_sum += waves[i].calculate(x)
		hue = remap(x, 0, width, 0, 1)
		stroke(Color.from_hsv(hue, 1,1,0.5))
		line(x, y_sum + height / 2, x, height / 2)
		stroke(Color(Color.ALICE_BLUE, 0.05))
		line(x, height / 2, x, -y_sum + height / 2)
		noStroke()
		fill(Color.from_hsv(hue, 1,1,0.5))
		circle(x, y_sum + height / 2, 4)
		circle(x, height / 2, 4)
		fill(Color(Color.ALICE_BLUE, 0.05))
		circle(x, -y_sum + height / 2, 4)
