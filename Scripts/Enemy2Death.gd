extends Node2D

signal Animation2Finished

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("Animation2Finished")
