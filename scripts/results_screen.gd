class_name ResultsScreen
extends Control

signal play_again

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_play_again_pressed() -> void:
	emit_signal("play_again")

func _on_quit_pressed() -> void:
	get_tree().quit()

func update_label(win: int) -> void:
	if win == Global.belongs_to.PLAYER:
		$WinLabel.text = "You win!"
		return
	if win == 2:
		$WinLabel.text = "It's a tie!"
		return
	$WinLabel.text = "You lose..."
