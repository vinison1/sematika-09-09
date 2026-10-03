extends Resource
class_name EnemyData

@export var nome : String = "monstro"
@export var textura : Texture2D
var rng = RandomNumberGenerator.new()
@export var damage: int = rng.randi_range(3,25)
@export var health : int = rng.randi_range(10,20)
