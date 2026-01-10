extends Node2D

const ManualPlayUseCase := preload("res://src/app/manual_play_use_case.gd")
const MovementService := preload("res://src/domain/grid/movement_service.gd")
const GridWorld := preload("res://src/domain/grid/grid_world.gd")
const LevelData := preload("res://src/adapters/resources/level_data.gd")
const MoveResult := preload("res://src/domain/grid/move_result.gd")

@onready var _input_adapter: ManualInputAdapter = $ManualInputAdapter
@onready var _world_view: WorldView = $WorldView
@onready var _hero_view: HeroView = $WorldView/HeroView
@onready var _action_log: ActionLog = $HUD/ActionLog

var _manual_play: ManualPlayUseCase
var _level_config: LevelData

@export var level_data: LevelData

const DEFAULT_LEVEL_PATH := "res://src/adapters/resources/demo_level.tres"

func _ready() -> void:
	_connect_input()
	_initialize_world()
	_sync_hero_to_state()

func _connect_input() -> void:
	_input_adapter.move_attempted.connect(_on_move_attempted)
	_input_adapter.restart_requested.connect(_on_restart_requested)

func _initialize_world() -> void:
	_level_config = _load_level_data()
	var world := _build_world()
	_manual_play = ManualPlayUseCase.new(world, MovementService.new())

	_world_view.tile_size = _level_config.tile_size
	_world_view.set_world(world)

	_hero_view.tile_size = _level_config.tile_size

func _build_world() -> GridWorld:
	return _level_config.create_world()

func _load_level_data() -> LevelData:
	if level_data != null:
		return level_data

	var loaded_level: LevelData = load(DEFAULT_LEVEL_PATH)
	if loaded_level == null:
		push_error("Unable to load default level data at %s" % DEFAULT_LEVEL_PATH)
		return LevelData.new()

	return loaded_level

func _on_move_attempted(direction: Vector2i) -> void:
	if _manual_play == null:
		return

	var result := _manual_play.try_move(direction)
	_record_action_attempt(direction, result)
	_sync_hero_to_state()

func _on_restart_requested() -> void:
	if _manual_play == null:
		return

	_manual_play.reset()
	_action_log.clear_entries()
	_sync_hero_to_state()

func _sync_hero_to_state() -> void:
	var position := _manual_play.get_current_position()
	_hero_view.set_grid_position(position)

func get_current_grid_position() -> GridPos:
	if _manual_play == null:
		return GridPos.new()
	return _manual_play.get_current_position()

func _record_action_attempt(direction: Vector2i, result: MoveResult) -> void:
	if _action_log == null:
		return

	_action_log.add_entry(direction, result)
