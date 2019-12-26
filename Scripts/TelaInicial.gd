extends Node2D

signal startPressed

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Botoes/Conj2.hide()
	$Botoes/Conj2/SongsOn.hide()

func _on_SongsOff_pressed():
	$Botoes/Conj2/SongsOff.hide()
	$Botoes/Conj2/SongsOn.show()

func _on_SongsOn_pressed():
	$Botoes/Conj2/SongsOff.show()
	$Botoes/Conj2/SongsOn.hide()

func _on_Start_pressed():
	emit_signal("startPressed")
	print("Sinal Emitido!!")
