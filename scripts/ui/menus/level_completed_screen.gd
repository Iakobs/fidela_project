extends Control

onready var start_button = $Button

func _ready():
	start_button.connect("pressed", self, "_on_start_button_pressed")

func _on_start_button_pressed():
	get_tree().change_scene("res://scenes/ui/menus/StartScreen.tscn")
