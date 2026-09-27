extends Node

signal lives_changed(new_lives)
signal score_changed(new_score)
signal level_changed(new_level)
signal game_over
signal game_restarted
signal game_won
signal touch_move(direction: Vector2)
signal paused
signal unpaused
signal settings_changed

var lives: int = 5
var score: int = 0
var current_level: int = 1
var is_game_active: bool = false
var is_paused: bool = false
var high_score: int = 0

var music_enabled: bool = true
var sfx_enabled: bool = true

var music_player: AudioStreamPlayer
var sfx_game_over: AudioStreamPlayer
var sfx_level_complete: AudioStreamPlayer

var bgm_normal_path: String = "res://assets/audio/music/bgm_normal.wav"
var bgm_fast_path: String = "res://assets/audio/music/bgm_fast.wav"
var sfx_game_over_path: String = "res://assets/audio/sfx/game_over.wav"
var sfx_level_complete_path: String = "res://assets/audio/sfx/level_complete.wav"

const MAX_LIVES := 5
const SAVE_PATH = "user://highscore.cfg"
const SETTINGS_PATH = "user://settings.cfg"

func _ready():
	load_high_score()
	load_settings()
	_setup_audio()

func _setup_audio():
	music_player = AudioStreamPlayer.new()
	var music_stream = load(bgm_normal_path)
	if music_stream:
		music_player.stream = music_stream
	music_player.bus = "Master"
	add_child(music_player)
	
	sfx_game_over = AudioStreamPlayer.new()
	var go_stream = load(sfx_game_over_path)
	if go_stream:
		sfx_game_over.stream = go_stream
	sfx_game_over.bus = "Master"
	add_child(sfx_game_over)
	
	sfx_level_complete = AudioStreamPlayer.new()
	var lc_stream = load(sfx_level_complete_path)
	if lc_stream:
		sfx_level_complete.stream = lc_stream
	sfx_level_complete.bus = "Master"
	add_child(sfx_level_complete)

func start_game():
	lives = 5
	score = 0
	current_level = 1
	is_game_active = true
	is_paused = false
	get_tree().paused = false
	lives_changed.emit(lives)
	score_changed.emit(score)
	level_changed.emit(current_level)
	game_restarted.emit()
	if music_enabled:
		_play_music(load(bgm_normal_path))

func pause_game():
	if not is_game_active:
		return
	is_paused = true
	get_tree().paused = true
	paused.emit()

func resume_game():
	is_paused = false
	get_tree().paused = false
	unpaused.emit()

func toggle_pause():
	if is_paused:
		resume_game()
	else:
		pause_game()

func add_score(points: int):
	score += points
	score_changed.emit(score)
	if score > high_score:
		high_score = score
		save_high_score()

func lose_life():
	if not is_game_active:
		return
	lives -= 1
	lives_changed.emit(lives)
	if lives <= 0:
		is_game_active = false
		_play_sfx(sfx_game_over)
		game_over.emit()

func next_level():
	current_level += 1
	level_changed.emit(current_level)
	add_score(100)
	_play_sfx(sfx_level_complete)
	if music_enabled:
		if current_level >= 5:
			_play_music(load(bgm_fast_path))
		else:
			_play_music(load(bgm_normal_path))

func _play_music(track: AudioStream):
	if not music_enabled or not track:
		return
	music_player.stop()
	music_player.stream = track
	music_player.play()

func _play_sfx(sfx: AudioStreamPlayer):
	if not sfx_enabled:
		return
	sfx.play()

func set_music_enabled(enabled: bool):
	music_enabled = enabled
	if not enabled:
		music_player.stop()
	else:
		if is_game_active:
			if current_level >= 5:
				_play_music(load(bgm_fast_path))
			else:
				_play_music(load(bgm_normal_path))
	save_settings()
	settings_changed.emit()

func set_sfx_enabled(enabled: bool):
	sfx_enabled = enabled
	save_settings()
	settings_changed.emit()

func get_difficulty() -> Dictionary:
	if current_level <= 2:
		return {"lanes": 5, "speed": 160.0, "spawn_interval": 3.5, "lives": 5}
	elif current_level <= 4:
		return {"lanes": 5, "speed": 200.0, "spawn_interval": 2.8, "lives": 5}
	elif current_level <= 6:
		return {"lanes": 6, "speed": 240.0, "spawn_interval": 2.2, "lives": 3}
	else:
		return {"lanes": 7, "speed": 280.0, "spawn_interval": 1.6, "lives": 3}

func load_high_score():
	var config = ConfigFile.new()
	var err = config.load(SAVE_PATH)
	if err == OK:
		high_score = config.get_value("scores", "high_score", 0)

func save_high_score():
	var config = ConfigFile.new()
	config.set_value("scores", "high_score", high_score)
	config.save(SAVE_PATH)

func load_settings():
	var config = ConfigFile.new()
	var err = config.load(SETTINGS_PATH)
	if err == OK:
		music_enabled = config.get_value("settings", "music_enabled", true)
		sfx_enabled = config.get_value("settings", "sfx_enabled", true)

func save_settings():
	var config = ConfigFile.new()
	config.set_value("settings", "music_enabled", music_enabled)
	config.set_value("settings", "sfx_enabled", sfx_enabled)
	config.save(SETTINGS_PATH)
