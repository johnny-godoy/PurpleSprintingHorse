extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var main_object = get_parent().get_node("Deslizable")
onready var objective_object = get_parent().get_node("Deslizable2")

var reset_scale = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	
	var distance
	
	if main_object.in_object:
	
		distance = position.distance_to(get_global_mouse_position())
		var angle = int(position.angle_to_point(get_global_mouse_position())*180/PI - 180) % 360
		
		rotation_degrees = angle
		
		scale.x = distance/ 64
		# 64 is Harcoded, is the default number of pixels when scale.x = 1
	else:
		if reset_scale:
			scale.x = 0
			get_parent().modulate = "#ffffff"
		elif objective_object.what_what:
			get_parent().modulate = "#3ac851"
	
	if distance:
		if objective_object.what_what:
			reset_scale = false
		else:
			reset_scale = true
			
			
	#if main_object.in_object and distance:
	#	if not objective_object.what_what:
	#		scale.x = 0
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
