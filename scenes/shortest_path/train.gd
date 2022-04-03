extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = 10

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_right"):
		position.x = position.x + 10
		
	if Input.is_action_pressed("ui_left"):
		position.x -= 10
		
	if Input.is_action_pressed("ui_up"):
		position.y = position.y - 10
		
	if Input.is_action_pressed("ui_down"):
		position.y += 10
		
	if Input.is_action_just_pressed("click"):
		rotation_degrees += 5
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
