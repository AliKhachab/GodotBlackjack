extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func resume() -> void:
	get_tree().paused = false
	
func pause() -> void:
	get_tree().paused = true

func testEsc() -> void:
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	else:
		resume()


func _on_resume_pressed() -> void:
	resume()

func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_quit_game_pressed() -> void:
	 get_tree().quit()
