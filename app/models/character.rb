class Character
  def initialize(energy=100)
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
end
