extends Node2D

signal ReadyLabelExit

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	movement1()

func _process(delta):
	pass
	
func movement1():
	var target = Vector2(position.x - 475,position.y)
	var move_tween = $MoveTween
	move_tween.interpolate_property(self, "position", position, target, 2, Tween.TRANS_QUINT, Tween.EASE_OUT)
	move_tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_GetReadyTimer_timeout():
	var target = Vector2(position.x - 600,position.y)
	var move_tween = $MoveTween
	move_tween.interpolate_property(self, "position", position, target, 2, Tween.TRANS_QUINT, Tween.EASE_OUT)
	move_tween.start()
	emit_signal("ReadyLabelExit")
