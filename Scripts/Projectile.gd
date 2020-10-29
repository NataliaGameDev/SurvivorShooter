extends Area2D

export var projectile_velocity = Vector2()
var type = "playerLaser"

func _ready():
	if get_parent().get_parent().get_parent().is_song_on:
		$AudioStreamPlayer2D.play()

func _process(delta): #Posição do player no momento
	position += projectile_velocity * delta
	
	if position.y <= 0:
		queue_free()

func get_projectile_velocity():
	return projectile_velocity


func _on_Projectile_area_entered(area):
	if area.type != "enemyLaser" and area.type != "playerLaser":
		queue_free()
