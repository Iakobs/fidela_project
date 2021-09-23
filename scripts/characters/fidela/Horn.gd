extends Spatial

class_name Horn

var slots : Array

func _ready():
	for child in get_children():
		if child is RemoteTransform:
			slots.push_back(child)
