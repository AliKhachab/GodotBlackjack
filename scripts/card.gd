class_name Card
extends Node2D

signal hovered
signal hovered_off
signal flipped_up


var card_code: String
var position_in_hand
var belongs_to = null # temp name for dealer vs. player. edit this if need be
var rank
var facedown: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().connect_card_signals(self)
	var a := $AnimationPlayer
	if a:
		a.connect("animation_finished", Callable(self, "_on_animation_finished"))


func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovered", self)
 
func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovered_off", self)

func set_card_texture(texture: Texture2D) -> void:
	$CardTexture.texture = texture

func flip() -> void:
	self.facedown = false
	self.get_node("AnimationPlayer").play("card_flip")
	
func _on_animation_finished(a: StringName) -> void:
	if a == "card_flip":
		emit_signal("flipped_up")
