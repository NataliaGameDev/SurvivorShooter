extends Button

signal Continuepressed

func _on_Continue_pressed():
	emit_signal("Continuepressed")
