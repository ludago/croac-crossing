extends CharacterBody2D

signal died
signal reached_goal

@export var jump_distance: float = 64.0
@export var jump_duration: float = 0.15

var is_jumping: bool = false
var is_alive: bool = true
var in_safe_spot: bool = false
var spawn_position: Vector2
var jump_tween: Tween
var last_direction: Vector2 = Vector2.UP

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var jump_sound: AudioStreamPlayer = $JumpSound
@onready var death_sound: AudioStreamPlayer = $DeathSound
@onready var croak_sound: AudioStreamPlayer = $CroakSound

func _ready():
	spawn_position = position
	
	if not GameManager.touch_move.is_connected(_on_touch_move):
		GameManager.touch_move.connect(_on_touch_move)
	
	sprite.play("idle")

func _on_touch_move(direction: Vector2):
	if not is_alive or is_jumping:
		return
	last_direction = direction
	jump_to(position + direction * jump_distance)

func _physics_process(_delta):
	move_and_slide()
	
	if not is_alive or is_jumping:
		return
	
	var direction = Vector2.ZERO
	
	if Input.is_action_just_pressed("ui_up"):
		direction = Vector2.UP
	elif Input.is_action_just_pressed("ui_down"):
		direction = Vector2.DOWN
	elif Input.is_action_just_pressed("ui_left"):
		direction = Vector2.LEFT
	elif Input.is_action_just_pressed("ui_right"):
		direction = Vector2.RIGHT
	
	if direction != Vector2.ZERO:
		last_direction = direction
		jump_to(position + direction * jump_distance)

func _get_direction_suffix() -> String:
	if last_direction.x < 0:
		return "_left"
	elif last_direction.x > 0:
		return "_right"
	return ""

func _play_anim(anim_name: String):
	sprite.play(anim_name + _get_direction_suffix())

func jump_to(target_position: Vector2):
	if is_jumping:
		return
	
	if target_position.x < 32 or target_position.x > 1888:
		return
	if target_position.y < 32 or target_position.y > 688:
		return
	
	is_jumping = true
	_play_anim("jump")
	jump_sound.play()
	
	if jump_tween:
		jump_tween.kill()
	
	jump_tween = create_tween()
	jump_tween.set_parallel(false)
	
	var mid_position = position.lerp(target_position, 0.5) + Vector2(0, -8)
	jump_tween.tween_property(self, "position", mid_position, jump_duration * 0.5)
	jump_tween.tween_property(self, "position", target_position, jump_duration * 0.5)
	jump_tween.tween_callback(_on_jump_finished)

func _on_jump_finished():
	is_jumping = false
	_play_anim("idle")
	croak_sound.play()
	
	if position.y <= 150 and not in_safe_spot:
		die()

func die():
	if not is_alive:
		return
	if not is_inside_tree():
		return
	
	is_alive = false
	died.emit()
	
	if sprite and is_instance_valid(sprite):
		sprite.play("death")
	if death_sound and is_instance_valid(death_sound):
		death_sound.play()
	
	_screen_shake()
	
	modulate = Color.RED
	var death_tween = create_tween()
	death_tween.tween_property(self, "modulate", Color.RED, 0.1)
	death_tween.tween_property(self, "modulate", Color.WHITE, 0.1)
	death_tween.tween_property(self, "modulate", Color.RED, 0.1)
	death_tween.tween_property(self, "modulate", Color.WHITE, 0.1)
	death_tween.tween_callback(_on_death_finished)

func _screen_shake():
	var main = get_tree().current_scene
	if not main:
		return
	if main.has_method("shake_camera"):
		main.shake_camera()
	var transition = main.get_node_or_null("ScreenTransition")
	if transition and transition.has_method("flash_white"):
		transition.flash_white()

func _on_death_finished():
	GameManager.lose_life()
	if GameManager.is_game_active:
		respawn()

func respawn():
	position = spawn_position
	is_alive = true
	is_jumping = false
	in_safe_spot = false
	visible = true
	last_direction = Vector2.UP
	sprite.play("idle")

func reset_to_start():
	position = spawn_position
	is_alive = true
	is_jumping = false
	in_safe_spot = false
	visible = true
	last_direction = Vector2.UP
	sprite.play("idle")
	modulate = Color.WHITE
