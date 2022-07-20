class_name SoundButton
extends TextureButton

onready var audio = $AudioStreamPlayer

export(String, FILE) var stream_file = "res://assets/sonido/menuhit.wav"
export(String, FILE) var next_scene = ""


func _ready() -> void:
	audio.stream = load(stream_file)
	self.connect("pressed", self, "on_button_pressed")


func on_button_pressed() -> void:
	audio.play()
	yield(audio, "finished")
	if !next_scene.empty():
		get_tree().change_scene(next_scene)
