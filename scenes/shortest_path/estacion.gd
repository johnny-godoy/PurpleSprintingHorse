extends Node2D


onready var deteccion = $AreaDeteccion
onready var manager = ShortestPathManager
onready var arm = $connecter

onready var estaciones_adyacentes = [self]

var boton_apretado = false
var i_have_arriving_path = false

# Called when the node enters the scene tree for the first time.
func _ready():
	deteccion.input_pickable = true
	deteccion.connect("mouse_entered", self, "_mouse_entered")
	deteccion.connect("input_event", self, "_clicked")

func _physics_process(delta):
	if manager.trying_to_connect and manager.current_station == self:
		if boton_apretado and not i_have_arriving_path:
			var distance
			
			distance = position.distance_to(get_global_mouse_position())
			var angle = int(position.angle_to_point(get_global_mouse_position())*180/PI - 180) % 360
				
			arm.rotation_degrees = angle
			arm.scale.x = distance/ 64
		
		else:
			i_have_arriving_path = false
			arm.scale.x = 0
			
	if Input.is_action_just_released("click"):
		boton_apretado = false
		
func _mouse_entered():
	if manager.trying_to_connect:
		if manager.current_station in estaciones_adyacentes:
			print("AA")

func _clicked(_viewport, event, _shape_idx):
	if InputMap.event_is_action(event, "click") && event.pressed:
		manager.trying_to_connect = true
		manager.current_station = self
		boton_apretado = true
		print("Activated")
		
	if InputMap.event_is_action(event, "click") && not event.pressed:
		if manager.trying_to_connect:
			if manager.current_station in estaciones_adyacentes:
				manager.reset_variables()
				i_have_arriving_path = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
