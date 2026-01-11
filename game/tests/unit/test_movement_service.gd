extends RefCounted

class GridWorldTestBuilder:
	var size := Vector2i.ONE
	var start := GridPos.new(0, 0)
	var goal := GridPos.new(0, 0)
	var walls: Array[Vector2i] = []

	func with_size(width: int, height: int) -> GridWorldTestBuilder:
		size = Vector2i(width, height)
		return self

	func with_start(start_pos: GridPos) -> GridWorldTestBuilder:
		start = start_pos
		return self

	func with_goal(goal_pos: GridPos) -> GridWorldTestBuilder:
		goal = goal_pos
		return self

	func with_walls(wall_positions: Array[Vector2i]) -> GridWorldTestBuilder:
		walls = wall_positions.duplicate()
		return self

	func build() -> GridWorld:
		return GridWorld.new(size.x, size.y, start, goal, walls)

func grid_world_builder() -> GridWorldTestBuilder:
	return GridWorldTestBuilder.new()

func test_try_move_table_driven_cases(test):
	var cases := [
		{
			"name": "moves_into_open_tile",
			"world_builder": func() -> GridWorld:
				return grid_world_builder() \
					.with_size(3, 3) \
					.with_start(GridPos.new(1, 1)) \
					.with_goal(GridPos.new(2, 2)) \
					.with_walls([Vector2i(2, 1)]) \
					.build(),
			"start": GridPos.new(1, 1),
			"direction": Vector2i.LEFT,
			"expected_outcome": MoveResult.Outcome.MOVED,
			"expected_destination": GridPos.new(0, 1),
			"expected_block_reason": MoveResult.BlockReason.NONE,
		},
		{
			"name": "blocks_on_wall",
			"world_builder": func() -> GridWorld:
				return grid_world_builder() \
					.with_size(4, 4) \
					.with_start(GridPos.new(0, 0)) \
					.with_goal(GridPos.new(3, 3)) \
					.with_walls([Vector2i(1, 0)]) \
					.build(),
			"start": GridPos.new(0, 0),
			"direction": Vector2i.RIGHT,
			"expected_outcome": MoveResult.Outcome.BLOCKED,
			"expected_destination": GridPos.new(0, 0),
			"expected_block_reason": MoveResult.BlockReason.WALL,
		},
		{
			"name": "blocks_out_of_bounds",
			"world_builder": func() -> GridWorld:
				return grid_world_builder() \
					.with_size(2, 2) \
					.with_start(GridPos.new(0, 0)) \
					.with_goal(GridPos.new(1, 1)) \
					.build(),
			"start": GridPos.new(0, 0),
			"direction": Vector2i.LEFT,
			"expected_outcome": MoveResult.Outcome.BLOCKED,
			"expected_destination": GridPos.new(0, 0),
			"expected_block_reason": MoveResult.BlockReason.OUT_OF_BOUNDS,
		},
	]

	for case in cases:
		_assert_move_outcome(
			test,
			case["name"],
			case["world_builder"].call(),
			case["start"],
			case["direction"],
			case["expected_outcome"],
			case["expected_destination"],
			case["expected_block_reason"]
		)


func test_try_move_is_deterministic_for_repeated_attempts(test):
	var world_builder := func() -> GridWorld:
		return grid_world_builder() \
			.with_size(3, 3) \
			.with_start(GridPos.new(1, 1)) \
			.with_goal(GridPos.new(2, 2)) \
			.build()

	var start := GridPos.new(1, 1)
	var direction := Vector2i.DOWN
	var service := MovementService.new()
	var first_result := service.try_move(world_builder.call(), start, direction)
	var second_result := service.try_move(world_builder.call(), start, direction)

	_assert_results_match(test, first_result, second_result, "results should match across attempts")
	_assert_move_result_properties(test, first_result, start, MoveResult.Outcome.MOVED, GridPos.new(1, 2), MoveResult.BlockReason.NONE)


func _assert_move_outcome(
	test,
	name: String,
	world: GridWorld,
	start: GridPos,
	direction: Vector2i,
	expected_outcome: MoveResult.Outcome,
	expected_destination: GridPos,
	expected_block_reason: MoveResult.BlockReason
):
	var service := MovementService.new()
	var original_start := GridPos.new(start.x, start.y)
	var result := service.try_move(world, start, direction)

	test.assert_true(start.equals(original_start), "%s: original position is not mutated" % name)
	_assert_move_result_properties(test, result, start, expected_outcome, expected_destination, expected_block_reason, name)


func _assert_move_result_properties(
	test,
	result: MoveResult,
	expected_start: GridPos,
	expected_outcome: MoveResult.Outcome,
	expected_destination: GridPos,
	expected_block_reason: MoveResult.BlockReason,
	case_name: String = ""
):
	var prefix := case_name if case_name != "" else "movement"
	if expected_outcome == MoveResult.Outcome.MOVED:
		test.assert_true(result.is_moved(), "%s: expected move" % prefix)
	else:
		test.assert_true(result.is_blocked(), "%s: expected blocked" % prefix)

	test.assert_true(result.start.equals(expected_start), "%s: start preserved" % prefix)
	test.assert_true(result.destination.equals(expected_destination), "%s: destination match" % prefix)
	test.assert_equal(result.block_reason, expected_block_reason, "%s: block reason match" % prefix)


func _assert_results_match(test, left: MoveResult, right: MoveResult, message: String):
	test.assert_equal(left.outcome, right.outcome, message)
	test.assert_true(left.start.equals(right.start), message)
	test.assert_true(left.destination.equals(right.destination), message)
	test.assert_equal(left.block_reason, right.block_reason, message)
