require "test_helper"

class GameTest < ActiveSupport::TestCase
  test "should be playable only with enough players" do
    error = assert_raises ArgumentError do
      bad_game = Game.new(0)
    end
    assert_equal "this game is not fun - character_number must be greater than 1", error.message

    error = assert_raises ArgumentError do
      solo_game = Game.new(1)
    end
    assert_equal "this game is not fun - character_number must be greater than 1", error.message
  end
end
