extends Control
func show_scores(a,b):
 $Panel/Label.text="CONOCIMIENTOS PREVIOS: %d/3\nEVALUACIÓN FINAL: %d/3\n\n"%[a,b]+("Mejoraste %d respuesta(s)."%(b-a) if b>a else ("Mantuviste tu resultado." if b==a else "Repasa las recomendaciones de seguridad."));show()
