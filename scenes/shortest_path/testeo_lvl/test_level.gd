extends Node2D

export var stations_scale := 0.5 setget , _get_scale
var _childs = []
var first_touch = true

onready var manager = ShortestPathManager
onready var map = $rome_subway
onready var stations = $rome_subway/map
onready var instruction_overlay = $horse_overlay

const station = preload("res://scenes/shortest_path/bases/estacionGenerica.tscn")
var _started_level = false

func _ready():
	manager.reset_variables()
	manager.HUD = $HUD_OVERLAY
	call_deferred('first_call')


func first_call():
	
	instruction_overlay.prompt_text('HOL HOLA HOLAS HOLASS')
	print('passed_0')
	instruction_overlay.prompt_text('AAAAAAA')
	print('passed_1')
	instruction_overlay.prompt_text('BBBBBBB')
	print('passed_2')
	
	# Se crean las estaciones
	for pos in stations.get_children():
		if not pos.is_in_group('stations'):
			continue
		var temp_station = station.instance()
		temp_station.position = pos.position
		temp_station.scale = self.stations_scale
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
