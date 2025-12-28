extends RefCounted

const GridPos = preload("res://src/domain/value_objects.gd")

func test_translation(test):
    var origin := GridPos.new(1, 2)
    var moved := origin.translated(Vector2i(3, -1))

    test.assert_true(origin.equals(GridPos.new(1, 2)), "original position retains coordinates")
    test.assert_true(moved.equals(GridPos.new(4, 1)), "translated position reflects offset")
    test.assert_true(not moved.equals(origin), "translated position is distinct from original")

func test_string_and_distance(test):
    var origin := GridPos.new(1, 2)
    var moved := GridPos.new(4, 1)

    test.assert_equal(origin.to_string(), "GridPos(1, 2)")
    test.assert_equal(origin.manhattan_distance_to(moved), 3, "manhattan distance matches offset")

func test_vector_supports_approx(test):
    var start := GridPos.new(0, 0)
    var result := start.translated(Vector2i(1, 1))
    test.assert_near(Vector2(result.x, result.y), Vector2(1.00001, 0.99999))
