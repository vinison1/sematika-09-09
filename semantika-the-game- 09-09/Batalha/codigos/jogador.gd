extends CharacterBody2D
class_name Jogador
@export var vida: int = 100
var vida_atual: int



func _ready():
	#inicia a vida do jogador quando o jogo começa
	vida_atual = vida
