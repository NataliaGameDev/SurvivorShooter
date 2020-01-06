extends Area2D

export var laserEnemy_velocity = 0
var type = "enemyLaser"

func _ready():
	pass
func _process(delta):
	translate(Vector2(0, laserEnemy_velocity))
	
	if position.y >= get_viewport_rect().size.y:
		queue_free()

func get_laser_velocity():
	return laserEnemy_velocity


func _on_Enemy1_laser_area_entered(area):
	if area.type == "player" or area.type == "player_powerUp":
		queue_free()
