extends RigidBody2D

export (int) var velocidad_min
export (int) var velocidad_max
var tipo_bacteria = ["grande","chica"]


func _ready():
	$AnimatedSprite.animation= tipo_bacteria[randi() % tipo_bacteria.size()]
	
	

func _on_Visibilidad_screen_exited():
	queue_free()  #elimina la bacteria si se sale de la pantalla
