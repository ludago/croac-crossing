extends Control

@onready var play_button: Button = $VBoxContainer/PlayButton
@onready var options_button: Button = $VBoxContainer/OptionsButton
@onready var frog: CharacterBody2D = $VBoxContainer/FrogCenter/FrogInstance
@onready var options_menu: CanvasLayer = $OptionsMenu

var croak_timer: Timer

func _ready():
	play_button.grab_focus()
	play_button.pressed.connect(_on_play_pressed)
	options_button.pressed.connect(_on_options_pressed)
	
	frog.get_node("AnimatedSprite2D").play("idle")
	
	await get_tree().process_frame
	var center_container = frog.get_parent()
	frog.position.x = center_container.size.x * 0.5
	
	croak_timer = Timer.new()
	croak_timer.wait_time = randf_range(3.0, 6.0)
	croak_timer.autostart = true
	croak_timer.timeout.connect(_on_croak_timer_timeout)
	add_child(croak_timer)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if options_menu.visible:
			options_menu._on_back_pressed()
		else:
			get_tree().quit()

func _on_croak_timer_timeout():
	frog.get_node("CroakSound").play()
	croak_timer.wait_time = randf_range(3.0, 6.0)

func _on_play_pressed():
	get_tree().change_scene_to_file("res://main.tscn")

func _on_options_pressed():
	options_menu.open()
