extends Node2D

export var stations_scale := 0.5 setget , _get_scale
var _childs = []
var _incomplete_stations = {}
var first_touch = true

onready var manager = ShortestPathManager
onready var map = $rome_subway
onready var stations = $rome_subway/map
onready var instruction_overlay = $horse_overlay
onready var map_mo = $moscow_subway
onready var map_mo_map = $moscow_subway/Control/map

const station = preload("res://scenes/shortest_path/bases/estacionGenerica.tscn")
var _started_level = false

func _ready():
	manager.reset_variables()
	manager.HUD = $HUD_OVERLAY
	
	# first_call()
	second_call()

func second_call():
	for station_node in get_tree().get_nodes_in_group('estacion'):
		var temp_station = station.instance()
		temp_station.position = station_node.position
		temp_station.scale = self.stations_scale
		temp_station.z_index = -1
		map_mo_map.add_child(temp_station, true)
		_incomplete_stations[temp_station.position] = temp_station
	
	# Hace uso de la posición de las estacions como identificador único
	for _temp_station_pos in _incomplete_stations.keys():
		var temp_station = _incomplete_stations[_temp_station_pos]
		for _neighbour_pos in map_mo.estaciones_y_vecinos[_temp_station_pos]:
			var _temp_neigh = _incomplete_stations[_neighbour_pos]
			temp_station.estaciones_adyacentes.append(_temp_neigh)
			temp_station.conexiones_a_estacion[_temp_neigh] = map_mo.get_conn_line(_temp_station_pos, _neighbour_pos)
	
	_incomplete_stations.values()[0].is_starting_station = true
	
	_started_level = true

func print_text():
	$SP_Camera.current = false
	yield(instruction_overlay.prompt_text('AAAAA'), "completed")
	yield(instruction_overlay.prompt_text('HOL HOLA HOLAS HOLASS'), "completed")
	print('passed_0')
	yield(instruction_overlay.prompt_iterables(['Habia una vez', 'unaaaaa', 'vez lorem ipsum', 'truzardaadadadada']), "completed")
	print('passed_1')
	print('passed_2')
	$SP_Camera.current = true
	$horse_overlay.visible = false

func first_call():
	
	yield(print_text(), "completed")
	
	# Se crean las estaciones
	for pos in stations.get_children():
		if not pos.is_in_group('stations'):
			continue
		var temp_station = station.instance()
		temp_station.position = pos.position
		temp_station.scale = self.stations_scale
		temp_station.z_index = -1
		map.add_child(temp_station, true)
		_childs.append(temp_station)
	
	# Se agregan las estaciones adyacentes para que puedan conectarse
	var num = 0
	for station in _childs:
		for neighbour in map.next_to[num]:
			station.estaciones_adyacentes.append(_childs[neighbour])
			station.conexiones_a_estacion[_childs[neighbour]] = map.connecting_line[[num, neighbour]]
		num = num + 1
	
	_childs[0].is_starting_station = true
	
	_started_level = true
	
func _get_scale():
	return Vector2(stations_scale, stations_scale)
