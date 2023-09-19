extends Node


var card_list: Array = []

func _init():
	var card_database = preload("res://Singletons/card_database.gd").new()
	card_list = card_database.cards_data.keys()
