extends Node2D

onready var deteccion = $AreaDeteccion
onready var manager = ShortestPathManager
onready var arm = $connecter

onready var estaciones_adyacentes = []  # Agregar instancias de estaciones adyacentes aquí
onready var conexiones_a_estacion = {}
onready var connected_to : Node2D
onready var connected_from : Node2D 

onready var station_sprite = $station_img

var mouse_button_pressed = false
var is_starting_station = false setget _set_is_starting
var is_ending_station = false setget _set_is_ending

# Called when the node enters the scene tree for the first time.
func _ready():
	deteccion.input_pickable = true
	deteccion.connect("input_event", self, "_clicked")

	add_to_group("station")
	
	if manager.start_station == self:
		is_starting_station = true # Future references, so the player has to start on that node

# warning-ignore:unused_argument
func _physics_process(delta):
	if manager.trying_to_connect and manager.current_station == self:
		if mouse_button_pressed and not connected_to:
			var distance
			
			var posi = get_global_mouse_position()
			
			distance = position.distance_to(posi)
			var angle = int(position.angle_to_point(posi)*180/PI - 180) % 360
				
			arm.rotation_degrees = angle
			arm.scale.x = distance / (64 * scale.x) # Asumiendo que scale.x = scale.y
		
		elif manager.accept_connection:
			connected_to = manager.current_ending_station
			manager.current_ending_station.connected_from = self
			manager.number_of_connections = manager.number_of_connections + 1
			manager.reset_variables()
			arm.scale.x = 0
			conexiones_a_estacion[connected_to].visible = true
			
		else:
			disconnect_paths()
			manager.reset_variables()
			
	if Input.is_action_just_released("click"):
		mouse_button_pressed = false

func _clicked(_viewport, event, _shape_idx):
	
	if InputMap.event_is_action(event, "click") && event.pressed:
		print('clicked')
		
		# Para permitir conexión debe ser la primera estación o deben existir conexiones
		if not is_starting_station and manager.number_of_connections == 0:
			return
		
		# Solo se puede conectar si hay alguien conectado antes
		if is_instance_valid(connected_from) or is_starting_station:
			manager.trying_to_connect = true
			manager.current_station = self
			mouse_button_pressed = true
		
	if InputMap.event_is_action(event, "click") && not event.pressed:
		if manager.trying_to_connect:
			if not connected_from:
				if manager.current_station in estaciones_adyacentes and not is_instance_valid(connected_to):
					manager.accept_connection = true
					manager.current_ending_station = self

func disconnect_paths():
	if is_instance_valid(connected_to):
		manager.number_of_connections = manager.number_of_connections - 1
		connected_to.disconnect_paths()
		conexiones_a_estacion[connected_to].visible = false # devuelve una línea
		connected_to.connected_from = null
		connected_to = null
	arm.scale.x = 0
	return
	
func _set_is_starting(value):
	is_starting_station = value
	station_sprite.texture = load("res://assets/shortest_path/start_station.png")
	#station_sprite.texture = "res://assets/shortest_path/start_station.png"
	
func _set_is_ending(_value):
	station_sprite.texture = load("res://assets/shortest_path/end_station.png")
