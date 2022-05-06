extends CanvasLayer

onready var menu_button: Button = $MenuButton
onready var level_label: Label = $LevelNumber
onready var to_color_label: Label = $ToColor
onready var colors_used_label: Label = $ColorsUsed
onready var errors_labels: Label = $Errors

var level = 0 setget _set_lvl
var to_color = 0 setget _set_to_color
var colors_used = 0 setget _set_colors_used
var errors = 0 setget _set_errors
var min_colors = 0 setget _set_min_colors


func _ready() -> void:
	# Configurando el botón de menú
	menu_button.connect("button_down", self, '_menu_button_pressed')
	menu_button.mouse_filter = Control.MOUSE_FILTER_STOP
	menu_button.add_stylebox_override("hover",
									  menu_button.get_stylebox('normal'))
	# Variables iniciales
	self.level = 1
	self.min_colors = 2
	self.colors_used = 0
	self.to_color = 3


func _menu_button_pressed() -> void:
	get_tree().change_scene("res://scenes/MainMenu.tscn")


func _set_lvl(new_number: int) -> void:
	level = new_number
	level_label.text = "Nivel: %d" % level


func _set_to_color(new_number: int) -> void:
	to_color = new_number
	to_color_label.text = "Por colorear: %d" % to_color


func _set_colors_used(new_number: int) -> void:
	colors_used = new_number
	colors_used_label.text = "Colores usados: %d/%d" % [colors_used, min_colors]


func _set_min_colors(new_number: int) -> void:
	min_colors = new_number
	colors_used_label.text = "Colores usados: %d/%d" % [colors_used, min_colors]


func _set_errors(new_number: int) -> void:
	errors = new_number
	errors_labels.text = "Errores: %d" % errors
