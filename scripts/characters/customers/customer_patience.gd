extends Spatial

signal patience_expired

const ADD_PATIENCE = {
	Enums.FRUITS.APPLE : 5.0,
	Enums.FRUITS.PEAR : 6.5,
	Enums.FRUITS.PINEAPPLE : 7.8,
	Enums.FRUITS.BANANA : 12.0,
}
const SUBSTRACT_PATIENCE = {
	Enums.FRUITS.APPLE : 5.0,
	Enums.FRUITS.PEAR : 6.5,
	Enums.FRUITS.PINEAPPLE : 7.8,
	Enums.FRUITS.BANANA : 12.0,
}

onready var progress_bar = $ProgressBar3D

func _ready():
	progress_bar.connect("value_changed", self, "_on_value_changed")

func start(patience_amount: float):
	progress_bar.start(patience_amount, true)

func stop():
	progress_bar.stop()

func add_patience(fruit: int):
	progress_bar.value += min(ADD_PATIENCE[fruit], 100)

func substract_patience(fruit: int):
	progress_bar.value -= max(SUBSTRACT_PATIENCE[fruit], 0)

func _on_value_changed(value: float):
	if in_range(value, 66.0, 100.0):
		progress_bar.modulate = Color.green
	elif in_range(value, 33.0, 66.0):
		progress_bar.modulate = Color.yellow
	elif in_range(value, 0.0, 33.0):
		progress_bar.modulate = Color.red
	else:
		emit_signal("patience_expired")

func in_range(value, minimum, maximum):
	return minimum < value and value <= maximum
