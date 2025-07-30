class_name Blackjack
extends Node2D

var player_card_stack: CardStack 
var dealer_card_stack: CardStack
var center_screen_x: float

@onready var deck: Deck = $Deck
@onready var player_ui: Control = $PlayerUI
@onready var scores: VBoxContainer = $Scores
@onready var player_score: RichTextLabel = $"Scores/Player Score"
@onready var dealer_score: RichTextLabel = $"Scores/Dealer Score"
@onready var hit_button: Button = $PlayerUI/HBoxContainer/Hit
@onready var stand_button: Button = $PlayerUI/HBoxContainer/Stand


func _ready() -> void:
	center_screen_x = get_viewport().size.x / 2
	
	hit_button.pressed.connect(on_hit_pressed)
	stand_button.pressed.connect(on_stand_pressed)
	
	Global.prepare_default_deck()

	player_card_stack = Global.card_stack_ref.instantiate()
	add_child(player_card_stack)
	player_card_stack.set_player_and_position(Global.belongs_to.PLAYER)

	dealer_card_stack = Global.card_stack_ref.instantiate()
	add_child(dealer_card_stack)
	dealer_card_stack.set_player_and_position(Global.belongs_to.DEALER)

	setup_game()

func setup_game() -> void:
	# Reset state or deal new hands
	return_cards_to_deck(player_card_stack)
	return_cards_to_deck(dealer_card_stack)
	deck.deck = Global.default_deck
	deck.deck.shuffle()

	draw_starting_hands()
	toggle_buttons_on(true)

func draw_starting_hands() -> void:
	# Player gets 2 cards
	Global.player_turn = Global.belongs_to.PLAYER
	deck.draw_card()
	deck.draw_card()

	# Dealer gets 2 cards (1 hidden)
	Global.player_turn = Global.belongs_to.DEALER
	deck.draw_card()
	deck.draw_card(true) # Note to self, make a flag to make this hidden later

	# Back to player turn for actual gameplay
	Global.player_turn = Global.belongs_to.PLAYER
	player_card_stack.update_score()
	dealer_card_stack.update_score()
	update_text_with_score(player_score, player_card_stack)
	dealer_score.text = "Score: "  + str(dealer_card_stack.calculate_score(true)) 

func return_cards_to_deck(stack: CardStack) -> void:
	stack.card_stack.clear()
	stack.update_card_positions()

func add_card_to_hand(card: Card) -> void:
	var hand = player_card_stack if (Global.player_turn == Global.belongs_to.PLAYER) else dealer_card_stack
	hand.add_card(card)
	# Fix this logic, cards are not going in player hands

func on_hit_pressed() -> void:
	deck.draw_card()
	player_card_stack.update_score()
	if player_card_stack.lost_game(): # if score > 21 force the player to stand
		stand() # find better way to say "end the game right here" without writing stand() twice
	if Global.player_turn == Global.belongs_to.PLAYER:
		update_text_with_score(player_score, player_card_stack)
	else:
		update_text_with_score(dealer_score, dealer_card_stack)

	
func on_stand_pressed() -> void:
	stand()

func stand() -> void:
	if Global.player_turn == Global.belongs_to.PLAYER:
		player_card_stack.update_score()
		update_text_with_score(player_score, player_card_stack)
		Global.player_turn = Global.belongs_to.DEALER
		toggle_buttons_on(false)
		flip_dealer_facedown_card(dealer_card_stack)
		dealer_play_turn()
	else:
		dealer_score.push_font_size(16)
		dealer_score.text = "Dealer stands with score: " + str(dealer_card_stack.calculate_score())
		
func game_results() -> int:
	if player_card_stack.get_score() > 21:
		return Global.belongs_to.DEALER
	return Global.belongs_to.PLAYER if player_card_stack.get_score() > dealer_card_stack.get_score() else Global.belongs_to.DEALER

func toggle_buttons_on(boolean: bool) -> void:
	# true = turn them on, false = turn them off. so toggle_buttons_on(false) will turn off the button
	# aka disable the button (disabled = true) and make them invisible (visible = false)
	hit_button.disabled = !boolean
	stand_button.disabled = !boolean
	hit_button.visible = boolean
	stand_button.visible = boolean

func update_text_with_score(label: RichTextLabel, hand: CardStack) -> void:
	label.text = "Score: "  + str(hand.get_score())

func flip_dealer_facedown_card(dealer_hand: CardStack) -> void:
	for card in dealer_hand.card_stack:
		if card.facedown:
			card.flip()
			break

func dealer_play_turn() -> void:
	dealer_card_stack.update_score()
	while dealer_should_draw():
		deck.draw_card()
		dealer_card_stack.update_score()
	stand()
	
func dealer_should_draw() -> bool:
	return dealer_card_stack.get_score() < 19
