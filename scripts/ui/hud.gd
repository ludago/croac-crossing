extends CanvasLayer

var lives_label: Label
var score_label: Label
var level_label: Label
var game_over_panel: PanelContainer
var pause_button: Button

func _ready():
	lives_label = $MarginContainer/VBoxContainer/LivesLabel
	score_label = $MarginContainer/VBoxContainer/ScoreLabel
	level_label = $MarginContainer/VBoxContainer/LevelLabel
	game_over_panel = $GameOverPanel
	pause_button = $PauseButton
	
	if not GameManager.lives_changed.is_connected(_on_lives_changed):
		GameManager.lives_changed.connect(_on_lives_changed)
	if not GameManager.score_changed.is_connected(_on_score_changed):
		GameManager.score_changed.connect(_on_score_changed)
	if not GameManager.level_changed.is_connected(_on_level_changed):
		GameManager.level_changed.connect(_on_level_changed)
	if not GameManager.game_over.is_connected(_on_game_over):
		GameManager.game_over.connect(_on_game_over)
	if not GameManager.game_restarted.is_connected(_on_game_restarted):
		GameManager.game_restarted.connect(_on_game_restarted)
	
	pause_button.pressed.connect(_on_pause_pressed)
	$GameOverPanel/VBoxContainer/RetryButton.pressed.connect(_on_retry_pressed)
	$GameOverPanel/VBoxContainer/MenuButton.pressed.connect(_on_menu_pressed)
	game_over_panel.visible = false
	update_ui()

func update_ui():
	_on_lives_changed(GameManager.lives)
	_on_score_changed(GameManager.score)
	_on_level_changed(GameManager.current_level)

func _on_lives_changed(new_lives: int):
	lives_label.text = "VIDAS: " + str(new_lives)

func _on_score_changed(new_score: int):
	score_label.text = "PUNTAJE: " + str(new_score)

func _on_level_changed(new_level: int):
	level_label.text = "NIVEL: " + str(new_level)

func _on_pause_pressed():
	GameManager.toggle_pause()

func _on_game_over():
	$GameOverPanel/VBoxContainer/ScoreValue.text = str(GameManager.score)
	$GameOverPanel/VBoxContainer/LevelValue.text = str(GameManager.current_level)
	$GameOverPanel/VBoxContainer/HighScoreValue.text = str(GameManager.high_score)
	game_over_panel.visible = true

func _on_retry_pressed():
	game_over_panel.visible = false
	get_tree().paused = false
	GameManager.start_game()
	get_tree().change_scene_to_file("res://main.tscn")

func _on_menu_pressed():
	game_over_panel.visible = false
	get_tree().paused = false
	GameManager.is_game_active = false
	get_tree().change_scene_to_file("res://scenes/ui/start_screen.tscn")

func _on_game_restarted():
	game_over_panel.visible = false
