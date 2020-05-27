extends Area2D

#signal nueva_zona
signal iniciar_juego_zona0
signal iniciar_juego_zona1
signal iniciar_juego_zona2
signal iniciar_juego_zona3
signal iniciar_juego_zona4
signal iniciar_juego_zona5
signal iniciar_juego_zona6

var zone
var pos={
	P0=[-8.694,-251.453],
	P1=[-8.154,-277.39],
	P2=[7.754,-135.517],
	P3=[-38.559,10.316],
	P4=[-37.39,161.61],
	P5=[-10.926,-192.611],
	P6=[-2.997,-206.43],
}
var body_tipe_used ={}
var body_type=["eyes","head","heart","intestine","skin","thyroid","tooth"]
#var body_type={
#	O0=[load("res://Sprites/Lights/eyes.gd")],
#	O1=[load("res://Sprites/Lights/head.gd")],
#	O2=[load("res://Sprites/Lights/heart.gd")],
#	O3=[load("res://Sprites/Lights/intestine.gd")],
#	O4=[load("res://Sprites/Lights/skin.gd")],
#	O5=[load("res://Sprites/Lights/thyroid.gd")],
#	O6=[load("res://Sprites/Lights/tooth.gd")],
#}

func inicio():
	initialize()
	zone=selectZone()
	configure_zone()
	$button_zone.show()
	yield($Timer, "timeout")
	$alarm.play()

func inicio_level():
	hide_lights()
	zone=selectZone()
	configure_zone()
	$button_zone.show()
	$body.show()
	yield($Timer, "timeout")
	$alarm.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func selectZone():
	var i
	randomize()
	zone=int(rand_range(0,6))
	if(body_tipe_used[zone]==1):
		i=0
		while(body_tipe_used[i]==1):
			i=i+1
		zone=i
	return zone
		

func initialize(): #Esta funcion hay que usarla en un lugar donde solo se ejecute una unica vez
	var i=0
	for i in body_type.size():
		body_tipe_used[i]=0

func get_pos():
	return pos["P"+str(zone)]
#func get_object():
#	return body_type["O"+str(zone)]

func configure_zone():
	var expos=get_pos()
	$button_zone.text=str(zone)
	#var exbody_type=get_object()
	var exbody
	$button_zone.set_position(Vector2(expos[0],expos[1]))
	$button_zone.set_size(Vector2(41,39))
	if(zone==0):
		$body/eyes.enabled=true
		$body/eyes.show()
	else:
		if(zone==1):
			$body/head.enabled=true
			$body/head.show()
		else:
			if(zone==2):
				$body/heart.enabled=true
				$body/heart.show()
			else:
				if(zone==3):
					$body/intestine.enabled=true
					$button_zone.set_size(Vector2(97,75))
					$body/intestine.show()
				else:
					if(zone==4):
						$body/skin.enabled=true
						$button_zone.set_size(Vector2(35,76))
						$body/skin.show()
					else:
						if(zone==5):
							$body/thyroid.enabled=true
							$button_zone.set_size(Vector2(46,24))
							$body/thyroid.show()
						else:
							$body/tooth.enabled=true
							$button_zone.set_size(Vector2(29,20))
							$body/tooth.show()
	#$body.animation="body_"+body_type[zone]
	$body/light_animation.play(body_type[zone])

func _process(delta):
	pass

func _on_Button_pressed():
	$body.hide()
	$button_zone.hide()
	$alarm.playing=false
	body_tipe_used[zone]=1
	$body/light_animation.stop(false)
	emit_signal("iniciar_juego_zona"+str(zone))

func hide_lights():
	$body/eyes.hide()
	$body/head.hide()
	$body/heart.hide()
	$body/intestine.hide()
	$body/skin.hide()
	$body/thyroid.hide()
	$body/tooth.hide()
