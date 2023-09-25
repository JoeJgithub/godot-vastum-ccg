extends MarginContainer


enum state_enum {
	InHand,
	InPlay,
	InMouse,
	FocusInHand,
	MoveDrawnCardToHand,
	ReorganizeHand,
}

var start_pos = 0
var target_pos = 0
var start_rot = 0
var target_rot = 0
var t = 0
var draw_time = 0.5
var state = state_enum.InHand
@onready var card_database = preload("res://Singletons/card_database.gd").new()
var card = "GoblinAmbusher"
@onready var card_data = card_database.cards_data[card]
@onready var card_image_path = "res://Assets/Cards/Art/%s-Rounded.png" % card
@onready var orig_scale = scale.x

# Called when the node enters the scene tree for the first time.
func _ready():
	var card_size = size
	var card_frame = get_node("CardFrame")
	var card_node = get_node("Card")
	var card_back = get_node("CardBack")
	
	$CardFrame.scale = card_size / card_frame.texture.get_size()
	$Card.texture = load(card_image_path)
	$Card.scale = card_size / card_node.texture.get_size()
	$CardBack.scale = card_size / card_back.texture.get_size()
	
	var type_template = "%s - %s"
	
	var card_name: String = card_data.name
	var attack := str(card_data.power)
	var health := str(card_data.health) 
	var cost := str(card_data.cost)
	var type: String = card_database.type_dict[str(card_data.type)]
	var subtypes := get_subtypes(card_data, card_database.subtype_dict)
	var modifiers := get_modifiers(card_data, card_database.modifier_dict)
	var card_text := get_card_text(card_data, modifiers)
	$Bars/TopBar/Name/CenterContainer/Name.text = card_name
	$Bars/TopBar/Cost/CenterContainer/Cost.text = cost
	$Bars/TypeBar/Type/CenterContainer/Type.text = get_type_str(type, subtypes, type_template)
	$Bars/TextBar/CardText/CenterContainer/CardText.text = card_text
	$Bars/BottomBar/Stats/CenterContainer/Stats.text = "%s / %s" % [attack, health]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	match state:
		state_enum.InHand:
			pass
		state_enum.InPlay:
			pass
		state_enum.InMouse:
			pass
		state_enum.FocusInHand:
			pass
		state_enum.MoveDrawnCardToHand: # trigger deck to hand animation
			if t <= 1: # Always be a 1
				position = start_pos.lerp(target_pos, t)
				rotation = start_rot * (1 - t) + target_rot * t
				scale.x = orig_scale * abs(2 * t - 1)
				if t >= 0.5 and $CardBack.visible:
					$CardBack.visible = false
				t += delta/float(draw_time) # To make a longer animation delta/n
			else:
				position = target_pos
				rotation = target_rot
				state = state_enum.InHand
				t = 0
		state_enum.ReorganizeHand:
			pass
		

func get_modifiers(data, mod_dict) -> Array[String]:
	var mods: Array[String] = []
	
	for id in data.modifiers:
		mods.append(mod_dict[str(id)])
	
	return mods

func get_subtypes(data, sub_dict) -> Array[String]:
	var subs: Array[String] = []
	for id in data.subtypes:
		subs.append(sub_dict[str(id)])
	
	return subs

func get_type_str(type, subtypes, template) -> String:
	var subtype_str := ""
	
	for n in range(len(subtypes)):
		subtype_str += subtypes[n] + ("" if n + 1 == len(subtypes) else " ")
	
	return template % [type, subtype_str]

func get_card_text(data, modifiers: Array[String]) -> String:
	var card_text_str := ""
	
	for n in range(len(modifiers)):
		card_text_str += modifiers[n] + ("" if n + 1 == len(modifiers) else " ")
	
	if len(data.card_text):
		card_text_str += (": " if len(card_text_str) else "") + data.card_text
	
	return card_text_str
