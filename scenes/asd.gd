extends MarginContainer

onready var coloreamiento = $Panel/VBoxContainer/VBoxContainer/Coloreamiento
onready var camino = $Panel/VBoxContainer/VBoxContainer/Camino
onready var exit = $Panel/VBoxContainer/VBoxContainer/Exit
# Called when the node enters the scene tree for the first time.
func _ready():
	coloreamiento.connect("pressed",self, "_on_coloreamiento_pressed")
	camino.connect("pressed",self, "_on_camino_pressed")
	exit.connect("pressed",self, "_on_exit_pressed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_coloreamiento_pressed():
	get_tree().change_scene("res://coloring/Level 1.tscn")

func _on_camino_pressed():
	get_tree().change_scene("res://scenes/shortest_path/hito_1/nivel_ejemplo_1.tscn")

func _on_exit_pressed():
	get_tree().quit()
