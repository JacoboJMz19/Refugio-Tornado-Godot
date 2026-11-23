extends Control

const GAME_SCENE := "res://scenes/main/Main.tscn"
@onready var info: AcceptDialog = $InfoDialog

func _ready() -> void:
	$Play.pressed.connect(_play)
	$HowTo.pressed.connect(_how_to)
	$Options.pressed.connect(_options)
	$Scores.pressed.connect(_scores)
	$Exit.pressed.connect(_exit)

func _play() -> void:
	get_tree().change_scene_to_file(GAME_SCENE)

func _how_to() -> void:
	info.title = "Cómo jugar"
	info.dialog_text = "WASD / Flechas: moverse\nShift: correr\nE: recoger objetos y ayudar a personas\nQ: soltar objetos\n\nRescata personas, llévalas al refugio y evita el tornado. Tienes seis minutos."
	info.popup_centered()

func _options() -> void:
	info.title = "Opciones"
	info.dialog_text = "Los controles y el volumen se configuran desde el proyecto Godot."
	info.popup_centered()

func _scores() -> void:
	info.title = "Puntajes"
	info.dialog_text = "Los resultados de conocimiento se muestran al terminar la partida. No hay una clasificación histórica guardada todavía."
	info.popup_centered()

func _exit() -> void:
	if OS.has_feature("web"):
		info.title = "Salir"
		info.dialog_text = "Puedes cerrar esta pestaña del navegador para salir."
		info.popup_centered()
	else:
		get_tree().quit()
