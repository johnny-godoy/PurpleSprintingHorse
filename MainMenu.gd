extends Node2D

onready var level_select = $Menu/SelectLevel
var asd = 4


func _ready() -> void:
	level_select.connect("pressed", self, "_on_level_select_pressed")


func _on_level_select_pressed() -> void:
	get_tree().change_scene("res://LevelSelect.tscn")
