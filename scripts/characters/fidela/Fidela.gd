extends Spatial

class_name Fidela

onready var left_horn = $LeftHorn
onready var right_horn = $RightHorn

func get_slots(horn: int) -> Array:
	match horn:
		Global.HORNS.LEFT:
			return left_horn.slots
		Global.HORNS.RIGHT:
			return right_horn.slots
		_:
			return []
