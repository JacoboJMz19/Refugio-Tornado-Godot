extends CanvasLayer
var player: Node2D
var tornado: Node2D
func _ready() -> void:
 GameManager.time_changed.connect(_time)
 GameManager.lives_changed.connect(_lives)
 GameManager.rescued_changed.connect(_rescued)
 _time(360)
 _lives(3)
 _rescued(0)
func _process(_delta: float) -> void:
 if not GameManager.running:
  return
 if player == null:
  player = get_tree().get_first_node_in_group("player")
 if tornado == null:
  tornado = get_tree().get_first_node_in_group("tornado")
 if player and tornado:
  var distance = player.global_position.distance_to(tornado.global_position)
  $Panel/VBox/Proximity.text = "TORNADO: %d px" % int(distance)
  var qx = clampi(int(player.global_position.x / (831.0 / 4.0)),0,3)
  var qy = clampi(int(player.global_position.y / (623.0 / 4.0)),0,3)
  $Panel/VBox/Quadrant.text = "CUADRANTE: %d/16" % (qy * 4 + qx + 1)
  $MiniMap/Marker.position = Vector2(player.global_position.x / 831.0 * 166.0, player.global_position.y / 623.0 * 125.0)
func _time(v: int) -> void:
 $Panel/VBox/Time.text = "TIEMPO %02d:%02d" % [int(v / 60),v % 60]
func _lives(v: int) -> void:
 $Panel/VBox/Lives.text = "VIDAS " + "♥ ".repeat(v)
func _rescued(v: int) -> void:
 $Panel/VBox/Rescued.text = "RESCATADOS %d/15" % v
func inventory(items: Array[String]) -> void:
 $Panel/VBox/Inventory.text = "MOCHILA %d/5: %s" % [items.size(),", ".join(items)]
func message(t: String) -> void:
 $Message.text = t
 $MessageTimer.start()
func _on_message_timer_timeout() -> void:
 $Message.text = ""
