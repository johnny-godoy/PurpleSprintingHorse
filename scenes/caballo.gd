extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var __texto_ejemplo = "Hola soy bojack, quieres jugar un juego? Esto será un crossover episode..."
var _iteraciones = 0
var _fps_per_percent
var _show_text = false
var _percent_increase
var finished = false
var prompt_running = false

signal frame_passed
signal bye_text
signal finished_prompt

onready var t = Timer.new()
onready var text_box : RichTextLabel = $PanelContainer/TextBox/RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _physics_process(delta):
	emit_signal('frame_passed')
	
func _input(event):
	if event.is_action_pressed("click"):
		if text_box.percent_visible == 1:
			emit_signal('bye_text')
			return
		
		if prompt_running:
			text_box.percent_visible = 1
		
	elif event.is_action_pressed("ui_accept"):
		prompt_text(__texto_ejemplo)
		prompt_text('asdhjaskjdaksjhdkas')
		

func prompt_text(text_to_prompt, fps_per_percent=1, percent_increase=0.009):
	
	# NO FUNCIONA, HAY QUE ARREGLAR
	
	if prompt_running:
		yield(self, 'finished_prompt')
		print('started_from_running')
	
	text_box.percent_visible = 0
	_fps_per_percent = fps_per_percent
	text_box.text = text_to_prompt
	_show_text = true
	finished = false
	_iteraciones = 0
	_percent_increase = percent_increase
	prompt_running = true
	
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
	
	yield(self, 'bye_text')
	prompt_running = false
	emit_signal('finished_prompt')
