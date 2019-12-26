extends Node2D

signal quitPressed

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_QuitToMenu_pressed():
	print("sinal de quit emitido")
	emit_signal("quitPressed")
