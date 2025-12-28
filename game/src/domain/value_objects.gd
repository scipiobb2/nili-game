extends RefCounted
class_name GridPos

var x: int
var y: int

func _init(x: int = 0, y: int = 0):
    self.x = x
    self.y = y

func translated(offset: Vector2i) -> GridPos:
    return GridPos.new(x + offset.x, y + offset.y)

func equals(other: GridPos) -> bool:
    if other == null:
        return false
    return x == other.x and y == other.y

func manhattan_distance_to(other: GridPos) -> int:
    if other == null:
        return INF
    return abs(other.x - x) + abs(other.y - y)

func to_string() -> String:
    return "GridPos(%d, %d)" % [x, y]
