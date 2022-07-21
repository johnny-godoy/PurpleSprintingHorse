extends TextureButton

onready var audio = $AudioStreamPlayer
onready var manager = ShortestPathManager

export(String, FILE) var stream_file = "res://assets/sonido/menuhit.wav"
export(String, FILE) var next_scene = ""


func _ready() -> void:
	audio.stream = load(stream_file)
	self.connect("pressed", self, "on_button_pressed")


func on_button_pressed() -> void:
	audio.play()
	yield(audio, "finished")
	manager.restart_levels()
	texture_normal = load("res://assets/IconPack/IconPackByAndelRodis/pngonebyone/trashcanopen.png")
