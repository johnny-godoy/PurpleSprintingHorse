extends Node2D

onready var manager = ShortestPathManager

onready var atras = $atras
onready var lvl1 = $Niveles2/lvl1
onready var lvl2 = $Niveles2/lvl2
onready var lvl3 = $Niveles2/lvl3

onready var spr_lvl1 = $estrellas_nivel_1
onready var spr_lvl2 = $estrellas_nivel_2
onready var spr_lvl3 = $estrellas_nivel_3

func _ready():
	atras.connect("pressed",self, "_on_atras_pressed")
	lvl1.connect("pressed",self, "_on_lvl1_pressed")
	lvl2.connect("pressed",self, "_on_lvl2_pressed")
	lvl3.connect("pressed",self, "_on_lvl3_pressed")
	spr_lvl1.texture = _star_texture(1)
	spr_lvl2.texture = _star_texture(2)
	spr_lvl3.texture = _star_texture(3)
	

func _on_atras_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")

func _on_lvl1_pressed():
	get_tree().change_scene("res://scenes/shortest_path/niveles/nivel_1.tscn")

func _on_lvl2_pressed():
	get_tree().change_scene("res://scenes/shortest_path/niveles/nivel_2.tscn")

func _on_lvl3_pressed():
	get_tree().change_scene("res://scenes/shortest_path/niveles/nivel_3.tscn")

func _star_texture(lvl):
	var num_stars = manager.load_stars(lvl)
	if num_stars == 3:
		return load("res://assets/shortest_path/3_estrellas.PNG")
	elif num_stars == 2:
		return load("res://assets/shortest_path/2_estrellas.PNG")
	elif num_stars == 1:
		return load("res://assets/shortest_path/1_estrellas.PNG")
	else:
		return load("res://assets/shortest_path/0_estrellas.PNG")
