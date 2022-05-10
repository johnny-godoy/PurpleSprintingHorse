extends Node2D

onready var exit = $Exit
onready var coloreamiento = $JuegaColoreamiento
onready var camino = $JuegaCamino

func _ready():
	exit.connect("pressed",self, "_on_exit_pressed")
	coloreamiento.connect("pressed",self,"on_coloreamiento_pressed")
	camino.connect("pressed",self,"on_camino_pressed")

func _on_exit_pressed():
	get_tree().quit()

func _on_coloreamiento_pressed():
	get_tree()

