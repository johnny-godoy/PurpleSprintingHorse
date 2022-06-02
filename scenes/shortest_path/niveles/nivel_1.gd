extends Node2D

onready var manager = ShortestPathManager

onready var HUD = $HUD_OVERLAY
onready var map = $rome_subway
onready var stations = $rome_subway/map
onready var won_menu = $wonMenu
onready var camera = $SP_Camera

export var minimum_connections = 5
export var number_of_level = 1

export var stations_scale := 0.5 setget , _get_scale

const station = preload("res://scenes/shortest_path/Bases/estacionGenerica.tscn")

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
	
	var stations_to_be_used = ['sp_red_5', 'sp_red_6', 'sp_red_4', 'sp_red_3', 'sp_red_2', 'sp_red_1']
	var _optimal_path = []
	
	# Se crean las estaciones
	for pos in stations.get_children():
		if not pos.is_in_group('stations'):
			continue
		elif not pos.get_name() in stations_to_be_used:
			_childs.append(null)
			continue
			
		var temp_station = station.instance()
		temp_station.position = pos.position
		temp_station.scale = self.stations_scale
		map.add_child(temp_station, true)
		_childs.append(temp_station)
		
		if pos.get_name() == 'sp_red_1':
			temp_station.is_starting_station = true
		
		if pos.get_name() == 'sp_red_6':
			manager.end_station = temp_station
			temp_station.is_ending_station = true
		
		_optimal_path.append(temp_station)
	
	manager.optimal_path = _optimal_path
		
	var num = 0
	for station in _childs:
		
		if not station:
			num = num + 1
			continue
		
		for neighbour in map.next_to[num]:
			station.estaciones_adyacentes.append(_childs[neighbour])
			station.conexiones_a_estacion[_childs[neighbour]] = map.connecting_line[[num, neighbour]]
		num = num + 1
	
var count = 0
var count2 = 0
var activated = false
func _physics_process(delta):
	
	if count < 90:
		count += 1
	
	if manager.player_won and not activated:
		activated = true
		camera.zoom = Vector2(1, 1)
		won_menu.pause_menu()
		
	elif not manager.player_won and activated:
		activated = false
		

func next_level():
	get_tree().change_scene("res://scenes/shortest_path/niveles/nivel_2.tscn")
