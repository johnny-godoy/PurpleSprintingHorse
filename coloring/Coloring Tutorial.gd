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
	for button in buckets.get_children():
		button.connect("pressed", self, "_on_Bucket_pressed", [button.modulate])
	for graph_element in graph.get_children():
		if graph_element is Joint2D:  # Edge
			var a = graph_element.get_node(graph_element.node_a).get_node("Button")
			var b = graph_element.get_node(graph_element.node_b).get_node("Button")
			connected_node_pairs.append([a, b])
		elif graph_element is PhysicsBody2D:  # Node
			var button = graph_element.get_node("Button")
			button.connect("pressed", self, "_on_Node_pressed", [button])
			buttons.append(button)


func _on_Bucket_pressed(color: Color) -> void:
	current_color = color


func _on_Node_pressed(button: Button) -> void:
	if current_color != null:
		button.modulate = current_color


func _process(_delta) -> void:
	var colors = []
	var uncolored_qty = 0
	for button in buttons:
		var color = button.modulate
		if color == uncolored:
			uncolored_qty += 1
		elif not (color in colors):
			colors.append(color)
	var color_count = len(colors)
	var errors = 0
	for nodes in connected_node_pairs:
		var a = nodes[0]
		var b = nodes[1]
		if (a.modulate == b.modulate) and (a.modulate != uncolored):
			errors += 1
	var score_text = "Faltan colorear: %s \nColores usados: %s/%s \nErrores: %s" % [uncolored_qty, color_count, max_color_count, errors]
	if uncolored_qty == 0 and (color_count <= max_color_count) and errors == 0:
		score_text += "\nGanaste!"
	score_label.text = score_text
