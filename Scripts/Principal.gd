extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().change_scene("res://Cenas/TelaInicial.tscn")
	$TelaInicial.connect("startPressed", self, "StartPressed")
	$Loading.connect("LoadingTimeOut", self, "_on_LoadingTimeOut")
	#$ReadyScreen.connect("StartLevel", self, "_on_StartLevel")
# Called every frame. 'delta' is the elapsed time since the previous frame.

func StartPressed():
	print("cheguei aqui!!")
	get_tree().change_scene("res://Cenas/Loading.tscn")
	
func _on_LoadingTimeOut():
	get_tree().change_scene("res://Cenas/ReadyScreen.tscn")
	#$ReadyScreen.show()