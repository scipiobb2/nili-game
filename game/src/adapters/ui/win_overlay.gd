extends Control
class_name WinOverlay

signal replay_pressed
signal next_pressed

@onready var _replay_button: Button = $PanelContainer/MarginContainer/Content/ReplayButton
@onready var _next_button: Button = $PanelContainer/MarginContainer/Content/NextButton

func _ready() -> void:
	if _replay_button != null:
		_replay_button.pressed.connect(_on_replay_pressed)
	if _next_button != null:
		_next_button.pressed.connect(_on_next_pressed)

func show_overlay() -> void:
	visible = true
	if _replay_button != null:
		_replay_button.grab_focus()

func hide_overlay() -> void:
	visible = false

func _on_replay_pressed() -> void:
	replay_pressed.emit()

func _on_next_pressed() -> void:
	next_pressed.emit()
