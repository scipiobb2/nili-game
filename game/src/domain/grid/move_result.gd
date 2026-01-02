extends RefCounted
class_name MoveResult

enum Outcome { MOVED, BLOCKED }
enum BlockReason { NONE, WALL, OUT_OF_BOUNDS }

var outcome: Outcome
var start: GridPos
var destination: GridPos
var block_reason: BlockReason

func _init(_outcome: Outcome, _start: GridPos, _destination: GridPos, _block_reason: BlockReason = BlockReason.NONE):
	outcome = _outcome
	start = GridPos.new(_start.x, _start.y)
	destination = GridPos.new(_destination.x, _destination.y)
	block_reason = _block_reason

static func moved(from: GridPos, to: GridPos) -> MoveResult:
	return MoveResult.new(Outcome.MOVED, from, to, BlockReason.NONE)

static func blocked(at: GridPos, reason: BlockReason) -> MoveResult:
	return MoveResult.new(Outcome.BLOCKED, at, at, reason)

func is_moved() -> bool:
	return outcome == Outcome.MOVED

func is_blocked() -> bool:
	return outcome == Outcome.BLOCKED
