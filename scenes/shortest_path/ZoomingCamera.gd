extends Node2D

const station = preload("res://scenes/shortest_path/estacionGenerica.tscn")
onready var nodes = $rome_subway/rome_subway

func _ready():
	var estacion_1 = station.instance()
	estacion_1.position = $rome_subway/rome_subway/sp_red_1.position
	estacion_1.scale = Vector2(0.5, 0.5)
	self.add_child(estacion_1)
	
