extends Node2D

var spawner_scene: PackedScene = preload("res://scenes/vehicles/vehicle_spawner.tscn")
var frog_scene: PackedScene = preload("res://scenes/player/frog.tscn")

var frog: CharacterBody2D
var spawners: Array = []
var safe_spots: Array = []

const AVENUE_Y_START: float = 150.0
const AVENUE_HEIGHT: float = 400.0
const FROG_SPAWN_Y: float = 600.0

func _ready():
	call_deferred("setup_level")
	if not GameManager.game_over.is_connected(_on_game_over):
		GameManager.game_over.connect(_on_game_over)
	if not GameManager.level_changed.is_connected(_on_level_changed):
		GameManager.level_changed.connect(_on_level_changed)

func setup_level():
	for child in get_children():
		if child.name != "Frog" and not child is Label:
			child.queue_free()
	spawners.clear()
	safe_spots.clear()
	
	var difficulty = GameManager.get_difficulty()
	var num_lanes = difficulty.lanes
	var base_speed = difficulty.speed
	var spawn_interval = difficulty.spawn_interval
	
	var lane_height = AVENUE_HEIGHT / num_lanes
	lane_height = clamp(lane_height, 50.0, 100.0)
	
	_draw_lane_lines(num_lanes, lane_height)
	_create_safe_spots()
	
	for i in range(num_lanes):
		var lane_y = AVENUE_Y_START + (i * lane_height) + (lane_height * 0.5)
		var dir = 1 if i % 2 == 0 else -1
		var speed_variation = randf_range(0.8, 1.2)
		
		var spawner = spawner_scene.instantiate()
		spawner.setup(base_speed * speed_variation, dir, spawn_interval, lane_y)
		add_child(spawner)
		spawners.append(spawner)
	
	if not frog or not frog.is_inside_tree():
		frog = frog_scene.instantiate()
		frog.position = Vector2(960, FROG_SPAWN_Y)
		add_child(frog)
	else:
		frog.reset_to_start()
		frog.position = Vector2(960, FROG_SPAWN_Y)

func _create_safe_spots():
	var tile_width = 220.0
	var num_tiles = 6
	var curb_y = 50.0
	var curb_height = 100.0
	
	for i in range(num_tiles):
		var spot_x = (i * tile_width) + (tile_width * 0.5)
		var spot_y = curb_y + curb_height * 0.5
		
		var spot = Area2D.new()
		spot.position = Vector2(spot_x, spot_y)
		
		var shape = CollisionShape2D.new()
		var rect = RectangleShape2D.new()
		rect.size = Vector2(100.0, 80.0)
		shape.shape = rect
		spot.add_child(shape)
		
		spot.body_entered.connect(_on_frog_entered_safe_spot)
		spot.body_exited.connect(_on_frog_exited_safe_spot)
		spot.set_meta("is_safe", true)
		
		add_child(spot)
		safe_spots.append(spot)

func _on_frog_entered_safe_spot(body: Node2D):
	if body == frog and frog.is_alive:
		frog.in_safe_spot = true
		frog.is_alive = false
		frog.visible = false
		GameManager.add_score(50)
		var transition = get_tree().current_scene.get_node_or_null("ScreenTransition")
		if transition:
			await transition.fade_in(0.3)
		await get_tree().create_timer(0.3).timeout
		GameManager.next_level()
		if transition:
			transition.fade_out(0.3)

func _on_frog_exited_safe_spot(body: Node2D):
	if body == frog:
		frog.in_safe_spot = false

func _on_level_changed(_new_level):
	setup_level()

func _on_game_over():
	for spawner in spawners:
		if spawner.is_inside_tree():
			spawner.queue_free()
	spawners.clear()

func _draw_lane_lines(num_lanes: int, lane_height: float):
	for i in range(num_lanes + 1):
		var line_y = AVENUE_Y_START + (i * lane_height)
		if line_y > AVENUE_Y_START + AVENUE_HEIGHT:
			break
		for x in range(0, 1920, 60):
			var dash = ColorRect.new()
			dash.color = Color(0.8, 0.8, 0.0)
			dash.size = Vector2(30, 3)
			dash.position = Vector2(x, line_y)
			dash.z_index = -1
			add_child(dash)
