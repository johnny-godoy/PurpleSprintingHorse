extends Node

# Variables globales para el shortest path

var trying_to_connect = false
var accept_connection = false

var current_ending_station : Node2D = null
var current_station : Node2D = null
var start_station : Node2D = null # Indefinite
var end_station : Node2D = null # Indefinite
var optimal_path = null # Indefinite
var star : Sprite = null
var star2: Sprite = null
var score_text = null

var number_of_connections = 0 # Reset by station

var zoo = 1

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
		
	if current_path == optimal_path:
		star.visible = true
		star2.visible = true
	elif len(current_path) > len(optimal_path):
		if len(current_path) == 4:
			star.visible = true
			star2.visible = false
		else:
			star.visible = false
			star2.visible = false
			score_text.text = "Existen caminos más cortos. Por lo que obtienes\n 0 de 2 estrellas :c"
	else:	
		star.visible = false
		star2.visible = false
		score_text.text = ""
