extends Node2D

onready var atras = $atras
onready var lvl1 = $Niveles2/lvl1
onready var lvl2 = $Niveles2/lvl2
onready var lvl3 = $Niveles2/lvl3

func _ready():
	atras.connect("pressed",self, "_on_atras_pressed")
	lvl1.connect("pressed",self, "_on_lvl1_pressed")
	lvl2.connect("pressed",self, "_on_lvl2_pressed")
	lvl3.connect("pressed",self, "_on_lvl3_pressed")

func _on_atras_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _on_lvl1_pressed():
	get_tree().change_scene("res://coloring/Level 1.tscn")

func _on_lvl2_pressed():
	get_tree().change_scene("res://coloring/Level 2.tscn")

func _on_lvl3_pressed():
	get_tree().change_scene("res://coloring/Level 3.tscn")
