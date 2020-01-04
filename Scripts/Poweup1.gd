extends Area2D

signal got_powerUp1

var type = "powerUp"

export var velocity = Vector2()

func _ready():
	position = Vector2( randi() % int(get_viewport_rect().size.x), 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(velocity * delta)
	
	if position.y >= get_viewport_rect().size.y:
		queue_free()

func _on_Poweup1_area_entered(area):
	if area.type == "player":
		queue_free()
		emit_signal("got_powerUp1")