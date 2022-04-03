extends KinematicBody2D

#### FUNCIONALIDAD ACTUAL
# Es capaz de moverse si el mouse lo apreta, mientras el mouse se mantenga
# apretado se movera el Godot. Ademas detecta si hay colición con algun otro
# nodo.

var SPEED = 100
var ACCELERATION = 10

var pressed = false
var in_object = false
var changed_color = false
var same_collision = false

var what_what = false

var velocity = Vector2()

onready var TheShape = $CollisionShape2D
onready var shape_size = TheShape.shape.extents

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(_delta):
	
	# velocity = move_and_slide_with_snap(velocity, Vector2.UP)
	
	var who 
	
	var c_pos = global_position
	
	if Input.is_action_pressed("click") && not get_parent().is_something_moving:
		
		var shaperect = Rect2(c_pos.x - shape_size.x, c_pos.y - shape_size.y, shape_size.x*2, shape_size.y*2)
		
		if shaperect.has_point(get_global_mouse_position()):
			in_object = true
			get_parent().is_something_moving = true
			
	if in_object:
		who = move_and_collide(get_global_mouse_position() - c_pos)
		if is_instance_valid(who):
			
			if not same_collision:
			
				if not changed_color:
					instance_from_id(who.collider_id).get_node("Godot1").modulate = '#d53232'
					changed_color = true
				else:
					instance_from_id(who.collider_id).get_node("Godot1").modulate = '#ffffff'
					changed_color = false
				
				same_collision = true
				
		else:
			same_collision = false
		pass
		
	if Input.is_action_just_released("click"):
		in_object = false
		get_parent().is_something_moving = false
	
	if true:
		var shaperect = Rect2(c_pos.x - shape_size.x, c_pos.y - shape_size.y, shape_size.x*2, shape_size.y*2)
		
		if shaperect.has_point(get_global_mouse_position()):
			what_what = true
		else:
			what_what = false
