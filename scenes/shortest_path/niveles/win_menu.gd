extends Node2D

onready var manager = ShortestPathManager
onready var audio = $pop
onready var click = $click
onready var resume = $WonMenu/PanelContainer/VBoxContainer/Resume
onready var main_menu = $WonMenu/PanelContainer/VBoxContainer/MainMenu
onready var next_level = $WonMenu/PanelContainer/VBoxContainer/NextLevel
onready var star_sprite = $WonMenu/PanelContainer/VBoxContainer/StarRect

func _ready():
	resume.connect("pressed", self, "_on_resume_pressed")
	main_menu.connect("pressed", self, "_on_main_menu_pressed")
	next_level.connect("pressed", self, "_on_next_level_pressed")
	visible = false

func pause_menu(number_of_stars=-1):
	if number_of_stars == 3:
		star_sprite.texture = load("res://assets/shortest_path/3_estrellas.PNG")
	elif number_of_stars == 2:
		star_sprite.texture = load("res://assets/shortest_path/2_estrellas.PNG")
	elif number_of_stars == 1:
		star_sprite.texture = load("res://assets/shortest_path/1_estrellas.PNG")
	else:
		star_sprite.texture = load("res://assets/shortest_path/0_estrellas.PNG")
	
	audio.play()
	yield(audio, "finished")
	get_tree().paused = true
	visible = true

func _on_resume_pressed():
	click.play()
	get_tree().paused = false
	# audio.play()
	# yield(audio, "finished")
	visible = false

func _on_main_menu_pressed():
	click.play()
	get_tree().change_scene("res://scenes/NivelesCamino.tscn")
	get_tree().paused = false

func _on_next_level_pressed():
	click.play()
	get_parent().next_level()
	get_tree().paused = false

