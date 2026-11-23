
extends Node

var music: AudioStreamPlayer
var ambience: AudioStreamPlayer
var effects: AudioStreamPlayer

const MUSIC_PATH = "res://assets/audio/music/tema_refugio.wav"
const WIND_PATH = "res://assets/audio/ambient/viento.wav"
const EFFECTS_PATH = "res://assets/audio/effects/"

func _ready() -> void:
	music = _player(-12.0)
	ambience = _player(-18.0)
	effects = _player(-3.0)

	print("AudioManager inicializado")

func _player(db: float) -> AudioStreamPlayer:
	var p = AudioStreamPlayer.new()
	p.volume_db = db
	p.bus = "Master"
	add_child(p)
	return p

func _load_audio(path: String, loop_audio: bool = false) -> AudioStream:
	if not ResourceLoader.exists(path):
		push_error("No existe el audio: " + path)
		return null

	var stream = load(path)

	if stream == null:
		push_error("No se pudo cargar: " + path)
		return null

	if loop_audio and stream is AudioStreamWAV:
		stream = stream.duplicate()
		stream.loop_mode = AudioStreamWAV.LOOP_FORWARD

	return stream

func start_ambience() -> void:
	var music_stream = _load_audio(MUSIC_PATH, true)
	var wind_stream = _load_audio(WIND_PATH, true)

	if music_stream != null:
		music.stream = music_stream
		music.play()
		print("Musica iniciada")

	if wind_stream != null:
		ambience.stream = wind_stream
		ambience.play()
		print("Viento iniciado")

func effect(name: String) -> void:
	var path = EFFECTS_PATH + name + ".wav"
	var sound = _load_audio(path)

	if sound == null:
		return

	var player = AudioStreamPlayer.new()
	player.bus = "Master"
	player.volume_db = -3.0
	player.stream = sound
	add_child(player)

	player.finished.connect(player.queue_free)
	player.play()

func stop_all() -> void:
	music.stop()
	ambience.stop()

	for child in get_children():
		if child is AudioStreamPlayer:
			if child != music and child != ambience and child != effects:
				child.stop()
				child.queue_free()
