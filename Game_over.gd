extends Node

const SAVE_PATH = "user://debug/save/saves.sav"

var player = {
#"username":"",
"score":0,
"level":0,
"lives":3
}

func _ready():
	$Loose_prev.visible=true
	$Watch_Ad.visible=true
	$Continue.visible=true
	load_game()

func _on_Watch_Ad_pressed():
	save_game(player.score,player.level,3)
	get_tree().change_scene("res://Level"+str(player.level+1)+".tscn")

func _on_Continue_pressed():
	save_game(0,0,3)
	get_tree().change_scene("res://Mundo.tscn")

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
