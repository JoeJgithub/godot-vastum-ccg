extends Node


enum Card {GoblinAmbusher, Militiaman, BlueDragon}


var cards_data: Dictionary = {}

var data_file_path = "res://Data/card_database.json"


# Called when the node enters the scene tree for the first time.
func init():
	var parsed_data = load_from_json(data_file_path)
	
	if (parsed_data):
		cards_data =  map_data_to_enums(parsed_data)


func load_from_json(file_path: String) -> Array:
	var parsed_result: Array = []
	
	if FileAccess.file_exists(file_path):
		var data_file = FileAccess.open(file_path, FileAccess.READ)
		parsed_result = JSON.parse_string(data_file.get_as_text())
		
		if parsed_result is Array:
			return parsed_result
		else:
			print("Error parsing file!")
	else:
		print("File not found!")
	return parsed_result


func map_data_to_enums(data_array: Array) -> Dictionary:
	var cards_dict: Dictionary = {}
	
	for data in data_array:
		cards_dict[Card.keys()[data.id]] = data
	
	return cards_dict
	
