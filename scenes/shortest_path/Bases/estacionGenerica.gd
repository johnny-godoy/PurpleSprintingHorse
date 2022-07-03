extends Node2D

onready var deteccion = $AreaDeteccion
onready var manager = ShortestPathManager
onready var arm = $connecter

onready var estaciones_adyacentes = []  # Agregar instancias de estaciones adyacentes aquí
onready var conexiones_a_estacion = {}
onready var connected_to : Node2D
onready var connected_from : Node2D 

onready var station_label = $RichTextLabel
onready var station_sprite = $station_img

var mouse_button_pressed = false
var is_starting_station = false setget _set_is_starting
var is_ending_station = false setget _set_is_ending

signal frame_passed

# TODO: end_station no debería poder tirar nuevas líneas
# Zoom cuando termina un nivel

# Called when the node enters the scene tree for the first time.
func _ready():
	deteccion.input_pickable = true
	deteccion.connect("input_event", self, "_clicked")

	add_to_group("station")
	
	if manager.start_station == self:
		is_starting_station = true # Future references, so the player has to start on that node

# warning-ignore:unused_argument
func _physics_process(delta):
	emit_signal('frame_passed')
	
	if manager.trying_to_connect and manager.current_station == self:
		if mouse_button_pressed and not connected_to:
			var distance
			
			var posi = get_global_mouse_position()
			
			distance = position.distance_to(posi)
			var angle = int(position.angle_to_point(posi)*180/PI - 180) % 360
				
			arm.rotation_degrees = angle
			arm.scale.x = distance / (64 * scale.x) # Asumiendo que scale.x = scale.y
		
		elif manager.accept_connection:
			manager.station_touched = true
			connected_to = manager.current_ending_station
			manager.current_ending_station.connected_from = self
			manager.number_of_connections = manager.number_of_connections + 1
			manager.reset_variables()
			arm.scale.x = 0
			conexiones_a_estacion[connected_to].visible = true
			
		else:
			manager.station_touched = true
			disconnect_paths()
			manager.reset_variables()
			
	if Input.is_action_just_released("click"):
		mouse_button_pressed = false

func _clicked(_viewport, event, _shape_idx):
	
	if InputMap.event_is_action(event, "click") && event.pressed:
		manager.station_touched = true
		
		# Para permitir conexión debe ser la primera estación o deben existir conexiones
		if not is_starting_station and manager.number_of_connections == 0:
			return
		
		# Solo se puede conectar si hay alguien conectado antes
		if is_instance_valid(connected_from) or is_starting_station:
			manager.trying_to_connect = true
			manager.current_station = self
			mouse_button_pressed = true
		
	if InputMap.event_is_action(event, "click") && not event.pressed:
		manager.station_touched = false
		if manager.trying_to_connect:
			if not connected_from:
				if manager.current_station in estaciones_adyacentes and not is_instance_valid(connected_to):
					manager.accept_connection = true
					manager.current_ending_station = self

func _input(event):
	if event is InputEventScreenTouch:
		manager.station_touched = false

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
	station_label.text = 'INICIO'
	station_sprite.texture = load("res://assets/shortest_path/star_white.png")
	station_sprite.scale = Vector2(0.025, 0.025)
	blink_station()
		
func _set_is_ending(value):
	is_ending_station = value
	station_label.text = 'FINAL'
	station_sprite.texture = load("res://assets/shortest_path/star_white.png")
	station_sprite.scale = Vector2(0.025, 0.025)
	blink_station()

func blink_station(frames=240, frames_per_blink=40):
	var to_set_a_sprite_once = false
	var _end_frames_passed = 0
	
	var asset = "res://assets/shortest_path/"
	
	if is_starting_station:
		asset += "star_yellow.png"
	elif is_ending_station:
		asset += "star_pink.png"
	else:
		return
	
	while _end_frames_passed < frames:
		if _end_frames_passed % frames_per_blink == 0:
			
			if to_set_a_sprite_once:
				station_sprite.texture = load(asset)
			else:
				station_sprite.texture = load("res://assets/shortest_path/star_white.png")
				
			to_set_a_sprite_once = !to_set_a_sprite_once
		_end_frames_passed += 1
		yield(self, 'frame_passed')
	station_sprite.texture = load("res://assets/shortest_path/star_white.png")
