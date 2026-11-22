extends Node2D
@export var speed: float = 36.0
var target = Vector2(120, 100)
var rng = RandomNumberGenerator.new()
var damage_timer = 0.0
func _ready() -> void:
 add_to_group("tornado")
 rng.randomize()
 position = Vector2(415,120)
 _choose_target()
func _process(delta: float) -> void:
 if not GameManager.running:
  return
 global_position = global_position.move_toward(target, speed * delta)
 damage_timer = maxf(0.0, damage_timer - delta)
 if global_position.distance_to(target) < 18.0:
  _choose_target()
 var p = get_tree().get_first_node_in_group("player")
 if p and global_position.distance_to(p.global_position) < 42.0 and damage_timer <= 0.0:
  GameManager.take_damage()
  AudioManager.effect("danio")
  damage_timer = 2.5
func _choose_target() -> void:
 target = Vector2(rng.randf_range(30,800),rng.randf_range(30,590))
