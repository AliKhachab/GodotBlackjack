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
	player_card_stack.update_score()
	dealer_card_stack.update_score()
	#game_loop()

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
	deck.draw_card() # Note to self, make a flag to make this hidden later

	# Back to player turn for actual gameplay
	Global.player_turn = Global.belongs_to.PLAYER

func return_cards_to_deck(stack: CardStack) -> void:
	stack.card_stack.clear()
	stack.update_card_positions()

func add_card_to_hand(card: Card) -> void:
	var hand = player_card_stack if (Global.player_turn == Global.belongs_to.PLAYER) else dealer_card_stack
	hand.add_card(card)
	# Fix this logic, cards are not going in player hands

func game_loop() -> void:
	Global.game_is_running = true
	while Global.game_is_running:
		pass
		#while Global.player_turn == Global.belongs_to.PLAYER:
			#if "hit":
				#deck.draw_card()
				#player_card_stack.update_score()
				#if player_card_stack.lost_game():
					#Global.player_turn = Global.belongs_to.DEALER
			#else:
				#Global.player_turn = Global.belongs_to.DEALER
		#while Global.player_turn == Global.belongs_to.DEALER:
			#pass


func on_hit_pressed() -> void:
	deck.draw_card()
	player_card_stack.update_score()
	if player_card_stack.lost_game(): # if score > 21 force the player to stand
		stand()
	
func on_stand_pressed() -> void:
	stand()

func stand() -> void:
	if Global.player_turn == Global.belongs_to.PLAYER:
		Global.player_turn = Global.belongs_to.DEALER
		toggle_buttons_on(false)
	else:
		pass # end game logic
		
func calculate_winner() -> void:
	pass

func toggle_buttons_on(boolean: bool) -> void:
	# true = turn them on, false = turn them off. so toggle_buttons_on(false) will turn off the button
	# aka disable the button (disabled = true) and make them invisible (visible = false)
	hit_button.disabled = !boolean
	stand_button.disabled = !boolean
	hit_button.visible = boolean
	stand_button.visible = boolean
	
