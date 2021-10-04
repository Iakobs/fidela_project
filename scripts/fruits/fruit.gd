extends Area

class_name Fruit

export(Enums.FRUITS) var fruit_enum: int

var original_position: Vector3 setget set_original_position
var original_horn setget set_original_horn

onready var shape = $CollisionShape

func set_original_position(position: Vector3):
	original_position = position

func set_original_horn(horn):
	original_horn = horn
