extends Camera2D

var shake = 0

func _ready():
    set_process(true)

func _process(delta):
    if shake > 0:
        position.x = cos(rad2deg(shake)) * 5
        position.y = sin(rad2deg(shake)) * 5
        shake -= 5 * delta

func shake():
    shake = 1
