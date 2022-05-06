extends Camera2D

var man = ShortestPathManager
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	var local = get_local_mouse_position()
	var station_pos = get_parent().get_node("rome_subway/rome_subway/sp_red_1").position
	var m_pos = get_global_mouse_position()
	if Input.is_action_just_pressed("temp"):

		zoom = zoom + Vector2(0.1, 0.1)
		print(zoom)
		print("Mouse pos: G" + str(m_pos) + " L" + str(local) + " station_pos: " + str(station_pos))
		
	if Input.is_action_just_pressed("zoom_out"):
		zoom = zoom - Vector2(0.1, 0.1)
		print(zoom)
		print("Mouse pos: " + str(m_pos) + "station_pos: " + str(station_pos))
		
	if Input.is_action_just_pressed("click"):
		print(zoom)
		print("Mouse pos: G" + str(m_pos) + " L" + str(local) + " station_pos: " + str(station_pos))
	
	man.zoo = zoom
