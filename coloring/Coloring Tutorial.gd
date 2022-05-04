extends Node2D

onready var buckets = $ColorBuckets
onready var graph = $GraphToColor
onready var score_label = $ScoreFrame/ScoreLabel

var buttons = []
var connected_node_pairs = []
var current_color = null
var uncolored = Color(1, 1, 1, 1)

var max_color_count = 2


func _ready() -> void:
	for button in buckets.get_children():  # Inicializando las cubetas
		button.connect("pressed", self, "_on_Bucket_pressed", [button.modulate])

	for graph_element in graph.get_children():  # Explorando cada elemento del grafo
		if graph_element is Joint2D:  # Aristas
			var a = graph_element.get_node(graph_element.node_a).get_node("TextureButton")
			var b = graph_element.get_node(graph_element.node_b).get_node("TextureButton")
			connected_node_pairs.append([a, b])
		elif graph_element is PhysicsBody2D:  # Nodos
			var button = graph_element.get_node("TextureButton")
			button.connect("pressed", self, "_on_Node_pressed", [button])
			buttons.append(button)


func _on_Bucket_pressed(color: Color) -> void:
	current_color = color


func _on_Node_pressed(button: TextureButton) -> void:
	if current_color != null:
		button.modulate = current_color


func _process(_delta) -> void:
	# Se determina la cantidad de nodos sin colorear
	var uncolored_qty = 0
	for button in buttons:
		if button.modulate == uncolored:
			uncolored_qty += 1
	
	# Se determina la cantidad de colores utilizados
	var colors = []
	for button in buttons:
		var color = button.modulate
		if color != uncolored and not (color in colors):
			colors.append(color)
	var color_count = len(colors)
	
	# Se determina la cantidad de aristas con dos nodos del mismo color.
	var errors = 0
	for nodes in connected_node_pairs:
		var a = nodes[0]
		var b = nodes[1]
		if (a.modulate == b.modulate) and (a.modulate != uncolored):
			errors += 1
	
	# Se genera el texto para el HUD
	var replace_values = [uncolored_qty, color_count, max_color_count, errors]
	var score_text = "Faltan colorear: %s \nColores usados: %s/%s \nErrores: %s" % replace_values
	if uncolored_qty == 0 and (color_count <= max_color_count) and errors == 0:
		score_text += "\nGanaste!"
	score_label.text = score_text
