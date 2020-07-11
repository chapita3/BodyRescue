extends KinematicBody2D

signal life_modify

export (PackedScene) var Attack_thing
onready var parent=get_parent()
var speed=1000
var alive=false
var life=5000
var velocity=Vector2(1000,0)
var attack=false
var target
var target_dir
var current_dir

func _ready():
	$AnimatedSprite.animation= "normal"
	$Area2D/CollisionShapeBoos.disabled=false
	$TimerAttack.start()

func _physics_process(delta):
	if not alive:
		return
	control(delta)
	move_and_slide(velocity)
	if(attack):
		#target=Global.getNave()
		#target_dir=(target.global_position-global_position).normalized()
		#current_dir=Vector2(1,0).rotated(self.global_rotation)
		#self.global_rotation=current_dir.linear_interpolate(target_dir,self.speed*delta).angle()
		pass

func control(delta):
	if parent is PathFollow2D:
		parent.set_offset(parent.get_offset() + speed * delta)
		position=Vector2()

func _process(delta):
	pass

func set_alive(x):
	alive=x

func change_health():
	life-=10
	emit_signal("life_modify",life)

func _on_Area2D_body_entered(body):
	var aux=body.name
	if ("Bala" in body.name):
		life-=10
		emit_signal("life_modify",life)

func shoot():
	var dir=Vector2(1,0).rotated(self.global_rotation)

func _on_TimerAttack_timeout():
	attack=true
	$TimerAttackStop.start()

func _on_TimerAttackStop_timeout():
	attack=false
	$TimerAttack.start()
