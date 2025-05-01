extends Node
signal round_started(text: String)
const TOTAL_ROUNDS: int = 5
@export var initial_spawn_offset: int = -50
var current_round: int = 0

func start_rounds() -> void:
	current_round = 1
	_start_round()

func _start_round() -> void:
	emit_signal("round_started", "Round %d/%d" % [current_round, TOTAL_ROUNDS])
	_spawn_wave(current_round)

func _spawn_wave(round_num: int) -> void:
	var EnemyScene: PackedScene = preload("res://Enemy.tscn")
	var count: int = round_num * 2 + 3
	for i in range(count):
		var enemy: Area2D = EnemyScene.instantiate()
		enemy.position = Vector2(randf_range(50, 750), initial_spawn_offset)
		get_parent().get_node("EnemyContainer").add_child(enemy)
	set_process(true)

func _process(delta: float) -> void:
	var enemy_count: int = get_parent().get_node("EnemyContainer").get_child_count()
	if enemy_count == 0:
		set_process(false)
		if current_round < TOTAL_ROUNDS:
			current_round += 1
			_start_round()
		else:
			emit_signal("round_started", "Game Over!")
