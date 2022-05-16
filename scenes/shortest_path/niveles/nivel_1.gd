extends Node2D

onready var manager = ShortestPathManager

onready var HUD = $HUD_OVERLAY
onready var map = $rome_subway
onready var stations = $rome_subway/map

export var minimum_connections = 2
export var number_of_level = 1

export var stations_scale := 0.5 setget , _get_scale

const station_scene = preload("res://scenes/shortest_path/bases/estacionGenerica.tscn")

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

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
