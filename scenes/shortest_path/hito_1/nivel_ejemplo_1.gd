extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var manager = ShortestPathManager
onready var lastStation = $estacion5
onready var star = $Sprite2

# Called when the node enters the scene tree for the first time.
func _ready():
	manager.start_station = $estacion1
	manager.end_station = $estacion5
	manager.optimal_path = [$estacion1, $estacion3, $estacion5]
	manager.star = $Sprite2
	manager.score_text = $Puntajes
	manager.star2 = $Sprite3

func _process(_delta):
	manager.check_path(lastStation)
