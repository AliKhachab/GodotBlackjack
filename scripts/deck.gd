class_name Deck
extends Node2D

var deck : Array[String] = []
const CARD_SCN_PATH := "res://scenes/card.tscn"
const CARD_SCENE = preload(CARD_SCN_PATH) 
var card_id = 0
var _drawing := false

func _ready() -> void:
	Global.card_db_ref.initialize_card_textures()
	Global.card_db_ref.generate_standard_deck(self.deck)

func draw_card(facedown := false, dealer_turn := false) -> Node2D:
	# cards drawn should wait for all other cards to be drawn.
	if self.deck.is_empty():
		return null
	_drawing = true
	var card_code = deck.pop_at(0)
	var new_card = CARD_SCENE.instantiate()
	new_card.name = str(++card_id) # use the name as the id for a unique identifier
	new_card.card_code = card_code
	new_card.rank = Global.card_db_ref.get_rank_from_code(new_card)
	new_card.set_card_texture(Global.card_db_ref.card_textures[card_code])
	$"..".add_card_to_hand(new_card)
	if !facedown: # play the flip but do not worry about connecting the card to the signal here because we do not need to wait for dealer
		# at this point. we only need to worry about dealer when it is dealer's turn, so check for dealer stall logic in blackjack.gd
		if !dealer_turn:
			new_card.flip()
			print("\ncard flipped in draw_card\n")
		new_card.facedown = false
	else:
		new_card.facedown = true
	if self.deck.is_empty():
		$Area2D/CollisionShape2D.disabled = true
		$Sprite2D.get_parent().visible = false
	return new_card


func is_drawing() -> bool:
	return _drawing

func set_not_drawing() -> void:
	_drawing = false