extends CanvasLayer

@onready var music_button: Button = $Panel/VBoxContainer/MusicButton
@onready var sfx_button: Button = $Panel/VBoxContainer/SFXButton
@onready var back_button: Button = $Panel/VBoxContainer/BackButton

func _ready():
	_update_buttons()
	music_button.pressed.connect(_on_music_pressed)
	sfx_button.pressed.connect(_on_sfx_pressed)
	back_button.pressed.connect(_on_back_pressed)
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

func open():
	_update_buttons()
	visible = true

func _update_buttons():
	music_button.text = "Musica: " + ("ON" if GameManager.music_enabled else "OFF")
	sfx_button.text = "Sonidos: " + ("ON" if GameManager.sfx_enabled else "OFF")

func _on_music_pressed():
	GameManager.set_music_enabled(not GameManager.music_enabled)
	_update_buttons()

func _on_sfx_pressed():
	GameManager.set_sfx_enabled(not GameManager.sfx_enabled)
	_update_buttons()

func _on_back_pressed():
	visible = false
