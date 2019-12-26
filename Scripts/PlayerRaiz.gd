extends Node2D

var shoot = preload("res://Cenas/Projectile.tscn").instance()

func _on_ShootTimer_timeout():
	add_child(shoot)
	