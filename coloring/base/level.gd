class_name Level
extends Node2D

onready var buckets = $ColorBuckets
onready var graph = $GraphToColor
onready var horse = $Horse_Overlay
onready var hud = $HUD_OVERLAY
onready var pop_audio = $Pop
onready var selected = $Marco/Selected

export var min_colors = 4
export var level = 0
export var leeway = 1

var buttons = []
var connected_node_pairs = []
var finished = false setget , is_finished
var lines = []
var uncolored = Color(1, 1, 1, 1)
var has_next_level: bool
var activated: bool = false


func _ready() -> void:
	horse.visible = false
	# Inicializando el HUD
	hud.min_colors = min_colors
	hud.level = level
	hud.last_level_button.visible = level != 1
	has_next_level = level < hud.last_implemented_level

	# Inicializando cada elemento del grafo
	for graph_element in graph.get_children():  
		if graph_element is Joint2D:  # Aristas
			var a = graph_element.get_node(graph_element.node_a).get_node("TextureButton")
			var b = graph_element.get_node(graph_element.node_b).get_node("TextureButton")
			connected_node_pairs.append([a, b])
			lines.append(graph_element.get_node("Line2D"))
		elif graph_element is PhysicsBody2D:  # Nodos
			var button = graph_element.get_node("TextureButton")
			button.connect("pressed", self, "_on_Node_pressed", [button])
			buttons.append(button)


func _on_Node_pressed(button: TextureButton) -> void:
	pop_audio.play()
	button.modulate = buckets.current_color


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
	for nodes_index in connected_node_pairs.size():
		var line = lines[nodes_index]
		var nodes = connected_node_pairs[nodes_index]
		var a = nodes[0]
		var b = nodes[1]
		if (a.modulate == b.modulate) and (a.modulate != uncolored):
			hud.errors += 1
			line.set_default_color(Color(1, 0.2, 0.2, 1))
		else:
			line.set_default_color(Color(0.4, 0.5, 1, 1))

	# Se actualiza el color seleccionado
	selected.color = buckets.current_color

	# Se revisa si el nivel terminó para correr la secuencia apropiada
	hud.level_progress = 0
	hud.next_level_button.visible = false
	if is_finished():
		hud.level_progress = 1 + int(hud.colors_used == min_colors)
		hud.next_level_button.visible = has_next_level
	if is_finished() and not activated:
		activated = true
		
		if not has_next_level:
			yield(goodbye(), "completed")
	elif not is_finished() and activated:
		activated = false


func is_finished() -> bool:
	return hud.colors_used <= min_colors + leeway and hud.errors == 0 and hud.to_color == 0


func goodbye():
	horse.visible = true
	var texto_despedida = 'Oh...hola.'

	var script = ['Tengo malas noticias, me van a expulsar de la Academia Equina de Arte...Por falta de integridad académica',
	'Las buenas noticias son que me conseguí un trabajo en construcción. ¡Deberías visitarme allá!']

	yield(horse.prompt_text(texto_despedida), "completed")
	yield(horse.prompt_iterables(script), "completed")
	horse.visible = false
