extends Control

@onready var enemy_texture:TextureRect= $"layout principal/area de batalha/lado inimigo/VBoxContainer/TextureRect"
@onready var enemy_health_bar: ProgressBar=$"layout principal/area de batalha/lado inimigo/VBoxContainer/Vida_Inimigo"
@onready var player_health_bar:ProgressBar=$"layout principal/area de batalha/lado do jogador/VBoxContainer/Vida_Jogador"
@onready var text_label:Label=$"layout principal/PanelContainer/Label"
@onready var run_button: Button = $"layout principal/run_button"
@onready var ataque: Button = $"layout principal/ataque"

var currect_enemy_health: int = 0
var enemy_damage:int = 0
var jogador :TextureRect



func _initialize (inimigo: EnemyData,player_ref:TextureRect):
	jogador=player_ref
	currect_enemy_health = inimigo.health
	enemy_damage = inimigo.damage
	
	enemy_health_bar.max_value  = inimigo.health
	enemy_health_bar.value = currect_enemy_health
	player_health_bar.max_value = jogador.max_health
	player_health_bar.value = jogador.vida_atual
	enemy_texture.texture = inimigo.textura
	text_label.text = "um "+ inimigo.name+" selvagem apareceu"


func _on_run_button_pressed() -> void:
	enemy_texture.hide()
	enemy_health_bar.hide()
	text_label.text = 'jogador fugiu'




func _on_ataque_pressed() -> void:
	text_label.text = 'jogador atacou'
