extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var cats_dict = JsonParser.load_json_into_dict("res://data/cats.json")
	var items_dict = JsonParser.load_json_into_dict("res://data/items.json")
	var room_state_dict = JsonParser.load_json_into_dict("res://saves/room_state.json")
	var new_room_state_dict = GameManager.update(room_state_dict, cats_dict, items_dict)
	JsonParser.save_dict_to_json(new_room_state_dict, "res://saves/room_state.json")
#	print_to_label(str(new_room_state_dict))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func print_to_label(label_message):
	get_node("Label").text = label_message
