extends Reference

class_name EventBusListener

var node: Node
var handler_method: String

func _init(_node: Node, _handler_method:String):
	node = _node
	handler_method = _handler_method
