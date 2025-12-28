extends Node

const TestRunnerCore = preload("res://tests/test_runner_core.gd")

func _ready():
	var runner := TestRunnerCore.TestRunner.new()
	var exit_code := runner.run()
	get_tree().quit(exit_code)
