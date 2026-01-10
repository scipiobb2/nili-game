extends RefCounted
class_name GameStateDTO

var world: GridWorld
var initial_position: GridPos
var current_position: GridPos

func _init(_world: GridWorld, _initial_position: GridPos, _current_position: GridPos):
	self.world = _world
	self.initial_position = GridPos.new(initial_position.x, _initial_position.y)
	self.current_position = GridPos.new(current_position.x, _current_position.y)

func copy() -> GameStateDTO:
	return GameStateDTO.new(world, initial_position, current_position)
