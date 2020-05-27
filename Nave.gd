extends Area2D

export (int) var Velocidad
var Movimiento = Vector2()
var limite
signal golpe

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
		$CollisionShapefrente.disabled = true
		$CollisionShapelado.disabled=false
	elif Movimiento.y != 0:
		$AnimatedSprite.animation = "frente"
		$AnimatedSprite.flip_v = Movimiento.y > 0
		$CollisionShapefrente.disabled =false
		$CollisionShapelado.disabled=true
	else:
		$AnimatedSprite.animation = "frente"
		$CollisionShapefrente.disabled =false
		$CollisionShapelado.disabled=true


func _on_Nave_body_entered(body):  #cuando hay una colision con un cuerpo
	hide()   #se oculta cuando recibe un golpe
	emit_signal("golpe")
	$CollisionShapefrente.disabled = true
	$CollisionShapelado.disabled=true
	
func inicio(pos):
	position = pos   #mostrar el personaje
	show()
	$CollisionShapefrente.disabled =false
	$CollisionShapelado.disabled=false
