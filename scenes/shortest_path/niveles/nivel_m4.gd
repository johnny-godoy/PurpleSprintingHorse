extends Node2D

# Estacion moscu 
const station = preload("res://scenes/shortest_path/bases/estacionGenerica.tscn")

var _incomplete_stations = {}

onready var map_mo = $moscow_subway
onready var map_mo_map = $moscow_subway/Control/map

onready var manager = ShortestPathManager

onready var HUD = $HUD_OVERLAY
onready var won_menu = $wonMenu
onready var camera = $SP_Camera

export var minimum_connections = 8
export var number_of_level = 7

export var stations_scale := 0.5 setget , _get_scale

# Called when the node enters the scene tree for the first time.
func _ready():
	# Le damos la información al HUD
	HUD.level_number = number_of_level
	HUD.min_num_conns = minimum_connections
	
	# Configuramos el manager
	manager.reset_variables()
	manager.HUD = HUD
	manager.number_of_connections = 0
	manager.player_won = false
	manager.optimal_path_len = minimum_connections
	
	create_and_conf_stations() # Replace with function body.

var activated = false
func _physics_process(delta):
	
	if manager.player_won and not activated:
		activated = true
		camera.zoom = Vector2(1, 1)
		won_menu.pause_menu()
		
	elif not manager.player_won and activated:
		activated = false

func create_and_conf_stations():
	for station_node in get_tree().get_nodes_in_group('estacion'):
		var temp_station = station.instance()
		temp_station.position = station_node.position
		temp_station.scale = self.stations_scale
		temp_station.top_offset = map_mo_map.margin_top
		temp_station.left_offset = map_mo_map.margin_left
		# temp_station.z_index = -1
		map_mo_map.add_child(temp_station, true)
		_incomplete_stations[temp_station.position] = temp_station

	# Hace uso de la posición de las estacions como identificador único
	for _temp_station_pos in _incomplete_stations.keys():
		var temp_station = _incomplete_stations[_temp_station_pos]
		for _neighbour_pos in map_mo.estaciones_y_vecinos[_temp_station_pos]:
			var _temp_neigh = _incomplete_stations[_neighbour_pos]
			temp_station.estaciones_adyacentes.append(_temp_neigh)
			temp_station.conexiones_a_estacion[_temp_neigh] = map_mo.get_conn_line(_temp_station_pos, _neighbour_pos)
	
	# Set the start and end stations
	_incomplete_stations[Vector2(641, 729)].is_starting_station = true
	_incomplete_stations[Vector2(385, 230)].is_ending_station = true
	
	manager.start_station = _incomplete_stations[Vector2(641, 729)]
	manager.end_station = _incomplete_stations[Vector2(385, 230)]
	manager.optimal_path = ['none']
	
	#min_path(manager.start_station, manager.end_station, [manager.start_station])
	#min_min()
	
func _get_scale():
	return Vector2(stations_scale, stations_scale)


var paths = []
func min_path(st, end, curr):
	
	for ss in st.estaciones_adyacentes:
		if ss in curr:
			continue
		
		if ss == end:
			paths.append({len(curr) : curr})
			return
		
		var a = curr.duplicate()
		a.append(ss)
		min_path(ss, end, a)
		
	return

func min_min():
	
	var curr_min = 100
	var curr_path 
	
	var path_2
	
	var first = true
	
	for par in paths:
		if par.keys()[0] < curr_min:
			curr_min = par.keys()[0]
			curr_path = par.values()[0]
		
		if par.keys()[0] == 7:
			print(7)
	
	var pses = []
	for sss in curr_path:
		pses.append(sss.position)
		sss.is_starting_station = true
		
	print(curr_min)
	print(pses)
