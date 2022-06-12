class Game
  attr_reader :character_number
  attr_reader :turn_direction

  def initialize(character_number, turn_direction: -1, attack_direction: -1)
    raise ArgumentError.new("this game is not fun - character_number must be greater than 1") if character_number <= 1
    @character_number = character_number.to_i
    # validate and store directions
    @turn_direction = valid_direction(turn_direction)
    @attack_direction = valid_direction(attack_direction)
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
    return 1 if direction > 0
    return -1 if direction < 0
    return 0
  end

  def new_character_list
    Array.new(@character_number) do |i|
      Knight.new(i+1)
    end
  end

  def next_move!
    @move_number += 1
    puts "#{current_acting_character.name} is active"
    # roll the dice
    dice = rand(1..6)
    # do the damage
    make_damage(closest_alive_character(@attack_direction), dice)
    advance_turn
  end

  def make_damage(target, amount)
    attacker = current_acting_character
    puts "#{attacker.name} (#{attacker.energy}) attacks #{target.name} (#{target.energy}) #{amount}with #{amount} damage"
    current_acting_character.make_damage(target, amount)
    if target.dead?
      puts "#{target.name} is dead"
    end
  end

  def advance_turn
    if @turn_direction == 0
      @current_acting_character_index = alive_character_ids.excluding(@current_acting_character_index).sample
    else
      # advance the turn to the closest alive character
      @current_acting_character_index = closest_alive_character_id(@turn_direction)
    end
  end

  def alive_character_ids
    @characters.enum_for(:each_with_index).select{|character, index| character.alive?}.map{|character, id| id}
  end

  def closest_alive_character_id(direction = 1)
    direction = random_direction if direction == 0
    # from the alive character ids choose the next or previous
    new_id_index = (alive_character_ids.find_index(@current_acting_character_index) + direction) % alive_character_ids.size
    # that was an index in array of indexes, too meta
    alive_character_ids[new_id_index]
  end

  # returns 1 or -1 at random
  def random_direction
    (rand(0..1) * 2) - 1
  end

  def current_acting_character
    @characters[@current_acting_character_index]
  end

  def closest_alive_character(direction)
    @characters[closest_alive_character_id(direction)]
  end
end
