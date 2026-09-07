extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.play("idle")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("COLLECTIBLE DIAMBIL")
		
		get_tree().current_scene.add_score(10)
		
		queue_free()
