class Witch < Character
  def initialize(id, energy = 50)
    super(id, energy)
  end

  def make_damage(target, dice_value)
    dice_value *= 2 if target.instance_of?(Knight)
    super(target, dice_value)
  end

  private

  def base_name
    "Witch"
  end
end
