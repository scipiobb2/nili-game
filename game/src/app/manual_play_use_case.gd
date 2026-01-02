extends RefCounted
class_name ManualPlayUseCase

var _world: GridWorld
var _movement_service: MovementService
var _initial_position: GridPos
var _current_position: GridPos

func _init(world: GridWorld, movement_service: MovementService, start_position: GridPos = null):
  assert(world != null, "ManualPlayUseCase requires a world")
  assert(movement_service != null, "ManualPlayUseCase requires a movement_service")
  _world = world
  _movement_service = movement_service
  _initial_position = start_position if start_position != null else GridPos.new(world.start.x, world.start.y)
  _current_position = GridPos.new(_initial_position.x, _initial_position.y)

  assert(_world.is_within_bounds(Vector2i(_initial_position.x, _initial_position.y)), "Start position must be within world bounds")

func try_move(direction: Vector2i) -> MoveResult:
  var result := _movement_service.try_move(_world, _current_position, direction)
  if result.is_moved():
    _current_position = GridPos.new(result.destination.x, result.destination.y)
  return result

func reset():
  _current_position = GridPos.new(_initial_position.x, _initial_position.y)

func get_state() -> GameStateDTO:
  return GameStateDTO.new(_world, _initial_position, _current_position)

func get_current_position() -> GridPos:
  return GridPos.new(_current_position.x, _current_position.y)
