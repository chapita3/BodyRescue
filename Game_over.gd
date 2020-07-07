extends Node

onready var save = load("res://Saves.gd").new()
var player = {
#"username":"",
"score":0,
"level":0,
"lives":3
}

func _ready():
	$Loose_prev.visible=true
	$Compra.visible=true
	$Continue.visible=true
	player=save.load_game()

func _on_Compra_pressed():
	save.save_game(player.score,player.level,3)
	get_tree().change_scene("res://Level"+str(player.level+1)+".tscn")

func _on_Continue_pressed():
	save.save_game(0,-1,3)
	get_tree().change_scene("res://Mundo.tscn")

