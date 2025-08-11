extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(_delta) -> void:
	testEsc() # Note to self -- in this case we need _process() unlike other classes i.e. blackjack.gd
	# because in those, the classes have built in listeners or things that run on top of listeners.
	# but here, the game needs to know if we pressed esc on any frame

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

func animate_pause(pausing: bool) -> void:
	if pausing:
		self.visible = true 
	else:
		self.visible = false
