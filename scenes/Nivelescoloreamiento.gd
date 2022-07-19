extends Node2D

onready var atras = $atras
onready var seleccion = $Scroll/Seleccion


func _ready():
	atras.connect("pressed", self, "_on_atras_pressed")
	# Cargando las calificaciones
	var calificaciones = ["Sin completar", "Completo", "Perfecto"]
	var guardado = File.new()
	guardado.open("res://coloring/base/coloring_progress.dat", File.READ)
	var indices_progreso = str2var(guardado.get_as_text())
	guardado.close()

	# Preparando los botones y etiquetas
	var seleccionables = seleccion.get_children()
	for nivel in seleccionables.size():
		var seleccionable = seleccionables[nivel]
		seleccionable.index.text = str(nivel + 1)
		seleccionable.completion.text = calificaciones[indices_progreso[nivel]]
		seleccionable.texture_normal = load("res://assets/coloring/level%d.png" % (nivel + 1))
		seleccionable.scene = "res://coloring/Level %d.png" % (nivel + 1)


func _on_atras_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/MainMenu.tscn")
