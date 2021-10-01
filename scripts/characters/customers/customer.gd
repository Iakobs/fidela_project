extends Area

signal balloon_opened

class_name Customer

var wanted_fruit: WantedFruit setget set_wanted_fruit
var points: int

onready var viewport = $Viewport
onready var viewport_renderer = $ViewportRenderer
onready var texture = $Viewport/BalloonContent/Texture
onready var label = $Viewport/BalloonContent/VBoxContainer/Label

onready var balloon_animation = $BalloonAnimation
onready var balloon = $Balloon

var is_balloon_opened = false

func set_wanted_fruit(_wanted_fruit: WantedFruit):
	wanted_fruit = _wanted_fruit

func start():
	open_balloon()
	yield(self, "balloon_opened")
	viewport_renderer.texture = viewport.get_texture()
	update_balloon()
	
func open_balloon():
	balloon_animation.play("open_balloon")
	yield(balloon_animation, "animation_finished")
	emit_signal("balloon_opened")

func feed(fruit: int):
	if wanted_fruit.fruit == fruit:
		wanted_fruit.amount -= 1
		update_balloon()
		if wanted_fruit.amount == 0:
			leave()

func update_balloon():
	var fruit = wanted_fruit.fruit
	match fruit:
		Global.FRUITS.APPLE:
			texture.texture = Global.AppleIcon
		Global.FRUITS.PEAR:
			texture.texture = Global.PearIcon
		Global.FRUITS.PINEAPPLE:
			texture.texture = Global.PineappleIcon
		Global.FRUITS.BANANA:
			texture.texture = Global.BananaIcon
	
	label.text = "X %s" % wanted_fruit.amount

func leave():
	viewport_renderer.texture = null
	balloon_animation.play_backwards("open_balloon")
	yield(balloon_animation, "animation_finished")
	EventBus.publish(EventNamespaces.CustomerEvents.CUSTOMER_LEAVING_EVENT)

func switch_balloon_visibility():
	balloon.visible = not balloon.visible
