extends Control

@export_file("*.json") var jsonsrc
var scene_script :  Dictionary
var current_block : Dictionary
var next_block : Dictionary

@export_category("scene reference")
@export var char_text : Label
@export var char_name : Label
@export var char_sprite : TextureRect

@export var BaseLayer : CanvasLayer
@export var ChoicesLayer : CanvasLayer

func _ready() -> void:
	get_json(jsonsrc)
	load_block(current_block)

func get_json(src: String):
	var jsontext = FileAccess.get_file_as_string(src)
	scene_script = JSON.parse_string(jsontext)
	current_block = scene_script["0"]

func load_block(block : Dictionary):
	if block.has("text"):	char_text.text = block["text"]
	if block.has("nome"):	char_name.text = block["nome"]

	if block.has("next"):
		var key = block["next"]
		next_block = scene_script[key]
	
	if block.has("escolha"):
		ChoicesLayer.show()
		ChoicesLayer.set_choices(block["escolha"])
	pass

func next():
	current_block = next_block
	load_block(current_block)
	pass
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		next()
