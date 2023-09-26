extends Node2D


const card_base = preload("res://Cards/card_base.tscn")
const card_size = Vector2(165, 220)
@onready var player_hand = preload("res://Cards/player_hand.gd").new()
@onready var card_list = player_hand.card_list
@onready var deck_size = card_list.size()
@onready var viewport_size = Vector2(get_viewport().size)
@onready var centre_card_wheel = viewport_size * Vector2(0.5, 1.25)
@onready var h_rad = viewport_size.x * 0.45
@onready var v_rad = viewport_size.y * 0.4
var angle = 0
var number_cards_hand = 0
var card_num = 0
var card_spread = 0.25
var oval_angle_vector = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func sort_hand_placement(): # reorganize hand
	var card_num = 0
	for card in $Cards.get_children():
		angle = PI / 2 + card_spread * (float(number_cards_hand) / 2 - card_num)
		oval_angle_vector = Vector2(h_rad * cos(angle), -v_rad * sin(angle))
		card.target_pos = centre_card_wheel + oval_angle_vector - card.size / 2
		card.start_rot = card.rotation
		card.target_rot = (PI / 2 - angle) / 4
		card_num += 1
		if card.state == card.state_enum.InHand:
			card.state = card.state_enum.ReorganizeHand
			card.start_pos = card.position

func draw_from_deck():
	angle = PI /2 + card_spread * (float(number_cards_hand) / 2 - number_cards_hand)
	var new_card = card_base.instantiate()
	var states = new_card.state_enum
	var card_selected = randi() % deck_size
	new_card.card = card_list[card_selected]
	new_card.position = $Deck.position - card_size / 2
	# new_card.position = get_global_mouse_position()
	oval_angle_vector = Vector2(h_rad * cos(angle), -v_rad * sin(angle))
	new_card.start_pos = $Deck.position - card_size / 2
	new_card.target_pos = centre_card_wheel + oval_angle_vector - new_card.size / 2
	new_card.start_rot = 0
	new_card.target_rot = (PI / 2 - angle) / 4
	new_card.scale = card_size / new_card.size
	new_card.state = states.MoveDrawnCardToHand
	sort_hand_placement()
	$Cards.add_child(new_card)
	card_list.erase(card_list[card_selected])
	angle += 0.3
	deck_size -= 1
	number_cards_hand += 1
	
	return deck_size
