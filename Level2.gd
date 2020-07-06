extends Node

export (PackedScene) var Bacteria
var Score
onready var save = get_node("res://Saves.gd")

var player = {
#"username":"",
"score":0,
"level":0,
"lives":3
}

func _ready():
	Score = 0
	#$Interfaz.update_score(Score)
	$Nave.inicio($InitialPosition.position) #posicion de inicio del jugador
	$InicioTimer.start()
	$Nave.show()
	$background.show()
	player=save.load_game()
	#$Interfaz/ScoreLabel.rect_position=Vector2(419.094,6.886)

func nuevo_juego():
	pass

func game_over():
	$BacteriaTimer.stop()
	#$Interfaz.game_over()
	$LevelLoose.visible=true
	$Next_Level.disabled=false
	$Next_Level.visible=true
	save.save_game(player.score,player.level,player.lives-1)
#if(player.lives==1):
#	get_tree().change_scene("res://Game_over.tscn")
#else:

func _on_NextScene_timeout():
	get_tree().change_scene("res://body.tscn")

func _on_InicioTimer_timeout():
	$BacteriaTimer.start()
	$ScoreTimer.start()
	
func _on_ScoreTimer_timeout():
	$LevelWin.visible=true
	save.save_game(Score+player.score,player.level+1,player.lives)
	#save_game(Score+player.score,player.level+1,player.lives)
	$NextScene.start()
	#$Interfaz.update_score(Score)

func _on_BacteriaTimer_timeout():
	#Seleccionar un lugar aleatorio en el camino
	$Camino/BacteriaPosicion.set_offset(randi())
	var B = Bacteria.instance()
	#var aux=get_node(B)
	B.change_bacteria_type(["grande3","chica3"])
	B.select_animation(randi() % B.tipo_bacteria.size())
	#aux.select_animation(randi() % tipo_bacteria.size())
	#$AnimatedSprite.animation= tipo_bacteria[randi() % tipo_bacteria.size()]
	add_child(B)
	
	#Seleccionar una direccion
	var d = $Camino/BacteriaPosicion.rotation + PI /2
	
	B.position = $Camino/BacteriaPosicion.position
	
	d += rand_range(-PI /4, PI /4)
	B.rotation = d
	B.set_linear_velocity(Vector2(rand_range(B.velocidad_min,B.velocidad_max), 0).rotated(d))

func play_again():
	get_tree().change_scene("res://Level2.tscn")
