extends ProgressBar

signal progress_completed

var finish: float
var total_duration: float

onready var tween = $Tween

func _ready():
	tween.connect("tween_all_completed", self, "_on_tween_completed")

func start(duration: float, reverse: bool = false):
	total_duration = duration
	finish = 0 if reverse else 100
	
	var start = 100 if reverse else 0
	tween.interpolate_property(self, "value", start, finish, duration)
	tween.start()

func stop():
	tween.stop_all()

func change_value(value: float):
	var duration = total_duration
	if tween.is_active():
		tween.stop_all()
		duration = calculate_intermediate_duration(value)
	
	tween.interpolate_property(self, "value", value, finish, duration)
	tween.start()

func calculate_intermediate_duration(intermediate_value):
	return intermediate_value / 100 * total_duration

func _on_tween_completed():
	emit_signal("progress_completed")
