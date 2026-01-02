extends RefCounted

func test_try_move_moves_into_open_tile(test):
        var world := GridWorld.new(
                3,
                3,
                GridPos.new(1, 1),
                GridPos.new(2, 2),
                [Vector2i(2, 1)]
        )
        var start := GridPos.new(1, 1)
        var result := MovementService.new().try_move(world, start, Vector2i.LEFT)

        test.assert_true(result.is_moved())
        test.assert_true(start.equals(GridPos.new(1, 1)), "original position is not mutated")
        test.assert_true(result.destination.equals(GridPos.new(0, 1)))
        test.assert_equal(result.block_reason, MoveResult.BlockReason.NONE)


func test_try_move_blocks_on_wall(test):
        var world := GridWorld.new(
                4,
                4,
                GridPos.new(0, 0),
                GridPos.new(3, 3),
                [Vector2i(1, 0)]
        )
        var start := GridPos.new(0, 0)
        var result := MovementService.new().try_move(world, start, Vector2i.RIGHT)

        test.assert_true(result.is_blocked())
        test.assert_true(result.start.equals(start))
        test.assert_true(result.destination.equals(start))
        test.assert_equal(result.block_reason, MoveResult.BlockReason.WALL)


func test_try_move_blocks_out_of_bounds(test):
        var world := GridWorld.new(
                2,
                2,
                GridPos.new(0, 0),
                GridPos.new(1, 1),
                []
        )
        var start := GridPos.new(0, 0)
        var result := MovementService.new().try_move(world, start, Vector2i.LEFT)

        test.assert_true(result.is_blocked())
        test.assert_true(result.start.equals(start))
        test.assert_true(result.destination.equals(start))
        test.assert_equal(result.block_reason, MoveResult.BlockReason.OUT_OF_BOUNDS)
