extends Node2D

@export var total_laps: int = 3

var car1: Car
var car2: Car
var race_track: RaceTrack
var ai_driver: AIDriver
var race_started: bool = false
var race_finished: bool = false
var countdown: int = 3
var countdown_timer: float = 0.0

var car_scene = preload("res://scenes/cars/car.tscn")

@onready var camera: Camera2D = $Camera2D
@onready var hud: CanvasLayer = $HUD
@onready var countdown_label: Label = $HUD/CountdownLabel
@onready var race_finished_panel: Panel = $HUD/RaceFinishedPanel

func _ready() -> void:
	race_track = RaceTrack.new()
	race_track.name = "RaceTrack"
	add_child(race_track)

	await get_tree().process_frame

	_create_cars()
	_create_ai()
	_setup_hud_buttons()
	_start_countdown()
	_setup_network()

func _create_cars() -> void:
	car1 = car_scene.instantiate()
	car1.name = "Car1"
	car1.car_color = Color(0.2, 0.4, 0.9)
	car1.player_id = 1
	car1.global_position = race_track.get_start_position(0)
	car1.direction = race_track.get_start_direction()
	add_child(car1)

	car2 = car_scene.instantiate()
	car2.name = "Car2"
	car2.car_color = Color(0.9, 0.2, 0.2)
	car2.player_id = 2
	car2.global_position = race_track.get_start_position(1)
	car2.direction = race_track.get_start_direction()
	add_child(car2)

func _create_ai() -> void:
	ai_driver = AIDriver.new()
	ai_driver.name = "AIDriver"
	ai_driver.target_car = car2
	ai_driver.race_track = race_track
	ai_driver.difficulty = 0.6
	add_child(ai_driver)

func _setup_hud_buttons() -> void:
	var back_button = hud.get_node_or_null("BackButton")
	if back_button:
		back_button.pressed.connect(_on_back_button_pressed)

	var restart_button = race_finished_panel.get_node_or_null("RestartButton")
	if restart_button:
		restart_button.pressed.connect(_on_restart_pressed)

func _start_countdown() -> void:
	countdown = 3
	countdown_timer = 0.0
	race_started = false
	if countdown_label:
		countdown_label.visible = true
		countdown_label.text = "3"
	if car1:
		car1.set_physics_process(false)
	if car2:
		car2.set_physics_process(false)

func _process(delta: float) -> void:
	if not race_started:
		countdown_timer += delta
		if countdown_timer >= 1.0:
			countdown_timer -= 1.0
			countdown -= 1
			if countdown_label:
				if countdown > 0:
					countdown_label.text = str(countdown)
				elif countdown == 0:
					countdown_label.text = "¡GO!"
				else:
					countdown_label.visible = false
					race_started = true
					_on_race_start()

	_update_hud()
	_check_laps()

func _on_race_start() -> void:
	if car1:
		car1.set_physics_process(true)
	if car2:
		car2.set_physics_process(true)

func _update_hud() -> void:
	if hud.has_method("update_speed"):
		var speed1 = car1.get_speed_kmh() if car1 else 0
		var speed2 = car2.get_speed_kmh() if car2 else 0
		hud.update_speed(speed1, speed2)

	if hud.has_method("update_laps"):
		var lap1 = car1.lap if car1 else 0
		var lap2 = car2.lap if car2 else 0
		hud.update_laps(lap1, lap2, total_laps)

	if hud.has_method("update_timer"):
		var time1 = car1.get_race_time() if car1 else "00:00.00"
		var time2 = car2.get_race_time() if car2 else "00:00.00"
		hud.update_timer(time1, time2)

func _check_laps() -> void:
	if race_finished:
		return

	if car1 and car1.lap >= total_laps:
		_on_race_complete(1)
	elif car2 and car2.lap >= total_laps:
		_on_race_complete(2)

func _on_race_complete(winner_id: int) -> void:
	race_finished = true
	if car1:
		car1.set_physics_process(false)
	if car2:
		car2.set_physics_process(false)

	if race_finished_panel:
		race_finished_panel.visible = true
		var winner_label = race_finished_panel.get_node("WinnerLabel")
		if winner_label:
			if winner_id == 1:
				winner_label.text = "¡GANASTE!\nTiempo: %s" % car1.get_race_time()
			else:
				winner_label.text = "¡Perdiste!\nTiempo: %s" % car2.get_race_time()

func _setup_network() -> void:
	if NetworkManager.is_host:
		pass
	elif NetworkManager.is_connected_to_server:
		pass

func restart_race() -> void:
	race_finished = false
	if race_finished_panel:
		race_finished_panel.visible = false
	if car1:
		car1.reset_car(race_track.get_start_position(0), race_track.get_start_direction())
	if car2:
		car2.reset_car(race_track.get_start_position(1), race_track.get_start_direction())
	if ai_driver:
		ai_driver.set_waypoints(race_track.get_waypoints())
	_start_countdown()

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
