extends RefCounted

var counter := 0

func _before():
	counter = 0

func _after():
	counter = -1

func test_truthiness(test):
	counter += 1
	test.assert_true(true, "sanity check true is true")
	test.assert_equal(counter, 1, "setup hook ran per test")

func test_math(test):
	counter += 2
	test.assert_equal(2 + 2, 4, "basic arithmetic works")
	test.assert_equal(counter, 2, "teardown resets counter before each test")
