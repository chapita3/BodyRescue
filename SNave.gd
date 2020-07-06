extends Area2D

export (int) var Velocidad
var Movimiento = Vector2()
var limite
signal golpe
const BALA = preload("res://Bala.tscn")

func _ready():
	hide()
	limite = get_viewport_rect().size



func _process(delta):
	Movimiento = Vector2()  #reinciar el valor
	
	if Input.is_action_pressed("ui_right"):
		Movimiento.x += 1
	if Input.is_action_pressed("ui_left"):
		Movimiento.x -= 1
	if Input.is_action_pressed("ui_down"):
		Movimiento.y += 1
	if Input.is_action_pressed("ui_up"):
		Movimiento.y -= 1
	
	
	if Movimiento.length() > 0:   #Verificar si se esta moviendo
		Movimiento = Movimiento.normalized() * Velocidad  #NOrmalizar la velocidad
	
	position += Movimiento * delta	#actualizar los movimientos
	position.x = clamp(position.x, 0, limite.x)
	position.y = clamp(position.y, 0, limite.y)
	
	if Movimiento.x != 0:   #posicionar al sprite depende de los movimientos
		$AnimatedSprite.animation = "lado"
		$AnimatedSprite.flip_h = Movimiento.x < 0
		#$CollisionShapefrente.disabled = true
		#$CollisionShapelado.disabled=false
	elif Movimiento.y != 0:
		$AnimatedSprite.animation = "frente"
		$AnimatedSprite.flip_v = Movimiento.y > 0
		#$CollisionShapefrente.disabled = true
		#$CollisionShapelado.disabled=false
	else:
		$AnimatedSprite.animation = "frente"
		#$CollisionShapefrente.disabled = true
		#$CollisionShapelado.disabled=false


func _on_Nave_body_entered(body):  #cuando hay una colision con un cuerpo
	hide()   #se oculta cuando recibe un golpe
	emit_signal("golpe")
	#$CollisionShape2D.disabled = true
	
func inicio(pos):
	position = pos   #mostrar el personaje
	show()
	$CollisionShape2D.disabled = false;
	

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if(event.position != position):
				var direction = (event.global_position - global_position).normalized()
				var bala = BALA.instance()
				get_parent().add_child(bala)
				bala.global_position = global_position + (30*direction)
				bala.set_bala_direction(direction)
	
	
