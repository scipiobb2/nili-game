extends Node2D
class_name HeroView

@export var tile_size: float = 64.0
@export var hero_color: Color = Color(0.9, 0.74, 0.3)
@export_range(0.0, 1.0, 0.01) var bonk_offset_ratio: float = 0.12
@export_range(0.0, 1.0, 0.01) var bonk_out_duration: float = 0.06
@export_range(0.0, 1.0, 0.01) var bonk_return_duration: float = 0.08

var _grid_position := GridPos.new(0, 0)
var _base_position := Vector2.ZERO
var _bonk_tween: Tween

func set_grid_position(_position: GridPos) -> void:
	_grid_position = GridPos.new(_position.x, _position.y)
	_base_position = _grid_to_local(_grid_position)
	_cancel_bonk()
	self.position = _base_position
	queue_redraw()

func get_grid_position() -> GridPos:
	return GridPos.new(_grid_position.x, _grid_position.y)

func _grid_to_local(pos: GridPos) -> Vector2:
	return Vector2((pos.x + 0.5) * tile_size, (pos.y + 0.5) * tile_size)

func play_bonk(direction: Vector2i) -> void:
	if direction == Vector2i.ZERO:
		return

	var offset := Vector2(direction.x, direction.y) * tile_size * bonk_offset_ratio
	_cancel_bonk()
	self.position = _base_position

	_bonk_tween = create_tween()
	_bonk_tween.set_trans(Tween.TRANS_SINE)
	_bonk_tween.set_ease(Tween.EASE_OUT)
	_bonk_tween.tween_property(self, "position", _base_position + offset, bonk_out_duration)
	_bonk_tween.tween_property(self, "position", _base_position, bonk_return_duration)
	_bonk_tween.finished.connect(_on_bonk_finished)

func _cancel_bonk() -> void:
	if _bonk_tween != null and _bonk_tween.is_running():
		_bonk_tween.kill()
	_bonk_tween = null

func _on_bonk_finished() -> void:
	_bonk_tween = null
	self.position = _base_position

func _draw() -> void:
	var radius := tile_size * 0.3
	draw_circle(Vector2.ZERO, radius, hero_color)
