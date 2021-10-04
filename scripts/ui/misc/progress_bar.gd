extends ProgressBar

signal progress_completed

onready var tween = $Tween

func start(duration: float):
	tween.interpolate_property(self, "value", 0, 100, duration)
	tween.start()
	yield(tween, "tween_completed")
	emit_signal("progress_completed")
