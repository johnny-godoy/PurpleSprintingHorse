extends Node2D

onready var camino = $shortestpath
onready var coloreamiento = $coloreamiento
onready var credits = $Credits
onready var exit = $Exit


func _ready() -> void:
	camino.connect("pressed", self, "_scene_changer", ["NivelesCamino.tscn"])
	coloreamiento.connect("pressed", self, "_scene_changer", ["NivelesColoreamiento.tscn"])
	credits.connect("pressed", self, "_scene_changer", ["Creditos.tscn"])
	exit.connect("pressed", self, "_on_exit_pressed")


func _scene_changer(path: String) -> void:
	 # warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/%s" % path)


func _on_exit_pressed() -> void:
	get_tree().quit()
