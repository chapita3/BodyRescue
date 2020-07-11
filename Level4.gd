extends Node

export (PackedScene) var Bacteria
signal start_HUD4
signal hide_HUD
signal start_boss

var ScoreInicial=0

var player = {
#"username":"",
"score":0,
"level":0,
"lives":3
}

func _ready():
	$Start.show()
	$TimerStart.start()
	emit_signal("hide_HUD")

func _on_TimerStart_timeout():
	$Start.hide()
	emit_signal("start_HUD4")
	#emit_signal("start_boss",true)
	$Nave.inicio($InitialPosition.position) #posicion de inicio del jugador
	#$InicioTimer.start()
	$Nave.show()
	$background.show()
	Global.load_game()
	player=Global.player
	ScoreInicial= player.score
	Global.new_game()
	$HUD_game.actualizarScore(ScoreInicial)
	$HUD_game.actualizarVidas(player.lives)
	$HUD_game.actualizarVidaBoss($Paths/PathBoss/PathFollowBoss/Boss.life)

func game_over():
	$BacteriaTimer.stop()
	$ScoreTimer.stop()
	emit_signal("hide_HUD")
	$LevelLoose.visible=true
	$Again.disabled=false
	$Again.visible=true
	if(player.lives<=1):
		get_tree().change_scene("res://Game_over.tscn")
	else:
		Global.save_game(ScoreInicial,player.level,player.lives-1)

func finish():		#Gana el nivel
	$BacteriaTimer.stop()
	$ScoreTimer.stop()
	emit_signal("hide_HUD")
	$LevelWin.visible=true
	Global.save_game(player.score,player.level+1,player.lives)
	$NextScene.start()
	
func _on_NextScene_timeout():
	get_tree().change_scene("res://body.tscn")

func _on_InicioTimer_timeout():
	$BacteriaTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	player.score += 1
	$HUD_game.actualizarScore(player.score)

func life_modify(life):
	$HUD_game.actualizarVidaBoss(life)

func _on_BacteriaTimer_timeout():
	#Seleccionar un lugar aleatorio en el camino
	$Camino/BacteriaPosicion.set_offset(randi())

	var B = Bacteria.instance()
	B.change_bacteria_type(["grande7","chica7"])
	B.select_animation(randi() % B.tipo_bacteria.size())
	add_child(B)
	
	#Seleccionar una direccion
	var d = $Camino/BacteriaPosicion.rotation + PI /2
	
	B.position = $Camino/BacteriaPosicion.position
	
	d += rand_range(-PI /4, PI /4)
	B.rotation = d
	B.set_linear_velocity(Vector2(rand_range(B.velocidad_min,B.velocidad_max), 0).rotated(d))

func play_again():
	get_tree().change_scene("res://Level4.tscn")
