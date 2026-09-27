extends Node

# Señales
signal connection_failed
signal player_connected
signal player_disconnected
signal game_started

# Estado de la red
var is_online: bool = false
var is_host: bool = false
var is_connected_to_server: bool = false
var peer: ENetMultiplayerPeer
var players: Dictionary = {}
var my_player_id: int = 0

const DEFAULT_PORT = 7000
const MAX_CLIENTS = 2

func host_game(port: int = DEFAULT_PORT) -> bool:
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, MAX_CLIENTS)
	if error != OK:
		return false

	multiplayer.peer = peer
	my_player_id = 1
	is_host = true
	is_online = true
	is_connected_to_server = true
	players[1] = {"name": "Host"}

	# Conectar señales
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)

	return true

func join_game(ip: String, port: int = DEFAULT_PORT) -> bool:
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(ip, port)
	if error != OK:
		return false

	multiplayer.peer = peer
	is_host = false
	is_online = true

	# Conectar señales
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)

	return true

func start_game() -> void:
	if is_host:
		rpc("start_game_rpc")

@rpc("authority", "call_remote", "reliable")
func start_game_rpc() -> void:
	game_started.emit()

func disconnect_from_server() -> void:
	if peer:
		peer.close()
		peer = null
	is_online = false
	is_host = false
	is_connected_to_server = false
	players.clear()

# Callbacks de red
func _on_peer_connected(id: int) -> void:
	players[id] = {"name": "Player %d" % id}
	player_connected.emit()

func _on_peer_disconnected(id: int) -> void:
	players.erase(id)
	player_disconnected.emit()

func _on_connected_to_server() -> void:
	is_connected_to_server = true
	my_player_id = multiplayer.get_unique_id()
	players[my_player_id] = {"name": "Client"}
	player_connected.emit()

func _on_connection_failed() -> void:
	is_connected_to_server = false
	connection_failed.emit()
	disconnect_from_server()

# Sincronización de estado del auto
func sync_car_state(car_id: int, position: Vector2, direction: float, speed: float) -> void:
	if is_online:
		rpc("update_car_state_rpc", car_id, position, direction, speed)

@rpc("any_peer", "call_remote", "unreliable")
func update_car_state_rpc(car_id: int, position: Vector2, direction: float, speed: float) -> void:
	# Recibir estado del auto del otro jugador
	pass

func get_player_count() -> int:
	return players.size()
