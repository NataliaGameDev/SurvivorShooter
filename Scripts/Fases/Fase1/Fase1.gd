extends Node2D

var stars = preload("res://Cenas/Stars.tscn").instance()
var readyscreen = preload("res://Cenas/ReadyScreen.tscn").instance()
var player = preload("res://Cenas/Player.tscn").instance()
var enemySpawner = preload("res://Cenas/Enemies/EnemySpawner.tscn").instance()
var enemyExplosion = preload("res://Cenas/Enemies/EnemyExplosion.tscn")
#var HUD = preload("res://Cenas/HUD/HUD.tscn").instance()

var lifeCounter = 0 #diz respeito à quantidade de corações na HUD
var gameTime = 0

signal restartLevel1
signal phoneBackPressed


func _ready():
	readyscreen.connect("StartLevel", self, "on_start_level_time")
	player.connect("game_over", self, "on_game_over")
	player.connect("hit", self, "on_player_hit")
	enemySpawner.connect("shake_camera", self, "on_shake_camera")
	add_child(readyscreen)
	$CanvasLayer/HUD.hide()
	get_tree().set_quit_on_go_back(false)
	
func _notification(what):
    if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
        _on_Back_pressed()
    if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
        _on_Back_pressed()

func on_start_level_time():
	if player.get_node("ShootTimer").is_stopped():
		player.get_node("ShootTimer").start(0.4)
	remove_child(readyscreen)
	add_child(stars)
	add_child(player)
	add_child(enemySpawner)
	$CanvasLayer/HUD.show()
	$GameTime.start()

func on_game_over():
	var new_explosion = enemyExplosion.instance()
	new_explosion.position = player.position
	add_child(new_explosion)
	player.get_node("Explosion").play()
	player.hide()
	enemySpawner.hide()
	player.get_node("CollisionShape2D").set_deferred("disabled", true)
	player.get_node("ShootTimer").stop()
	remove_child(enemySpawner)
	$GameTime.stop()
	$CanvasLayer/GameOverNode.game_over_movement()	

func on_player_hit():
	$CameraFase1.shake()
	if lifeCounter <= 3:
		$CanvasLayer/HUD.get_node("PlayerLife").get_node("Life" + str(lifeCounter)).hide()
	lifeCounter += 1

func _on_GameTime_timeout():
	gameTime += 1
	$CanvasLayer/HUD.get_node("GameTime").text = str(gameTime)


func _on_RestartLevel_pressed():
	print("RestartLevel emitido")
	emit_signal("restartLevel1")
	
func _on_Back_pressed():
    emit_signal("phoneBackPressed")

func _on_BattleMusic_finished():
	$BattleMusic.play()

func on_shake_camera():
	$CameraFase1.shake()
