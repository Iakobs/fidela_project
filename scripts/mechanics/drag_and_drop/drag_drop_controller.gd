extends Node

class_name DragDropController

const DraggingArea = preload("res://scenes/drag_and_drop/DraggingArea.tscn")

export (float) var ray_length = 100

var camera: Camera
var draggable: Fruit
var dragging_area: Area

func _ready():
	camera = get_tree().get_root().get_camera()
	set_physics_process(false)

func drag_start(_draggable: Fruit):
	if not draggable:
		set_physics_process(true)
		
		draggable = _draggable
		
		setup_dragging_area()

func drag_stop():
	if draggable:
		set_physics_process(false)
		
		draggable.set_translation(draggable.original_position)
		draggable = null
		
		tear_down_dragging_area()

func _unhandled_input(event):
	var screen_touch_is_released = event is InputEventScreenTouch and \
		not event.is_pressed()
	if draggable and screen_touch_is_released:
		drag_stop()

func _physics_process(_delta):
	var mouse = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse)
	var to = from + camera.project_ray_normal(mouse) * ray_length
	
	var cast = camera.get_world().direct_space_state.intersect_ray(from, 
				to, [], dragging_area.get_collision_mask(), true, true)
	if not cast.empty():
		var cast_position = cast['position']
		draggable.set_translation(cast_position)

func setup_dragging_area():
	var z_position = draggable.transform.origin.z
	dragging_area = DraggingArea.instance()
	dragging_area.transform.origin.z = z_position
	camera.get_parent().add_child(dragging_area)

func tear_down_dragging_area():
	camera.get_parent().remove_child(dragging_area)
	dragging_area = null
