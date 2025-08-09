class_name Deck
extends Node2D

var deck : Array[String] = []
const CARD_SCN_PATH := "res://scenes/card.tscn"
const CARD_SCENE = preload(CARD_SCN_PATH) 
var card_id = 0

func _ready() -> void:
	Global.card_db_ref.initialize_card_textures()
	Global.card_db_ref.generate_standard_deck(self.deck)

func draw_card(facedown := false) -> Node2D: # TODO create functionality to limit amount of cards drawn at once. 
	# cards drawn should wait for all other cards to be drawn.
	if !self.deck:
		return null
		
	var card_code = deck.pop_at(0)
	var new_card = CARD_SCENE.instantiate()
	new_card.name = str(++card_id) # use the name as the id for a unique identifier
	new_card.card_code = card_code
	new_card.rank = Global.card_db_ref.get_rank_from_code(new_card)
	new_card.set_card_texture(Global.card_db_ref.card_textures[card_code])
	$"..".add_card_to_hand(new_card)
	if !facedown:
		new_card.get_node("AnimationPlayer").play("card_flip")
		new_card.facedown = false
	else:
		new_card.facedown = true
	if deck == []:
		$Area2D/CollisionShape2D.disabled = true
		$Sprite2D.get_parent().visible = false
		
	return new_card
