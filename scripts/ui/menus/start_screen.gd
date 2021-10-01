extends Control

onready var start_button = $Start
onready var exit_button = $Exit

func _ready():
	start_button.connect("pressed", self, "_on_start_button_pressed")
	exit_button.connect("pressed", self, "_on_exit_button_pressed")

func _on_start_button_pressed():
	SceneChanger.load_scene("res://scenes/test/TestScene.tscn", self)

func _on_exit_button_pressed():
	get_tree().quit()
