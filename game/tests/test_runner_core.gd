extends RefCounted

class TestContext:
	var test_name: String
	var assertions: Array

	func _init(_test_name: String):
		self.test_name = _test_name
		assertions = []

	func assert_true(condition: bool, message: String = ""):
		var passed := condition == true
		var msg := message if passed and message != "" else "Expected condition to be true"
		_record_assertion(condition, msg)

	func assert_equal(actual, expected, message: String = ""):
		var passed := _values_equal(actual, expected)
		var msg := message if passed and message != "" else "Expected %s to equal %s" % [str(actual), str(expected)]
		_record_assertion(passed, msg)

	func assert_near(actual, expected, message: String = ""):
		var passed := _values_equal(actual, expected)
		var msg := message if passed and message != "" else "Expected %s to approximately equal %s" % [str(actual), str(expected)]
		_record_assertion(passed, msg)

	func failures() -> Array:
		var failed := []
		for assertion in assertions:
			if not assertion.get("passed", false):
				failed.append(assertion.get("message", "Assertion failed"))
		return failed

	func _record_assertion(passed: bool, message: String):
		assertions.append({"passed": passed, "message": message})

	func _values_equal(actual, expected) -> bool:
		if actual is float or expected is float:
			return is_equal_approx(actual, expected)

		if (actual is Vector2 or actual is Vector2i) and (expected is Vector2 or expected is Vector2i):
			return Vector2(actual).is_equal_approx(Vector2(expected))

		if (actual is Vector3 or actual is Vector3i) and (expected is Vector3 or expected is Vector3i):
			return Vector3(actual).is_equal_approx(Vector3(expected))

		return actual == expected


class TestCaseResult:
	var name: String
	var passed: bool
	var failure_messages: Array

	func _init(_name: String, _passed: bool, _failure_messages: Array = []):
		self.name = _name
		self.passed = _passed
		self.failure_messages = _failure_messages


class TestResult:
	var file_path: String
	var case_results: Array[TestCaseResult]

	func _init(_file_path: String, _case_results: Array[TestCaseResult]):
		self.file_path = _file_path
		self.case_results = _case_results

	func passed() -> bool:
		for case in case_results:
			if not case.passed:
				return false
		return true


class TestRunner:
	const UNIT_TEST_DIR := "res://tests/unit"

	func run() -> int:
		var test_paths := _discover_tests_recursive(UNIT_TEST_DIR)
		if test_paths.is_empty():
			print("No tests found in %s" % UNIT_TEST_DIR)
			return 0

		var failed_files := []

		for path in test_paths:
			var result: TestResult = _run_test_file(path)
			var friendly := _friendly_name(path)
			for case in result.case_results:
				if case.passed:
					print("[PASS] %s :: %s" % [friendly, case.name])
				else:
					failed_files.append(path)
					var reason := "Unknown failure" if case.failure_messages.is_empty() else "; ".join(case.failure_messages)
					print("[FAIL] %s :: %s -- %s" % [friendly, case.name, reason])

		if failed_files.is_empty():
			print("All tests passed (%d files)." % test_paths.size())
			return 0

		var unique_failed := {}
		for path in failed_files:
			unique_failed[path] = true
		print("%d test file(s) failed." % unique_failed.size())
		return 1

	func _discover_tests_recursive(dir_path: String) -> Array:
		var paths := []
		var dir := DirAccess.open(dir_path)
		if dir == null:
			push_error("Unable to open %s" % dir_path)
			return paths

		dir.list_dir_begin()
		while true:
			var file := dir.get_next()
			if file == "":
				break
			if file.begins_with("."):
				continue
			var full_path := "%s/%s" % [dir_path, file]
			if dir.current_is_dir():
				paths.append_array(_discover_tests_recursive(full_path))
				continue
			if file.begins_with("test_") and file.ends_with(".gd"):
				paths.append(full_path)
		dir.list_dir_end()
		paths.sort()
		return paths

	func _run_test_file(path: String) -> TestResult:
		var script := load(path)
		if script == null:
			return TestResult.new(path, [TestCaseResult.new("load_script", false, ["Could not load script"])])

		var instance = script.new()
		var test_methods := _get_test_methods(instance)

		if test_methods.is_empty():
			if instance.has_method("run"):
				test_methods.append("run")
			else:
				var missing_case := TestCaseResult.new("no_tests", false, ["No test_ methods or run(context) found"])
				return TestResult.new(path, [missing_case])

		var case_results: Array[TestCaseResult] = []

		for method_name in test_methods:
			var context := TestContext.new(method_name)

			if instance.has_method("_before"):
				instance._before()

			instance.call(method_name, context)

			if instance.has_method("_after"):
				instance._after()

			var failures := context.failures()
			var passed := failures.is_empty()
			case_results.append(TestCaseResult.new(method_name, passed, failures))

		return TestResult.new(path, case_results)

	func _get_test_methods(instance) -> Array[String]:
		var methods: Array[String] = []
		for method_data in instance.get_method_list():
			var name: String = method_data.name
			if name.begins_with("test_"):
				methods.append(name)
		methods.sort()
		return methods

	func _friendly_name(path: String) -> String:
		return path.get_file().trim_suffix(".gd")
