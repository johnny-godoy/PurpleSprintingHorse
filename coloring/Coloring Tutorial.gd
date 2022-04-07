extends Node2D

onready var current_color = null
onready var buckets = $ColorBuckets
onready var graph = $GraphToSolve
onready var buttons = []
onready var connected_node_pairs = []
var max_color_count = 2
var uncolored = Color(1, 1, 1, 1)


func _ready() -> void:
	for button in buckets.get_children():
		button.connect("pressed", self, "_on_Bucket_pressed", [button.modulate])
	for graph_element in graph.get_children():
		if graph_element is Joint2D:
			var a = graph_element.get_node(graph_element.node_a).get_node("Button")
			var b = graph_element.get_node(graph_element.node_b).get_node("Button")
			connected_node_pairs.append([a, b])
		elif graph_element is PhysicsBody2D:
			var button = graph_element.get_node("Button")
			button.connect("pressed", self, "_on_Node_pressed", [button])
			buttons.append(button)


func _on_Bucket_pressed(color: Color) -> void:
	current_color = color
	print("Color actual: ", current_color)


func _on_Node_pressed(button: Button) -> void:
	if current_color != null:
		button.modulate = current_color


func _process(delta) -> void:
	var colors = []
	for button in buttons:
		var color: Color = button.modulate
		if color == uncolored:
			return
		if not (color in colors):
			colors.append(color)
	if len(colors) > max_color_count:
		return
	for nodes in connected_node_pairs:
		var a = nodes[0]
		var b = nodes[1]
		if a.modulate == b.modulate:
			return
	print("WIN")
