extends CanvasLayer



func _ready():
	pass # Replace with function body.

func actualizarScore(score):
	$Score.text = str(score)

func actualizarVidas(vidas):
	$Vidas.text = str(vidas)

func actualizarAnticuerpos(a):
	$Anticuerpos.text = str(a)
	
func actualizarEnemigos(e):
	$Enemigos.text = str(e)

func _on_Level1_start_HUD1():
	$Vitamina.show()
	$Vidas.show()
