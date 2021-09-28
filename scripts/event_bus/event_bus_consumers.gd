extends Reference

class_name EventBusConsumers

var consumers = {}

func get_listeners_for_event(event: String) -> Array:
	return consumers.get(event, [])

func subscribe_listener_to_event(listener: EventBusListener, event: String):
	var listeners = get_listeners_for_event(event)
	listeners.append(listener)
	consumers[event] = listeners

func unsubscribe_listener_from_event(node: Node, event: String):
	var listeners = get_listeners_for_event(event)
	for listener in listeners:
		if listener.node == node:
			listeners.remove(listeners.find(listener))
			break
