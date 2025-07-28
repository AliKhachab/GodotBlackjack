extends Node 

const CARD_ORIGINAL_SCALE = 3
const CARD_MOVE_HIGHLIGHT_SCALE = 3.1
const STARTING_HAND_COUNT = 2 #because blackjack starts with 2 cards for the dealer and the player
const CARD_DRAW_SPEED = 0.4
const PLAYER_HAND_LOCATION = 890
const DEALER_HAND_LOCATION = 190
const CARD_WIDTH = 42 * CARD_ORIGINAL_SCALE
const CARD_HEIGHT = 60 * CARD_ORIGINAL_SCALE

var card_db_ref = preload("res://scripts/card_db.gd")
var game_is_running := false
var player_turn := belongs_to.PLAYER

enum belongs_to {PLAYER, DEALER}

var card_stack_ref = preload("res://scenes/card_stack.tscn")
var player_card_stack
var dealer_card_stack
var default_deck : Array[String] = []

func prepare_default_deck() -> void:
	card_db_ref.generate_standard_deck(default_deck)
