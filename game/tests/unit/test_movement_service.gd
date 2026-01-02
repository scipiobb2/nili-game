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

func test_try_move_moves_into_open_tile(test):
  var world := grid_world_builder() \
    .with_size(3, 3) \
    .with_start(GridPos.new(1, 1)) \
    .with_goal(GridPos.new(2, 2)) \
    .with_walls([Vector2i(2, 1)]) \
    .build()
  var start := GridPos.new(1, 1)
  var result := MovementService.new().try_move(world, start, Vector2i.LEFT)

  test.assert_true(result.is_moved())
  test.assert_true(start.equals(GridPos.new(1, 1)), "original position is not mutated")
  test.assert_true(result.destination.equals(GridPos.new(0, 1)))
  test.assert_equal(result.block_reason, MoveResult.BlockReason.NONE)


func test_try_move_blocks_on_wall(test):
  var world := grid_world_builder() \
    .with_size(4, 4) \
    .with_start(GridPos.new(0, 0)) \
    .with_goal(GridPos.new(3, 3)) \
    .with_walls([Vector2i(1, 0)]) \
    .build()
  var start := GridPos.new(0, 0)
  var result := MovementService.new().try_move(world, start, Vector2i.RIGHT)

  test.assert_true(result.is_blocked())
  test.assert_true(result.start.equals(start))
  test.assert_true(result.destination.equals(start))
  test.assert_equal(result.block_reason, MoveResult.BlockReason.WALL)


func test_try_move_blocks_out_of_bounds(test):
  var world := grid_world_builder() \
    .with_size(2, 2) \
    .with_start(GridPos.new(0, 0)) \
    .with_goal(GridPos.new(1, 1)) \
    .build()
  var start := GridPos.new(0, 0)
  var result := MovementService.new().try_move(world, start, Vector2i.LEFT)

  test.assert_true(result.is_blocked())
  test.assert_true(result.start.equals(start))
  test.assert_true(result.destination.equals(start))
  test.assert_equal(result.block_reason, MoveResult.BlockReason.OUT_OF_BOUNDS)
