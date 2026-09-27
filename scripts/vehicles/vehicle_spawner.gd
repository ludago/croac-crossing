extends Node2D

var spawn_interval: float = 2.0
var min_interval: float = 0.8
var max_interval: float = 3.0
var direction: int = 1
var lane_speed: float = 100.0
var lane_y: float = 0.0
var max_vehicles: int = 3

var vehicle_scene: PackedScene = preload("res://scenes/vehicles/car.tscn")
var spawn_timer: Timer

func _ready():
	spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.autostart = true
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	add_child(spawn_timer)
	
	for i in range(2):
		var vehicle = _create_vehicle()
		if direction > 0:
			vehicle.position.x = randf_range(-300, 800)
		else:
			vehicle.position.x = randf_range(960, 2220)
		vehicle.position.y = 0
		add_child(vehicle)

func _on_spawn_timer_timeout():
	if _count_vehicles() >= max_vehicles:
		return
	
	var vehicle = _create_vehicle()
	if direction > 0:
		vehicle.position.x = -100
	else:
		vehicle.position.x = 2020
	vehicle.position.y = 0
	add_child(vehicle)
	spawn_timer.wait_time = randf_range(min_interval, max_interval)

func _count_vehicles() -> int:
	var count = 0
	for child in get_children():
		if child is Area2D:
			count += 1
	return count

func _create_vehicle() -> Area2D:
	var vehicle = vehicle_scene.instantiate()
	
	var vehicle_types = ["car", "car", "car", "bus", "truck", "motorcycle", "sports_car", "pickup", "van"]
	var random_type = vehicle_types[randi() % vehicle_types.size()]
	
	var speed_multiplier = 1.0
	match random_type:
		"bus":
			speed_multiplier = 0.6
		"truck":
			speed_multiplier = 0.8
		"motorcycle":
			speed_multiplier = 1.4
	
	vehicle.setup(lane_speed * speed_multiplier, direction, random_type)
	return vehicle

func setup(p_speed: float, p_direction: int, p_interval: float, p_y: float):
	lane_speed = p_speed
	direction = p_direction
	spawn_interval = p_interval
	min_interval = p_interval * 0.5
	max_interval = p_interval * 1.5
	lane_y = p_y
	position.y = p_y
	
	if spawn_timer:
		spawn_timer.wait_time = spawn_interval
		spawn_timer.start()
