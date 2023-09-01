extends SubViewportContainer

### Set 'sketch' variable ( inside editor or code )
@export var sketch: GDScript

@onready var sketch_viewport: SubViewport = %SketchViewport
@onready var viewport_bg : ColorRect = %ViewportBg
@onready var canvas: Node2D = %Canvas
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var label_warning_msg: Label = $CanvasLayer/LabelWarningMsg
@onready var bt_menu = %BtMenu
@onready var panel = %Panel
@onready var lb_fps = %LabelFps
@onready var bt_current_color = %BtCurrentColor
@onready var img_save : Image
@onready var file_dialog = %FileDialog

var current_sketch_path: String = ""


func _ready() -> void:
	if sketch == null:
		label_warning_msg.visible = true
	else:
		current_sketch_path = sketch.get_path()
		load_sketch()
		bt_menu.show()
#	get_tree().root.connect("size_changed", _on_window_size_changed)
	
	## Need this to handle input ..
	sketch_viewport.handle_input_locally = true

func load_sketch():
	canvas.set_script(sketch)
	canvas.connect("set_background_color", set_background_color)
	canvas.connect("set_viewport_size", set_viewport_size)
	canvas.connect("set_current_color", set_current_color)
	canvas.sub_viewport = sketch_viewport
	canvas._init_from_main_scene()

func set_background_color(color:Color):
	viewport_bg.color = color

func set_viewport_size(viewport_size):
#	print("set viewport size : ", viewport_size)
	sketch_viewport.size = viewport_size
	sketch_viewport.size_2d_override = viewport_size
	viewport_bg.size = viewport_size
	DisplayServer.window_set_size(viewport_size)

func set_current_color(color):
	bt_current_color.color = color

func _on_window_size_changed():
	print("window size changed : ", get_viewport_rect().size)

func _on_bt_menu_pressed() -> void:
	panel.show()
	bt_menu.hide()

func _on_bt_hide_pressed() -> void:
	panel.hide()
	bt_menu.show()

func _on_bt_pause_pressed() -> void:
	print("on Button pause pressed ..")
	canvas.pause()

func _on_bt_restart_pressed() -> void:
	# reset viewport first !!
	sketch_viewport.size = Vector2.ZERO
	canvas.restart()

func _on_color_BtCurrentColor_changed(color: Color) -> void:
	canvas._current_color = color

func _on_bt_save_image_pressed() -> void:
	img_save = sketch_viewport.get_texture().get_image()
	file_dialog.show()

func _on_file_dialog_file_selected(path: String) -> void:
	img_save.save_png(path)

### can't use this inside subViewport ..? FIXME !!
func _unhandled_input(event: InputEvent) -> void:
	if sketch == null:
		return
	canvas._unhandled_input(event)
