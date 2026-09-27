extends CanvasLayer

@onready var resume_button: Button = $Panel/VBoxContainer/ResumeButton
@onready var options_button: Button = $Panel/VBoxContainer/OptionsButton
@onready var restart_button: Button = $Panel/VBoxContainer/RestartButton
@onready var menu_button: Button = $Panel/VBoxContainer/MenuButton

var options_menu_scene: PackedScene = preload("res://scenes/ui/options_menu.tscn")
var options_menu_instance: CanvasLayer = null

func _ready():
	resume_button.pressed.connect(_on_resume_pressed)
	options_button.pressed.connect(_on_options_pressed)
	restart_button.pressed.connect(_on_restart_pressed)
	menu_button.pressed.connect(_on_menu_pressed)
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_resume_pressed():
	GameManager.resume_game()
	visible = false

func _on_options_pressed():
	if not options_menu_instance:
		options_menu_instance = options_menu_scene.instantiate()
		get_tree().current_scene.add_child(options_menu_instance)
	options_menu_instance.open()

func _on_restart_pressed():
	visible = false
	get_tree().paused = false
	GameManager.start_game()
	get_tree().change_scene_to_file("res://main.tscn")

func _on_menu_pressed():
	visible = false
	get_tree().paused = false
	GameManager.is_game_active = false
	get_tree().change_scene_to_file("res://scenes/ui/start_screen.tscn")
