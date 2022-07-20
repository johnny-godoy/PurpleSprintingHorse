extends Node2D

onready var manager = ShortestPathManager
onready var atras = $atras
onready var seleccion = $Scroll/Seleccion


func _ready():
	# Preparando los botones y etiquetas
	var seleccionables = seleccion.get_children()
	for nivel in seleccionables.size():
		var seleccionable = seleccionables[nivel]
		seleccionable.shortest_path()
		seleccionable.index.text = str(nivel + 1)
		# seleccionable.completion.text = Según lo que carguen del guardado
		seleccionable.texture_normal = load("res://assets/shortest_path/lvl%d.png" % (nivel + 1))
		seleccionable.next_scene = "res://scenes/shortest_path/niveles/nivel_%d.tscn" % (nivel + 1)
		seleccionable.star_texture(_star_texture(nivel + 1))

func _star_texture(lvl):
	var num_stars = manager.load_stars(lvl)
	if num_stars == 3:
		return load("res://assets/shortest_path/3_estrellas.PNG")
	elif num_stars == 2:
		return load("res://assets/shortest_path/2_estrellas.PNG")
	elif num_stars == 1:
		return load("res://assets/shortest_path/1_estrellas.PNG")
	else:
		return load("res://assets/shortest_path/0_estrellas.PNG")
