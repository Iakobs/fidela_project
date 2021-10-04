extends Node

onready var left_horn = $LeftHorn
onready var right_horn = $RightHorn

func get_horn_slots(horn: int) -> Array:
	match horn:
		Enums.HORNS.LEFT:
			return left_horn
		Enums.HORNS.RIGHT:
			return right_horn
		_:
			return []
