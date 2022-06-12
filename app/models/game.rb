class Game
  def initialize(character_number)
    @character_number = character_number
    # generate a list of characters
    @characters = new_character_list
    @current_acting_character_index = alive_character_ids.first
    @move_number = 0
  end

  def finished?
    # is there more than one character left alive?
    alive_character_ids.size == 1
  end

  def play!
    while !finished?
      @move_number += 1
      next_move!
    end

    @winner = @characters[alive_character_ids.last]
  end

  def winner
    raise "The game needs to be played first" unless finished?
    @winner
  end

  private

  def new_character_list
    Array.new(@character_number) do |i|
      Character.new("Character #{i+1}")
    end
  end

  def next_move!
    # roll the dice
    dice = rand(1..6)
    # do the damage
    current_acting_character.make_damage(next_acting_character, dice)
    # advance the turn to move to the next alive character
    @current_acting_character_index = closest_alive_character_id
  end

  def alive_character_ids
    @characters.enum_for(:each_with_index).select{|character, index| character.alive?}.map{|character, id| id}
  end

  def closest_alive_character_id
    # from the alive character ids choose the next or previous
    new_id_index = (alive_character_ids.find_index(@current_acting_character_index) + 1) % alive_character_ids.size
    # that was an index in array of indexes, too meta
    alive_character_ids[new_id_index]
  end

  def current_acting_character
    @characters[@current_acting_character_index]
  end

  def next_acting_character
    @characters[closest_alive_character_id]
  end
end
