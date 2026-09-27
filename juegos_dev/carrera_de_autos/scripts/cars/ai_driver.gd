extends Node
class_name AIDriver

@export var target_car: Car
@export var race_track: Node2D
@export var difficulty: float = 0.5

var waypoints: Array[Vector2] = []
var current_waypoint_index: int = 0
var look_ahead: float = 100.0
var steer_strength: float = 2.5
var throttle_noise: float = 0.0
var noise_timer: float = 0.0

func _ready() -> void:
	if race_track and race_track.has_method("get_waypoints"):
		waypoints = race_track.get_waypoints()

func _physics_process(delta: float) -> void:
	if not target_car or target_car.finished:
		return

	if waypoints.is_empty():
		_ai_simple_control(delta)
		return

	_ai_waypoint_control(delta)

func _ai_simple_control(delta: float) -> void:
	target_car.speed = move_toward(target_car.speed, target_car.max_speed * 0.8, 500 * delta)

	noise_timer += delta
	if noise_timer > 0.5:
		noise_timer = 0
		throttle_noise = randf_range(-0.3, 0.3)

	target_car.direction += sin(noise_timer * 2) * 0.02

func _ai_waypoint_control(delta: float) -> void:
	var car_pos = target_car.global_position
	var target_pos = waypoints[current_waypoint_index]

	var dist_to_waypoint = car_pos.distance_to(target_pos)

	if dist_to_waypoint < look_ahead:
		current_waypoint_index = (current_waypoint_index + 1) % waypoints.size()

	var desired_direction = car_pos.direction_to(target_pos)
	var angle_diff = desired_direction.angle() - target_car.direction

	while angle_diff > PI:
		angle_diff -= 2 * PI
	while angle_diff < -PI:
		angle_diff += 2 * PI

	var speed_factor = 1.0 - (difficulty * 0.3)
	noise_timer += delta
	throttle_noise = sin(noise_timer * 3) * (1.0 - difficulty) * 0.2

	target_car.speed = move_toward(
		target_car.speed,
		target_car.max_speed * speed_factor + throttle_noise * 100,
		600 * delta
	)

	if abs(angle_diff) > 0.1:
		if angle_diff > 0:
			target_car.direction += steer_strength * delta * difficulty
		else:
			target_car.direction -= steer_strength * delta * difficulty

	if abs(angle_diff) > 0.5 and abs(target_car.speed) > 200:
		target_car.is_drifting = true
	else:
		target_car.is_drifting = false

func set_waypoints(new_waypoints: Array[Vector2]) -> void:
	waypoints = new_waypoints
	current_waypoint_index = 0
