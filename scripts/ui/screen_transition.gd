extends CanvasLayer

var fade_rect: ColorRect
var is_transitioning: bool = false

func _ready():
	layer = 30
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	fade_rect = ColorRect.new()
	fade_rect.color = Color(0, 0, 0, 0)
	fade_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(fade_rect)

func fade_in(duration: float = 0.5):
	if is_transitioning:
		return
	is_transitioning = true
	fade_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	var tween = create_tween()
	tween.tween_property(fade_rect, "color:a", 1.0, duration)
	await tween.finished
	is_transitioning = false

func fade_out(duration: float = 0.5):
	if is_transitioning:
		return
	is_transitioning = true
	var tween = create_tween()
	tween.tween_property(fade_rect, "color:a", 0.0, duration)
	await tween.finished
	fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	is_transitioning = false

func fade_in_out(duration: float = 0.3):
	await fade_in(duration)
	await fade_out(duration)

func flash_white(duration: float = 0.15):
	fade_rect.color = Color(1, 1, 1, 0.8)
	fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var tween = create_tween()
	tween.tween_property(fade_rect, "color:a", 0.0, duration)
	await tween.finished
