class GamesController < ApplicationController
  def new
    @page_title = "Start new Game of Knights"
  end
  
  def create
    @game = Game.new(
      params[:character_number].to_i,
      turn_direction: params[:turn_direction].to_i,
      attack_direction: params[:attack_direction].to_i,
      witches_percentage: params[:witches_percentage].to_i,
    )
    @game.play!
    @page_title = "Game of #{@game.character_number} Knights"
  end
end
