extends Node2D

var level_scene: PackedScene = preload("res://scenes/game/level.tscn")
var hud_scene: PackedScene = preload("res://scenes/ui/hud.tscn")
var touch_controls_scene: PackedScene = preload("res://scenes/ui/touch_controls.tscn")
var pause_menu_scene: PackedScene = preload("res://scenes/ui/pause_menu.tscn")
var transition_scene: PackedScene = preload("res://scenes/ui/screen_transition.tscn")
var curb_texture: Texture2D = preload("res://assets/sprites/environment/cordon_desague.png")

var level: Node2D
var pause_menu: CanvasLayer
var transition: CanvasLayer

func _ready():
	draw_background()
	
	transition = transition_scene.instantiate()
	add_child(transition)
	
	GameManager.start_game()
	
	level = level_scene.instantiate()
	add_child(level)
	
	add_child(hud_scene.instantiate())
	
	add_child(touch_controls_scene.instantiate())
	
	pause_menu = pause_menu_scene.instantiate()
	add_child(pause_menu)
	
	if not GameManager.game_restarted.is_connected(_on_game_restarted):
		GameManager.game_restarted.connect(_on_game_restarted)

func _on_game_restarted():
	transition.fade_out(0.3)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if not GameManager.is_game_active:
			restart_game()
	if event.is_action_pressed("ui_cancel"):
		if GameManager.is_game_active:
			GameManager.toggle_pause()
			pause_menu.visible = GameManager.is_paused

func restart_game():
	await transition.fade_in(0.3)
	if level:
		level.queue_free()
	GameManager.start_game()
	level = level_scene.instantiate()
	add_child(level)
	transition.fade_out(0.3)

func shake_camera():
	var tween = create_tween()
	for i in range(6):
		var offset = Vector2(randf_range(-4, 4), randf_range(-4, 4))
		tween.tween_property(self, "offset", offset, 0.05)
	tween.tween_property(self, "offset", Vector2.ZERO, 0.05)

func draw_background():
	var top_margin = ColorRect.new()
	top_margin.color = Color(0.05, 0.05, 0.05)
	top_margin.size = Vector2(1920, 50)
	top_margin.position = Vector2(0, 0)
	top_margin.z_index = -2
	add_child(top_margin)
	
	var curb_y = 50.0
	var curb_height = 100.0
	var tile_width = 220.0
	for x in range(0, 1960, int(tile_width)):
		var curb_sprite = Sprite2D.new()
		curb_sprite.texture = curb_texture
		curb_sprite.position = Vector2(x + tile_width * 0.5, curb_y + curb_height * 0.5)
		curb_sprite.scale = Vector2(tile_width / curb_texture.get_width(), curb_height / curb_texture.get_height())
		curb_sprite.z_index = -2
		add_child(curb_sprite)
	
	var avenue = ColorRect.new()
	avenue.color = Color(0.25, 0.25, 0.25)
	avenue.size = Vector2(1920, 400)
	avenue.position = Vector2(0, 150)
	avenue.z_index = -2
	add_child(avenue)
	
	var grass_bottom = ColorRect.new()
	grass_bottom.color = Color(0.2, 0.6, 0.2)
	grass_bottom.size = Vector2(1920, 100)
	grass_bottom.position = Vector2(0, 550)
	grass_bottom.z_index = -2
	add_child(grass_bottom)
	
	var bottom_margin = ColorRect.new()
	bottom_margin.color = Color(0.05, 0.05, 0.05)
	bottom_margin.size = Vector2(1920, 70)
	bottom_margin.position = Vector2(0, 650)
	bottom_margin.z_index = -2
	add_child(bottom_margin)
