extends Control

export(Global.HORNS) var horn: int

var buttons: Array

func _ready():
	buttons = [
		$AppleButton,
		$PearButton,
		$PineappleButton,
		$BananaButton
	]
	for button in buttons:
		button.set_horn(horn)
