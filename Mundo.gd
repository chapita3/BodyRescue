extends Node

export (PackedScene) var Body
var Score
const SAVE_PATH = "user://saves.sav"

var player = {
"score":0,
"level":0,
"lives":3
}

func _ready():
	randomize()

func _on_Interfaz_iniciar_juego():
	if(!load_game()):
		save_game(0,-1,3)
	get_tree().change_scene_to(Body)

func save_game(score,level,lives):
	var save_game = File.new()
	save_game.open(SAVE_PATH, File.WRITE)
	player.score=score
	player.level=level
	player.lives=lives
	save_game.store_line(to_json(player))
	save_game.close()
	
func load_game():
	var exist=true
	var save_game = File.new()
	if not save_game.file_exists(SAVE_PATH):
		exist=false
	save_game.close()
	return exist
