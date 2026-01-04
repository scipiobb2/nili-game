extends RefCounted

const _ACTION_KEYCODES := {
  "move_up": [Key.KEY_UP, Key.KEY_W],
  "move_down": [Key.KEY_DOWN, Key.KEY_S],
  "move_left": [Key.KEY_LEFT, Key.KEY_A],
  "move_right": [Key.KEY_RIGHT, Key.KEY_D],
  "restart": [Key.KEY_R],
}

func _ensure_project_input_map():
	InputMap.load_from_project_settings()

	for action in _ACTION_KEYCODES.keys():
		if not InputMap.has_action(action):
			InputMap.add_action(action)

		var existing_events := InputMap.action_get_events(action)
		for keycode in _ACTION_KEYCODES[action]:
			if not _has_event_with_key(existing_events, keycode):
				var event := InputEventKey.new()
				event.keycode = keycode
				event.physical_keycode = keycode
				InputMap.action_add_event(action, event)

func _has_event_with_key(events: Array, keycode: int) -> bool:
	for event in events:
		if not (event is InputEventKey):
			continue

		if event.keycode == keycode or event.physical_keycode == keycode:
			return true

	return false

func test_emits_move_attempt_on_arrow_press(test):
	_ensure_project_input_map()
	var adapter := ManualInputAdapter.new()

	var captured := []
	adapter.move_attempted.connect(func(direction: Vector2i):
		captured.append(direction)
		)

	var event := InputEventKey.new()
	event.keycode = Key.KEY_RIGHT
	event.physical_keycode = Key.KEY_RIGHT
	event.pressed = true
	adapter._unhandled_input(event)

	test.assert_equal(captured.size(), 1, "one move emitted")
	test.assert_equal(captured[0], Vector2i(1, 0), "right arrow maps to +x movement")

func test_emits_restart_on_restart_press(test):
	_ensure_project_input_map()
	var adapter := ManualInputAdapter.new()

	var restart_events := []
	adapter.restart_requested.connect(func():
		restart_events.append(true)
		)

	var event := InputEventKey.new()
	event.keycode = Key.KEY_R
	event.physical_keycode = Key.KEY_R
	event.pressed = true
	adapter._unhandled_input(event)

	test.assert_equal(restart_events.size(), 1, "restart signal emitted once")

func test_ignores_echo_events(test):
	_ensure_project_input_map()
	var adapter := ManualInputAdapter.new()

	var captured := []
	adapter.move_attempted.connect(func(direction: Vector2i):
		captured.append(direction)
			)

	var event := InputEventKey.new()
	event.keycode = Key.KEY_UP
	event.physical_keycode = Key.KEY_UP
	event.pressed = true
	event.echo = true
	adapter._unhandled_input(event)

	test.assert_true(captured.is_empty(), "echo inputs are ignored")
