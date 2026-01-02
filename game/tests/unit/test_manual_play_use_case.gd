func build_world(width: int, height: int, start: GridPos, goal: GridPos, walls: Array[Vector2i] = []) -> GridWorld:
  return GridWorld.new(width, height, start, goal, walls)

func test_defaults_to_world_start(test):
  var world := build_world(3, 3, GridPos.new(1, 1), GridPos.new(2, 2))
  var use_case := ManualPlayUseCase.new(world, MovementService.new())

  var state: GameStateDTO = use_case.get_state()
  test.assert_true(state.current_position.equals(world.start), "current position starts at world.start")


func test_try_move_updates_position_on_success(test):
  var world := build_world(3, 3, GridPos.new(0, 0), GridPos.new(2, 2))
  var use_case := ManualPlayUseCase.new(world, MovementService.new())

  var result := use_case.try_move(Vector2i.RIGHT)
  var state: GameStateDTO = use_case.get_state()

  test.assert_true(result.is_moved(), "move should succeed")
  test.assert_true(state.current_position.equals(GridPos.new(1, 0)), "position updated after move")


func test_try_move_keeps_position_when_blocked(test):
  var world := build_world(3, 3, GridPos.new(1, 1), GridPos.new(2, 2), [Vector2i(2, 1)])
  var use_case := ManualPlayUseCase.new(world, MovementService.new())

  var result := use_case.try_move(Vector2i.RIGHT)
  var state: GameStateDTO = use_case.get_state()

  test.assert_true(result.is_blocked(), "blocked move reported")
  test.assert_true(state.current_position.equals(GridPos.new(1, 1)), "position unchanged after blocked move")


func test_reset_restores_start_position(test):
  var world := build_world(4, 4, GridPos.new(1, 1), GridPos.new(3, 3))
  var use_case := ManualPlayUseCase.new(world, MovementService.new())

  use_case.try_move(Vector2i.DOWN)
  test.assert_true(use_case.get_current_position().equals(GridPos.new(1, 2)), "position moved before reset")

  use_case.reset()

  test.assert_true(use_case.get_current_position().equals(GridPos.new(1, 1)), "reset returns to initial position")


func test_get_state_returns_copies(test):
  var world := build_world(3, 3, GridPos.new(0, 0), GridPos.new(2, 2))
  var use_case := ManualPlayUseCase.new(world, MovementService.new())

  var state: GameStateDTO = use_case.get_state()
  state.current_position.x = 5

  test.assert_true(use_case.get_current_position().equals(GridPos.new(0, 0)), "mutating state copy does not affect use case")
