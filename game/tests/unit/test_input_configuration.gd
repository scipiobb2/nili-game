extends RefCounted

const REQUIRED_ACTIONS := [
  "move_up",
  "move_down",
  "move_left",
  "move_right",
  "restart",
]

func test_project_has_required_inputs(test):
  InputMap.load_from_project_settings()

  for action in REQUIRED_ACTIONS:
    test.assert_true(
      InputMap.has_action(action),
      "Project Settings missing required action: %s" % action
    )
