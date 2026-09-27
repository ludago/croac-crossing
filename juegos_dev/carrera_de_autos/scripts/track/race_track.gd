extends Node2D
class_name RaceTrack

@export var track_width: float = 200.0
@export var track_color: Color = Color(0.3, 0.3, 0.3)
@export var grass_color: Color = Color(0.2, 0.6, 0.2)
@export var line_color: Color = Color.WHITE

var track_points: Array[Vector2] = []
var inner_points: Array[Vector2] = []
var outer_points: Array[Vector2] = []
var checkpoints: Array[Vector2] = []
var start_positions: Array[Vector2] = []
var finish_line_pos: Vector2 = Vector2.ZERO
var checkpoint_areas: Array[Area2D] = []

func _ready() -> void:
	_generate_track()
	_create_collisions()
	_create_checkpoints()
	queue_redraw()

func _generate_track() -> void:
	var center = Vector2(640, 360)
	var radius_x = 450.0
	var radius_y = 250.0
	var num_points = 64

	track_points.clear()
	inner_points.clear()
	outer_points.clear()
	checkpoints.clear()

	for i in range(num_points):
		var angle = (i / float(num_points)) * TAU
		var point = center + Vector2(cos(angle) * radius_x, sin(angle) * radius_y)
		track_points.append(point)

		var normal = (point - center).normalized()
		inner_points.append(point - normal * (track_width / 2))
		outer_points.append(point + normal * (track_width / 2))

	for i in range(0, num_points, 16):
		checkpoints.append(track_points[i])

	var start_angle = 0.0
	var start_point = center + Vector2(cos(start_angle) * radius_x, sin(start_angle) * radius_y)
	var start_normal = (start_point - center).normalized()
	start_positions = [
		start_point + start_normal * 30,
		start_point - start_normal * 30
	]
	finish_line_pos = start_point

func _create_collisions() -> void:
	if track_points.is_empty():
		return

	var walls_outer = StaticBody2D.new()
	walls_outer.name = "WallsOuter"
	add_child(walls_outer)

	var walls_inner = StaticBody2D.new()
	walls_inner.name = "WallsInner"
	add_child(walls_inner)

	var step = 4
	for i in range(track_points.size()):
		var next = (i + step) % track_points.size()

		var seg_outer = CollisionPolygon2D.new()
		var seg_inner = CollisionPolygon2D.new()

		var p1 = outer_points[i]
		var p2 = outer_points[next]
		var thickness = 8.0
		var normal_outer = (p2 - p1).normalized().orthogonal()

		seg_outer.polygon = [
			p1 + normal_outer * thickness,
			p2 + normal_outer * thickness,
			p2 - normal_outer * thickness,
			p1 - normal_outer * thickness,
		]
		walls_outer.add_child(seg_outer)

		var p1i = inner_points[i]
		var p2i = inner_points[next]
		var normal_inner = (p2i - p1i).normalized().orthogonal()

		seg_inner.polygon = [
			p1i + normal_inner * thickness,
			p2i + normal_inner * thickness,
			p2i - normal_inner * thickness,
			p1i - normal_inner * thickness,
		]
		walls_inner.add_child(seg_inner)

func _create_checkpoints() -> void:
	checkpoint_areas.clear()
	for i in range(checkpoints.size()):
		var area = Area2D.new()
		area.name = "Checkpoint_%d" % i
		area.set_meta("checkpoint_id", i)
		add_child(area)

		var shape = CollisionShape2D.new()
		var rect = RectangleShape2D.new()
		rect.size = Vector2(track_width, 30)
		shape.shape = rect
		area.add_child(shape)

		area.global_position = checkpoints[i]
		area.collision_layer = 0
		area.collision_mask = 1

		area.body_entered.connect(_on_checkpoint_body_entered.bind(i))

	checkpoints.clear()
	for i in range(checkpoint_areas.size()):
		checkpoints.append(checkpoint_areas[i].global_position)

func _on_checkpoint_body_entered(body: Node2D, checkpoint_id: int) -> void:
	if body is Car:
		body._on_checkpoint_reached(checkpoint_id)

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, Vector2(1280, 720)), grass_color)

	if track_points.is_empty():
		return

	_draw_track_surface()
	_draw_track_borders()
	_draw_finish_line()

func _draw_track_surface() -> void:
	for i in range(track_points.size()):
		var next = (i + 1) % track_points.size()
		var p1_inner = inner_points[i]
		var p1_outer = outer_points[i]
		var p2_inner = inner_points[next]
		var p2_outer = outer_points[next]

		var polygon = [p1_inner, p1_outer, p2_outer, p2_inner]
		draw_colored_polygon(polygon, track_color)

	for i in range(track_points.size()):
		if i % 4 < 2:
			var next = (i + 1) % track_points.size()
			draw_line(track_points[i], track_points[next], Color.YELLOW, 2.0)

func _draw_track_borders() -> void:
	for i in range(outer_points.size()):
		var next = (i + 1) % outer_points.size()
		draw_line(outer_points[i], outer_points[next], line_color, 3.0)

	for i in range(inner_points.size()):
		var next = (i + 1) % inner_points.size()
		draw_line(inner_points[i], inner_points[next], line_color, 3.0)

func _draw_finish_line() -> void:
	if start_positions.size() >= 2:
		var p1 = start_positions[0]
		var p2 = start_positions[1]
		var mid = (p1 + p2) / 2
		var dir = (p2 - p1).normalized()
		var perp = dir.rotated(PI / 2)

		for i in range(-5, 6):
			var offset = perp * i * 8
			var color = Color.WHITE if i % 2 == 0 else Color.BLACK
			draw_line(mid + offset - dir * 15, mid + offset + dir * 15, color, 4.0)

func get_waypoints() -> Array[Vector2]:
	return track_points

func get_start_position(index: int) -> Vector2:
	if index < start_positions.size():
		return start_positions[index]
	return start_positions[0]

func get_start_direction() -> float:
	if track_points.size() > 1:
		return start_positions[0].angle_to(track_points[0])
	return 0.0

func get_checkpoint_position(index: int) -> Vector2:
	if index < checkpoints.size():
		return checkpoints[index]
	return Vector2.ZERO

func get_total_checkpoints() -> int:
	return checkpoints.size()
