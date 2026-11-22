extends Area2D
@export var item_id="agua"
func _ready():
 add_to_group("interactable");add_to_group("world_item")
 $Sprite2D.texture=load("res://assets/items/%s.png"%item_id)
