extends Node2D
class_name WorldView

@export var tile_size: float = 64.0
@export var tile_color: Color = Color(0.12, 0.12, 0.16)
@export var grid_line_color: Color = Color(0.28, 0.28, 0.32)
@export var wall_color: Color = Color(0.37, 0.24, 0.55)
@export var goal_color: Color = Color(0.26, 0.6, 0.35)

var _world: GridWorld
var _walls: Array[Vector2i] = []

func set_world(world: GridWorld) -> void:
	_world = world
	_walls = world.get_walls()
	queue_redraw()

func _draw() -> void:
	if _world == null:
		return

	_draw_tiles()
	_draw_walls()
	_draw_goal()

func _draw_tiles() -> void:
	var full_width := _world.width * tile_size
	var full_height := _world.height * tile_size

	var total_rect := Rect2(0, 0, full_width, full_height)
	draw_rect(total_rect, tile_color, true)

	var lines := PackedVector2Array()

	for x in range(_world.width + 1):
		var x_px := x * tile_size
		lines.append(Vector2(x_px, 0))
		lines.append(Vector2(x_px, full_height))

	for y in range(_world.height + 1):
		var y_px := y * tile_size
		lines.append(Vector2(0, y_px))
		lines.append(Vector2(full_width, y_px))

	if not lines.is_empty():
		draw_multiline(lines, grid_line_color)

func _draw_walls() -> void:
	for wall in _walls:
		var rect := Rect2(Vector2(wall.x * tile_size, wall.y * tile_size), Vector2(tile_size, tile_size))
		draw_rect(rect, wall_color, true)

func _draw_goal() -> void:
	var goal := _world.goal
	var rect := Rect2(Vector2(goal.x * tile_size, goal.y * tile_size), Vector2(tile_size, tile_size))
	draw_rect(rect, goal_color, true)
