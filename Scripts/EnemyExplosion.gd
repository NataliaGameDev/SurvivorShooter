extends Sprite

func _ready():
	$Smoke.emitting = true
	$Flare.emitting = true
	
	$Smoke.one_shot = true
	$Flare.one_shot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
