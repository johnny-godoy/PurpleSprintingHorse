extends Node

#######
# En cada nivel se debe settear al inicio:
#	- start_station
#	- end_station
#	- optimal_path
#	- number_of_connections = 0
#	- optimal_path y optimal_path_len

# Variables globales para el shortest path

#### PARA GUARDAR Y CARGAR INFORMACIÓN DE LOS NIVELES #####

var _file_data = {}
var _file_name = "res://shortest_path_progress.json"

##### PARA MANEJO DE NIVELES ###

# Literal spaguetti
var station_touched = false

var trying_to_connect = false
var accept_connection = false

var current_ending_station : Node2D = null
var current_station : Node2D = null
var start_station : Node2D = null # Indefinite
var end_station : Node2D = null # Indefinite
var optimal_path = ['none'] # Indefinite
var optimal_path_len = 0xFFFFFFFF
var max_deviation_from_len = 3

var number_of_connections := 0 setget _set_noc# Reset by station

var HUD : Node2D

export var player_won = false

func _ready():
	load_data()


# Sets the default state for the temp vars.
# Reinicia las variables que se deben reiniciar al inicio de un nivel.
func reset_variables():
	trying_to_connect = false
	current_station = null
	accept_connection = false
	current_ending_station = null

# Checkeo de que se encontró el camino más corto, permite encontrarlo por largo 
# o por exactitud del camino
# Para largo se usa la variable 'optimal_path_len'
# Para camino exacto se usa 'optimal_path'
func check_path(last_station : Node2D):
	var current_path = []
	var current_station = last_station
	if len(optimal_path) != 0:
		while is_instance_valid(current_station):
			current_path.insert(0, current_station)
			current_station = current_station.connected_from
		
		if current_path == optimal_path or len(current_path) == optimal_path_len+1:
			player_won = true
		elif len(current_path) < optimal_path_len + 1 + max_deviation_from_len:
			player_won = true
		else:
			player_won = false

# Llamado por las estaciones cuando se conectan y desconectan, cambia la
# cantidad de conexiones en el HUD. Permite además un checkeo cuando es llamado
# por la estación final.
func _set_noc(value):
	number_of_connections = value
	HUD.num_connections = value
	
	if current_ending_station == end_station:
		check_path(current_ending_station)
	else:
		player_won = false

"""
Para guardar y cargar puntajes en los niveles del camino más corto

Ej de diccionario:
	{
		"1": { # numero del nivel
			 "noc": 3, # numero de conexiones
			 "starts": 3 # numero de estrellas
			 }, 
		"2":5 	   # 
	}

"""
func save_score(level, number_of_stars, noc = number_of_connections):
	
	if typeof(level) == TYPE_INT:
		level = var2str(level)
	
	_file_data[level] = {
						"noc": noc,
						"stars": number_of_stars
						}
						
	save_data()
	return
	
func save_data(data = _file_data):
	var file = File.new()
	file.open(_file_name, File.WRITE)
	file.store_line(to_json(_file_data))
	file.close()
	
func load_data(return_data = false):
	var file = File.new()
	if not file.file_exists(_file_name):
		file.open(_file_name, File.WRITE)
		file.store_line(to_json(_file_data))
		file.close()
		return
		
	file.open(_file_name, File.READ)
	_file_data = parse_json(file.get_as_text())
	
	if _file_data == null:
		_file_data = {}
	
	if return_data:
		return _file_data

func load_stars(level):
	if typeof(level) == TYPE_INT:
		level = var2str(level)
		
	return _file_data[level]["stars"]
	
func restart_levels():
	for i in range(1,11):
		_file_data[var2str(i)] = {
						"noc": 0,
						"stars": 0
						}
	save_data()
