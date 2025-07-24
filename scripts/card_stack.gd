class_name CardStack
extends Node2D

var _player: int
var hand_position: int
var card_stack: Array[Card] = [] 
var _score: int = 0
var center_screen_x := 0

func _ready() -> void:
	center_screen_x = get_viewport().size.x / 2

func set_player_and_position(player: int) -> void:
	_player = player
	hand_position = Global.PLAYER_HAND_LOCATION if player == Global.belongs_to.PLAYER else Global.DEALER_HAND_LOCATION

func add_card(card: Card) -> void:
	if card in card_stack:
		animate_card_to_position(card, card.position_in_hand)
		return

	card_stack.insert(0, card)
	$CardManager.add_child(card)
	update_card_positions()

func update_card_positions() -> void:
	for i in range(card_stack.size()):
		var card = card_stack[i]
		var new_position = Vector2(calculate_card_position(i), hand_position)
		card.position_in_hand = new_position
		animate_card_to_position(card, new_position)

func calculate_card_position(index: int) -> float:
	var total_width = (card_stack.size() - 1) * Global.CARD_WIDTH
	return center_screen_x + index * Global.CARD_WIDTH - total_width / 2

func animate_card_to_position(card: Card, new_position: Vector2) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", new_position, Global.CARD_DRAW_SPEED)

func update_score() -> void:
	_score = calculate_score()

func calculate_score() -> int:
	var aces = 0
	var score = 0
	for card in card_stack:
		if card.rank in ["J", "Q", "K"]:
			score += 10
		elif card.rank == "A":
			aces += 1
			score += 11
		else:
			score += int(Global.card_db_ref.RANKS[card.rank])
	while score > 21 and aces > 0:
		score -= 10
		aces -= 1
	return score

func lost_game() -> bool:
	return self._score > 21
	
