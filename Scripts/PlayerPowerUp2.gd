extends Node2D

export (PackedScene) var proj

var shoot = 4

func _ready():
	$PowerUp2Song.play()

func _on_PowerUp2Timer_timeout():
	$ShooterTimer.stop()
	queue_free()

func _on_ShooterTimer_timeout():
	var new_proj = proj.instance()
	var new_proj2 = proj.instance()
	
	new_proj.set_as_toplevel(true)
	new_proj2.set_as_toplevel(true)
	
	new_proj.position = Vector2(get_parent().position.x + 30, get_parent().position.y)
	new_proj2.position = Vector2(get_parent().position.x - 30, get_parent().position.y)
	
	add_child(new_proj)
	add_child(new_proj2)
	