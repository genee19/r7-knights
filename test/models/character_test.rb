require "test_helper"

class CharacterTest < ActiveSupport::TestCase
  test "generate name" do
    character = Character.new(1)
    assert_equal "Character 1", character.name
    character = Character.new(2)
    assert_equal "Character 2", character.name
  end

  test "take damage" do
    character = Character.new(1, 100)
    assert_equal 100, character.energy
    character.take_damage(5)
    assert_equal 95, character.energy
    character.take_damage(95)
    assert_equal 0, character.energy
    assert character.dead?, "When all energy is expleted, character is dead"

    character = Character.new(1, 5)
    assert_equal 5, character.energy
    character.take_damage(6)
    assert_equal 0, character.energy, "Energy cannot go below zero"
    assert character.dead?, "When all energy is expleted, character is dead"
    refute character.alive?, "Alive is literally opposite from the dead"
  end
end
