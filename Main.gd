extends Node2D
const TOTAL_ROUNDS: int = 5
var round_label: Label
var hp_label: Label
var hp: int = 3

func _ready() -> void:
	# Round display
	round_label = Label.new()
	round_label.position = Vector2(10, 10)
	add_child(round_label)
	# HP display
	hp_label = Label.new()
	var screen_size = get_viewport_rect().size
	hp_label.position = Vector2(screen_size.x - 100, 10)
	hp_label.text = "HP: %d" % hp
	add_child(hp_label)
	# Center player
	$Player.position = screen_size / 2
	# Connect round signals
	var round_manager = $RoundManager
	round_manager.round_started.connect(_on_round_started)
	round_manager.start_rounds()
	# Connect player hit
	$Player.hit.connect(_on_player_hit)

func _on_round_started(text: String) -> void:
	round_label.text = text

func _on_player_hit() -> void:
	hp -= 1
	hp_label.text = "HP: %d" % hp
	if hp <= 0:
		round_label.text = "Game Over!"
		$Player.queue_free()

func _input(event: InputEvent) -> void:
	if hp <= 0 and event is InputEventKey and event.pressed:
		get_tree().reload_current_scene()
