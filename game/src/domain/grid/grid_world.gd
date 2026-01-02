extends RefCounted
class_name GridWorld

var width: int
var height: int
var start: GridPos
var goal: GridPos
var walls: Array[Vector2i]

var _wall_lookup: Dictionary = {}

func _init(_width: int, _height: int, _start: GridPos, _goal: GridPos, wall_positions: Array = []):
	width = _width
	height = _height
	start = GridPos.new(_start.x, _start.y)
	goal = GridPos.new(_goal.x, _goal.y)
	walls = []

	for wall in wall_positions:
		var coordinate: Vector2i
		if wall is GridPos:
			coordinate = Vector2i(wall.x, wall.y)
		else:
			coordinate = Vector2i(wall)

		walls.append(coordinate)
		_wall_lookup[coordinate] = true

func is_within_bounds(position: Vector2i) -> bool:
	return position.x >= 0 and position.y >= 0 and position.x < width and position.y < height

func is_wall(position: Vector2i) -> bool:
	return _wall_lookup.has(position)

func is_goal(position: GridPos) -> bool:
	return position.equals(goal)

func is_walkable(position: Vector2i) -> bool:
	return is_within_bounds(position) and not is_wall(position)
