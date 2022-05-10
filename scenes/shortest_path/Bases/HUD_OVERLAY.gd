extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _menu_button:Button = $HUD/MenuButton
onready var _level_number_label:Label = $HUD/LevelNumber
onready var _stations_label:Label = $HUD/StationNumber

var level_number = 0 setget _set_lvl_num
var num_connections = 0 setget _number_of_connections
var min_num_conns = 0 setget _set_min_conns

# Called when the node enters the scene tree for the first time.
func _ready():
	_menu_button.connect("button_down", self, '_menu_button_pressed')
	_menu_button.mouse_filter = Control.MOUSE_FILTER_STOP
	_menu_button.add_stylebox_override("hover", _menu_button.get_stylebox('normal'))
	
# Despliega el menú
func _menu_button_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
	
func _set_lvl_num(new_number):
	level_number = new_number
	_level_number_label.text = "Nivel %d"	 % new_number

func _number_of_connections(number_of_stations):
	num_connections = number_of_stations
	_stations_label.text = 'Estaciones: %d/%d' % [num_connections, min_num_conns]

func _set_min_conns(min_number):
	min_num_conns = min_number
	_stations_label.text = 'Estaciones: %d/%d' % [num_connections, min_num_conns]

