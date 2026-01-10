extends Node2D
class_name HeroView

@export var tile_size: float = 64.0
@export var hero_color: Color = Color(0.9, 0.74, 0.3)

var _grid_position := GridPos.new(0, 0)

func set_grid_position(_position: GridPos) -> void:
	_grid_position = GridPos.new(_position.x, _position.y)
	var local_position := _grid_to_local(_grid_position)
	self.position = local_position
	queue_redraw()

func get_grid_position() -> GridPos:
	return GridPos.new(_grid_position.x, _grid_position.y)

func _grid_to_local(pos: GridPos) -> Vector2:
	return Vector2((pos.x + 0.5) * tile_size, (pos.y + 0.5) * tile_size)

func _draw() -> void:
	var radius := tile_size * 0.3
	draw_circle(Vector2.ZERO, radius, hero_color)
