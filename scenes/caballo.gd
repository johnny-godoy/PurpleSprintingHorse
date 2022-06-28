extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var _iteraciones = 0
var _fps_per_percent
var _show_text = false
var _percent_increase
var finished = false
var _waiting_list = []
var default_fpspp = 1
var default_percent_increase = 0.009

signal frame_passed
signal finished_prompt
signal user_ended_prompt

onready var text_box : RichTextLabel = $horse_overlay/PanelContainer/TextBox/RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _physics_process(_delta):
	emit_signal('frame_passed')
	
func _input(event):
	if event.is_action_pressed("click"):
		if text_box.percent_visible !=1:
			text_box.percent_visible = 1
		else:
			emit_signal('user_ended_prompt')
		
	elif event.is_action_pressed("ui_accept"):
		prompt_text('Apretaste ui_accept y ahora estas leyendo el texto de ejemplo.')
		prompt_text('Esto es mas texto, mira como cambia el tempo (manualmente)', 2)
		prompt_text('Este tempo es de software 123456789.')
		

func _prompt_text(text_to_prompt, fps_per_percent, percent_increase):
	
	_waiting_list.append(text_to_prompt)
	
	if len(_waiting_list) != 1:
		while _waiting_list[0] != text_to_prompt:
			yield(self, 'finished_prompt')
		
	text_box.percent_visible = 0
	_fps_per_percent = fps_per_percent
	text_box.text = text_to_prompt
	_show_text = true
	finished = false
	_iteraciones = 0
	_percent_increase = percent_increase
	
	while not finished:
		if text_box.percent_visible < 1 and _show_text:
			if _iteraciones == _fps_per_percent:
				text_box.percent_visible += _percent_increase
		elif text_box.percent_visible == 1:
			_show_text = false
			finished = true
			
		if _show_text:
			_iteraciones = (_iteraciones + 1) % (_fps_per_percent + 1)
		
		yield(self, 'frame_passed')
	
	
	yield(self, 'user_ended_prompt')
	_waiting_list.pop_front()
	emit_signal('finished_prompt')

func prompt_text(text_to_prompt, fps_per_percent=default_fpspp, percent_increase=default_percent_increase):
	yield(_prompt_text(text_to_prompt, fps_per_percent, percent_increase), "completed")

func prompt_iterables(iterable_object):
	
	if not typeof(iterable_object) in [TYPE_ARRAY, TYPE_DICTIONARY]:
		print('Invalid object given to the function "prompt_list"')
		
	if iterable_object is Dictionary:
		for key in iterable_object.keys():
			var args = iterable_object[key]
			var fpspp = default_fpspp
			var pi = default_percent_increase
			if typeof(args) == TYPE_ARRAY and len(args) == 2:
				
				if typeof(args[0]) == TYPE_INT:
					fpspp = args[0]
				
				if typeof(args[1]) == TYPE_REAL and args[1] < 1:
					pi = args[1]
					
			yield(_prompt_text(key, fpspp, pi), "completed")
			
	elif iterable_object is Array:
		for data in iterable_object:
			var fpspp = default_fpspp
			var pi = default_percent_increase
			var text
			if typeof(data) == TYPE_ARRAY:
				text = data[0]
				
				if len(data) >=2 and typeof(data[1]) == TYPE_INT:
					fpspp = data[1]
					
				if len(data) == 3 and typeof(data[2]) == TYPE_REAL and data[2] < 1:
					pi = data[2]
			else:
				text = data
				
			yield(_prompt_text(text, fpspp, pi), "completed")
