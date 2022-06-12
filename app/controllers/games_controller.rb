class GamesController < ApplicationController
  def new

  end

  def create
    @game = Game.new(
      params[:character_number].to_i,
      turn_direction: params[:turn_direction].to_i,
      attack_direction: params[:attack_direction].to_i
    )
    @game.play!
  end
end
