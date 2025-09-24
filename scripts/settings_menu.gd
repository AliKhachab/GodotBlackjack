class_name SettingsMenu
extends Control

signal back_button_pressed
# @onready var back_button: Button = $VBoxContainer/BackButton

func _on_back_button_pressed() -> void:
	emit_signal("back_button_pressed")
