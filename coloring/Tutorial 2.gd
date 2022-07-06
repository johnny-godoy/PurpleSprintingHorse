extends Node2D

func _ready():
	var instruction_overlay = $Horse_Overlay
	var texto_bienvenida = '¡Felicidades en completar el nivel anterior!.'

	var script = ['Como ves, es muy fácil terminar estas tareas si usas un color por cada círculo',
	'El desafío que te propongo ahora es hacerlo en la menor cantidad de colores que puedas',
	'¡Este nivel se puede hacer en 2 colores! A ver si encuentras la solución.']
	
	yield(instruction_overlay.prompt_text(texto_bienvenida), "completed")
	yield(instruction_overlay.prompt_iterables(script), "completed")
	instruction_overlay.visible = false
