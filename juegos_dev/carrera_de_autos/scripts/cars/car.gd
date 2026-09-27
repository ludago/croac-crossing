extends CharacterBody2D
class_name Car

@export var car_color: Color = Color.RED
@export var max_speed: float = 400.0
@export var acceleration: float = 800.0
@export var friction: float = 600.0
@export var turn_speed: float = 3.0
@export var drift_factor: float = 0.95

var speed: float = 0.0
var direction: float = 0.0
var is_drifting: bool = false
var lap: int = 0
var lap_progress: float = 0.0
var checkpoint_count: int = 0
var total_checkpoints: int = 0
var finished: bool = false
var player_id: int = 0
var race_timer: float = 0.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var trail: Line2D = $Trail

func _ready() -> void:
	_create_car_sprite()
	_create_collision_shape()
	if trail:
		trail.clear_points()

func _create_car_sprite() -> void:
	if not sprite:
		sprite = Sprite2D.new()
		sprite.name = "Sprite2D"
		add_child(sprite)

	var image = Image.create(40, 24, false, Image.FORMAT_RGBA8)
	image.fill(car_color)

	for x in range(8, 32):
		for y in range(4, 20):
			if x < 14 or x > 26:
				if y > 6 and y < 18:
					image.set_pixel(x, y, car_color.darkened(0.3))

	for x in range(36, 40):
		for y in range(6, 10):
			image.set_pixel(x, y, Color.YELLOW)
		for y in range(14, 18):
			image.set_pixel(x, y, Color.YELLOW)

	for x in range(4, 12):
		for y in range(0, 4):
			image.set_pixel(x, y, Color.BLACK)
		for y in range(20, 24):
			image.set_pixel(x, y, Color.BLACK)
	for x in range(28, 36):
		for y in range(0, 4):
			image.set_pixel(x, y, Color.BLACK)
		for y in range(20, 24):
			image.set_pixel(x, y, Color.BLACK)

	var texture = ImageTexture.create_from_image(image)
	sprite.texture = texture
	sprite.rotation = -PI / 2

func _create_collision_shape() -> void:
	var collision = get_node_or_null("CollisionShape2D")
	if not collision:
		collision = CollisionShape2D.new()
		collision.name = "CollisionShape2D"
		add_child(collision)

	var shape = RectangleShape2D.new()
	shape.size = Vector2(20, 36)
	collision.shape = shape

func _physics_process(delta: float) -> void:
	if finished:
		return

	race_timer += delta
	_handle_input(delta)
	_apply_movement(delta)
	move_and_slide()
	_update_trail()

func _handle_input(delta: float) -> void:
	if Input.is_action_pressed("move_up"):
		speed = move_toward(speed, max_speed, acceleration * delta)
	elif Input.is_action_pressed("move_down"):
		speed = move_toward(speed, -max_speed * 0.5, acceleration * delta)
	else:
		speed = move_toward(speed, 0, friction * delta)

	if speed != 0:
		var turn_amount = turn_speed * delta * (speed / max_speed)
		if Input.is_action_pressed("move_left"):
			direction -= turn_amount
		if Input.is_action_pressed("move_right"):
			direction += turn_amount

	is_drifting = Input.is_action_pressed("brake") and abs(speed) > 100

func _apply_movement(_delta: float) -> void:
	velocity = Vector2.from_angle(direction) * speed

	if is_drifting:
		velocity = velocity.rotated(randf_range(-0.1, 0.1))

	if sprite:
		sprite.rotation = direction - PI / 2

func _update_trail() -> void:
	if trail and abs(speed) > 50:
		trail.add_point(global_position)
		if trail.get_point_count() > 50:
			trail.remove_point(0)
	elif trail and abs(speed) <= 50:
		if trail.get_point_count() > 0:
			trail.remove_point(0)

func get_speed_kmh() -> int:
	return int(abs(speed) * 0.36)

func get_race_time() -> String:
	var mins = int(race_timer) / 60
	var secs = int(race_timer) % 60
	var ms = int(fmod(race_timer, 1.0) * 100)
	return "%02d:%02d.%02d" % [mins, secs, ms]

func reset_car(pos: Vector2, rot: float) -> void:
	global_position = pos
	direction = rot
	speed = 0
	lap = 0
	checkpoint_count = 0
	finished = false
	race_timer = 0.0
	if trail:
		trail.clear_points()

func _on_checkpoint_reached(checkpoint_id: int) -> void:
	if checkpoint_id == checkpoint_count:
		checkpoint_count += 1

func _on_lap_completed() -> void:
	lap += 1
	checkpoint_count = 0
