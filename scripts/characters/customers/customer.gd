extends Area

class_name Customer

var points: int

onready var viewport = $Viewport
onready var viewport_renderer = $ViewportRenderer
onready var texture = $Viewport/BalloonContent/Texture
onready var label = $Viewport/BalloonContent/VBoxContainer/Label

var AppleIcon = preload("res://assets/ui/apple_icon.png")
var PearIcon = preload("res://assets/ui/pear_icon.png")
var PineappleIcon = preload("res://assets/ui/pineapple_icon.png")
var BananaIcon = preload("res://assets/ui/banana_icon.png")

func _ready():
	viewport_renderer.texture = viewport.get_texture()
	texture.texture = null
	label.text = ""

func feed(fruit: int):
	pass

func draw_balloon(wanted_fruit: WantedFruit):
	var fruit = wanted_fruit.fruit
	match(fruit):
		FruitFactory.FRUITS.APPLE:
			texture.texture = AppleIcon
		FruitFactory.FRUITS.PEAR:
			texture.texture = PearIcon
		FruitFactory.FRUITS.PINEAPPLE:
			texture.texture = PineappleIcon
		FruitFactory.FRUITS.BANANA:
			texture.texture = BananaIcon
	
	label.text = "X %s" % wanted_fruit.amount
		
