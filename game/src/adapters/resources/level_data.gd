extends Resource
class_name LevelData

const GridWorld := preload("res://src/domain/grid/grid_world.gd")
const GridPos := preload("res://src/domain/value_objects.gd")

@export var width: int = 0
@export var height: int = 0
@export var start: Vector2i = Vector2i.ZERO
@export var goal: Vector2i = Vector2i.ZERO
@export var walls: Array[Vector2i] = []
@export var tile_size: float = 64.0

func create_world() -> GridWorld:
  var start_pos := GridPos.new(start.x, start.y)
  var goal_pos := GridPos.new(goal.x, goal.y)
  return GridWorld.new(width, height, start_pos, goal_pos, walls)
