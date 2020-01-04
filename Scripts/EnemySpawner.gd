extends Node2D

export (PackedScene) var enemy1
export (PackedScene) var enemy2
export (PackedScene) var enemy3

signal shake_camera

func _ready():
	sort_Enemy3SpawnTimer()

func _on_Enemy1SpawnTimer_timeout():
	var px
	var side = randi() % 2
	if side:
		px = get_viewport_rect().size.x -1
	else:
		px = 1
	
	var new_enemy1 = enemy1.instance()
	new_enemy1.connect("enemy1_destroyed", self, "on_enemy1_destroyed")
	new_enemy1.position = Vector2( px, randi() % int(get_viewport_rect().size.y/2))
	add_child(new_enemy1)
	#pass # Replace with function body.

func _on_Enemy2SpawnTimer_timeout():
	
	var new_enemy2 = enemy2.instance()
	new_enemy2.position = Vector2( randi() % int(get_viewport_rect().size.x), 0)
	add_child(new_enemy2)
	
func on_enemy1_destroyed():
	emit_signal("shake_camera")

func _on_Enemy3SpawnTimer_timeout():
	var new_enemy3 = enemy3.instance()
	new_enemy3.position = Vector2( randi() % int(get_viewport_rect().size.x), 0)
	add_child(new_enemy3)
	sort_Enemy3SpawnTimer()

func sort_Enemy3SpawnTimer():
	var time = randi() % 30
	$Enemy3SpawnTimer.wait_time = time
	$Enemy3SpawnTimer.start()
