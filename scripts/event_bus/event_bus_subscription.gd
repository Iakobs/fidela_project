extends Reference

class_name EventBusSubscription
	
var event: String
var handler_method: String

func _init(_event:String, _handler_method: String):
	event = _event
	handler_method = _handler_method
