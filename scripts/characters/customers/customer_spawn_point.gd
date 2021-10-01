extends Spatial

var current_customer: Customer

onready var path = $CustomerPath

func _ready():
	pass

func subscriptions() -> Array:
	return [
		EventBusSubscription.new(
			EventNamespaces.CustomerEvents.CUSTOMER_LEAVING_EVENT,
			"_on_customer_leaving"
		)
	]

func spawn_customer(customer: Customer):
	add_customer(customer)

func add_customer(customer: Customer):
	current_customer = customer
	path.add_customer(current_customer)

func _on_customer_leaving(_payload: Dictionary):
	path.remove_customer()
	current_customer = null
