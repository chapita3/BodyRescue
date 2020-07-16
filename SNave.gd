extends "res://Nave.gd"

var can_shot=true
signal killed
signal shot
signal bala_plus
var cantBact
const BALA = preload("res://Bala.tscn")

func _ready():
	#hide()
	limite = get_viewport_rect().size

func _process(delta):
	cantBact=Global.bactKill
	emit_signal("killed",cantBact)
	Global.setNave(self)

func _input(event):
	if(can_shot && event is InputEventMouseButton):
		if event.button_index == BUTTON_LEFT and event.pressed:
			if(event.position != position):
				var direction = (event.global_position - global_position).normalized()
				var bala = BALA.instance()
				add_child(bala)
				bala.global_position = global_position + (30*direction)
				bala.set_bala_direction(direction)
				emit_signal("shot")

func _on_Nave_area_entered(area):
	if ("Ataque" in area.name):		#Ataque del boss
		alive=false
		emit_signal("golpe")
	else:
		if ("Bala_plus" in area.name):
			emit_signal("bala_plus")
		else:
			emit_signal("catch")

func change_shot(cond):
	can_shot=cond
	
func set_alive(cond):
	alive=cond
