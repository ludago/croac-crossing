extends CanvasLayer

func _ready():
	layer = 20

func _on_up_pressed():
	GameManager.touch_move.emit(Vector2.UP)

func _on_up_released():
	pass

func _on_down_pressed():
	GameManager.touch_move.emit(Vector2.DOWN)

func _on_down_released():
	pass

func _on_left_pressed():
	GameManager.touch_move.emit(Vector2.LEFT)

func _on_left_released():
	pass

func _on_right_pressed():
	GameManager.touch_move.emit(Vector2.RIGHT)

func _on_right_released():
	pass
