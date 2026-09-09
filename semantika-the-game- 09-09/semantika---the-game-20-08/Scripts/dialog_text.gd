extends Control
class_name DialogText
var _step: float = 0.05
var _id: int = 0
var data: Dictionary

@export_category("Objects")
@export var _dialog: RichTextLabel = null

func _ready() -> void:
	_initialize_dialog()
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept") and _dialog.visible_ratio < 1:
		_step = 0.01
		return
	_step = 0.05
	if Input.is_action_just_pressed("ui_accept"):
		_id += 1
		if _id == data.size():
			queue_free()
		return
		
	_initialize_dialog()
	
func _initialize_dialog() -> void:
	_dialog.text = data[_id]["dialog"]
	_dialog.visible_characters = 0
	while _dialog.visible_ratio < 1:
		await get_tree().create_timer(_step).timeout
		_dialog.visible_characters += 1
		pass
		
