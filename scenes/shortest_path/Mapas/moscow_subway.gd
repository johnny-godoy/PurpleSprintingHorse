extends Node2D


var estaciones_y_vecinos : Dictionary= {}
var _conexiones_y_nodo : Dictionary = {}
onready var mapa = $Control/map

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for estacion in get_tree().get_nodes_in_group('estacion'):
		estaciones_y_vecinos[estacion.position] = []
	
	var _node_a : Node2D
	var _node_b : Node2D
	for conexion in get_tree().get_nodes_in_group('conexion'):
		_node_a = conexion.get_node(conexion.node_a)
		_node_b = conexion.get_node(conexion.node_b)
		estaciones_y_vecinos[_node_a.position].append(_node_b.position)
		estaciones_y_vecinos[_node_b.position].append(_node_a.position)
		# Para cada conexion tomar nodos de los bordes y meterlos a 
		# la posicion adecuada
		 
		var _sorted = _sort_positions([_node_a.position, _node_b.position])
		var _linea_conexion = conexion.get_children()[0]
		_linea_conexion.visible = false
		_conexiones_y_nodo[_sorted] = _linea_conexion
		
func get_conn_line(pos_nodo_a, pos_nodo_b):
	return _conexiones_y_nodo[_sort_positions([pos_nodo_a, pos_nodo_b])]
	
func _sort_positions(list_of_pos):
	var pos_a = list_of_pos[0]
	var pos_b = list_of_pos[1]
	
	var _sorted
	if pos_a[0] < pos_b[0]:
		_sorted = [pos_a, pos_b]
	elif pos_a[0] > pos_b[0]:
		_sorted = [pos_b, pos_a]
	else:
		if pos_a[1] < pos_b[1]:
			_sorted = [pos_a, pos_b]
		elif pos_a[1] > pos_b[1]:
			_sorted = [pos_b, pos_a]
	
	return _sorted
