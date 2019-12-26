extends Node2D

# Called when the node enters the scene tree for the first time.
var initialScene = load("res://Cenas/TelaInicial.tscn").instance()
var loadingScene = load("res://Cenas/Loading.tscn").instance()
var player = load("res://Cenas/Player.tscn").instance()
var fase1 = load("res://Cenas/Fases/Fase1.tscn").instance()

var music_stop_position = 0	

func _ready():
	get_tree().paused = false
	initialScene.connect("startPressed", self, "_on_start_pressed")
	loadingScene.connect("LoadingTimeOut", self, "_on_loading_time_out")
	fase1.connect("restartLevel1", self, "on_restart_level1")
	fase1.get_node("CanvasLayer").get_node("HUD").connect("quitPressed", self, "on_quit_pressed")
	fase1.connect("phoneBackPressed", self, "on_phoneBackPressed")
	$CanvasLayer.get_node("PopupMenu").get_node("Continue").connect("Continuepressed", self, "on_continue_pressed")
	add_child(initialScene)
	print("INICIALIZADA")

func _on_start_pressed():
	remove_child(initialScene)
	add_child(loadingScene)
	
func _on_loading_time_out():
	remove_child(loadingScene)
	add_child(fase1)

func on_quit_pressed():
	print("ok")
	fase1.get_tree().paused = true
	$CanvasLayer/PopupMenu.show()

func on_restart_level1():
	print("Sinal Recebido")
	remove_child(fase1)
	fase1 = load("res://Cenas/Fases/Fase1.tscn").instance()
	fase1.connect("restartLevel1", self, "on_restart_level1")
	fase1.get_node("CanvasLayer").get_node("HUD").connect("quitPressed", self, "on_quit_pressed")
	fase1.connect("phoneBackPressed", self, "on_phoneBackPressed")
	$CanvasLayer/PopupMenu.get_node("Continue").connect("Continuepressed", self, "on_continue_pressed")
	add_child(loadingScene)
	loadingScene.get_node("LoadingTimer").start()
	
	
func on_continue_pressed():
	$CanvasLayer/PopupMenu.hide()
	fase1.get_tree().paused = false

func _on_QuitToMenu_pressed():
	get_tree().reload_current_scene()

func on_phoneBackPressed():
	fase1.get_tree().paused = true
	$CanvasLayer/PopupMenu.show()