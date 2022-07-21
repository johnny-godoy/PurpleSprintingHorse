extends Node2D

onready var manager = ShortestPathManager

onready var places = get_tree().get_nodes_in_group('stations')
onready var HUD = $HUD_OVERLAY
onready var map = $cdmx_subway
onready var stations = $cdmx_subway/map
onready var won_menu = $wonMenu
onready var stations_to_be_used = []
onready var camera = $SP_Camera

export var minimum_connections = 7
export var number_of_level = 5

export var stations_scale := 0.5 setget , _get_scale

const station = preload("res://scenes/shortest_path/Bases/estacionGenerica.tscn")

var _childs = []

# Devuelve un vector con la escala, para setear la escala de cada estación
func _get_scale():
	return Vector2(stations_scale, stations_scale)

# Siguiente nivel
func next_level():
	get_tree().change_scene("res://scenes/shortest_path/niveles/nivel_4.tscn")

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
	
	for st in places:
		stations_to_be_used.append(st.get_name())
	
	var _optimal_path_map_ = ['grey_6','grey_7','lightblue_1','lightblue_2','brown_4','blue_10','brown_3','lightgreen_6']
	var _optimal_path = range(len(_optimal_path_map_))
	
	# Se crean las estaciones
	for pos in stations.get_children():
		if not pos.is_in_group('stations'):
			continue
			
		var temp_station = station.instance()
		temp_station.position = pos.position
		temp_station.scale = self.stations_scale
		map.add_child(temp_station, true)
		_childs.append(temp_station)
		
		if pos.get_name() == _optimal_path_map_[0]:
			temp_station.is_starting_station = true
		
		if pos.get_name() == _optimal_path_map_[-1]:
			manager.end_station = temp_station
			temp_station.is_ending_station = true
	
		if pos.name in _optimal_path_map_:
			_optimal_path[_optimal_path_map_.find(pos.name)] = temp_station
	var num = 0
	for station in _childs:
		
		if not station:
			num = num + 1
			continue
		
		for neighbour in map.next_to[num]:
			station.estaciones_adyacentes.append(_childs[neighbour])
			station.conexiones_a_estacion[_childs[neighbour]] = map.connecting_line[[num, neighbour]]
		num = num + 1
	
	manager.optimal_path = _optimal_path
	
var count = 0
var count2 = 0
var activated = false
func _physics_process(delta):
	if manager.player_won and not activated:
		activated = true
		var stars = _calculate_stars()
		manager.save_score(number_of_level, stars)
		camera.zoom = Vector2(1, 1)
		print("nivel: ", stars)
		won_menu.pause_menu(stars)
		
	elif not manager.player_won and activated:
		activated = false
		
func _calculate_stars():
	var noc = manager.number_of_connections
	
	if noc == minimum_connections:
		return 3
	elif noc == minimum_connections + 1:
		return 2
	elif noc == minimum_connections + 2:
		return 1
	else:
		return 0
