class_name CardManager
extends Node2D

var screen_size
var card_being_dragged
const COLLISION_MASK_CARD = 1
const COLLISION_MASK_CARD_SLOT = 2
const DEFAULT_CARD_MOVE_SPEED = 0.3
var global_ref
var is_hovering_on_card: bool 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	# $"../InputManager".connect("lmb_released", on_left_click_released)

func connect_card_signals(card):
	card.connect("hovered", on_hovered_over_card)
	card.connect("hovered_off", on_hovered_off_card)

func on_hovered_over_card(card):
	if !is_hovering_on_card:
		is_hovering_on_card = true
		highlight_card(card, true)

func on_hovered_off_card(card):
	if !card_being_dragged:
		highlight_card(card, false)
		# check if we hovered onto another card
		var new_card_hovered = raycast_check_for_card()
		if new_card_hovered:
			highlight_card(new_card_hovered, true)
		else:
			is_hovering_on_card = false 
			
func raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_CARD
	var result = space_state.intersect_point(parameters)
	if len(result) > 0:
		return get_card_with_highest_z_index(result)
		# return result[0].collider.get_parent() 
		# intersect point params prints an array with an object,
		# get the object @ index 0 and get the collider item. 
		# then access that item's parent to get the card itself
	else:
		return null

func get_card_with_highest_z_index(cards):
	var highest_z_card = cards[0].collider.get_parent()
	var highest_z_index = highest_z_card.z_index
	for i in range(1, cards.size()): # skip 0 bc that one is the first one in the list
		var curr_card = cards[i].collider.get_parent()
		if curr_card.z_index > highest_z_index:
			highest_z_card = curr_card
			highest_z_index = curr_card.z_index
	return highest_z_card

func highlight_card(card, hovered):
	if hovered:
		print("Hovering")
		card.scale = Vector2(Global.CARD_MOVE_HIGHLIGHT_SCALE, Global.CARD_MOVE_HIGHLIGHT_SCALE)
		card.z_index = 2
	else:
		card.scale = Vector2(Global.CARD_ORIGINAL_SCALE, Global.CARD_ORIGINAL_SCALE)
		card.z_index = 1
