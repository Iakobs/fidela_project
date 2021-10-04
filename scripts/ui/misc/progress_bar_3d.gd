extends Sprite3D

signal progress_completed

onready var viewport = $Viewport
onready var progress_bar = $Viewport/ProgressBar

func _ready():
	texture = viewport.get_texture()
	progress_bar.connect("progress_completed", self, "_on_progress_completed")

func start(duration: float):
	progress_bar.start(duration)

func _on_progress_completed():
	emit_signal("progress_completed")
