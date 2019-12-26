extends Node2D

func _ready():
	pass

func game_over_movement():
	var target = Vector2(position.x - 590,position.y)
	$GameOverTwin.interpolate_property(self, "position", position, target, 2, Tween.TRANS_QUINT, Tween.EASE_OUT)
	$GameOverTwin.start()
