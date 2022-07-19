extends Node2D

onready var atras = $atras
onready var seleccion = $Scroll/Seleccion


func _ready():
	atras.connect("pressed", self, "_on_atras_pressed")
	# Preparando los botones y etiquetas
	var seleccionables = seleccion.get_children()
	for nivel in seleccionables.size():
		var seleccionable = seleccionables[nivel]
		seleccionable.index.text = str(nivel + 1)
		# seleccionable.completion.text = Según lo que carguen del guardado
		seleccionable.texture_normal = load("res://assets/shortest_path/lvl%d.png" % (nivel + 1))
		seleccionable.scene = "res://scenes/shortest_path/niveles/nivel_%d.tscn" % (nivel + 1)


func _on_atras_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/MainMenu.tscn")
