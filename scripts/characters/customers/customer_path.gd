extends Path

export(float, 0.0, 10.0, 0.5) var follow_speed = 7.0

var customer: Customer
var customer_in = true

onready var follow = $PathFollow

func _ready():
	set_process(false)

func add_customer(new_customer: Customer):
	customer = new_customer
	follow.add_child(customer)
	
	follow.unit_offset = 0.0
	set_process(true)

func remove_customer():
	follow.unit_offset = 1.0
	set_process(true)

func _process(delta):
	if customer:
		if follow.unit_offset == 1.0 and customer_in:
			customer_in = false
			customer.start()
			set_process(false)
		if follow.unit_offset == 0 and not customer_in:
			customer_in = true
			follow.remove_child(customer)
			customer.queue_free()
			customer = null
			set_process(false)
			EventBus.publish(EventNamespaces.CustomerEvents.CUSTOMER_LEFT_EVENT)
			
		var speed = follow_speed if customer_in else follow_speed * -1
		follow.offset = follow.offset + speed * delta
