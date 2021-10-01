extends Area

class_name Customer

var wanted_fruit: WantedFruit setget set_wanted_fruit
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

func set_wanted_fruit(_wanted_fruit: WantedFruit):
	wanted_fruit = _wanted_fruit
	draw_balloon()

func feed(fruit: int):
	if wanted_fruit.fruit == fruit:
		self.wanted_fruit.amount -= 1
		if wanted_fruit.amount == 0:
			leave()

func draw_balloon():
	var fruit = wanted_fruit.fruit
	match fruit:
		Global.FRUITS.APPLE:
			texture.texture = AppleIcon
		Global.FRUITS.PEAR:
			texture.texture = PearIcon
		Global.FRUITS.PINEAPPLE:
			texture.texture = PineappleIcon
		Global.FRUITS.BANANA:
			texture.texture = BananaIcon
	
	label.text = "X %s" % wanted_fruit.amount

func leave():
	EventBus.publish(EventNamespaces.CustomerEvents.CUSTOMER_LEFT_EVENT)
	queue_free()
