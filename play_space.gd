extends Node2D


const card_base = preload("res://Cards/card_base.tscn")
const card_size = Vector2(165, 220)
@onready var player_hand = preload("res://Cards/player_hand.gd").new()
@onready var card_list = player_hand.card_list
@onready var deck_size = card_list.size()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if deck_size and Input.is_action_just_released("left_click"):
		var new_card = card_base.instantiate()
		var card_selected = randi() % deck_size
		new_card.card = card_list[card_selected]
		new_card.position = get_global_mouse_position()
		new_card.scale = card_size / new_card.size
		$Cards.add_child(new_card)
		card_list.erase(card_list[card_selected])
		deck_size -= 1
