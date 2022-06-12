class Game
  attr_reader :character_number
  attr_reader :turn_direction

  def initialize(character_number, turn_direction: -1)
    @character_number = character_number
    # validate and store turn direction
    @turn_direction = valid_direction(turn_direction)
    # generate a list of characters
    @characters = new_character_list
    # grant the right of move to the first characte
    @current_acting_character_index = alive_character_ids.first
    # initialize the moves counter
    @move_number = 0
  end

  def finished?
    # is there more than one character left alive?
    alive_character_ids.size == 1
  end

  def play!
    while !finished?
      next_move!
    end
    winner
  end

  def winner
    raise "The game needs to be played first" unless finished?
    @characters[alive_character_ids.last]
  end

  private

  def valid_direction(direction)
    direction >= 0 ? 1 : -1
  end

  def new_character_list
    Array.new(@character_number) do |i|
      Knight.new(i+1)
    end
  end

  def next_move!
    @move_number += 1
    # roll the dice
    dice = rand(1..6)
    # do the damage
    current_acting_character.make_damage(next_acting_character, dice)
    # advance the turn to the closest alive character
    @current_acting_character_index = closest_alive_character_id(@turn_direction)
  end

  def alive_character_ids
    @characters.enum_for(:each_with_index).select{|character, index| character.alive?}.map{|character, id| id}
  end

  def closest_alive_character_id(direction = 1)
    # from the alive character ids choose the next or previous
    new_id_index = (alive_character_ids.find_index(@current_acting_character_index) + direction) % alive_character_ids.size
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
