extends Node

# Variables globales para el shortest path

var trying_to_connect = false
var current_station : Node2D = null

# Sets the default state
func reset_variables():
	trying_to_connect = false
	current_station = null
