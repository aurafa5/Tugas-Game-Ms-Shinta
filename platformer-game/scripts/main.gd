extends Node2D

@onready var score_label: Label = $CanvasLayer/Panel/ScoreLabel

var score = 0


func _ready() -> void:
	_setup_level()
	update_score()


func _process(delta: float) -> void:
	pass


func _setup_level() -> void:
	var enemies = $LevelRoot.get_node_or_null("Enemies")

	if enemies:
		for enemy in enemies.get_children():
			enemy.player_died.connect(_on_player_died)


func _on_player_died(body):
	print("Player Killed")
	body.die()


func add_score(amount: int) -> void:
	score += amount
	update_score()


func update_score() -> void:
	score_label.text = "Score: " + str(score)
