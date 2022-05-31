extends Node2D

onready var manager = ShortestPathManager

onready var HUD = $HUD_OVERLAY
onready var map = $rome_subway
onready var stations = $rome_subway/map
onready var won_menu = $wonMenu

export var minimum_connections = 5
export var number_of_level = 2

export var stations_scale := 0.5 setget , _get_scale

const station = preload("res://scenes/shortest_path/bases/estacionGenerica.tscn")

var _childs = []

# Devuelve un vector con la escala, para setear la escala de cada estación
func _get_scale():
	return Vector2(stations_scale, stations_scale)

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
	
	var _optimal_path_map_ = ['sp_blue_8', 'sp_blue_7', 'sp_black_1', 'sp_red_7', 'sp_red_8', 'sp_red_9']
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
		
		if pos.get_name() == 'sp_blue_8':
			temp_station.is_starting_station = true
		
		if pos.get_name() == 'sp_red_9':
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
	
	if count < 90:
		count += 1
	
	if manager.player_won and not activated:
		activated = true
		won_menu.pause_menu()
	elif not manager.player_won and activated:
		activated = false
		

func next_level():
	get_tree().change_scene("res://scenes/shortest_path/niveles/nivel_3.tscn")
