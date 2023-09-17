extends MarginContainer


@onready var card_database = preload("res://Singletons/card_database.gd").new()

# Called when the node enters the scene tree for the first time.
func _ready():
	card_database.init()
	var card = card_database.Card.keys()[card_database.Card.GoblinAmbusher]
	var card_data = card_database.cards_data[card]
	var card_size = size
	var card_frame = get_node("CardFrame")
	var frame_texture_size = card_frame.texture.get_size()
	$CardFrame.scale = card_size / frame_texture_size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
