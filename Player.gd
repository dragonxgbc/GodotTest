extends CharacterBody2D
signal hit
@export var speed: int = 300

func _physics_process(delta: float) -> void:
	var input_dir: Vector2 = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	# Use Python-style ternary in GDScript 2.0
	velocity = input_dir.normalized() * speed if input_dir != Vector2.ZERO else Vector2.ZERO
	move_and_slide()

func take_damage() -> void:
	emit_signal("hit")
