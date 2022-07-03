extends Node2D

onready var exit = $Exit
onready var coloreamiento = $coloreamiento
onready var camino = $shortestpath

func _ready():
	exit.connect("pressed",self, "_on_exit_pressed")
	coloreamiento.connect("pressed",self,"_on_coloreamiento_pressed")
	camino.connect("pressed",self,"_on_camino_pressed")

func _on_exit_pressed():
	get_tree().quit()

func _on_coloreamiento_pressed():
	get_tree().change_scene("res://scenes/NivelesColoreamiento.tscn")

# Creada por Agustin temporalmente
func _on_camino_pressed():
	get_tree().change_scene("res://scenes/NivelesCamino.tscn")
