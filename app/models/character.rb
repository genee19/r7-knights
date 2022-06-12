class Character
  attr_reader :name
  attr_reader :energy

  def initialize(number, energy=100)
    @name = "#{base_name} #{number}"
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
    end
  end

  def make_damage(to_character, amount)
    to_character.take_damage(amount)
  end

  private

  def base_name
    "Character"
  end
end
