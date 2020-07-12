extends KinematicBody2D

const SPEED = 1000
var velocity = Vector2()

var destroyed = false

func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	#if collision:
	#	velocity = velocity.bounce(collision.normal)
#		emit_signal("shooted")

func set_bala_direction(direction):
	velocity = direction * SPEED

func kill_bala():
	if (!destroyed):
		destroyed = true
		call_deferred("free")

func _on_Area2D_body_entered(body):
	if body != self:
		if("Bacteria" in body.name):
			body.elim()
			Global.new_bacteria_kill()
		else:
			if("Bala" in body.name):
				body.kill_bala()
		kill_bala()
		
func _on_Area2D_Bala_area_entered(area):
	if ("Ataque" in area.name):
		kill_bala()

func _on_Visibilidad_screen_exited():
	queue_free() 



