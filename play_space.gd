extends Node2D


const card_base = preload("res://Cards/card_base.tscn")
var player_hand = preload("res://Cards/player_hand.gd").new()
var card_list = player_hand.card_list

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if Input.is_action_just_released("left_click"):
		var new_card = card_base.instantiate()
		print(card_list)
		var card_i = randi() % card_list.size()
		print(card_list[card_i])
		new_card.card = card_list[card_i]
		new_card.position = get_global_mouse_position()
		$Cards.add_child(new_card)
