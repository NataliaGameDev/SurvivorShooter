extends Node2D

export (PackedScene) var powerup1
export (PackedScene) var powerup2
export (PackedScene) var powerup3

signal playerLife
signal playerAggressive
signal playerSaw

func _on_PowerUp1_spawner_timeout():
	var new_powerUp1 = powerup1.instance()
	new_powerUp1.connect("got_powerUp1", self, "on_got_powerUp1")
	
	add_child(new_powerUp1)

func on_got_powerUp1():
	emit_signal("playerLife")

func _on_PoweUp2_spawner_timeout():
	var new_powerUp2 = powerup2.instance()
	new_powerUp2.connect("got_PowerUp2", self, "on_got_PowerUp2")
	add_child(new_powerUp2)

func on_got_PowerUp2():
	emit_signal("playerAggressive")


func _on_PoweUp3_spawner_timeout():
	var new_powerUp3 = powerup3.instance()
	new_powerUp3.connect("got_powerUp3", self, "on_got_PowerUp3")
	
	add_child(new_powerUp3)


func on_got_PowerUp3():
	emit_signal("playerSaw")
