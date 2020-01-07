extends Node2D

signal callPontuation

func _ready():
	$AnimationPlayer.play("Completed")

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("callPontuation")
	queue_free()
