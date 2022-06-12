class Character
  attr_reader :name
  attr_reader :energy
  BASE_NAME = "Character"

  def initialize(number, energy=100)
    @name = "#{BASE_NAME} #{number}"
    @energy = energy
  end

  def dead?
    @energy <= 0
  end

  def alive?
    !dead?
  end

  def take_damage(amount)
    @energy -= amount
    if dead?
      @energy = 0
      puts "#{@name} is dead"
    end
  end

  def make_damage(to_character, amount)
    puts "#{@name} (#{@energy}) rolled #{amount} and hits #{to_character.name} (#{to_character.energy})"
    to_character.take_damage(amount)
  end
end
