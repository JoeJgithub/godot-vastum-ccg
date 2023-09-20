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
	if Input.is_action_just_released("left_click"):
		if deck_size > 0:
			deck_size = $'../../'.draw_from_deck()
			if deck_size == 0:
				disabled = true
