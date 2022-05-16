extends Node

#######
# En cada nivel se debe settear al inicio:
#	- start_station
#	- end_station
#	- optimal_path
#	- number_of_connections = 0

# Variables globales para el shortest path

var trying_to_connect = false
var accept_connection = false

var current_ending_station : Node2D = null
var current_station : Node2D = null
var start_station : Node2D = null # Indefinite
var end_station : Node2D = null # Indefinite
var optimal_path = null # Indefinite

var number_of_connections := 0 setget _set_noc# Reset by station

var HUD : Node2D

# Sets the default state for the temp vars.
func reset_variables():
	trying_to_connect = false
	current_station = null
	accept_connection = false
	current_ending_station = null

func check_path(last_station : Node2D):
	var current_path = []
	var current_station = last_station
	if len(optimal_path) != 0:
		while is_instance_valid(current_station):
			current_path.insert(0, current_station)
			current_station = current_station.connected_from

func _set_noc(value):
	number_of_connections = value
	HUD.num_connections = value
