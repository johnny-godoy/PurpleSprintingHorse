extends Node2D

onready var deteccion = $AreaDeteccion
onready var manager = ShortestPathManager
onready var arm = $connecter

onready var estaciones_adyacentes = [null]  # Agregar instancias de estaciones adyacentes aquí
onready var connected_to : Node2D = null
onready var connected_from : Node2D = null

var mouse_button_pressed = false
var is_starting_station = false

# Called when the node enters the scene tree for the first time.
func _ready():
	deteccion.input_pickable = true
	deteccion.connect("input_event", self, "_clicked")
	
	add_to_group("station")
	
	if manager.start_station == self:
		is_starting_station = true # Future references, so the player has to start on that node
	
func _physics_process(delta):
	if manager.trying_to_connect and manager.current_station == self:
		if mouse_button_pressed and not connected_to:
			var distance
			
			distance = position.distance_to(get_global_mouse_position())
			var angle = int(position.angle_to_point(get_global_mouse_position())*180/PI - 180) % 360
				
			arm.rotation_degrees = angle
			arm.scale.x = distance/ 64
		
		elif manager.accept_connection:
			connected_to = manager.current_ending_station
			manager.current_ending_station.connected_from = self
			manager.reset_variables()
		
		else:
			disconnect_paths()
			manager.reset_variables()
			
	if Input.is_action_just_released("click"):
		mouse_button_pressed = false
	
func _clicked(_viewport, event, _shape_idx):
	if InputMap.event_is_action(event, "click") && event.pressed:
		manager.trying_to_connect = true
		manager.current_station = self
		mouse_button_pressed = true
		print("Activated")
		
	if InputMap.event_is_action(event, "click") && not event.pressed:
		if manager.trying_to_connect:
			if not connected_from:
				if manager.current_station in estaciones_adyacentes and not is_instance_valid(connected_to):
					manager.accept_connection = true
					manager.current_ending_station = self

func disconnect_paths():
	if is_instance_valid(connected_to):
		connected_to.disconnect_paths()
		connected_to = null
	arm.scale.x = 0
	connected_from = null
	return
