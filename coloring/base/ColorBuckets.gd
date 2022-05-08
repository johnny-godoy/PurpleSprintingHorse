extends HBoxContainer

var current_color = Color(1, 1, 1, 1)


func _ready():
	# Inicializando las cubetas
	for button in self.get_children():
		button.connect("pressed", self, "_on_Bucket_pressed", [button.modulate])


func _on_Bucket_pressed(color: Color) -> void:
	current_color = color
