extends Spatial

class_name Fidela

onready var left_horn = $LeftHorn
onready var right_horn = $RightHorn

func get_horn_slots(horn: int) -> Array:
	match horn:
		Global.HORNS.LEFT:
			return left_horn
		Global.HORNS.RIGHT:
			return right_horn
		_:
			return []
