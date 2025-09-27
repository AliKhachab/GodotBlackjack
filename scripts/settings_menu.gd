class_name SettingsMenu
extends Control

signal back_button_pressed
# @onready var back_button: Button = $VBoxContainer/BackButton
@onready var master_audio_slider: AudioHSlider = $PanelContainer/VBoxContainer/MasterAudioSlider
@onready var music_audio_slider: AudioHSlider = $PanelContainer/VBoxContainer/MusicAudioSlider
@onready var sfx_audio_slider: AudioHSlider = $PanelContainer/VBoxContainer/SFXAudioSlider

func _on_back_button_pressed() -> void:
	emit_signal("back_button_pressed")

func set_slider_defaults() -> void:
	_set_slider_starting_value(master_audio_slider, 100)
	_set_slider_starting_value(music_audio_slider, 75)
	_set_slider_starting_value(sfx_audio_slider, 75)

func _set_slider_starting_value(slider: HSlider, value: int) -> void:
	slider.value = value
