extends Node2D

signal StartLevel

func _on_StartTimer_timeout():
	$StartText.hide()
	emit_signal("StartLevel")
	print("Hora de começar o jogo")
	
