extends "res://Scripts/Commands.gd"

export var enemy_velocity = Vector2()
var type = "enemy2"
var value = 2

#Jelly-Fish life
var enemy2_life = 2

func _ready():
	$Enemy2Death.connect("Animation2Finished", self, "on_death_animation2_finished")
	$Enemy2Death.hide()
	velocity = enemy_velocity

func _process(delta):
	
	move(delta)

func _on_Enemy2_area_entered(area):
	if area.type == "player":
		queue_free()
	elif (area.type == "playerLaser" or area.type == "player_powerUp") and enemy2_life > 0:
		enemy2_life -= 1
	
	if enemy2_life == 0:
		$CollisionShape2D.set_deferred("disabled", true)
		$AnimatedSprite.hide()
		$Enemy2Death.show()
		$Enemy2Death/AnimationPlayer.play("Splash")
		$Enemy2Death/AudioStreamPlayer.play()

func on_death_animation2_finished():
	emit_signal("enemyDestroyed", self)
	queue_free()