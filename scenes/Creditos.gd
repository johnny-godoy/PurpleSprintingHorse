extends Node2D

onready var atras = $atras


func _ready() -> void:
	atras.connect("pressed", self, "_on_atras_pressed")


func _on_atras_pressed() -> void:
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/MainMenu.tscn")
