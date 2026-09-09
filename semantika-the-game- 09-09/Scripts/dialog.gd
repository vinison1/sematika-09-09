extends Control


##conexões de nodulo

@onready var label: Label = $Label
@onready var timer: Timer = $Timer
@onready var button: Button = $Button


## variaveis
var dialog_array : Array = [
	"Oi poderia me vender um pão?",
	"Sim só um pão...",
	"É tão dificil assim só me dar um pão cara?"
]
var dialog_index : int = 0:
	set(value):
		dialog_index = value
		label.visible_characters = -1
		


##funçoes
func _ready() -> void:
	label.text = ""
	timer.timeout.connect(animate_label)


func animate_label() -> void:
	if dialog_index >= dialog_array.size():
		return

	label.text = dialog_array[dialog_index]
	label.visible_characters += 1
	
	if label.visible_ratio == 1:
		dialog_index += 1
	else:
		timer.start()


func _on_button_pressed() -> void:
	if timer.is_stopped():
		animate_label()
	else:
		dialog_index += 1
		timer.stop()
