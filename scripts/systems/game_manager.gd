
extends Node

signal time_changed(value: int)
signal lives_changed(value: int)
signal rescued_changed(value: int)
signal game_finished

const GAME_DURATION = 180
const MAX_LIVES = 3
const MAX_RESCUES = 15
const MAX_NPCS = 15

var seconds_left: int = GAME_DURATION
var lives: int = MAX_LIVES
var rescued: int = 0
var running: bool = false
var finished: bool = false

var timer: Timer


func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.timeout.connect(_tick)
	add_child(timer)


func start_game() -> void:
	seconds_left = GAME_DURATION
	lives = MAX_LIVES
	rescued = 0
	running = true
	finished = false

	time_changed.emit(seconds_left)
	lives_changed.emit(lives)
	rescued_changed.emit(rescued)

	timer.start()


func _tick() -> void:
	if not running:
		return

	seconds_left = max(0, seconds_left - 1)
	time_changed.emit(seconds_left)

	if seconds_left == 0:
		finish_game()


func take_damage() -> void:
	if not running:
		return

	lives = max(0, lives - 1)
	lives_changed.emit(lives)

	if lives == 0:
		finish_game()


func register_rescue() -> bool:
	if not running or rescued >= MAX_RESCUES:
		return false

	rescued += 1
	rescued_changed.emit(rescued)
	return true


func get_elapsed_seconds() -> int:
	return GAME_DURATION - seconds_left


func get_elapsed_time() -> String:
	var total_seconds: int = get_elapsed_seconds()

	var minutes: int = int(total_seconds / 60)
	var seconds: int = total_seconds % 60

	return "%02d:%02d" % [minutes, seconds]


func finish_game() -> void:
	if finished:
		return

	finished = true
	running = false
	timer.stop()

	game_finished.emit()
