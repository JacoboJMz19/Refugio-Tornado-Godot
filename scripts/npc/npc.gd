extends CharacterBody2D
@export var speed: float = 85.0
var following = false
var follow_target = Vector2.ZERO
func _ready() -> void:
 add_to_group("person")
 add_to_group("interactable")
 collision_layer = 0
 collision_mask = 0
func _physics_process(_delta: float) -> void:
 if not GameManager.running or not following:
  return
 if global_position.distance_to(follow_target) > 15.0:
  velocity = global_position.direction_to(follow_target) * speed
 else:
  velocity = Vector2.ZERO
 move_and_slide()
