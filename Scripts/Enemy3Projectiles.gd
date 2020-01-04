extends Node2D

export var velocity = 100
var type = "enemyLaser"
func _ready():
	pass # Replace with function body.


func _process(delta):
	translate(Vector2(0, velocity) * delta)
	
	$Enemy3Projectile_1.translate(Vector2(0, velocity) * delta)
	$Enemy3Projectile_2.translate(Vector2(velocity, 0) * delta)
