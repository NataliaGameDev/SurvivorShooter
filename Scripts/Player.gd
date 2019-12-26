extends Area2D

#export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.
export (PackedScene) var projectile #prefab para o tiro
var player_life = 4
signal game_over #Signal emited when player chances end
signal hit #When player gets hit from enemy

var type = "player"

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(275,950)
	screen_size = get_viewport_rect().size
	$DamageFade.set_as_toplevel(true)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_input(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)
		position = event.position

func _on_ShootTimer_timeout():
	var new_projectile = projectile.instance()
	new_projectile.set_as_toplevel(true)
	new_projectile.position = Vector2(position.x, position.y - 70)
	add_child(new_projectile)


func _on_Player_area_entered(area):
	if area.type == "playerLaser":
		player_life = player_life
	elif player_life == 0:
		$DamageFade/Fade.play("DamageFade")
		emit_signal("game_over")
		print("GAME OVER")
	else:
		Input.vibrate_handheld(100)
		$DamageFade/Fade.play("DamageFade")
		$PlayerHit.play()
		emit_signal("hit")
		player_life -= 1
