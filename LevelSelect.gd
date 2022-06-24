extends Node2D

onready var menu = $Menu
var paths = ["coloring/Level 1", "scenes/shortest_path/nivel_ejemplo_1", "MainMenu"]


func _ready() -> void:
	for i in menu.get_children().size():
		menu.get_children()[i].connect("pressed", self, "_on_button_pressed", [i])


func _on_button_pressed(i: int) -> void:
	get_tree().change_scene("res://%s.tscn"%paths[i])
