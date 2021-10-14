extends Sprite3D

signal progress_completed
signal value_changed

onready var viewport = $Viewport
onready var progress_bar = $Viewport/ProgressBar

var value: float setget set_value, get_value

func _ready():
	texture = viewport.get_texture()
	progress_bar.connect("progress_completed", self, "_on_progress_completed")
	progress_bar.connect("value_changed", self, "_on_value_changed")

func start(duration: float, reverse: bool = false):
	progress_bar.start(duration, reverse)

func stop():
	pass

func set_value(value: float):
	value = clamp(value, 0.0, 100.0)
	progress_bar.change_value(value)
	emit_signal("value_changed", value)

func get_value() -> float:
	return progress_bar.value

func _on_progress_completed():
	emit_signal("progress_completed")

func _on_value_changed(value: float):
	emit_signal("value_changed", value)
