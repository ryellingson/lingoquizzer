class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    #select the game by id and store it in a variable creating an instance
    @game = Game.find(params[:id])
    #create an instance variable assigning problems to the game instance
    if @game.icon_based
      @problems = @game.problems.sample(33)
    else
      @problems = @game.problems.shuffle
    end
  end
end
