extends RefCounted

func _create_game_root() -> Node2D:
	var scene: PackedScene = load("res://src/adapters/scenes/game_root.tscn")
	var instance: Node2D = scene.instantiate()
	instance._ready()
	return instance

func test_successful_move_updates_hero_and_state(test):
	var game_root: Node2D = _create_game_root()

	var start: GridPos = game_root.get_current_grid_position()
	game_root._on_move_attempted(Vector2i.DOWN)
	var after_move: GridPos = game_root.get_current_grid_position()

	test.assert_true(Vector2i(after_move.x, after_move.y) != Vector2i(start.x, start.y), "hero moves on open tile")

	var hero_view: HeroView = game_root.get_node("WorldView/HeroView")
	var hero_grid: GridPos = hero_view.get_grid_position()
	test.assert_equal(Vector2i(hero_grid.x, hero_grid.y), Vector2i(after_move.x, after_move.y), "view follows domain position")
	game_root.free()

func test_blocked_move_does_not_change_position(test):
	var game_root: Node2D = _create_game_root()

	var start: GridPos = game_root.get_current_grid_position()
	game_root._on_move_attempted(Vector2i.RIGHT)
	var after_move: GridPos = game_root.get_current_grid_position()

	test.assert_equal(Vector2i(after_move.x, after_move.y), Vector2i(start.x, start.y), "blocked move keeps hero in place")
	game_root.free()
