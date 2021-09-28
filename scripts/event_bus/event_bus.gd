extends Node

"""
@author iakobs

Based on nhydock's EventBus 
(https://medium.com/@progdozer/a-dventure-dev-log-utilizing-a-global-event-bus-in-godot-acf34f5d11d1)

Global Event Bus allows for registration and fan-out signal like
message passing between arbitrary objects. Add this as a singleton
to your project.
"""

const CONSUMER_GROUP: String = "consumer"

var consumers = EventBusConsumers.new()

func _enter_tree():
	get_tree().connect("node_added", self, "_add_listener")
	get_tree().connect("node_removed", self, "_remove_listener")
	
func _add_listener(node: Node):
	if node.is_in_group(CONSUMER_GROUP):
		for subscription in node._subscriptions():
			if subscription is EventBusSubscription:
				var event = subscription.event
				var method = subscription.handler_method
				var listener = EventBusListener.new(node, method)
				consumers.subscribe_listener_to_event(listener, event)
		
func _remove_listener(node: Node):
	if node.is_in_group(CONSUMER_GROUP):
		for subscription in node._subscriptions():
			if subscription is EventBusSubscription:
				var event = subscription.event
				consumers.unsubscribe_listener_from_event(node, event)

func publish(event: String, payload = {}):
	for listener in consumers.get_listeners_for_event(event):
		if listener is EventBusListener:
			var node = listener.node
			var method = listener.handler_method
			if node.has_method(method):
				node.call_deferred(method, payload)
