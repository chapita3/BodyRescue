extends KinematicBody2D

const SPEED = 2000
var velocity = Vector2()
signal shooted
var shot=false

var destroyed = false

func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	if (collision!=null):
		velocity = velocity.bounce(collision.normal)
		emit_signal("shooted")

func set_bala_direction(direction):
	velocity = direction * SPEED

func kill_bala():
	if (!destroyed):
		destroyed = true
		call_deferred("free")

func _on_Area2D_body_entered(body):
	#if (body != self && body!=get_tree().get_root().get_node("Nave")&&body!=get_tree().get_root().get_node("antibody2D")):
	if(body==get_tree().get_root().get_node("Bacteria")):
		if ("Bala" in body.name):
			body.kill_bala()
			kill_bala()
			emit_signal("shooted")
			shot=true

func _on_Visibilidad_screen_exited():
	queue_free()  #elimina la bala si se sale de la pantalla

func _on_Bala_shooted():
	return shot
