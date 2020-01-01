extends Area2D

export var velocity = Vector2()

var type = "enemy"

var enemy3_life = 3

func _ready():
	#position = Vector2(get_viewport_rect().size.x/2, 0)
	$Enemy3Death.connect("Animation2Finished", self, "on_animation2_finished")

func _process(delta):
	translate(velocity * delta)
	
	if position.y >= get_viewport_rect().size.y:
		queue_free()

func _on_Enemy3_area_entered(area):
	if area.type == "player":
		queue_free()
	elif area.type == "playerLaser" and enemy3_life > 0:
		enemy3_life -= 1
	
	if enemy3_life == 0:
		$AnimatedSprite.hide()
		$CollisionShape2D.set_deferred("disabled", true)
		$Enemy3Death/AnimationPlayer.play("Splash2")

func on_animation2_finished():
	queue_free()
