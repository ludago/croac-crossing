extends Area2D

@export var speed: float = 100.0
@export var direction: int = 1
@export var vehicle_type: String = "car"

var sprite: Sprite2D
var collision_shape: CollisionShape2D
var screen_width: float = 1920.0
var is_setup: bool = false

var sound_pass: AudioStreamPlayer

var sounds = {
	"car": preload("res://assets/audio/sfx/car_pass.wav"),
	"bus": preload("res://assets/audio/sfx/bus_pass.wav"),
	"truck": preload("res://assets/audio/sfx/truck_pass.wav"),
	"motorcycle": preload("res://assets/audio/sfx/moto_pass.wav")
}

var sprites = {
	"car": preload("res://assets/sprites/vehicles/auto.png"),
	"sports_car": preload("res://assets/sprites/vehicles/auto_deportivo.png"),
	"bus": preload("res://assets/sprites/vehicles/bus.png"),
	"truck": preload("res://assets/sprites/vehicles/camion.png"),
	"pickup": preload("res://assets/sprites/vehicles/camioneta.png"),
	"van": preload("res://assets/sprites/vehicles/combi.png"),
	"motorcycle": preload("res://assets/sprites/vehicles/moto.png")
}

var vehicle_sizes = {
	"car": {"scale": Vector2(0.45, 0.45), "collision": Vector2(30, 55)},
	"sports_car": {"scale": Vector2(0.45, 0.45), "collision": Vector2(30, 55)},
	"bus": {"scale": Vector2(0.35, 0.45), "collision": Vector2(30, 70)},
	"truck": {"scale": Vector2(0.35, 0.45), "collision": Vector2(30, 65)},
	"pickup": {"scale": Vector2(0.35, 0.45), "collision": Vector2(30, 60)},
	"van": {"scale": Vector2(0.35, 0.45), "collision": Vector2(30, 60)},
	"motorcycle": {"scale": Vector2(0.4, 0.45), "collision": Vector2(25, 45)}
}

func _ready():
	sprite = $Sprite2D
	collision_shape = $CollisionShape2D
	body_entered.connect(_on_body_entered)
	call_deferred("_setup_visual")
	call_deferred("_setup_sound")

func _setup_sound():
	sound_pass = AudioStreamPlayer.new()
	sound_pass.stream = sounds.get(vehicle_type, sounds["car"])
	add_child(sound_pass)
	sound_pass.play()

func _setup_visual():
	if sprite == null:
		return
	
	var tex = sprites.get(vehicle_type, sprites["car"])
	sprite.texture = tex
	
	var size_data = vehicle_sizes.get(vehicle_type, vehicle_sizes["car"])
	sprite.scale = size_data["scale"]
	
	if direction > 0:
		sprite.rotation = PI / 2
	else:
		sprite.rotation = -PI / 2
	
	if collision_shape and collision_shape.shape:
		collision_shape.shape.size = size_data["collision"]

func _physics_process(delta):
	position.x += speed * direction * delta
	
	if direction > 0 and position.x > screen_width + 100:
		queue_free()
	elif direction < 0 and position.x < -100:
		queue_free()

func _on_body_entered(body):
	if body.has_method("die") and "is_alive" in body and body.is_alive:
		body.die()

func setup(p_speed: float, p_direction: int, p_type: String):
	speed = p_speed
	direction = p_direction
	vehicle_type = p_type
