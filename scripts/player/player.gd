extends CharacterBody2D
@export var walk_speed: float = 40.0
@export var run_speed: float = 70.0
var inventory: Array[String] = []
var followers: Array[Node2D] = []
func _ready() -> void:
 add_to_group("player")
func _physics_process(_delta: float) -> void:
 if not GameManager.running:
  velocity = Vector2.ZERO
  return
 var direction = Input.get_vector("move_left","move_right","move_up","move_down")
 if direction.x != 0.0:
  direction.y = 0.0
 velocity = direction * (run_speed if Input.is_action_pressed("run") else walk_speed)
 move_and_slide()
 for i in range(followers.size()):
  if is_instance_valid(followers[i]):
   followers[i].follow_target = global_position + Vector2(-18.0 * (i + 1), 18.0)
func _unhandled_input(event: InputEvent) -> void:
 if not GameManager.running:
  return
 if event.is_action_pressed("interact"):
  interact()
 if event.is_action_pressed("drop_item"):
  drop_item()
func interact() -> void:
 var nearest: Node2D = null
 var distance = 46.0
 for node in get_tree().get_nodes_in_group("interactable"):
  if not is_instance_valid(node):
   continue
  if node.is_in_group("person") and node.following:
   continue
  var d = global_position.distance_to(node.global_position)
  if d < distance:
   nearest = node
   distance = d
 if nearest == null:
  _message("Acércate a un objeto o persona y pulsa E")
  return
 if nearest.is_in_group("world_item"):
  if inventory.size() >= 5:
   _message("Inventario lleno (5/5)")
   return
  inventory.append(nearest.item_id)
  nearest.queue_free()
  AudioManager.effect("recoger")
  get_node("/root/Main/Interface/HUD").inventory(inventory)
 elif nearest.is_in_group("person"):
  if followers.size() >= 4 or GameManager.rescued + followers.size() >= GameManager.MAX_RESCUES:
   _message("Capacidad de rescate: 4")
   return
  nearest.following = true
  followers.append(nearest)
  AudioManager.effect("rescate")
  _message("Personas acompañando: %d/4" % followers.size())
func drop_item() -> void:
 if inventory.is_empty():
  return
 var item_name = inventory.pop_back()
 var scene = load("res://scenes/objects/WorldItem.tscn")
 var item = scene.instantiate()
 item.item_id = item_name
 item.global_position = global_position + Vector2(0, 22)
 get_node("/root/Main/WorldRoot/World/Objects").add_child(item)
 AudioManager.effect("soltar")
 get_node("/root/Main/Interface/HUD").inventory(inventory)
func deliver_people(body: Node2D) -> void:
 if body != self or not GameManager.running:
  return
 for n in followers:
  if is_instance_valid(n) and GameManager.register_rescue():
   n.queue_free()
 followers.clear()
 _message("Refugio: %d/15 personas a salvo" % GameManager.rescued)
 if GameManager.rescued >= GameManager.MAX_RESCUES:
  GameManager.finish_game()
func _message(msg: String) -> void:
 get_node("/root/Main/Interface/HUD").message(msg)
