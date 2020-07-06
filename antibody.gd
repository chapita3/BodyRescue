extends Area2D

signal catch
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$antibody.playing=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func antibody_show():
	$antibodyAnimation.play("show_up")
	$antibodyAnimation.play("rotate")

func body_entered(body):
	hide()
	emit_signal("catch")
	$antibodyCollision.disabled=true
	$antibody.disabled=true
