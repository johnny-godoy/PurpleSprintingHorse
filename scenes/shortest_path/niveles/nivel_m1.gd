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

export var minimum_connections = 11 # 3S-11, 2S-12, 1S-13, 0S-14+
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
	
	create_and_conf_stations()

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
	_incomplete_stations.values()[0].is_starting_station = true
	_incomplete_stations.values()[-1].is_ending_station = true
	
	manager.start_station = _incomplete_stations.values()[0]
	manager.end_station = _incomplete_stations.values()[-1]
	manager.optimal_path = ['none']
	
	# Esto busca el camino más corto
	#min_path(_incomplete_stations.values()[0], _incomplete_stations.values()[-1], [_incomplete_stations.values()[0]])
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
		
		if par.keys()[0] == 12:
			print(12)
		
		if par.keys()[0] == 13:
			print(13)
				
		if par.keys()[0] == 11:
			if first:
				for sab in par.values()[0]:
					sab.is_starting_station = true
				first = false
			else:
				for sab in par.values()[0]:
					sab.is_ending_station = true
	
	var pses = []
	for sss in curr_path:
		pses.append(sss.position)
	
	print(curr_min)
	print(pses)
