extends Area2D
@export var speed: int = 100
@onready var bullet_timer: Timer = $BulletTimer
signal died

func _ready() -> void:
	bullet_timer.timeout.connect(_on_BulletTimer_timeout)
	body_entered.connect(_on_Enemy_body_entered)
	bullet_timer.start()

func _process(delta: float) -> void:
	position.y += speed * delta
	if position.y > 650:
		queue_free()

func _on_BulletTimer_timeout() -> void:
	_shoot_pattern()

@onready var bullet_container: Node2D = get_tree().get_current_scene().get_node("BulletContainer")

func _shoot_pattern() -> void:
	var BulletScene: PackedScene = preload("res://EnemyBullet.tscn")
	var count: int = 8
	for i in range(count):
		var angle: float = deg_to_rad(360 * i / count)
		var b: Area2D = BulletScene.instantiate()
		b.position = position
		b.velocity = Vector2(cos(angle), sin(angle)) * 200
		bullet_container.add_child(b)  # use scene root container


func _on_Enemy_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		body.take_damage()
		_die()

func _die() -> void:
	emit_signal("died")
	queue_free()
