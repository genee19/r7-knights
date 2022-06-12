class Character
  attr_reader :name

  def initialize(name, energy=100)
    @name = name
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
end
