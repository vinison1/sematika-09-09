extends TextureRect


@export var vida: int = 100
@export var monstro: Array[EnemyData]
var vida_atual: int

func _ready():
	#inicia a vida do jogador quando o jogo começa
	vida_atual = vida
