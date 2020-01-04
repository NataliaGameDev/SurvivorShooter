extends "res://Scripts/Commands.gd"

export var enemy_velocity = Vector2()
export (PackedScene) var enemy_laser
export (PackedScene) var enemy_explosion

var type = "enemy1"
var value = 1

func _ready():
	velocity = enemy_velocity
	
func _process(delta):	
	move(delta)

func _on_EnemyShootTimer_timeout():
	var new_enemyLaser = enemy_laser.instance()
	new_enemyLaser.set_as_toplevel(true)
	new_enemyLaser.position = Vector2(position.x, position.y + 10)
	get_parent().add_child(new_enemyLaser)

func _on_Enemy1_area_entered(area):
	if area.type == "playerLaser" or area.type == "player":
		$Enemy1_CollisionShape.set_deferred("disabled", true)
		$Enemy1_sprite.hide()
		$EnemyShootTimer.stop()
		$DeleteTimer.start()
		emit_signal("enemyDestroyed", self)
		$Enemy1Death.get_node("CPUParticles2D").emitting = true


func _on_DeleteTimer_timeout():
	queue_free()
