extends Control
signal completed(score:int)
var phase="pre";var index=0;var score=0;var answered=false;var qs=[]
const PRE=[
 {"q":"¿Qué debes hacer cuando se emite una alerta de tornado?","a":["Buscar un refugio seguro","Acercarte a observarlo","Salir a conducir"],"c":0,"f":"Dirígete a un refugio interior y sigue las alertas oficiales."},
 {"q":"¿Cuál es un lugar más seguro durante un tornado?","a":["Habitación interior en el nivel más bajo","Debajo de un árbol","Un vehículo en campo abierto"],"c":0,"f":"Un espacio interior, bajo y alejado de ventanas ofrece mayor protección."},
 {"q":"¿Qué debes evitar durante un tornado?","a":["Ventanas y puertas exteriores","Un refugio interior","Una habitación sin ventanas"],"c":0,"f":"Los vidrios y objetos proyectados pueden causar lesiones."}]
const POST=[
 {"q":"Si estás en una casa durante un tornado, ¿dónde debes protegerte?","a":["En un sótano o habitación interior baja","En el balcón","Junto a una ventana"],"c":0,"f":"El sótano o una habitación interior en el nivel más bajo es preferible."},
 {"q":"¿Qué debes hacer si estás en un automóvil y se aproxima un tornado?","a":["Buscar un refugio resistente cercano","Estacionarte bajo un puente","Seguir la trayectoria del tornado"],"c":0,"f":"Un vehículo no es un refugio seguro; busca un edificio resistente si es posible."},
 {"q":"¿Cuándo es seguro salir del refugio?","a":["Cuando las autoridades indiquen que pasó el peligro","Cuando deje de llover","Cuando baje el viento unos segundos"],"c":0,"f":"Espera la confirmación oficial de que el peligro terminó."}]
func begin(p):phase=p;qs=PRE if p=="pre" else POST;index=0;score=0;visible=true;_show()
func _show():
 answered=false;$Card/VBox/Feedback.text="";$Card/VBox/Continue.hide();$Card/VBox/Title.text="CONOCIMIENTOS PREVIOS" if phase=="pre" else "EVALUACIÓN FINAL";$Card/VBox/Progress.text="Pregunta %d de 3"%[index+1];$Card/VBox/Question.text=qs[index].q
 for c in $Card/VBox/Options.get_children():c.queue_free()
 for i in qs[index].a.size():
  var b=Button.new();b.text=qs[index].a[i];b.custom_minimum_size.y=40;b.pressed.connect(_answer.bind(i));$Card/VBox/Options.add_child(b)
func _answer(i):
 if answered:return
 answered=true
 if i==qs[index].c:score+=1
 $Card/VBox/Feedback.text=qs[index].f
 for b in $Card/VBox/Options.get_children():b.disabled=true
 $Card/VBox/Continue.show();$Card/VBox/Continue.text="Continuar" if index<2 else "Finalizar"
func _on_continue_pressed():
 if not answered:return
 index+=1
 if index<3:_show()
 else:visible=false;completed.emit(score)
