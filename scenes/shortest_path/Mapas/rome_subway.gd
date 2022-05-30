extends Node2D

# draw_polyline ($ Path2D.curve.get_baked_points (), Color.aquamarine, 5, true)
var next_to = []
var connecting_line = {}

onready var lines = $map/lines
onready var places = get_tree().get_nodes_in_group('stations')
onready var lines_childs = lines.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	_add_conn('sp_red_1', [
		['sp_red_2', $map/lines/red_1]
		])
	_add_conn('sp_red_2', [
		['sp_red_1', $map/lines/red_1], 
		['sp_red_3', $map/lines/red_2]
		])
	_add_conn('sp_red_3', [
		['sp_red_2', $map/lines/red_2], 
		['sp_red_4', $map/lines/red_3]
		])
	_add_conn('sp_red_4', [
		['sp_red_3', $map/lines/red_3], 
		['sp_red_5', $map/lines/red_5]
		])
	_add_conn('sp_red_5', [
		['sp_red_4', $map/lines/red_5], 
		['sp_red_6', $map/lines/red_6]
		])
	_add_conn('sp_red_6', [
		['sp_black_1', $map/lines/red_7], 
		['sp_red_5', $map/lines/red_6]
		])
	_add_conn('sp_black_1', [
		['sp_blue_1', $map/lines/blue_7], 
		['sp_blue_7', $map/lines/blue_6], 
		['sp_red_6', $map/lines/red_7], 
		['sp_red_7', $map/lines/red_8],
		['sp_green_1', $map/lines/green_1]
		])
	_add_conn('sp_red_7', [
		['sp_black_1', $map/lines/red_8], 
		['sp_red_8', $map/lines/red_10]
		])
	_add_conn('sp_green_1', [
		['sp_black_1', $map/lines/green_1]
		])
	_add_conn('sp_blue_1', [
		['sp_black_1', $map/lines/blue_7], 
		['sp_blue_3', $map/lines/blue_8], 
		['sp_blue_2', $map/lines/blue_10]
		])
	_add_conn('sp_blue_2', [
		['sp_blue_1', $map/lines/blue_10], 
		['sp_blue_5', $map/lines/blue_11]
		])
	_add_conn('sp_blue_3', [
		['sp_blue_1', $map/lines/blue_8], 
		['sp_blue_4', $map/lines/blue_9]
		])
	_add_conn('sp_blue_4', [
		['sp_blue_3', $map/lines/blue_9]
		])
	_add_conn('sp_blue_5', [
		['sp_blue_2', $map/lines/blue_11], 
		['sp_blue_6', $map/lines/blue_12]
		])
	_add_conn('sp_blue_6', [
		['sp_blue_5', $map/lines/blue_12]
		])
	_add_conn('sp_blue_7', [
		['sp_blue_8', $map/lines/blue_5], 
		['sp_black_1', $map/lines/blue_6]
		])
	_add_conn('sp_blue_8', [
		['sp_blue_9', $map/lines/blue_4], 
		['sp_blue_7', $map/lines/blue_5]
		])
	_add_conn('sp_blue_9', [
		['sp_blue_10', $map/lines/blue_3], 
		['sp_blue_8', $map/lines/blue_4]
		])
	_add_conn('sp_blue_10', [
		['sp_blue_11', $map/lines/blue_2], 
		['sp_blue_9', $map/lines/blue_3]
		])
	_add_conn('sp_blue_11', [
		['sp_blue_12', $map/lines/blue_1], 
		['sp_blue_10', $map/lines/blue_2]
		])
	_add_conn('sp_blue_12', [
		['sp_blue_11', $map/lines/blue_1]
		])
	_add_conn('sp_red_8', [
		['sp_red_7', $map/lines/red_10], 
		['sp_red_9', $map/lines/red_11]
		])
	_add_conn('sp_red_9', [
		['sp_red_8', $map/lines/red_11], 
		['sp_red_10', $map/lines/red_12]
		])
	_add_conn('sp_red_10', [
		['sp_red_9', $map/lines/red_12], 
		['sp_red_11', $map/lines/red_13]
		])
	_add_conn('sp_red_11', [
		['sp_red_10', $map/lines/red_13]
		])

	for line in lines_childs:
		line.visible = false
	
func _add_conn(_og, connections):
	
	var temp_node = []
	var temp_line = {}

	for node_n_line in connections:
		temp_node.append(name_to_num(node_n_line[0]))
		connecting_line[[name_to_num(_og), name_to_num(node_n_line[0])]] = node_n_line[1]
	
	next_to.append(temp_node)
	#connecting_line = temp_line

func name_to_num(the_node):
	return places.find(get_node('map/' + the_node))
