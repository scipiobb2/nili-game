extends RefCounted
class_name GameStateDTO

var world: GridWorld
var initial_position: GridPos
var current_position: GridPos

func _init(world: GridWorld, initial_position: GridPos, current_position: GridPos):
  self.world = world
  self.initial_position = GridPos.new(initial_position.x, initial_position.y)
  self.current_position = GridPos.new(current_position.x, current_position.y)

func copy() -> GameStateDTO:
  return GameStateDTO.new(world, initial_position, current_position)
