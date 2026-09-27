extends Control

func _ready() -> void:
	# Conectar botones
	$VBoxContainer/PlayButton.pressed.connect(_on_play_pressed)
	$VBoxContainer/OnlineButton.pressed.connect(_on_online_pressed)
	$VBoxContainer/SettingsButton.pressed.connect(_on_settings_pressed)
	$VBoxContainer/QuitButton.pressed.connect(_on_quit_pressed)

func _on_play_pressed() -> void:
	# Modo un jugador vs AI
	NetworkManager.is_online = false
	get_tree().change_scene_to_file("res://scenes/track/game.tscn")

func _on_online_pressed() -> void:
	# Ir a pantalla de lobby online
	get_tree().change_scene_to_file("res://scenes/ui/lobby.tscn")

func _on_settings_pressed() -> void:
	# TODO: Pantalla de configuración
	pass

func _on_quit_pressed() -> void:
	get_tree().quit()
