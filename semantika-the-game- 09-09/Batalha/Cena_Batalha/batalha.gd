extends Control
@export var monstro_possiveis: Array[EnemyData]
@onready var jogador:Jogador =$"layout principal/area de batalha/CharacterBody2D"
@onready var textura_inimigo: TextureRect = %enemy
@onready var enemy_health_bar: ProgressBar = %Vida_Inimigo
@onready var player_health_bar: ProgressBar =%Vida_Jogador
@onready var text_label: Label = %Label
@onready var textura_botao:TextureButton =$"layout principal/PanelContainer/HBoxContainer/HBoxContainer2/ataque"
@onready var correr: TextureButton = $"layout principal/PanelContainer/HBoxContainer/HBoxContainer/run"
var monstros_derrotados = 0
var monstros_totais = 3
# Variáveis para guardar as referências de dados
var current_enemy_health: int = 0
var enemy_damage: int = 0

func esconder():
	textura_botao.hide()
	correr.hide()
	enemy_health_bar.hide()
	player_health_bar.hide()
func monstrar():
	correr.show()
	textura_botao.show()
	enemy_health_bar.show()
	player_health_bar.show()
	

func _ready() -> void:
	var inimigo = SignalBus.monstro_selecionado
	if inimigo != null and jogador != null:
		esconder()
		current_enemy_health = inimigo.health
		enemy_damage = inimigo.damage
		textura_inimigo.texture = inimigo.textura
		text_label.text = "um "+inimigo.nome+" selvagem apareceu"
		await get_tree().create_timer(1.5).timeout
		monstrar()
		enemy_health_bar.max_value = inimigo.health
		enemy_health_bar.value = current_enemy_health
		player_health_bar.max_value = jogador.vida
		player_health_bar.value = jogador.vida_atual

func _on_run_pressed():
	correr.get_node("uianaimation_componet").cleanup()
	textura_inimigo.hide()
	enemy_health_bar.hide()
	text_label.text = 'jogador fugiu'
	textura_botao.disabled = true
	correr.disabled = true
	await get_tree().create_timer(2.5).timeout
	get_tree().change_scene_to_file("res://cenas/Titulo.tscn")


func _on_ataque_pressed():
	textura_botao.get_node("uianaimation_componet2").cleanup()
	textura_botao.disabled = true
	correr.disabled = true
	
	#dano "falso"
	var rng = RandomNumberGenerator.new()
	var dano_ataque = rng.randi_range(5,20)
	var sorte = rng.randi_range(1,15)
	const dano_critico = 7 
	#dano critico se sorte for igual a 7
	if sorte == dano_critico: 
		var dano = rng.randi_range(15,40)
		current_enemy_health -= dano
		enemy_health_bar.value = current_enemy_health
		text_label.text = 'voce causou '+str(dano)+' de dano critico'
	else: 
		current_enemy_health -= dano_ataque
		enemy_health_bar.value = current_enemy_health
		text_label.text = 'voce causou '+str(dano_ataque)+' de dano'
	
	#pausa de 1 segundo
	await get_tree().create_timer(1.0).timeout
	
	#função de vitoria ou turno do inimigo
	if current_enemy_health <= 0:
		monstros_derrotados += 1
		if monstros_derrotados >= monstros_totais:
			vitoria()
		else:
			buscar_monstro()
			cura()
	else:
		turno_inimigo()

func turno_inimigo():
	var rng = RandomNumberGenerator.new()
	text_label.text='o inimigo atacou'
	await get_tree().create_timer(1.0).timeout
	var esquiva = rng.randi_range(1,10)
	var esquivou = 8
	if esquiva > esquivou:
		text_label.text = "voce esquivou do ataque inimigo"
	else: 
		jogador.vida_atual -= enemy_damage
		player_health_bar.value = jogador.vida_atual
		text_label.text = 'voce recebeu '+str(enemy_damage)+' de dano'
	
	await get_tree().create_timer(1.0).timeout
	
	#checar se o jogador morreu
	if jogador.vida_atual <= 0 :
		text_label.text = 'voce foi derrotado...'
		await get_tree().create_timer(2.5).timeout
		jogador.hide()
		player_health_bar.hide()
		get_tree().change_scene_to_file("res://cenas/Titulo.tscn")
		# colocar alguma tela de morte
		#get_tree()
	else:
		textura_botao.disabled = false
		correr.disabled = false
		text_label.text = 'agora e a sua vez'

func vitoria():
	text_label.text = 'voce venceu'
	await get_tree().create_timer(1.5).timeout
	textura_inimigo.hide()
	enemy_health_bar.hide()
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://cenas/Titulo.tscn")

func buscar_monstro():
	text_label.text = "Você derrotou o monstro"
	await get_tree().create_timer(1.5).timeout
	
	var novo_inimigo = monstro_possiveis.pick_random()
	current_enemy_health = novo_inimigo.health
	enemy_damage = novo_inimigo.damage
	
	# 4. Atualiza a interface gráfica
	textura_inimigo.texture = novo_inimigo.textura
	enemy_health_bar.max_value = novo_inimigo.health
	enemy_health_bar.value = current_enemy_health
	text_label.text = "Um novo " + novo_inimigo.nome + " selvagem apareceu!"
	
	# 5. Faz a imagem e a barra do monstro reaparecerem na tela
	textura_inimigo.show()
	enemy_health_bar.show()
	
	# 6. Reativa os botões para o jogador poder voltar a agir
	textura_botao.disabled = false
	correr.disabled = false

func cura():
	player_health_bar.value = jogador.vida_atual + 20 
#get_tree().change_scene_to_file("res://cenas/Titulo.tscn")
