module GamesHelper
  def direction_description(direction)
    return 'previous' if direction == -1
    return 'next' if direction == 1
    return 'random'
  end
end
