extends CanvasLayer

@onready var speed_label1: Label = $SpeedLabel1
@onready var speed_label2: Label = $SpeedLabel2
@onready var lap_label1: Label = $LapLabel1
@onready var lap_label2: Label = $LapLabel2
@onready var position_label: Label = $PositionLabel
@onready var minimap: Control = $Minimap

var timer_label1: Label
var timer_label2: Label

func _ready() -> void:
	timer_label1 = Label.new()
	timer_label1.name = "TimerLabel1"
	timer_label1.offset_left = 20.0
	timer_label1.offset_top = 170.0
	timer_label1.offset_right = 250.0
	timer_label1.offset_bottom = 200.0
	timer_label1.text = "Tiempo: 00:00.00"
	add_child(timer_label1)

	timer_label2 = Label.new()
	timer_label2.name = "TimerLabel2"
	timer_label2.offset_left = 20.0
	timer_label2.offset_top = 200.0
	timer_label2.offset_right = 250.0
	timer_label2.offset_bottom = 230.0
	timer_label2.text = "Tiempo: 00:00.00"
	add_child(timer_label2)

	if minimap:
		minimap.draw.connect(_draw_minimap)

func update_speed(speed1: int, speed2: int) -> void:
	if speed_label1:
		speed_label1.text = "J1: %d km/h" % speed1
	if speed_label2:
		speed_label2.text = "J2: %d km/h" % speed2

func update_laps(lap1: int, lap2: int, total: int) -> void:
	if lap_label1:
		lap_label1.text = "J1: Vuelta %d/%d" % [lap1 + 1, total]
	if lap_label2:
		lap_label2.text = "J2: Vuelta %d/%d" % [lap2 + 1, total]

func update_position(pos1: String, pos2: String) -> void:
	if position_label:
		position_label.text = "Pos: %s - %s" % [pos1, pos2]

func update_timer(time1: String, time2: String) -> void:
	if timer_label1:
		timer_label1.text = "Tiempo: %s" % time1
	if timer_label2:
		timer_label2.text = "Tiempo: %s" % time2

func _draw_minimap() -> void:
	if not minimap:
		return

	var rect = minimap.get_global_rect()
	minimap.draw_rect(Rect2(Vector2.ZERO, rect.size), Color(0.1, 0.1, 0.1, 0.8))

	var game = get_parent()
	if not game:
		return

	var track = null
	for child in game.get_children():
		if child is RaceTrack:
			track = child
			break

	if not track:
		return

	var scale_x = rect.size.x / 1280.0
	var scale_y = rect.size.y / 720.0
	var scale_f = min(scale_x, scale_y) * 0.8
	var offset = rect.size * 0.1

	if track.track_points.size() > 1:
		for i in range(track.track_points.size()):
			var next = (i + 1) % track.track_points.size()
			var p1 = (track.inner_points[i] - Vector2(640, 360)) * scale_f + rect.size / 2 + offset
			var p2 = (track.inner_points[next] - Vector2(640, 360)) * scale_f + rect.size / 2 + offset
			minimap.draw_line(p1, p2, Color(0.5, 0.5, 0.5), 1.0)

			p1 = (track.outer_points[i] - Vector2(640, 360)) * scale_f + rect.size / 2 + offset
			p2 = (track.outer_points[next] - Vector2(640, 360)) * scale_f + rect.size / 2 + offset
			minimap.draw_line(p1, p2, Color(0.5, 0.5, 0.5), 1.0)

	var car1 = game.get_node_or_null("Car1")
	var car2 = game.get_node_or_null("Car2")

	if car1:
		var pos1 = (car1.global_position - Vector2(640, 360)) * scale_f + rect.size / 2 + offset
		minimap.draw_circle(pos1, 4.0, Color(0.2, 0.4, 0.9))

	if car2:
		var pos2 = (car2.global_position - Vector2(640, 360)) * scale_f + rect.size / 2 + offset
		minimap.draw_circle(pos2, 4.0, Color(0.9, 0.2, 0.2))
