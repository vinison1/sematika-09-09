extends CanvasLayer

@export var b_group : ButtonGroup

func _ready() -> void:
	b_group.pressed.connect(get_choice)

func set_choices(choices: Dictionary):
	print(choices)
	var index = 0
	var buttons = b_group.get_buttons()
	for c in choices.keys():
		print(c)
		buttons[index].text = c
		index += 1
	pass

func get_choice (b : Button):
	print(b)
