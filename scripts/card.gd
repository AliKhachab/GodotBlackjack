class_name Card
extends Node2D

signal hovered
signal hovered_off

var card_code: String
var position_in_hand
var belongs_to = null # temp name for dealer vs. player. edit this if need be
var rank
var facedown: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().connect_card_signals(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovered", self)
 
func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovered_off", self)

func set_card_texture(texture: Texture2D) -> void:
	$CardTexture.texture = texture

func flip() -> void:
	self.facedown = false
	self.get_node("AnimationPlayer").play("card_flip")
