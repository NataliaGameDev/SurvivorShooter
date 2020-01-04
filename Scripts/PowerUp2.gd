extends Area2D

export var velocity = Vector2()
signal got_PowerUp2

var type = "powerUp"

func _ready():
	position = Vector2( randi() % int(get_viewport_rect().size.x), 0)

func _process(delta):
	
	translate(velocity * delta)
	
	if position.y >= get_viewport_rect().size.y:
		queue_free()

func _on_PowerUp2_area_entered(area):
	if area.type == "player":
		queue_free()
		emit_signal("got_PowerUp2")
