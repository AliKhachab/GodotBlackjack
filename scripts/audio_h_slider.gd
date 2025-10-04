class_name AudioHSlider
extends HSlider

@export var bus_name: String

var bus_index: int

# Define the dB range for the slider (min_db to max_db)
const MIN_DB = -60.0
const MAX_DB = 5.0

func _ready() -> void:
	self.bus_index = AudioServer.get_bus_index(bus_name)  
	value_changed.connect(self._on_value_changed)

	self.min_value = 0.0
	self.max_value = 100.0

	var current_db = AudioServer.get_bus_volume_db(bus_index)
	value = _db_to_slider_value(current_db)
	
func _on_value_changed(slider_value: float) -> void:
	var db_value = _slider_value_to_db(slider_value) # convert slider value to decibels (no need to worry abt updating the slider bc user changed it + node is built to handle that)
	AudioServer.set_bus_volume_db(bus_index, db_value) # audio bus now uses that decibel value


# LERP between min_db and max_db and get db value
func _slider_value_to_db(slider_value: float) -> float:
	if slider_value <= 0.0:
		return MIN_DB
	# a + (t * (b - a)), where A is min value, B is max value, t is parameter
	return MIN_DB + (slider_value / 100.0) * (MAX_DB - MIN_DB)


# inverse lerp * 100 to get slider value
func _db_to_slider_value(db_value: float) -> float:
	if db_value <= MIN_DB:
		return 0.0
	# ((v - a) / (b - a)) = t, multiply by 100 to get percentage and then map that to slider
	return ((db_value - MIN_DB) / (MAX_DB - MIN_DB)) * 100.0
