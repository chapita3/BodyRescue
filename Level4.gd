extends Node

export (PackedScene) var Bacteria
export (PackedScene) var Bala_plus
export (int) var cantBalasMax
export (int) var maxPlus
signal start_HUD4
signal hide_HUD
signal start_boss

var cantBalas
var cantAntbody=0
var cantPlus=0
var ScoreInicial=0

var player = {
#"username":"",
"score":0,
"level":0,
"lives":3
}

func _ready():
	$Start.show()
	$TimerStart.start()
	cantBalas=cantBalasMax
	$Nave.change_shot(false)
	emit_signal("hide_HUD")

func _on_TimerStart_timeout():
	$Start.hide()
	emit_signal("start_HUD4")
	#emit_signal("start_boss",true)
	$Nave.inicio($InitialPosition.position) #posicion de inicio del jugador
	$InicioTimer.start()
	$Nave.show()
	$background.show()
	Global.load_game()
	player=Global.player
	ScoreInicial= player.score
	Global.new_game()
	$HUD_game.actualizarScore(ScoreInicial)
	$HUD_game.actualizarVidas(player.lives)
	$HUD_game.actualizarBalas(cantBalasMax)
	$HUD_game.actualizarVidaBoss($Paths/PathBoss/PathFollowBoss/Boss.life)

func game_over():
	$BacteriaTimer.stop()
	$ScoreTimer.stop()
	$Paths/PathBoss/PathFollowBoss/Boss.detener()
	emit_signal("hide_HUD")
	$LevelLoose.visible=true
	$Again.disabled=false
	$Again.visible=true
	if(player.lives<=1):
		get_tree().change_scene("res://Game_over.tscn")
	else:
		Global.save_game(ScoreInicial,player.level,player.lives-1)

func finish():		#Gana el juego
	$BacteriaTimer.stop()
	$ScoreTimer.stop()
	emit_signal("hide_HUD")
	$LevelWin.visible=true
	$WinTimer.start()

func _on_InicioTimer_timeout():
	$BacteriaTimer.start()
	$ScoreTimer.start()
	$TimerInicioBoss.start()

func _on_ScoreTimer_timeout():
	player.score += 1
	$HUD_game.actualizarScore(player.score)

func life_modify(life):
	$HUD_game.actualizarVidaBoss(life)
	if (life==0):
		finish()
		$AnimBossDeath.play("Death_Boss")

func _on_BacteriaTimer_timeout():
	#Seleccionar un lugar aleatorio en el camino
	$Camino/BacteriaPosicion.set_offset(randi())

	var B = Bacteria.instance()
	B.change_bacteria_type(["grande4","chica4"])
	B.select_animation(randi() % B.tipo_bacteria.size())
	add_child(B)
	
	#Seleccionar una direccion
	var d = $Camino/BacteriaPosicion.rotation + PI /2
	
	B.position = $Camino/BacteriaPosicion.position
	
	d += rand_range(-PI /4, PI /4)
	B.rotation = d
	B.level_call()
	B.set_linear_velocity(Vector2(rand_range(B.velocidad_min,B.velocidad_max), 0).rotated(d))

func _on_Nave_shot():
	cantBalas-=1
	$HUD_game.actualizarBalas(cantBalas)
	if(cantBalas<=0):
		$Nave.change_shot(false)
		$TimerBalaPlus.start()

func _on_TimerBalaPlus_timeout():
	var b=Bala_plus.instance()
	var size=get_viewport().get_visible_rect().size
	randomize()
	var xPos=rand_range(-202.518,258.386)
	var yPos=rand_range(-253.497,461.749)
	#b.global_position=Vector2(xPos,yPos)
	b.position=Vector2(xPos,yPos)
	add_child(b)

func _on_Nave_bala_plus():
	cantBalas+=1
	$HUD_game.actualizarBalas(cantBalas)
	$Nave.change_shot(true)
	if(cantBalas>=maxPlus):
		$TimerBalaPlus.stop()

func play_again():
	get_tree().change_scene("res://Level4.tscn")

func _on_Boss_Attack(attack,pos,dir,target):
	var a=attack.instance()
	add_child(a)
	a.start(pos,dir,target)
	
func _on_Restart_pressed():
	Global.save_game(0,-1,3)
	get_tree().change_scene("res://body.tscn")

func _on_AnimBossDeath_animation_finished(anim_name):
	emit_signal("hide_HUD")
	$LevelWin.visible=true
	$Win.visible=true
	$Win/Tiempo.text=str(player.score)
	$Win/Tiempo.visible=true
	Global.actualizarRecord(player.score)
	$Restart.visible=true
	$Restart.disabled=false
	$Restart/Contenido.visible=true
	Global.save_game(player.score,player.level+1,player.lives)

func _on_TimerInicioBoss_timeout():
	$Paths/PathBoss/PathFollowBoss/Boss.set_alive(true)
	$Nave.change_shot(true)
