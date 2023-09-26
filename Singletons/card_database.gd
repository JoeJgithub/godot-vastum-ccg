extends Node


enum Card {GoblinAmbusher, Militiaman, BlueDragon, GoblinScout, GoblinBrute}

var type_dict := {
	"1": "Creature",
	"2": "Relic",
	"3": "Equipment",
	"4": "Spell",
}
var subtype_dict := {
	"1": "Human",
	"2": "Goblin",
	"3": "Dragon",
	"4": "Rogue",
	"5": "Soldier",
	"6": "Elemental",
}
var modifier_dict := {
	"1": "Haste",
	"2": "Flying",
	"3": "Expertise",
	"4": "Advantage"
}
var cards_data := {}
var data_file_path = "res://Data/card_database.json"


# Called when the node enters the scene tree for the first time.
func _init():
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
	var cards_dict := {}
	
	for data in data_array:
		cards_dict[Card.keys()[data.id - 1]] = data
	
	return cards_dict
	
