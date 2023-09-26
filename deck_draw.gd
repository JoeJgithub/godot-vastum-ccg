extends TextureButton


var deck_size = INF

# Called when the node enters the scene tree for the first time.
func _ready():
	scale *= $"../../".card_size / size
	print(size, scale)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _gui_input(event):
	if event.is_action_released("left_click"):
		var overdrawn = draw_card(1) # If an action causes you to overdraw you lose the game

func draw_card(n: int): # draws n cards from deck if deck_size >= n
	if n <= 0:
		print("You cannot draw 0 or less cards")
		
	if deck_size >= n:
		deck_size = $'../../'.draw_from_deck()
		if deck_size == 0:
			disabled = true
	else:
		return false # If you draw from an empty deck you lose the game
	
	return true
