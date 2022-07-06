extends Node2D

func _ready():
	var instruction_overlay = $Horse_Overlay
	var texto_bienvenida = '¡Felicidades en completar el nivel anterior!.'

	var script = ['En la esquina verás en cuantos colores es posible terminar los niveles, pero puedes avanzar si es que te toma un color más',
	'¡Intenta terminarlos en la menor cantidad de colores para tener una puntuación perfecta!',
	'Bueno, ahora te dejaré que sigas. Éxito pintando']

	yield(instruction_overlay.prompt_text(texto_bienvenida), "completed")
	yield(instruction_overlay.prompt_iterables(script), "completed")
	instruction_overlay.visible = false
