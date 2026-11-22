extends Node2D
const WORLD = preload("res://scenes/world/World.tscn")
const PLAYER = preload("res://scenes/player/Player.tscn")
const TORNADO = preload("res://scenes/tornado/Tornado.tscn")
const HUD = preload("res://scenes/ui/HUD.tscn")
const TRIVIA = preload("res://scenes/ui/Trivia.tscn")
const RESULTS = preload("res://scenes/ui/Results.tscn")
var phase = "pre"
var pre_score = 0
var post_score = 0
func _ready() -> void:
 var world = WORLD.instantiate()
 $WorldRoot.add_child(world)
 var player = PLAYER.instantiate()
 $PlayerRoot.add_child(player)
 world.get_node("Shelter").body_entered.connect(player.deliver_people)
 var tornado = TORNADO.instantiate()
 world.get_node("Tornado").add_child(tornado)
 $Interface.add_child(HUD.instantiate())
 var quiz = TRIVIA.instantiate()
 $Interface.add_child(quiz)
 quiz.completed.connect(_quiz_done)
 $Interface.add_child(RESULTS.instantiate())
 GameManager.game_finished.connect(_game_over)
 AudioManager.start_ambience()
 quiz.begin("pre")
func _quiz_done(score: int) -> void:
 if phase == "pre":
  pre_score = score
  phase = "playing"
  GameManager.start_game()
  AudioManager.effect("sirena")
 elif phase == "post":
  post_score = score
  phase = "results"
  $Interface/Results.show_scores(pre_score,post_score)
func _game_over() -> void:
 if phase != "playing":
  return
 phase = "post"
 $Interface/Trivia.begin("post")
 AudioManager.stop_all()
