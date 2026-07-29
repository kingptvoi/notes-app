extends Control

@onready var fileDialog = $loadDialog
@onready var saveDialog = $saveDialog
@onready var textEdit = $TextEdit

var dragging: bool

var file_to_load: String
var file_to_save: String

var current_file: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DisplayServer.window_set_min_size(Vector2i(600, 750))
	DisplayServer.window_set_max_size(Vector2i(DisplayServer.screen_get_size()))

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _button_pressed(value: String) -> void:
	if value == "quit_button":
		get_tree().quit()
	if value == "save":
		#save_note(textEdit.text, "note1")
		saveDialog.visible = true
	if value == "load":
		fileDialog.visible = true
	if value == "new":
		pass

func save_note(text: String, file_name: String) -> void:
	var file = FileAccess.open(file_name, FileAccess.WRITE)
	file.store_string(text)
	file.close()
	
func load_note(file_name: String) -> String:
	if !FileAccess.file_exists(file_name):
		return ""

	var file = FileAccess.open(file_name, FileAccess.READ)
	var text = file.get_as_text()
	file.close()

	return text

func _on_load_dialog_file_selected(path: String) -> void:
	file_to_load = path
	textEdit.text = load_note(file_to_load)
	print(file_to_load)
	
func _on_save_dialog_file_selected(path: String) -> void:
	file_to_save = path
	save_note(textEdit.text, file_to_save)
	print(file_to_save)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and dragging:
			DisplayServer.window_start_drag()

#func _on_title_background_mouse_entered() -> void:
	#dragging = true
#
#func _on_title_background_mouse_exited() -> void:
	#dragging = false
