extends Node

export (PackedScene) var Bacteria
var Score
var maxScore=20
const SAVE_PATH = "user://saves.sav"

var player = {
#"username":"",
"score":0,
"level":0,
"lives":3
}

func _ready():
	randomize()
	Score = 0
	$Nave.inicio($InitialPosition.position) #posicion de inicio del jugador
	$InicioTimer.start()
	#$Interfaz.update_score(Score)

func nuevo_juego():
	Score = 0
	$Nave.inicio($InitialPosition.position) #posicion de inicio del jugador
	$InicioTimer.start()
	#$Interfaz.update_score(Score)

func game_over():
	$ScoreTimer.stop()
	$BacteriaTimer.stop()
	load_game()
	if(Score>=maxScore):
		$LevelWin.visible=true
		save_game(Score+player.score,player.level+1,player.lives)
		$NextScene.start()
	else:
		if(player.lives==1):
			get_tree().change_scene("res://Game_over.tscn")
		else:
			save_game(player.score,player.level,player.lives-1)
			$LevelLoose.visible=true
			$Prev_level.start()

func _on_InicioTimer_timeout():
	$BacteriaTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	Score += 1
	#$Interfaz.update_score(Score)

func _on_BacteriaTimer_timeout():
	#Seleccionar un lugar aleatorio en el camino
	$Camino/BacteriaPosicion.set_offset(randi())
	
	var B = Bacteria.instance()
	B.change_bacteria_type(["grande2","chica2"])
	B.select_animation(randi() % B.tipo_bacteria.size())
	add_child(B)
	
	#Seleccionar una direccion
	var d = $Camino/BacteriaPosicion.rotation + PI /2
	
	B.position = $Camino/BacteriaPosicion.position
	
	d += rand_range(-PI /4, PI /4)
	B.rotation = d
	B.set_linear_velocity(Vector2(rand_range(B.velocidad_min,B.velocidad_max), 0).rotated(d))

func save_game(score,level,lives):
	var save_game = File.new()
	save_game.open(SAVE_PATH, File.WRITE)
	player.score=score
	#player.level=str(level)
	#player.lives=str(lives)
	save_game.store_line(to_json(player))
	save_game.close()

func load_game():
	var save_game = File.new()
	if not save_game.file_exists(SAVE_PATH):
		return # Error! No hay archivo que guardar
	save_game.open(SAVE_PATH, File.READ)
	player = parse_json(save_game.get_line())
	save_game.close()
	
func _on_Prev_level_timeout():
	get_tree().change_scene("res://Level2.tscn")
