extends Node
var music:AudioStreamPlayer
var ambience:AudioStreamPlayer
var effects:AudioStreamPlayer
func _ready():
 music=_player(-12);ambience=_player(-18);effects=_player(-3)
func _player(db):
 var p=AudioStreamPlayer.new();p.volume_db=db;add_child(p);return p
func start_ambience():
 music.stream=load("res://assets/audio/music/tema_refugio.wav");music.play()
 ambience.stream=load("res://assets/audio/ambient/viento.wav");ambience.play()
func effect(name):
 var path="res://assets/audio/effects/%s.wav"%name
 if ResourceLoader.exists(path):effects.stream=load(path);effects.play()
func stop_all():music.stop();ambience.stop()
