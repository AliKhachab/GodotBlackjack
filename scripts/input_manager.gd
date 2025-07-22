extends Node2D

#signal lmb_clicked
#signal lmb_released
#
#const COLLISION_MASK_CARD = 1
#const COLLISION_MASK_DECK = 4 
#var card_manager_reference
#var deck_reference

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass

#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#if event.pressed:
			#raycast_at_cursor()
		#else:
			#pass 
			#
#func raycast_at_cursor():
	#var space_state = get_world_2d().direct_space_state
	#var parameters = PhysicsPointQueryParameters2D.new()
	#parameters.position = get_global_mouse_position()
	#parameters.collide_with_areas = true
	#var result = space_state.intersect_point(parameters)
	#if len(result) > 0: # because intersect_point returns a list of items @ said point clicked
		#var result_collision_mask = result[0].collider.collision_mask
		#if result_collision_mask == COLLISION_MASK_CARD:
			#var card = result[0].collider.get_parent()
			#if card: # make sure card is not null for whatever reason, 
				#card_manager_reference.start_drag(card)
		#elif result_collision_mask == COLLISION_MASK_DECK:
			#deck_reference.draw_card()
