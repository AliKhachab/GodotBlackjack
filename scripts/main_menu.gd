extends Control

func _on_start_game_pressed() -> void:
	Global.game_is_running = true
	Global.player_turn = Global.belongs_to.PLAYER

	get_tree().change_scene_to_file("res://scenes/blackjack.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
