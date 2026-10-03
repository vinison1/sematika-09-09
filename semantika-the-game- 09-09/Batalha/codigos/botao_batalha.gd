extends TextureButton

@export var monstro: Array[EnemyData]
func _on_pressed() ->void:
	var random_monster = monstro.pick_random()
	SignalBus.monstro_selecionado = random_monster
	get_tree().change_scene_to_file("res://Batalha/Cena_Batalha/batalha.tscn")
