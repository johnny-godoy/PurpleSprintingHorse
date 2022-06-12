extends CanvasLayer

onready var menu_button: Button = $MenuButton
onready var next_level_button: Button = $NextLevelButton
onready var last_level_button: Button = $LastLevelButton
onready var level_label: Label = $LevelNumber
onready var to_color_label: Label = $ToColor
onready var colors_used_label: Label = $ColorsUsed
onready var errors_labels: Label = $Errors

var level = 0 setget _set_lvl
var to_color = 0 setget _set_to_color
var colors_used = 0 setget _set_colors_used
var errors = 0 setget _set_errors
var save_file = File.new()
var last_implemented_level = 4
var level_progress = 0
var progress_array
var min_colors


func _ready() -> void:
	# Configurando el botón de menú
	# warning-ignore:return_value_discarded
	menu_button.connect("button_down", self, '_scene_changer', ["res://scenes/MainMenu.tscn"])
	menu_button.mouse_filter = Control.MOUSE_FILTER_STOP
	menu_button.add_stylebox_override("hover", menu_button.get_stylebox('normal'))

	# Configurando los botones para cambiar de nivel
	# Siguiente nivel
	# warning-ignore:return_value_discarded
	next_level_button.connect("button_down", self, '_on_next_level_pressed')
	next_level_button.mouse_filter = Control.MOUSE_FILTER_STOP
	next_level_button.add_stylebox_override("hover", next_level_button.get_stylebox('normal'))
	# Nivel anterior
	# warning-ignore:return_value_discarded
	last_level_button.connect("button_down", self, '_on_last_level_pressed')
	last_level_button.mouse_filter = Control.MOUSE_FILTER_STOP
	last_level_button.add_stylebox_override("hover", last_level_button.get_stylebox('normal'))

	# Cargando el progreso de los niveles
	save_file.open("res://coloring/base/coloring_progress.dat", File.READ)
	progress_array = str2var(save_file.get_as_text())
	save_file.close()


func save_progress() -> void:
	progress_array[level - 1] = max(progress_array[level - 1], level_progress)
	save_file.open("res://coloring/base/coloring_progress.dat", File.WRITE)
	save_file.store_string(str(progress_array))
	save_file.close()


func _scene_changer(path) -> void:
	save_progress()
	# warning-ignore:return_value_discarded
	get_tree().change_scene(path)


func _on_next_level_pressed() -> void:
	_scene_changer("res://coloring/Level %d.tscn" % (level + 1))


func _on_last_level_pressed() -> void:
	_scene_changer("res://coloring/Level %d.tscn" % (level - 1))


func _set_lvl(new_number: int) -> void:
	level = new_number
	level_label.text = "Nivel: %d" % level


func _set_to_color(new_number: int) -> void:
	to_color = new_number
	to_color_label.text = "Por colorear: %d" % to_color
	if to_color == 0:
		to_color_label.add_color_override("font_color", Color(0, 0, 0, 1))
	else:
		to_color_label.add_color_override("font_color", Color(1, 0, 0, 1))


func _set_colors_used(new_number: int) -> void:
	colors_used = new_number
	colors_used_label.text = "Colores usados: %d/%d" % [colors_used, min_colors]
	if colors_used <= min_colors:
		colors_used_label.add_color_override("font_color", Color(0, 0, 0, 1))
	else:
		colors_used_label.add_color_override("font_color", Color(1, 0, 0, 1))


func _set_errors(new_number: int) -> void:
	errors = new_number
	errors_labels.text = "Errores: %d" % errors
	if errors == 0:
		errors_labels.add_color_override("font_color", Color(0, 0, 0, 1))
	else:
		errors_labels.add_color_override("font_color", Color(1, 0, 0, 1))
