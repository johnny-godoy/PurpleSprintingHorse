extends Node2D

export var stations_scale := 0.5 setget , _get_scale
var to_child_ = []

onready var manager = ShortestPathManager
onready var nodes = $rome_subway
onready var stations = $rome_subway/map

const station = preload("res://scenes/shortest_path/estacionGenerica.tscn")

func _ready():
	manager.reset_variables()
	
	for pos in stations.get_children():
		var temp_station = station.instance()
		temp_station.position = pos.position
		temp_station.scale = self.stations_scale
		nodes.add_child(temp_station, true)
	
	# estacion_2.estaciones_adyacentes = [estacion_1]
	# estacion_3.estaciones_adyacentes = [estacion_2]
	# estacion_1.estaciones_adyacentes = [estacion_2]

func _get_scale():
	return Vector2(stations_scale, stations_scale)
