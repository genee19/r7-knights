require "test_helper"

class KnightTest < ActiveSupport::TestCase
  test "generate name" do
    character = Knight.new(1)
    assert_equal "Knight 1", character.name
    character = Knight.new(2)
    assert_equal "Knight 2", character.name
  end

  test "take damage" do
    character = Knight.new(1, 100)
    assert_equal 100, character.energy
    character.take_damage(5)
    assert_equal 95, character.energy
    assert character.alive?, "With some energy, the character is not yet dead"
    character.take_damage(95)
    assert_equal 0, character.energy
    assert character.dead?, "When all energy is expleted, character is dead"

    character = Knight.new(1, 5)
    assert_equal 5, character.energy
    character.take_damage(6)
    assert_equal 0, character.energy, "Energy cannot go below zero"
    assert character.dead?, "When all energy is expleted, character is dead"
    refute character.alive?, "Alive is literally opposite from the dead"
  end

  test "make damage to a knight" do
    attacker = Knight.new(1, 10)
    assert_equal 10, attacker.energy
    target = Knight.new(2, 10)
    assert_equal 10, target.energy

    attacker.make_damage(target, 5)
    assert_equal 10, attacker.energy, "Attacker's energy should stay intact"
    assert attacker.alive?
    assert_equal 5, target.energy, "Target's energy should deplete as a result of an attack"
    assert target.alive?

    attacker.make_damage(target, 10)
    assert_equal 10, attacker.energy, "Attacker's energy should stay intact"
    assert attacker.alive?
    assert_equal 0, target.energy, "Target's energy should deplete as a result of an attack"
    assert target.dead?
  end
end
