extends Node2D

onready var camino = $shortestpath
onready var coloreamiento = $coloreamiento
onready var credits = $Credits
onready var exit = $Exit


func _ready() -> void:
	exit.connect("pressed", self, "_on_exit_pressed")

func _on_exit_pressed() -> void:
	get_tree().quit()
