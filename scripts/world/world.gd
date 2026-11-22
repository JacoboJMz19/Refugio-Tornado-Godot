extends Node2D
const NPC = preload("res://scenes/npc/NPC.tscn")
const ITEM = preload("res://scenes/objects/WorldItem.tscn")
const PEOPLE = [Vector2(88,145),Vector2(185,140),Vector2(280,165),Vector2(445,148),Vector2(612,160),Vector2(78,285),Vector2(180,286),Vector2(285,285),Vector2(465,285),Vector2(720,288),Vector2(100,398),Vector2(270,388),Vector2(385,382),Vector2(565,395),Vector2(665,475)]
const ITEMS = [Vector2(78,153),Vector2(195,151),Vector2(285,154),Vector2(565,170),Vector2(85,290),Vector2(210,292),Vector2(395,286),Vector2(630,290),Vector2(95,393),Vector2(315,395),Vector2(505,470),Vector2(720,490)]
const TYPES = ["linterna","agua","botiquin","vendas","baterias","comida"]
func _ready() -> void:
 for p in PEOPLE:
  var n = NPC.instantiate()
  n.position = p
  $NPCs.add_child(n)
 for i in range(ITEMS.size()):
  var o = ITEM.instantiate()
  o.position = ITEMS[i]
  o.item_id = TYPES[i % TYPES.size()]
  $Objects.add_child(o)
 # Obstáculos aproximados; conservan la textura original.
 var obstacles = [Rect2(42,35,105,111),Rect2(157,40,72,112),Rect2(237,31,158,121),Rect2(483,35,82,115),Rect2(33,187,105,91),Rect2(161,187,75,88),Rect2(254,187,141,92),Rect2(540,188,125,88),Rect2(35,302,200,82),Rect2(535,300,130,80),Rect2(34,396,243,100),Rect2(320,404,100,96),Rect2(493,400,174,66),Rect2(497,487,164,60),Rect2(684,490,79,65)]
 for rect in obstacles:
  var body = StaticBody2D.new()
  body.position = rect.position + rect.size / 2.0
  var collision = CollisionShape2D.new()
  var shape = RectangleShape2D.new()
  shape.size = rect.size
  collision.shape = shape
  body.add_child(collision)
  $Map/CollisionAreas.add_child(body)
