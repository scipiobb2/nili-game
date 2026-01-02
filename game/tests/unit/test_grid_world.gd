extends RefCounted
const GridWorld = preload("res://src/domain/grid/grid_world.gd")
const MoveResult = preload("res://src/domain/grid/move_result.gd")

func test_grid_world_tracks_bounds_and_walls(test):
	var start := GridPos.new(1, 1)
	var goal := GridPos.new(3, 2)
	var walls: Array[Vector2i] = [Vector2i(0, 1), Vector2i(2, 0)]
	var world: GridWorld = GridWorld.new(4, 3, start, goal, walls)

	test.assert_true(world.is_within_bounds(Vector2i(0, 0)))
	test.assert_true(world.is_within_bounds(Vector2i(3, 2)))
	test.assert_true(not world.is_within_bounds(Vector2i(-1, 0)))
	test.assert_true(not world.is_within_bounds(Vector2i(4, 1)))

	test.assert_true(world.is_wall(Vector2i(0, 1)), "wall lookup uses provided coordinates")
	test.assert_true(not world.is_wall(Vector2i(1, 1)), "non-wall tiles stay walkable")
	test.assert_true(world.is_goal(GridPos.new(3, 2)), "goal position matches definition")
	test.assert_true(world.is_walkable(Vector2i(1, 1)))
	test.assert_true(not world.is_walkable(Vector2i(0, 1)), "walls are not walkable")
	test.assert_true(not world.is_walkable(Vector2i(4, 1)), "out of bounds is not walkable")

	var retrieved_walls: Array[Vector2i] = world.get_walls()
	test.assert_true(retrieved_walls == walls, "wall getter returns configured walls")
	retrieved_walls.append(Vector2i(3, 3))
	test.assert_true(not world.is_wall(Vector2i(3, 3)), "wall lookup is not mutated by external changes")
	test.assert_true(world.is_walkable_pos(GridPos.new(1, 1)))
	test.assert_true(not world.is_walkable_pos(GridPos.new(0, 1)))

func test_move_result_represents_outcomes_and_copies_positions(test):
	var start := GridPos.new(0, 0)
	var destination := GridPos.new(1, 0)
	var moved := MoveResult.moved(start, destination)
	start.x = 5
	destination.y = 3

	test.assert_true(moved.is_moved())
	test.assert_true(moved.start.equals(GridPos.new(0, 0)), "start is copied, not referenced")
	test.assert_true(moved.destination.equals(GridPos.new(1, 0)), "destination is copied, not referenced")
	test.assert_equal(moved.block_reason, MoveResult.BlockReason.NONE)

	var blocked_position := GridPos.new(2, 2)
	var blocked := MoveResult.blocked(blocked_position, MoveResult.BlockReason.WALL)
	blocked_position.x = 9

	test.assert_true(blocked.is_blocked())
	test.assert_true(blocked.start.equals(GridPos.new(2, 2)))
	test.assert_true(blocked.destination.equals(GridPos.new(2, 2)))
	test.assert_equal(blocked.block_reason, MoveResult.BlockReason.WALL)
