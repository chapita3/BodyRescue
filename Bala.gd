extends KinematicBody2D

const SPEED = 2000
var velocity = Vector2()
#signal shooted
signal bacteria_Kill
var kill=false

var destroyed = false

func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	if (collision!=null):
		velocity = velocity.bounce(collision.normal)
#		emit_signal("shooted")

func set_bala_direction(direction):
	velocity = direction * SPEED

func kill_bala():
	if (!destroyed):
		destroyed = true
		call_deferred("free")

func _on_Area2D_body_entered(body):
	#if (body != self && body!=get_tree().get_root().get_node("Nave")&&body!=get_tree().get_root().get_node("antibody2D")):
	if body != self:
		if "Bala" in body.name:
			body.kill_bala()
			kill_bala()
			#emit_signal("shooted")
			#kill=true
		if "Bacteria" in body.name:
			kill_bala()	
			body.elim()
			emit_signal("bacteria_Kill")

func valor_kill():	
	return kill

func _on_Visibilidad_screen_exited():
	queue_free()  #elimina la bala si se sale de la pantalla

#func _on_Bala_shooted():
#	shot=true
#	return shot
