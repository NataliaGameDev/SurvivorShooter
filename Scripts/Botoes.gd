extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Settings_pressed():
	$Conj1.hide()
	$Conj2.show()
	
func _on_Back_pressed():
	$Conj1.show()
	$Conj2.hide()

func _on_Quit_pressed():
	get_tree().quit()
