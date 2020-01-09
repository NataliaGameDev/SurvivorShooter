extends Node2D

signal pontuationsQuitPressed

func _ready():
	#movement()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func movement():
	$VictoryMusic.play()
	var target = Vector2(position.x,position.y - 1000)
	$VictoryTwin.interpolate_property(self, "position", position, target, 2, Tween.TRANS_QUINT, Tween.EASE_OUT)
	$VictoryTwin.start()

func _on_PontuationsQuitButton_pressed():
	print("SinalEmitido")
	emit_signal("pontuationsQuitPressed")
