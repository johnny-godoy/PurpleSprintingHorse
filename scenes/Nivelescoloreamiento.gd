extends Node2D

onready var atras = $atras
onready var niveles = $Niveles2
onready var etiquetas_calificaciones = $LabelsCalificacion
onready var lvl1 = $Niveles2/lvl1
onready var lvl2 = $Niveles2/lvl2
onready var lvl3 = $Niveles2/lvl3


func _ready():
	atras.connect("pressed", self, "_on_atras_pressed")
	# Cargando las calificaciones
	var calificaciones = ["Sin completar", "Completo", "Perfecto"]
	var guardado = File.new()
	guardado.open("res://coloring/base/coloring_progress.dat", File.READ)
	var indices_progreso = str2var(guardado.get_as_text())
	guardado.close()

	# Preparando los botones y etiquetas
	var hijos_niveles = niveles.get_children()
	var labels = etiquetas_calificaciones.get_children()
	for nivel in hijos_niveles.size():
		hijos_niveles[nivel].connect("pressed", self, "_on_level_button_pressed", [nivel + 1])
		labels[nivel].text = calificaciones[indices_progreso[nivel]]


func _on_atras_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/MainMenu.tscn")


func _on_level_button_pressed(level: int):
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://coloring/Level %d.tscn" % level)
