extends Node2D

onready var buckets = $ColorBuckets
onready var graph = $GraphToColor
onready var hud = $HUD_OVERLAY


var buttons = []
var connected_node_pairs = []
var current_color = null
var uncolored = Color(1, 1, 1, 1)


func _ready() -> void:
	# Inicializando el HUD
	hud.min_colors = 3
	hud.level = 2
	
	# Inicializando las cubetas
	for button in buckets.get_children():
		button.connect("pressed", self, "_on_Bucket_pressed", [button.modulate])
	
	# Inicializando cada elemento del grafo
	for graph_element in graph.get_children():  
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
	hud.to_color = 0
	for button in buttons:
		if button.modulate == uncolored:
			hud.to_color += 1

	# Se determina la cantidad de colores utilizados
	var colors = []
	for button in buttons:
		var color = button.modulate
		if color != uncolored and not (color in colors):
			colors.append(color)
	hud.colors_used = len(colors)

	# Se determina la cantidad de aristas con dos nodos del mismo color.
	hud.errors = 0
	for nodes in connected_node_pairs:
		var a = nodes[0]
		var b = nodes[1]
		if (a.modulate == b.modulate) and (a.modulate != uncolored):
			hud.errors += 1
