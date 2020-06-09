extends Node

export (PackedScene) var Bacteria
export (PackedScene) var Body
var Score
const SAVE_PATH = "res://debug/save/saves.sav"

var player = {
"score":0,
"level":0,
"lives":3
}

func _ready():
	randomize()

func _on_Interfaz_iniciar_juego():
	get_tree().change_scene_to(Body)
	if(!load_game()):
		save_game(0,0,3)
	

func iniciar_juego():
	Score = 0
	$Interfaz.update_score(Score)
	#$Nave.inicio($PosicionDeInicio.position) #posicion de inicio del jugador
	#$InicioTimer.start()
	$Area2D.hide()
	$Interfaz/ScoreLabel.rect_position=Vector2(419.094,6.886)

func game_over():
	$ScoreTimer.stop()
	$BacteriaTimer.stop()
	#$Interfaz.game_over()
	$Area2D.show()
	$Area2D.inicio_level()
	
func _on_InicioTimer_timeout():
	$BacteriaTimer.start()
	$ScoreTimer.start()
	
func _on_ScoreTimer_timeout():
	Score += 1
	$Interfaz.update_score(Score)

func _on_BacteriaTimer_timeout():
	#Seleccionar un lugar aleatorio en el camino
	$Camino/BacteriaPosicion.set_offset(randi())
	
	var B = Bacteria.instance()
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
	var exist
	var save_game = File.new()
	if not save_game.file_exists(SAVE_PATH):
		exist=false
	save_game.open(SAVE_PATH, File.READ)
	player = parse_json(save_game.get_line())
	save_game.close()
	return exist
