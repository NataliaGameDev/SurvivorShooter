extends Area2D

var projectile3_velocity = Vector2()
var type = "enemyLaser"


func _process(delta):
	if projectile3_velocity.x != 0 or projectile3_velocity.y != 0 :
		translate(projectile3_velocity * delta)
	else:
		print("A VELOCIDADE DO PROJÉTIL DO INIMIGO 3 NÃO FOI DEFINIDA")
	
	if ( (position.x >= get_viewport_rect().size.x) or 
	(position.y >= get_viewport_rect().size.y) or
	(position.x <= 0) ):
		queue_free()

func set_projectile3_velocity(velocity):
	projectile3_velocity.x = velocity.x
	projectile3_velocity.y = velocity.y

func _on_Enemy3Projectile_area_entered(area):
	if area.type == "player":
		queue_free()