extends Node2D

var save = load("res://Scripts/Commands.gd")
onready var new_save = save.new()

var stars = preload("res://Cenas/Stars.tscn").instance()
var readyscreen = preload("res://Cenas/ReadyScreen.tscn").instance()
var player = preload("res://Cenas/Player.tscn").instance()
var enemySpawner = preload("res://Cenas/Enemies/EnemySpawner.tscn").instance()
var enemyExplosion = preload("res://Cenas/Enemies/EnemyExplosion.tscn")
var powerUpSpawner = preload("res://Cenas/PowerUps/PowerUpSpawner.tscn").instance()
var playerPowerUp2 = preload("res://Cenas/PowerUps/PlayerPowerUp2.tscn")
var playerPowerUp3 = preload("res://Cenas/PowerUps/PlayerPowerUp3.tscn")
#var HUD = preload("res://Cenas/HUD/HUD.tscn").instance()

var lifeCounter = 0 #diz respeito à quantidade de corações na HUD
var gameTime = 0
var level = 0

signal restartLevel1
signal phoneBackPressed


func _ready():
	readyscreen.connect("StartLevel", self, "on_start_level_time")
	player.connect("game_over", self, "on_game_over")
	player.connect("hit", self, "on_player_hit")
	enemySpawner.connect("shake_camera", self, "on_shake_camera")
	enemySpawner.connect("increment_jelly_coin", self, "on_increment_jelly_coin")
	powerUpSpawner.connect("playerLife", self, "on_player_life")
	powerUpSpawner.connect("playerAggressive", self, "on_PlayerAggressive")
	powerUpSpawner.connect("playerSaw", self, "on_PlayerSaw")
	add_child(readyscreen)
	$CanvasLayer/HUD.hide()
	get_tree().set_quit_on_go_back(false)
	

func _process(delta):
	if gameTime == (30 + level):
		pass
		#Parar o jogo
		# Mostrar uma tela com as pontuações
		# e com a opção de ir ao proximo nível
		#Salvar o progresso
	
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
	add_child(powerUpSpawner)
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
	remove_child(powerUpSpawner)
	$GameTime.stop()
	$CanvasLayer/GameOverNode.game_over_movement()
	player.total_silver_jellycoins += player.fase_silver_jellycoins
	new_save.organize_saves(get_tree().get_nodes_in_group("save"))

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

func on_player_life():
	if lifeCounter > 0:
		lifeCounter -= 1
	if player.player_life <= 3:
		player.player_life += 1
	$CanvasLayer/HUD/PlayerLife.get_node("Life" + str(lifeCounter)).show()
	$PowerUpSong.play()

func on_PlayerAggressive():
	var new_powerUp2 = playerPowerUp2.instance()
	player.add_child(new_powerUp2)

func on_PlayerSaw():
	var new_powerUp3 = playerPowerUp3.instance()
	player.add_child(new_powerUp3)

func on_increment_jelly_coin(enemy):
	if enemy.type == "enemy1":
		player.fase_silver_jellycoins +=1
		$CanvasLayer/HUD/PlayerJellyCoins.text = str(player.fase_silver_jellycoins)
	elif enemy.type == "enemy2":
		player.fase_silver_jellycoins +=2
		$CanvasLayer/HUD/PlayerJellyCoins.text = str(player.fase_silver_jellycoins)
	else:
		player.fase_silver_jellycoins +=3
		$CanvasLayer/HUD/PlayerJellyCoins.text = str(player.fase_silver_jellycoins)

#implementando o sistema de levels: Cada level terá dução de 30s + level
#Quando o game GameTime terminar, o level deve ser encerrado, as pontuações
#devem ser informadas na tela e deve-se ter um botão para iniciar o
#proximo level