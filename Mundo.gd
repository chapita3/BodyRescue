extends Node

export (PackedScene) var Bacteria
var Score 

func _ready():
	randomize()
	$Area2D.hide()
	$Bacteria.hide()

func iniciar_juego():
	Score = 0
	$Interfaz.update_score(Score)
	$Nave.inicio($PosicionDeInicio.position) #posicion de inicio del jugador
	$InicioTimer.start()
	$Area2D.hide()
	$Interfaz/ScoreLabel.rect_position=Vector2(419.094,6.886)

func nuevo_juego():
	$Area2D.show()
	$Area2D.inicio()

func game_over():
	$ScoreTimer.stop()
	$BacteriaTimer.stop()
	#$Interfaz.game_over()
	$Area2D.show()
	$Area2D.inicio_level()
	
	
func _on_InicioTimer_timeout():
	$BacteriaTimer.start()
	$ScoreTimer.start()
	
func _on_ScoreTimer_timeout():
	Score += 1
	$Interfaz.update_score(Score)

func _on_BacteriaTimer_timeout():
	#Seleccionar un lugar aleatorio en el camino
	$Camino/BacteriaPosicion.set_offset(randi())
	
	var B = Bacteria.instance()
	add_child(B)
	
	#Seleccionar una direccion
	var d = $Camino/BacteriaPosicion.rotation + PI /2
	
	B.position = $Camino/BacteriaPosicion.position
	
	d += rand_range(-PI /4, PI /4)
	B.rotation = d
	B.set_linear_velocity(Vector2(rand_range(B.velocidad_min,B.velocidad_max), 0).rotated(d))

func juego_zona0():
	iniciar_juego()
	$fondo0.show()
	
func juego_zona1():
	iniciar_juego()
	$fondo1.show()
	
func juego_zona2():
	iniciar_juego()
	$fondo2.show()
	
func juego_zona3():
	iniciar_juego()
	$fondo3.show()

func juego_zona4():
	iniciar_juego()
	$fondo4.show()
	
func juego_zona5():
	iniciar_juego()
	$fondo5.show()
	
func juego_zona6():
	iniciar_juego()
	$fondo6.show()
