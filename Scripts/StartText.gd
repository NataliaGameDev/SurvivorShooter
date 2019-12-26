extends Node2D

var isStartTimerRunning = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_parent().get_node("Ready").connect("ReadyLabelExit", self, "_on_ReadyLabelExit")
	$TimerLabel.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isStartTimerRunning:
		$TimerLabel.text = String(int($StartTimer.time_left))

func _on_ReadyLabelExit():
	print($StartTimer.wait_time)
	$TimerLabel.text = String($StartTimer.time_left)
	$StartTimer.start()
	isStartTimerRunning = true
	$TimerLabel.show()
