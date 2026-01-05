extends Node
class_name ManualInputAdapter

signal move_attempted(direction: Vector2i)
signal restart_requested()

const _ACTION_TO_DIRECTION := {
  "move_up": Vector2i(0, -1),
  "move_down": Vector2i(0, 1),
  "move_left": Vector2i(-1, 0),
  "move_right": Vector2i(1, 0),
}

func _unhandled_input(event: InputEvent):
	if not _is_relevant_key_event(event):
		return

	if event.is_action_pressed("restart"):
		restart_requested.emit()
		_mark_as_handled()
		return

	var direction: Vector2i = _direction_from_event(event)
	if direction != Vector2i.ZERO:
		move_attempted.emit(direction)
		_mark_as_handled()

func _direction_from_event(event: InputEvent) -> Vector2i:
	for action in _ACTION_TO_DIRECTION.keys():
		if event.is_action_pressed(action):
			return _ACTION_TO_DIRECTION[action]
	return Vector2i.ZERO

func _is_relevant_key_event(event: InputEvent) -> bool:
	return event is InputEventKey and event.pressed and not event.echo

func _mark_as_handled():
	if get_viewport():
		get_viewport().set_input_as_handled()
