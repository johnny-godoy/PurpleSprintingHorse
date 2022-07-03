extends Node2D

# draw_polyline ($ Path2D.curve.get_baked_points (), Color.aquamarine, 5, true)
var next_to = []
var connecting_line = {}

onready var lines = $map/lines
onready var places = get_tree().get_nodes_in_group('stations')
onready var lines_childs = lines.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	_add_conn(places[0], [
		[places[1], $map/lines/blue_1],
		[places[10], $map/lines/orange_1],
		[places[11], $map/lines/orange_2]
		])
	_add_conn(places[1], [
		[places[0],$map/lines/blue_1],
		[places[2], $map/lines/blue_2]
		])
	_add_conn(places[2], [
		[places[1], $map/lines/blue_2],
		[places[3], $map/lines/blue_3]
		])
	_add_conn(places[3], [
		[places[2], $map/lines/blue_3],
		[places[23], $map/lines/lightgreen_4],
		[places[24], $map/lines/lightgreen_5],
		[places[4], $map/lines/blue_4]
		])
	_add_conn(places[4], [
		[places[3], $map/lines/blue_4],
		[places[30], $map/lines/green_1],
		[places[37], $map/lines/green_2],
		[places[5], $map/lines/blue_5]
		
		])
	_add_conn(places[5], [
		[places[4], $map/lines/blue_5],
		[places[6], $map/lines/blue_6]
		])
	_add_conn(places[6], [
		[places[5], $map/lines/blue_6],
		[places[7], $map/lines/blue_7]
		])
	_add_conn(places[7], [
		[places[6], $map/lines/blue_7],
		[places[8], $map/lines/blue_8],
		[places[45], $map/lines/pink_7],
		[places[46], $map/lines/pink_8]
		])
	_add_conn(places[8], [
		[places[7], $map/lines/blue_8],
		[places[9], $map/lines/blue_9]
		])
	_add_conn(places[9], [
		[places[8], $map/lines/blue_9],
		[places[39], $map/lines/green_5],
		[places[49], $map/lines/brown_5],
		[places[40], $map/lines/green_6],
		[places[50], $map/lines/brown_6]
		])
	_add_conn(places[10], [
		[places[0], $map/lines/orange_1],
		[places[16], $map/lines/red_1]
		])
	_add_conn(places[11], [
		[places[0], $map/lines/orange_2],
		[places[12], $map/lines/orange_3]
		])
	_add_conn(places[12], [
		[places[11], $map/lines/orange_3],
		[places[13], $map/lines/orange_4]
		])
	_add_conn(places[13], [
		[places[12], $map/lines/orange_4],
		[places[14], $map/lines/orange_5]
		])
	_add_conn(places[14], [
		[places[13], $map/lines/orange_5],
		[places[15], $map/lines/orange_6]
		])
	_add_conn(places[15], [
		[places[14], $map/lines/orange_6],
		[places[42], $map/lines/pink_1],
		[places[47], $map/lines/brown_1]
		])
	_add_conn(places[16], [
		[places[10], $map/lines/red_1],
		[places[17], $map/lines/red_2],
		[places[19], $map/lines/yellow_1]
		])
	_add_conn(places[17], [
		[places[16], $map/lines/red_2],
		[places[18], $map/lines/red_3],
		[places[19], $map/lines/lightgreen_1]
		])
	_add_conn(places[18], [
		[places[17], $map/lines/red_3],
		[places[21], $map/lines/lightblue_1]
		])
	_add_conn(places[19], [
		[places[16], $map/lines/yellow_1],
		[places[20], $map/lines/yellow_2],
		[places[17], $map/lines/lightgreen_1],
		[places[22], $map/lines/lightgreen_2]
		])
	_add_conn(places[20], [
		[places[19], $map/lines/yellow_2],
		[places[21], $map/lines/yellow_3]
		])
	_add_conn(places[21], [
		[places[20], $map/lines/yellow_3],
		[places[18], $map/lines/lightblue_1],
		[places[34], $map/lines/lightblue_2]
		])
	_add_conn(places[22], [
		[places[19], $map/lines/lightgreen_2],
		[places[23], $map/lines/lightgreen_3]
		])
	_add_conn(places[23], [
		[places[22], $map/lines/lightgreen_3],
		[places[28], $map/lines/grey_1],
		[places[29], $map/lines/grey_2],
		[places[3], $map/lines/lightgreen_4]
		])
	_add_conn(places[24], [
		[places[3], $map/lines/lightgreen_5],
		[places[25], $map/lines/lightgreen_6]
		])
	_add_conn(places[25], [
		[places[24], $map/lines/lightgreen_6],
		[places[26], $map/lines/lightgreen_7],
		[places[44], $map/lines/pink_4],
		[places[38], $map/lines/pink_5]
		])
	_add_conn(places[26], [
		[places[25], $map/lines/lightgreen_7],
		[places[27], $map/lines/lightgreen_8]
		])
	_add_conn(places[27], [
		[places[26], $map/lines/lightgreen_8],
		[places[48], $map/lines/brown_3],
		[places[49], $map/lines/brown_4]
		])
	_add_conn(places[28], [
		[places[23], $map/lines/grey_1]
		])
	_add_conn(places[29], [
		[places[23], $map/lines/grey_2],
		[places[30], $map/lines/grey_3]
		])
	_add_conn(places[30], [
		[places[29], $map/lines/grey_3],
		[places[31], $map/lines/grey_4],
		[places[4], $map/lines/green_1]
		])
	_add_conn(places[31], [
		[places[30], $map/lines/grey_4],
		[places[32], $map/lines/grey_5],
		])
	_add_conn(places[32], [
		[places[31], $map/lines/grey_5],
		[places[33], $map/lines/grey_6]
		])
	_add_conn(places[33], [
		[places[32], $map/lines/grey_6],
		[places[34], $map/lines/grey_7]
		])
	_add_conn(places[34], [
		[places[33], $map/lines/grey_7],
		[places[21], $map/lines/lightblue_2],
		[places[35], $map/lines/lightblue_3]
		])
	_add_conn(places[35], [
		[places[34], $map/lines/lightblue_3],
		[places[46], $map/lines/pink_9],
		[places[36], $map/lines/lightblue_4]
		])
	_add_conn(places[36], [
		[places[35], $map/lines/lightblue_4],
		[places[41], $map/lines/lightblue_5],
		[places[50], $map/lines/brown_7]
		])
	_add_conn(places[38], [
		[places[37], $map/lines/green_3],
		[places[39], $map/lines/green_4],
		[places[25], $map/lines/pink_5],
		[places[45], $map/lines/pink_6]
		])
	_add_conn(places[39], [
		[places[38], $map/lines/green_4],
		[places[9], $map/lines/green_5]
		])
	_add_conn(places[40], [
		[places[9], $map/lines/green_6],
		[places[41], $map/lines/green_7]
		])
	_add_conn(places[41], [
		[places[40], $map/lines/green_7],
		[places[36], $map/lines/lightblue_5]
		])
	_add_conn(places[42], [
		[places[15], $map/lines/pink_1],
		[places[43], $map/lines/pink_2]
		])
	_add_conn(places[43], [
		[places[42], $map/lines/pink_2],
		[places[44], $map/lines/pink_3]
		])
	_add_conn(places[44], [
		[places[43], $map/lines/pink_3],
		[places[25], $map/lines/pink_4]
		])
	_add_conn(places[45], [
		[places[38], $map/lines/pink_6],
		[places[7], $map/lines/pink_7]
		])
	_add_conn(places[46], [
		[places[7], $map/lines/pink_8],
		[places[35], $map/lines/pink_9]
		])
	_add_conn(places[47], [
		[places[15], $map/lines/brown_1],
		[places[48], $map/lines/brown_2]
		])
	_add_conn(places[48], [
		[places[47], $map/lines/brown_2],
		[places[27], $map/lines/brown_3]
		])
	_add_conn(places[49], [
		[places[27], $map/lines/brown_4],
		[places[9], $map/lines/brown_5]
		])
	_add_conn(places[50], [
		[places[9], $map/lines/brown_6],
		[places[36], $map/lines/brown_7]
		])

	for line in lines_childs:
		line.visible = false
	
func _add_conn(_og, connections):
	
	var temp_node = []

	for node_n_line in connections:
		temp_node.append(name_to_num(node_n_line[0]))
		connecting_line[[name_to_num(_og), name_to_num(node_n_line[0])]] = node_n_line[1]
	
	next_to.append(temp_node)
	#connecting_line = temp_line

func name_to_num(the_node):
	return places.find(get_node('map/' + the_node))
