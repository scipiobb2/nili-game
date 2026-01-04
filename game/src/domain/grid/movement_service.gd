extends RefCounted
class_name MovementService

func try_move(world: GridWorld, position: GridPos, direction: Vector2i) -> MoveResult:
		assert(world != null, "MovementService.try_move requires a world")
		assert(position != null, "MovementService.try_move requires a position")

		var destination := position.translated(direction)
		var destination_vector := Vector2i(destination.x, destination.y)

		if not world.is_within_bounds(destination_vector):
				return MoveResult.blocked(position, MoveResult.BlockReason.OUT_OF_BOUNDS)

		if world.is_wall(destination_vector):
				return MoveResult.blocked(position, MoveResult.BlockReason.WALL)

		return MoveResult.moved(position, destination)
