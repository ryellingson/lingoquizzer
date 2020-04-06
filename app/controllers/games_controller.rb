class GamesController < ApplicationController
  def show
    #select the game by id and store it in a variable
    @game = Game.find(params[:id])
    @problems = @game.problems
  end
end
