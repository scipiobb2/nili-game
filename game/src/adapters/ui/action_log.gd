extends Control
class_name ActionLog

const MoveResult := preload("res://src/domain/grid/move_result.gd")

@export_range(1, 50) var max_entries := 6
@export var entry_font_size: int = 20

@onready var _log_label: RichTextLabel = $PanelContainer/MarginContainer/Content/LogLabel

var _entries: Array[String] = []

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	clear_entries()

func add_entry(direction: Vector2i, result: MoveResult) -> void:
	if _log_label == null:
		return

	var command_name := _direction_to_command_name(direction)
	var entry := command_name
	if result != null and result.is_blocked():
		entry = "%s - blocked%s" % [command_name, _block_reason_text(result.block_reason)]

	_entries.append(entry)
	_trim_to_limit()
	_render_entries()

func clear_entries() -> void:
	_entries.clear()
	_render_entries()

func _render_entries() -> void:
	if _log_label == null:
		return

	_log_label.text = "\n".join(_entries)
	_log_label.add_theme_font_size_override("font_size", entry_font_size)

func _trim_to_limit() -> void:
	while _entries.size() > max_entries:
		_entries.pop_front()

func _direction_to_command_name(direction: Vector2i) -> String:
	if direction == Vector2i.LEFT:
		return "move_left()"
	if direction == Vector2i.RIGHT:
		return "move_right()"
	if direction == Vector2i.UP:
		return "move_up()"
	if direction == Vector2i.DOWN:
		return "move_down()"
	return "move()"

func _block_reason_text(reason: MoveResult.BlockReason) -> String:
	match reason:
		MoveResult.BlockReason.WALL:
			return " (wall)"
		MoveResult.BlockReason.OUT_OF_BOUNDS:
			return " (bounds)"
		_:
			return ""
