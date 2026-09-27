extends Control

@onready var status_label: Label = $VBoxContainer/StatusLabel
@onready var ip_input: LineEdit = $VBoxContainer/IPInput
@onready var port_input: LineEdit = $VBoxContainer/PortInput
@onready var host_button: Button = $VBoxContainer/HostButton
@onready var join_button: Button = $VBoxContainer/JoinButton
@onready var start_button: Button = $VBoxContainer/StartButton
@onready var back_button: Button = $VBoxContainer/BackButton

func _ready() -> void:
	host_button.pressed.connect(_on_host_pressed)
	join_button.pressed.connect(_on_join_pressed)
	start_button.pressed.connect(_on_start_pressed)
	back_button.pressed.connect(_on_back_pressed)
	start_button.disabled = true

	ip_input.text = "127.0.0.1"
	port_input.text = "7000"
	status_label.text = "Desconectado"

	NetworkManager.connection_failed.connect(_on_connection_failed)
	NetworkManager.player_connected.connect(_on_player_connected)
	NetworkManager.game_started.connect(_on_game_started)

func _on_host_pressed() -> void:
	var port = port_input.text.to_int()
	if NetworkManager.host_game(port):
		status_label.text = "Esperando jugador..."
		host_button.disabled = true
		join_button.disabled = true
		start_button.disabled = false
	else:
		status_label.text = "Error al crear servidor"

func _on_join_pressed() -> void:
	var ip = ip_input.text
	var port = port_input.text.to_int()
	status_label.text = "Conectando..."
	if NetworkManager.join_game(ip, port):
		status_label.text = "Conectado! Esperando inicio..."
		host_button.disabled = true
		join_button.disabled = true
	else:
		status_label.text = "Error al conectar"

func _on_start_pressed() -> void:
	NetworkManager.start_game()

func _on_connection_failed() -> void:
	status_label.text = "Error de conexión"
	host_button.disabled = false
	join_button.disabled = false
	start_button.disabled = true

func _on_player_connected() -> void:
	status_label.text = "¡Jugador conectado!"
	start_button.disabled = false

func _on_game_started() -> void:
	get_tree().change_scene_to_file("res://scenes/track/game.tscn")

func _on_back_pressed() -> void:
	NetworkManager.disconnect_from_server()
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
