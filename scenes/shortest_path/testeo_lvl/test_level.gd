extends Node2D

onready var manager = ShortestPathManager
const station = preload("res://scenes/shortest_path/estacionGenerica.tscn")
onready var nodes = $rome_subway

func _ready():
	manager.reset_variables()
	
	var estacion_1 = station.instance()
	estacion_1.position = $rome_subway/rome_subway/sp_red_1.position
	estacion_1.scale = Vector2(0.5, 0.5)
	
	var estacion_2 = station.instance()
	estacion_2.position = $rome_subway/rome_subway/sp_red_2.position
	estacion_2.scale = Vector2(0.5, 0.5)
	
	var estacion_3 = station.instance()
	estacion_3.position = $rome_subway/rome_subway/sp_red_3.position
	estacion_3.scale = Vector2(0.3, 0.3)
	
	manager.start_station = estacion_1
	manager.end_station = estacion_2
	manager.optimal_path = [estacion_1, estacion_2]
	
	self.add_child(estacion_1, true)
	self.add_child(estacion_2, true)
	self.add_child(estacion_3, true)
	
	estacion_2.estaciones_adyacentes = [estacion_1]
	estacion_3.estaciones_adyacentes = [estacion_2]
	estacion_1.estaciones_adyacentes = [estacion_2]
	
func _physics_process(delta):
	if is_instance_valid(manager.current_ending_station):
		print(manager.current_ending_station)
