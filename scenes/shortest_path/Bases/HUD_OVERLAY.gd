extends Node2D

onready var manager = ShortestPathManager
onready var audio = $AudioStreamPlayer
onready var background_music = $LoopSound
onready var _menu_button:Button = $HUD/MenuButton
onready var _level_number_label:Label = $HUD/LevelNumber
onready var _stations_label:Label = $HUD/StationNumber
onready var _tip_button : Button = $HUD/tips
onready var _tip_text = $HUD/RichTextLabel

var level_number = 0 setget _set_lvl_num
var num_connections = 0 setget _number_of_connections
var min_num_conns = 0 setget _set_min_conns

var tip1 = "Tip 1: Aprovecha que cada línea tiene su propio color."
var tip2 = "Tip 2: A veces se puede buscar el camino más corto hasta un punto anterior y desde ahí seguir."
var tip3 = "Tip 3: Algunas conexiones recorren más distancia que otras."

var tips = [tip1, tip2, tip3]

# Called when the node enters the scene tree for the first time.
func _ready():
	_menu_button.connect("button_down", self, '_menu_button_pressed')
	_menu_button.mouse_filter = Control.MOUSE_FILTER_STOP
	_menu_button.add_stylebox_override("hover", _menu_button.get_stylebox('normal'))
	_tip_button.add_stylebox_override("hover", _menu_button.get_stylebox('normal'))
	_tip_button.mouse_filter = Control.MOUSE_FILTER_STOP

var _frames_passed = 0
func _physics_process(delta):
	if manager.player_tried_to_win:
		var tip = randi() % 3
		_tip_text.text = tips[tip]
		_tip_text.visible = true
		_frames_passed = 0
	else:
		_frames_passed += 1 % 3601
	
	if _frames_passed == 600:
		_tip_text.visible = false

# Despliega el menú
func _menu_button_pressed():
	audio.play()
	yield(audio, "finished")
	get_tree().change_scene("res://scenes/NivelesCamino.tscn")

func _set_lvl_num(new_number):
	level_number = new_number
	_level_number_label.text = "Nivel %d"	 % new_number

func _number_of_connections(number_of_stations):
	num_connections = number_of_stations
	_stations_label.text = 'Conexiones: %d/%d' % [num_connections, min_num_conns]

func _set_min_conns(min_number):
	min_num_conns = min_number
	_stations_label.text = 'Conexiones: %d/%d' % [num_connections, min_num_conns]

func stop_music():
	background_music.stop()
