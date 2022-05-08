extends Node2D

onready var exit = $Exit

func _ready():
	exit.connect("pressed",self, "_on_exit_pressed")

func _on_exit_pressed():
	get_tree().quit()

