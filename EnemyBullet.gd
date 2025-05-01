extends Area2D
@export var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	body_entered.connect(_on_EnemyBullet_body_entered)

func _process(delta: float) -> void:
	position += velocity * delta
	if position.x < 0 or position.x > 800 or position.y < 0 or position.y > 600:
		queue_free()

func _on_EnemyBullet_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		body.take_damage()
		queue_free()
