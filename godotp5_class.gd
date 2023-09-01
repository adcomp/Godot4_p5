extends Node2D
class_name GodotP5

###	Godot Doc : class CanvasItem
#	https://docs.godotengine.org/en/stable/classes/class_canvasitem.html
###

###
# 	Link : https://p5js.org
# 	GodotP5 is based on p5js’s original goals, but I didn’t tie to p5js’s syntax. Some things are the same (like the setup() and createCanvas() functions), but other things are very different.
# 	I think that creative coding is a great way to practice the fundamentals of coding, which you can then apply to whatever you want.
###

signal set_background_color
signal set_viewport_size
signal set_current_color

### Class variable
enum VIEWPORT_MODE {ALWAYS, NEVER, ONCE}
var _is_loaded : bool = false
var sub_viewport: SubViewport
var _current_bg_color: Color = Color.BLACK
var _current_color: Color = Color.WHITE

### VAR P5JS
var width : float = 100
var height : float = 100
var displayWidth: float
var displayHeight: float
var windowWidth: float
var windowHeight: float

var frameCount: int = 0
var deltaTime: float

var mouseX : int = 0
var mouseY : int = 0
var mouseIsPressed : bool = false
var mouseButton
var pmouseX
var pmouseY
var movedX
var movedY

var keyIsPressed
var key
var keyCode

const TWO_PI = TAU
const HALF_PI = PI/2.0
const QUARTER_PI = PI/4.0


### P5JS FUNC / VAR
var _fill_color: Color = Color.WHITE
var _stroke_color: Color = Color.GRAY
var _stroke_weight: int = 1
var _no_stroke: bool = false
var _no_fill: bool = false
var _matrix_transform = Transform2D()
var _matrix_transform_saved
var _is_looping: bool = true
var _point_count: int = 32

# beginShape/endShape array
var _shape_array: Array
var _shape_mode

var _antialiased: bool = true


func _init_from_main_scene():
	setup()
	_is_loaded = true

	if _is_looping == false:
		# need to call _draw at least one time ?
		queue_redraw()
	else:
		loop()

func set_title(title:String) -> void:
	DisplayServer.window_set_title(title)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _unhandled_input(event: InputEvent) -> void:

	if event is InputEventMouseMotion:
		pass

	if event is InputEventKey:
		if event.is_pressed():
			keyIsPressed = true
		else:
			keyIsPressed = true
		key = event.as_text_physical_keycode()

	if event is InputEventMouseButton:
		if event.is_pressed():
			mouseIsPressed = true
		else:
			mouseIsPressed = false
		match event.button_index:
			1: mouseButton = "LEFT"
			2: mouseButton = "CENTER"
			3: mouseButton = "RIGHT"

func _on_viewport_size_changed() -> void:
	width = get_viewport_rect().size.x
	height = get_viewport_rect().size.y

func set_viewport_mode(mode: VIEWPORT_MODE) -> void:
	match mode:
		VIEWPORT_MODE.ALWAYS:
			sub_viewport.render_target_clear_mode = SubViewport.CLEAR_MODE_ALWAYS
		VIEWPORT_MODE.NEVER:
			sub_viewport.render_target_clear_mode = SubViewport.CLEAR_MODE_NEVER
		VIEWPORT_MODE.ONCE:
			sub_viewport.render_target_clear_mode = SubViewport.CLEAR_MODE_ONCE

func _process(delta: float) -> void:
	if _is_loaded:
		if _is_looping:
			queue_redraw()
			frameCount += 1
			deltaTime = delta
			_reset_matrix()
	else:
		return
	
	if mouseIsPressed:
		mousePressed()

	var mouse_pos = get_local_mouse_position()
	mouseX = mouse_pos.x
	mouseY = mouse_pos.y

##	change to loop() / noLoop()
func pause() -> void:
	if is_processing():
		set_process(false)
	else:
		set_process(true)

##	make it _local_
func restart() -> void:
	setup()



### Rendering
func createCanvas(w:int, h:int):
	height = h
	width = w
	set_viewport_size.emit(Vector2i(w, h))

func resizeCanvas(): pass
func noCanvas(): pass


### Settings
func background(color : Color, alpha: float = -1) -> void:
	if alpha != -1:
		set_background_color.emit(Color(color, alpha))
	else:
		set_background_color.emit(Color(color, 0))
	RenderingServer.set_default_clear_color(color)
	_current_bg_color = color

func clear():
	### NEED TO BE REWRITE 
	draw_rect(Rect2(0, 0, width, height), _current_bg_color, true)
	
func noStroke():
	_no_stroke = true

func noFill():
	_no_fill = true

func fill(color: Color) -> void:
	_fill_color = color
	_no_fill = false

func stroke(color: Color) -> void:
	_stroke_color = color
	_no_stroke = false

func set_color(color:Color):
#	set_current_color.emit(color)
	_current_color = color
	_stroke_color = color
	_fill_color = color
	_no_fill = false
	_no_stroke = false

func setPointCount(point_count):
	_point_count = point_count

### Environment
func cursor(): pass
func noCursor(): pass
func windowResized(): pass
func fullscreen(): pass

func frameRate(fps:int) -> void:
	Engine.max_fps = fps

func getTargetFrameRate():
	return Engine.max_fps 


### Shape
# void draw_polyline ( PackedVector2Array points, Color color, float width=-1.0, bool antialiased=false )
# void draw_arc ( Vector2 center, float radius, float start_angle, float end_angle, int point_count, Color color, float width=-1.0, bool antialiased=false )
# void draw_polygon ( PackedVector2Array points, PackedColorArray colors, PackedVector2Array uvs=PackedVector2Array(), Texture2D texture=null )

func circle(x:float, y:float, radius:float, point_count: int = 32):
	if _no_fill == false:
		draw_circle(Vector2(x,y), radius, _fill_color)
	if _no_stroke == false:
		draw_arc(Vector2(x,y), radius, 0, TAU, point_count, _stroke_color, _stroke_weight, _antialiased)

func line(x0:float, y0:float, x1:float, y1:float):
	if _no_stroke:
		return
	draw_line(Vector2(x0, y0), Vector2(x1, y1), _stroke_color, _stroke_weight, _antialiased)

func arc(x, y, w, h, start, stop):
	draw_arc(Vector2(x,y), w, start, stop, _point_count, _stroke_color, _stroke_weight, _antialiased)

func ellipse(): pass

func point(x, y):
	circle(x, y, _stroke_weight)

func quad(x1, y1, x2, y2, x3, y3, x4, y4, detailX = -1, detailY = -1):
	var pca = PackedVector2Array()
	pca.append(Vector2(x1, y1))
	pca.append(Vector2(x2, y2))
	pca.append(Vector2(x3, y3))
	pca.append(Vector2(x4, y4))
	
	if _no_fill == false:
		draw_polygon (pca, PackedColorArray([_fill_color]))
	if _no_stroke == false:
		pca.append(Vector2(x1, y1))
		draw_polyline(pca, _stroke_color, _stroke_weight, _antialiased)

func rect(x, y, w, h):
	quad(x, y, x + w, y, x + w, y + h, x, y + h)
#	if _no_fill == false:
#		draw_rect(Rect2(x, y, w, h), _fill_color, true)
#	if _no_stroke == false:
#		draw_rect(Rect2(x, y, w, h), _stroke_color, false, _stroke_weight)

func square(x, y, s):
	rect(x, y, s, s)

func triangle(x1, y1, x2, y2, x3, y3):
	var pca = PackedVector2Array()
	pca.append(Vector2(x1, y1))
	pca.append(Vector2(x2, y2))
	pca.append(Vector2(x3, y3))

	if _no_fill == false:
		draw_polygon (pca, PackedColorArray([_fill_color]))
	if _no_stroke == false:
		pca.append(Vector2(x1, y1))
		draw_polyline(pca, _stroke_color, _stroke_weight, _antialiased)

func beginShape(shape_mode = -1):
	# set shape mode !!!
	_shape_array = []

func endShape(close = false):
	if close:
		_shape_array.append(_shape_array[0])
	
	var pca = PackedVector2Array(_shape_array)
	if _no_fill == false:
		draw_polygon (pca, PackedColorArray([_fill_color]))
	if _no_stroke == false:
		draw_polyline(pca, _stroke_color, _stroke_weight, _antialiased)

func vertex(x, y):
	_shape_array.append(Vector2(x,y))

func ellipseMode(): pass
func rectMode(): pass

func noSmooth():
	_antialiased = false

func smooth():
	_antialiased = true

func strokeCap(): pass
func strokeJoin(): pass

func strokeWeight(w: int):
	_stroke_weight = w

func bezier(): pass
func bezierDetail(): pass
func bezierPoint(): pass
func bezierTangent(): pass
func curve(): pass
func curveDetail(): pass
func curveTightness(): pass
func curvePoint(): pass
func curveTangent(): pass


### Structure
func setup() -> void: pass
# preload already exist in godot
# func preload(): pass
func _draw() -> void: pass

func noLoop():
	print("call no loop .. !!")
	_is_looping = false
	set_process(false)

func loop() -> void:
	_is_looping = true
	set_process(true)

func isLooping() -> bool:
	return _is_looping

func push():
	_matrix_transform_saved = _matrix_transform

func pop():
	_matrix_transform = _matrix_transform_saved
	self.transform = _matrix_transform


### Transform

# !!!
# void draw_set_transform ( Vector2 position, float rotation=0.0, Vector2 scale=Vector2(1, 1) )
# void draw_set_transform_matrix ( Transform2D xform )
# !!!

func m_rotate(angle: float) -> void:
	# Rotating the transformation matrix
	_matrix_transform.x.x = cos(angle)
	_matrix_transform.y.y = cos(angle)
	_matrix_transform.x.y = sin(angle)
	_matrix_transform.y.x = -sin(angle)
	self.transform = _matrix_transform

func m_translate(x: float, y: float) -> void:
	# Translating the transformation matrix
	_matrix_transform.origin = Vector2(x, y)
#	_matrix_transform = _matrix_transform.translated(Vector2(x, y))
	self.transform = _matrix_transform

func _reset_matrix():
	_matrix_transform.origin = Vector2.ZERO
	_matrix_transform.x = Vector2(1, 0)
	_matrix_transform.y = Vector2(0, 1)
	self.transform = _matrix_transform

func applyMatrix(): pass
func resetMatrix(): pass

# already exist in Node2D ###
# func rotate(): pass
# func scale(): pass
# func translate(): pass

func shearX(): pass
func shearY(): pass



### Time & Date
func day(): pass
func month(): pass
func year(): pass

func hour():
	return Time.get_time_dict_from_system().hour

func minute():
	return Time.get_time_dict_from_system().minute

func second():
	return Time.get_time_dict_from_system().second

func millis(): pass


### Mouse
func mouseMoved(): pass
func mouseDragged(): pass
func mousePressed(): pass
func mouseReleased(): pass
func mouseClicked(): pass
func doubleClicked(): pass
func mouseWheel(): pass
func requestPointerLock(): pass
func exitPointerLock(): pass


### Keyboard
func keyPressed(): pass
func keyReleased(): pass
func keyTyped(): pass
func keyIsDown(): pass


### Image
func createImage(): pass
func saveCanvas(): pass
func saveFrames(): pass
