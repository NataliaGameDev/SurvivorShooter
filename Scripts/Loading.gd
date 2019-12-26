extends TextureRect
signal LoadingTimeOut

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$LoadingTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LoadingTimer_timeout():
	emit_signal("LoadingTimeOut")
	print("Terminou o tempo de loading")
