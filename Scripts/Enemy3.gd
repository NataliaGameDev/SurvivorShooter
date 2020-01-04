extends Area2D

export var velocity = Vector2()
export (PackedScene) var projectile

var type = "enemy3"

var enemy3_life = 3

func _ready():
	position = Vector2(get_viewport_rect().size.x/2, 0)
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


func _on_Enemy3ShootTimer_timeout():
	
	var projectile1 = projectile.instance()
	projectile1.position = Vector2(position.x, position.y + 10)
	projectile1.set_projectile3_velocity(Vector2(0, 500))
	projectile1.set_as_toplevel(true)
	add_child(projectile1)
	
	var projectile2 = projectile.instance()
	projectile2.position = Vector2(position.x + 10, position.y)
	projectile2.set_projectile3_velocity(Vector2(500, 0))
	projectile2.rotation_degrees = 270
	projectile2.set_as_toplevel(true)
	add_child(projectile2)
	
	var projectile3 = projectile.instance()
	projectile3.position = Vector2(position.x - 10, position.y)
	projectile3.set_projectile3_velocity(Vector2(-500, 0))
	projectile3.rotation_degrees = 90
	projectile3.set_as_toplevel(true)
	add_child(projectile3)