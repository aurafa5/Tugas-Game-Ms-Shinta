extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound

const SPEED = 300.0
const JUMP_VELOCITY = -850.0
var alive = true


func _physics_process(delta: float) -> void:
	
	if !alive:
		return
	#Add amination
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")

	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.play("jump")
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if direction == 1.0:
		animated_sprite_2d.flip_h = false
	if direction == -1.0:
		animated_sprite_2d.flip_h = true
		
func _ready() -> void:
	animated_sprite_2d.animation_finished.connect(_on_animation_finished)


func die() -> void:
	if !alive:
		return

	alive = false
	animated_sprite_2d.play("died")


func _on_animation_finished() -> void:
	if animated_sprite_2d.animation == "died":
		get_tree().reload_current_scene()
