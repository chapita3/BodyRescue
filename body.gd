extends Area2D

#signal nueva_zona
signal iniciar_juego_zona0
signal iniciar_juego_zona1
signal iniciar_juego_zona2
signal iniciar_juego_zona3

export (PackedScene) var Scene1
export (PackedScene) var Scene2
export (PackedScene) var Scene3
export (PackedScene) var Scene4

onready var save = load("res://Saves.gd").new()

var player = {
#"username":"",
"score":0,
"level":0,
"lives":3
}

var zone
var pos={
	P0=[-8.694,-251.453],
	P1=[5.612,-176.626],
	P2=[5.453,-216.522],
	P3=[16.074,-124.532],
	#OLD-POS
	#P0=[-37.39,161.61],
	#P1=[-2.997,-206.43],
	#P2=[-8.694,-251.453],
	#P3=[-10.926,-192.611],
	#P5=[-38.559,10.316],
	#P6=[7.754,-135.517],
	#P7=[-8.154,-277.39],
}
var body_type_used ={}
#var body_type=["skin","tooth","eyes","thyroid","diaphragm","intestine","heart","head"]
var body_type=["eyes","tooth","head","heart"]
#var body_type={
#	O0=[load("res://Sprites/Lights/eyes.gd")],
#	O1=[load("res://Sprites/Lights/head.gd")],
#	O2=[load("res://Sprites/Lights/heart.gd")],
#	O3=[load("res://Sprites/Lights/intestine.gd")],
#	O4=[load("res://Sprites/Lights/skin.gd")],
#	O5=[load("res://Sprites/Lights/thyroid.gd")],
#	O6=[load("res://Sprites/Lights/tooth.gd")],
#}

func _ready():
	player=save.load_game()
	$vitamins.text=str(player.lives)
	initialize()
	zone=selectZone()
	configure_zone()
	$button_zone.show()
	yield($Timer, "timeout")
	$alarm.play()

func inicio():
	pass

func inicio_level():
	hide_lights()
	zone=selectZone()
	configure_zone()
	$button_zone.show()
	$body.show()
	yield($Timer, "timeout")
	$alarm.play()

func selectZone():
	var i=0
	#zone=int(rand_range(0,6))
	
	#if(body_type_used[zone]==1):
	#	i=0
	while(body_type_used[i]==1):
		i=i+1
	zone=i
	return zone

func initialize():
	var i=0
	var aux=body_type.size()-1
	while(i<=player.level):
		body_type_used[i]=1  #[1,_,_,_]
		i+=1
	while(i<=(body_type.size()-1)):
		body_type_used[i]=0    #[1,0,0,0]
		i+=1
	var lpm

func get_pos():
	return pos["P"+str(zone)]
#func get_object():
#	return body_type["O"+str(zone)]

func configure_zone():
	var expos=get_pos() #Busca posicion de la luz
	$button_zone.text=str(zone)
	#var exbody_type=get_object()
	$button_zone.set_position(Vector2(expos[0],expos[1]))
	$button_zone.set_size(Vector2(41,39))
	if(zone==0):
		$body/eyes.enabled=true
		$body/eyes.show()
	else:
		if(zone==1):
			$body/tooth.enabled=true
			$button_zone.set_size(Vector2(29,20))
			$body/tooth.show()
		else:
			if(zone==2):
				$body/head.enabled=true
				$body/head.show()
			else:
				if(zone==3):
					$body/heart.enabled=true
					$body/heart.show()
				else:
					if(zone==5):
						$body/intestine.enabled=true
						$button_zone.set_size(Vector2(97,75))
						$body/intestine.show()
					else:
						if(zone==4):
							$body/thyroid.enabled=true
							$button_zone.set_size(Vector2(46,24))
							$body/thyroid.show()
						else:
							$body/skin.enabled=true
							$button_zone.set_size(Vector2(35,76))
							$body/skin.show()
	#$body.animation="body_"+body_type[zone]
	$body/light_animation.play(body_type[zone])

func _process(delta):
	pass

func _on_Button_pressed():
	$body.hide()
	$button_zone.hide()
	$alarm.playing=false
	$body/light_animation.stop(false)
	#emit_signal("iniciar_juego_zona"+str(zone))
	emit_signal("iniciar_juego_zona"+str(zone))

func hide_lights():
	$body/eyes.hide()
	$body/head.hide()
	$body/heart.hide()
	$body/intestine.hide()
	$body/skin.hide()
	$body/thyroid.hide()
	$body/tooth.hide()

func juego_zona0():
	#iniciar_juego()
	get_tree().change_scene_to(Scene1)
	#$fondo0.show()
	
func juego_zona1():
	#iniciar_juego()
	get_tree().change_scene_to(Scene2)
	#$fondo1.show()
	
func juego_zona2():
	#iniciar_juego()
	get_tree().change_scene_to(Scene3)
	#$fondo2.show()
	
func juego_zona3():
	#iniciar_juego()
	get_tree().change_scene_to(Scene4)
	#$fondo3.show()
