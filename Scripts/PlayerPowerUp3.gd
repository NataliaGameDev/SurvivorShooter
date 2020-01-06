extends Area2D

var type = "player_powerUp"
signal sawFinished

func _ready():
	get_parent().get_node("CollisionShape2D").set_deferred("disabled", true)
	$AnimationPlayer.play("SawAnimation")

func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer.play("SawAnimation")

func _on_PowerUp3Timer_timeout():
	get_parent().get_node("CollisionShape2D").set_deferred("disabled", false)
	queue_free()
