extends Node2D

# draw_polyline ($ Path2D.curve.get_baked_points (), Color.aquamarine, 5, true)
var next_to = []
onready var places = get_tree().get_nodes_in_group('stations')
# Called when the node enters the scene tree for the first time.
func _ready():
	_add_conn('sp_red_1', ['sp_red_2'])
	_add_conn('sp_red_2', ['sp_red_1', 'sp_red_3'])
	_add_conn('sp_red_3', ['sp_red_2', 'sp_red_4'])
	_add_conn('sp_red_4', ['sp_red_3', 'sp_red_5'])
	_add_conn('sp_red_5', ['sp_red_4', 'sp_red_6'])
	_add_conn('sp_red_6', ['sp_black_1', 'sp_red_5'])
	_add_conn('sp_black_1', ['sp_blue_1', 'sp_blue_7', 'sp_red_6', 'sp_red_7', 'sp_green_1'])
	_add_conn('sp_red_7', ['sp_black_1', 'sp_red_8'])
	_add_conn('sp_green_1', ['sp_black_1'])
	_add_conn('sp_blue_1', ['sp_black_1', 'sp_blue_3', 'sp_blue_2'])
	_add_conn('sp_blue_2', ['sp_blue_1', 'sp_blue_5'])
	_add_conn('sp_blue_3', ['sp_blue_1', 'sp_blue_4'])
	_add_conn('sp_blue_4', ['sp_blue_3'])
	_add_conn('sp_blue_5', ['sp_blue_2', 'sp_blue_6'])
	_add_conn('sp_blue_6', ['sp_blue_5'])
	_add_conn('sp_blue_7', ['sp_blue_8', 'sp_black_1'])
	_add_conn('sp_blue_8', ['sp_blue_9', 'sp_blue_7'])
	_add_conn('sp_blue_9', ['sp_blue_10', 'sp_blue_8'])
	_add_conn('sp_blue_10', ['sp_blue_11', 'sp_blue_9'])
	_add_conn('sp_blue_11', ['sp_blue_12', 'sp_blue_10'])
	_add_conn('sp_blue_12', ['sp_blue_11'])
	_add_conn('sp_red_8', ['sp_red_7', 'sp_red_9'])
	_add_conn('sp_red_9', ['sp_red_8', 'sp_red_10'])
	_add_conn('sp_red_10', ['sp_red_9', 'sp_red_11'])
	_add_conn('sp_red_11', ['sp_red_10'])
	
func _add_conn(_og, connections):
	
	var temp = []
	
	for node in connections:
		temp.append(_name_to_num(node))
	
	next_to.append(temp)

func _name_to_num(the_node):
	return places.find(get_node('map/' + the_node))
