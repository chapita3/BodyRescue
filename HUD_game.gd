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
	$Vidas.visible=true
	$Vitamina.visible=true
	$Reloj.visible=true
	$Score.visible=true
	$AnticuerposPic.visible=false
	$Anticuerpos.visible=false
	$Enemigos.visible=false
	$EnemigosPic.visible=false

func _on_Level2_start_HUD2():
	$Vidas.visible=true
	$Vitamina.visible=true
	$Reloj.visible=true
	$Score.visible=true
	$AnticuerposPic.visible=true
	$Anticuerpos.visible=true
	$Enemigos.visible=false
	$EnemigosPic.visible=false

func _on_Level3_start_HUD3():
	$Vidas.visible=true
	$Vitamina.visible=true
	$Reloj.visible=true
	$Score.visible=true
	$AnticuerposPic.visible=true
	$Anticuerpos.visible=true
	$Enemigos.visible=true
	$EnemigosPic.visible=true
	
func _on_Level4_start_HUD4():
	$Vidas.visible=true
	$Vitamina.visible=true
	$Reloj.visible=true
	$Score.visible=true
	$AnticuerposPic.visible=false
	$Anticuerpos.visible=false
	$Enemigos.visible=false
	$EnemigosPic.visible=false
  
func hide_HUD():
	$Vidas.visible=false
	$Vitamina.visible=false
	$Reloj.visible=false
	$Score.visible=false
	$AnticuerposPic.visible=false
	$Anticuerpos.visible=false
	$Enemigos.visible=false
	$EnemigosPic.visible=false



