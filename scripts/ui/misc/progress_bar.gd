extends ProgressBar

signal progress_completed

onready var tween = $Tween

func _ready():
	tween.connect("tween_all_completed", self, "_on_tween_completed")

func start(duration: float):
	tween.interpolate_property(self, "value", 0, 100, duration)
	tween.start()

func _on_tween_completed():
	emit_signal("progress_completed")
