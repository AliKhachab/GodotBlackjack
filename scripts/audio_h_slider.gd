class_name AudioHSlider
extends HSlider

@export var bus_name: String

var bus_index: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.bus_index = AudioServer.get_bus_index(bus_name)  
	value_changed.connect(self._on_value_changed)
	
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	# this gets the linear value from the logarithmic decibel audio value, useful for
	# storing it globally so audio values transfer over btwn scenes and whatnot.
	
func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	# linear_to_db is a function that converts from linear energy to decibels, which helps us
	# turn linear input (volume slider) into logarithmic output (volume)
