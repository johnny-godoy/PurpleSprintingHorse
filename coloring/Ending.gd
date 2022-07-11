extends Node2D

func _ready():
	var instruction_overlay = $Horse_Overlay
	var texto_bienvenida = 'Oh...hola.'

	var script = ['Tengo malas noticias, me van a expulsar de la Academia Equina de Arte...Por falta de integridad académica',
	'Las buenas noticias son que me conseguí un trabajo en construcción. ¡Deberías visitarme allá!',
	'Hmmm, aunque acá quedó un último desafío...']

	yield(instruction_overlay.prompt_text(texto_bienvenida), "completed")
	yield(instruction_overlay.prompt_iterables(script), "completed")
	instruction_overlay.visible = false
