extends Area2D

export var enemy_velocity = Vector2()
var type = "enemy"

#Jelly-Fish life
var enemy2_life = 2

func _process(delta):
	translate(enemy_velocity * delta)
	
	if position.y >= get_viewport_rect().size.y:
		queue_free()

func _on_Enemy2_area_entered(area):
	if area.type == "player":
		queue_free()
	elif area.type == "playerLaser" and enemy2_life > 0:
		enemy2_life -= 1
	
	if enemy2_life == 0:
		queue_free()
