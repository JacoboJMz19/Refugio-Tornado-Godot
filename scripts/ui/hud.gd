
extends CanvasLayer

var player: Node2D
var tornado: Node2D

const MAX_LIVES: int = 3
const MAX_RESCUES: int = 15
const GAME_DURATION: int = 180


func _ready() -> void:
	GameManager.time_changed.connect(_time)
	GameManager.lives_changed.connect(_lives)
	GameManager.rescued_changed.connect(_rescued)

	_time(GameManager.seconds_left)
	_lives(GameManager.lives)
	_rescued(GameManager.rescued)


func _process(_delta: float) -> void:
	if not GameManager.running:
		return

	if not is_instance_valid(player):
		player = get_tree().get_first_node_in_group("player")

	if not is_instance_valid(tornado):
		tornado = get_tree().get_first_node_in_group("tornado")

	if player != null and tornado != null:
		var distance: float = player.global_position.distance_to(
			tornado.global_position
		)

		$Panel/VBox/Proximity.text = (
			"TORNADO: %d px" % int(distance)
		)

	if player != null:
		var qx: int = clampi(
			int(player.global_position.x / (831.0 / 4.0)),
			0,
			3
		)

		var qy: int = clampi(
			int(player.global_position.y / (623.0 / 4.0)),
			0,
			3
		)

		$Panel/VBox/Quadrant.text = (
			"CUADRANTE: %d/16" % (qy * 4 + qx + 1)
		)

		$MiniMap/Marker.position = Vector2(
			player.global_position.x / 831.0 * 166.0,
			player.global_position.y / 623.0 * 125.0
		)


func _time(v: int) -> void:
	$Panel/VBox/Time.text = (
		"TIEMPO %02d:%02d" % [int(v / 60), v % 60]
	)


func _lives(v: int) -> void:
	var lives_label: Label = $Panel/VBox/Lives

	if has_node("Panel/VBox/LivesContainer"):
		var hearts: HBoxContainer = $Panel/VBox/LivesContainer

		lives_label.text = "VIDAS"

		for i in range(hearts.get_child_count()):
			var heart: Control = hearts.get_child(i)
			heart.visible = i < v
	else:
		lives_label.text = "VIDAS %d/%d" % [v, MAX_LIVES]


func _rescued(v: int) -> void:
	$Panel/VBox/Rescued.text = (
		"RESCATADOS %d/%d" % [v, MAX_RESCUES]
	)


func inventory(items: Array[String]) -> void:
	$Panel/VBox/Inventory.text = (
		"MOCHILA %d/5: %s" %
		[items.size(), ", ".join(items)]
	)


func message(t: String) -> void:
	$Message.text = t
	$MessageTimer.start()


func _on_message_timer_timeout() -> void:
	$Message.text = ""
