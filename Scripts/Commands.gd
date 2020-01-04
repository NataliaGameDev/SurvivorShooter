extends Area2D

class_name Commands

var velocity = Vector2()
var _to_save = []

signal enemyDestroyed(enemy)

func move(delta):
	translate(velocity * delta)
	
	if position.x > get_viewport_rect().size.x or position.x < 0:
		velocity.x *= -1

	if position.y > get_viewport_rect().size.y:
		queue_free()

func organize_saves(nodes_to_be_saved):
	
	for i in nodes_to_be_saved:
		_to_save.append(save(i))
		
	var save_game = File.new()
	save_game.open("res://savegame.save", File.WRITE)
	
	for i in _to_save:
		save_game.store_line(to_json(i))
	save_game.close()
	
	print("Arquivo Escrito")

func save(node):
	var save_dict
	if node.name == "Player":
		save_dict = {
	        "filename" : node.get_filename(),
	        "parent" : node.get_parent().get_path(),
	        "total_jellycoins" : node.total_jellycoins
			}
	return save_dict

func load_game(save_nodes):
    var save_game = File.new()
    if not save_game.file_exists("res://savegame.save"):
        return # Error! We don't have a save to load.

    # We need to revert the game state so we're not cloning objects
    # during loading. This will vary wildly depending on the needs of a
    # project, so take care with this step.
    # For our example, we will accomplish this by deleting saveable objects.
    for i in save_nodes:
        i.queue_free()

    # Load the file line by line and process that dictionary to restore
    # the object it represents.
    save_game.open("user://savegame.save", File.READ)
    while not save_game.eof_reached():
        var current_line = parse_json(save_game.get_line())
        # Firstly, we need to create the object and add it to the tree and set its position.
        var new_object = load(current_line["filename"]).instance()
        get_node(current_line["parent"]).add_child(new_object)
        # Now we set the remaining variables.
        for i in current_line.keys():
            if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
                continue
            new_object.set(i, current_line[i])
    save_game.close()