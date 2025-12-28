extends SceneTree

const TestRunnerCore = preload("res://tests/test_runner_core.gd")

func _init():
	var runner := TestRunnerCore.TestRunner.new()
	var exit_code := runner.run()
	quit(exit_code)
