extends Camera2D

var manager = ShortestPathManager
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# https://www.gdquest.com/tutorial/godot/2d/camera-zoom/

# Lower cap for the `_zoom_level`.
export var min_zoom := 0.3
# Upper cap for the `_zoom_level`.
export var max_zoom := 1.1
# Controls how much we increase or decrease the `_zoom_level` on every turn of the scroll wheel.
export var zoom_factor := 0.1
# Duration of the zoom's tween animation.
export var zoom_duration := 0.2

# Ubicación corte superior de la cámara
export var top_position : float
# Ubicación corte inferior de la cámara
export var bottom_position : float
# Ubicación corte izquierdo de la cámara
export var left_position : float
# Ubicación corte derecho de la cámara
export var right_position : float

# For zoom/moving on PC
var dragging # For dragging
var mouse_start_pos
var screen_start_position
var og_screen_pos

# For zoom/moving on mobile
var touch_events = {}
var last_drag_distance = 0
var zoom_speed = 0.05

var og_diff_left
var og_diff_right
var og_diff_top
var og_diff_bottom

# The camera's target zoom level.
var _zoom_level := 1.0 setget _set_zoom_level

# We store a reference to the scene's tween node.
onready var tween: Tween = $Smoother

func _ready():
	og_screen_pos = position
	og_diff_left = position.x
	og_diff_right = get_viewport().size.x - position.x
	og_diff_top = position.y
	og_diff_bottom = get_viewport().size.y - position.y
	
# WITH WHEEL 
func _set_zoom_level(value: float):
	# We limit the value between `min_zoom` and `max_zoom`
	_zoom_level = clamp(value, min_zoom, max_zoom)
	# Then, we ask the tween node to animate the camera's `zoom` property from its current value
	# to the target zoom level.
	tween.interpolate_property(
		self,
		"zoom",
		zoom,
		Vector2(_zoom_level, _zoom_level),
		zoom_duration,
		tween.TRANS_SINE,
		# Easing out means we start fast and slow down as we reach the target value.
		tween.EASE_OUT
	)
	
	if _zoom_level == 1:
		tween.interpolate_property(
		self,
		"position",
		position,
		Vector2(og_screen_pos.x*max_zoom, og_screen_pos.y*max_zoom),
		zoom_duration,
		tween.TRANS_SINE,
		# Easing out means we start fast and slow down as we reach the target value.
		tween.EASE_OUT
		)
	tween.start()
	
func _input(event):
	
	##### MOBILE OPTIONS
	if event is InputEventScreenTouch:
		# Pasos:
		# - Revisar si se pusieron dos dedos
		# - De hacerlo revisar sus posiciones
		# - Si se separan -> Zoom de acercamiento, en caso contrario zoom de alejamiento según distancia
		# - 
		if event.pressed:
			touch_events[event.index] = event
			print('camera input')
		else:
			touch_events.erase(event.index)
		
	
	if event is InputEventScreenDrag and not manager.station_touched:
		
		touch_events[event.index] = event
		if touch_events.size() == 1:
			var new_pos = -zoom * event.relative + position
			_update_position(new_pos)
			# position += event.relative.rotated(rotation) * zoom.x
		# TODO: arreglar/customizar para valores nuestros (no genéricos)
		elif touch_events.size() == 2:
			var drag_distance = touch_events[0].position.distance_to(touch_events[1].position)
			if abs(drag_distance - last_drag_distance) > 10:
				var new_zoom = (1 + zoom_speed) if drag_distance < last_drag_distance else (1 - zoom_speed)
				_set_zoom_level(zoom.x * new_zoom)
				# new_zoom = clamp(zoom.x * new_zoom, min_zoom, max_zoom)
				# zoom = Vector2.ONE * new_zoom
				last_drag_distance = drag_distance
		
	##### MOUSE - PC OPTIONS
	if event.is_action("mouse_button"):
		if event.is_pressed():
			mouse_start_pos = event.position
			screen_start_position = position
			dragging = true
		else:
			dragging = false

	elif event is InputEventMouseMotion and dragging:
		var new_pos = zoom * (mouse_start_pos - event.position) + screen_start_position
		_update_position(new_pos)
		
	# Wheel zoom / move
	if event.is_action_pressed("zoom_in"):
		# Inside a given class, we need to either write `self._zoom_level = ...` or explicitly
		# call the setter function to use it.
		_set_zoom_level(_zoom_level - zoom_factor)

	elif event.is_action_pressed("zoom_out"):
		_set_zoom_level(_zoom_level + zoom_factor)

# Se le da una nueva posición y según eso se hace un clamp
func _update_position(new_position):
	top_position = max(position.y - zoom.y*og_diff_top, limit_top) ## IF TOP_POS == LIMIT
	bottom_position = min(position.y + zoom.y*og_diff_bottom, limit_bottom)
	left_position = max(position.x - zoom.x*og_diff_left, limit_left)
	right_position = min(position.x + zoom.x*og_diff_right, limit_right)
	
	var top_condition = limit_top == top_position and new_position.y < position.y
	var bot_condition = limit_bottom == bottom_position and new_position.y > position.y
	
	var left_condition = limit_left == left_position and new_position.x < position.x
	var right_condition = limit_right == right_position and new_position.x > position.x
	
	if top_condition or bot_condition:
		pass
	else:
		position.y = new_position.y
	
	if left_condition or right_condition:
		pass
	else:
		position.x = new_position.x
