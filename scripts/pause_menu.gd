extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(_delta) -> void:
	testEsc()

func resume() -> void:
	get_tree().paused = false
	animate_pause(false)
	
func pause() -> void:
	get_tree().paused = true
	animate_pause(true)

func testEsc() -> void:
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
		print("pause")
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()
		print("unpause")


func _on_resume_pressed() -> void:
	resume()

func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_quit_game_pressed() -> void:
	get_tree().quit()

func animate_pause(pause: bool) -> void:
	if pause:
		self.visible = true 
	else:
		self.visible = false
