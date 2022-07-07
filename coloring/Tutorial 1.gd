extends Node2D

func _ready():
	var instruction_overlay = $Horse_Overlay
	var texto_bienvenida = '¡Hola!, yo soy el Caballo Púrpura.'

	var script = ['Estudio en la importante Academia Equina de Arte....pero necesito tu ayuda con mi tarea',
	'Debes pintar los círculos en la pantalla, ¡es fácil!.',
	'En tu caballete tienes una selección de colores, ¡elige los que más que gusten!',
	'Presiona un color para seleccionarlo, y luego presiona un círculo para pintarlo de ese color. Si quieres borrar un color, usa el blanco :)',
	'Hay una regla muy importante que no puedes olvidar: Si dos círculos están unidos por una línea, ¡no los puedes pintar del mismo color!',
	'Si te equivocas, la línea se volverá roja, indicando tu error',
	'Pero eso es suficiente charla, ¡vamos a divertirnos!']

	yield(instruction_overlay.prompt_text(texto_bienvenida), "completed")
	yield(instruction_overlay.prompt_iterables(script), "completed")
	instruction_overlay.visible = false
