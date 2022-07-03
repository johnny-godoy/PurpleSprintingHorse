extends MarginContainer

onready var resume = $PanelContainer/VBoxContainer/Resume
onready var main_menu = $PanelContainer/VBoxContainer/MainMenu
onready var next_level = $PanelContainer/VBoxContainer/NextLevel

func _ready():
	resume.connect("pressed", self, "_on_resume_pressed")
	main_menu.connect("pressed", self, "_on_main_menu_pressed")
	next_level.connect("pressed", self, "_on_next_level_pressed")
	visible = false

func pause_menu():
	get_tree().paused = true
	visible = true

func _on_resume_pressed():
	get_tree().paused = false
	visible = false

func _on_main_menu_pressed():
	get_tree().change_scene("res://scenes/NivelesCamino.tscn")
	get_tree().paused = false

func _on_next_level_pressed():
	get_parent().next_level()
	get_tree().paused = false
