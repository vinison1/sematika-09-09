extends Node
class_name uianaimation_componet

@export var animante_from_center : bool = true
@export var animante_scale : Vector2 = Vector2.ONE
@export var animantion_duration : float = 0.1
@export var transition_type : Tween.TransitionType
@export var  button_soud : AudioStream
@export var audio_player := AudioStreamPlayer.new()

var target : Control
var default_scale : Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = get_parent()
	call_deferred("setup")

func setup() -> void:
	target.mouse_entered.connect(_one_mouse_over)
	target.mouse_exited.connect(_one_mouse_out)
	if animante_from_center:
		target.pivot_offset = target.size / 2
	default_scale = target.scale
	
	if button_soud:
		audio_player.stream = button_soud
		add_child(audio_player)

func _one_mouse_over() -> void:
	init_tweed("scale", animante_scale, animantion_duration)
	

func _one_mouse_out() -> void:
	init_tweed("scale", default_scale, animantion_duration)


func init_tweed(property: String, value , duration : float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(target, property, value, duration).set_trans(transition_type)
