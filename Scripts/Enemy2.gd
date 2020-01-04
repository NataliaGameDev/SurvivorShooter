extends Area2D

export var enemy_velocity = Vector2()
var type = "enemy2"

#Jelly-Fish life
var enemy2_life = 2

func _ready():
	$Enemy2Death.connect("Animation2Finished", self, "on_death_animation2_finished")
	$Enemy2Death.hide()

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
		$CollisionShape2D.set_deferred("disabled", true)
		$AnimatedSprite.hide()
		$Enemy2Death.show()
		$Enemy2Death/AnimationPlayer.play("Splash")
		$Enemy2Death/AudioStreamPlayer.play()

func on_death_animation2_finished():
	queue_free()