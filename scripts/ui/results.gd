
extends Control

func show_scores(a: int, b: int) -> void:
	var tiempo: String = GameManager.get_elapsed_time()
	var rescatados: int = GameManager.rescued
	var vidas: int = GameManager.lives

	var resultado: String = ""

	if rescatados >= GameManager.MAX_RESCUES:
		resultado = "¡RESCATE COMPLETADO!"
	elif vidas <= 0:
		resultado = "¡TE QUEDASTE SIN VIDAS!"
	else:
		resultado = "¡SE AGOTÓ EL TIEMPO!"

	var aprendizaje: String = ""

	if b > a:
		aprendizaje = "Mejoraste %d respuesta(s)." % (b - a)
	elif b == a:
		aprendizaje = "Mantuviste tu resultado."
	else:
		aprendizaje = "Repasa las recomendaciones de seguridad."

	$Panel/Label.text = (
		resultado + "\n\n" +
		"PERSONAS RESCATADAS: %d/15\n" % rescatados +
		"TIEMPO UTILIZADO: %s\n" % tiempo +
		"VIDAS RESTANTES: %d/3\n\n" % vidas +
		"CONOCIMIENTOS PREVIOS: %d/3\n" % a +
		"EVALUACIÓN FINAL: %d/3\n\n" % b +
		aprendizaje
	)

	show()
