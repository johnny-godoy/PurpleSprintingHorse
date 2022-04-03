extends Node2D

onready var current_color = null
onready var buckets = $ColorBuckets
onready var to_color = $ColoredNode


func _ready() -> void:
	for button in buckets.get_children():
		button.connect("pressed", self, "_on_Bucket_pressed", [button.modulate])
	to_color.connect("pressed", self, "_on_Node_pressed", [to_color])


func _on_Bucket_pressed(color: Color) -> void:
	current_color = color
	print("Color actual: ", current_color)


func _on_Node_pressed(button: Button) -> void:
	if current_color != null:
		button.modulate = current_color
