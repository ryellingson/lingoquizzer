class GamesController < ApplicationController
  def show
    #select the game by id and store it in a variable creating an instance
    @game = Game.find(params[:id])
    #create an instance variable assigning problems to the game instance
    @problems = @game.problems
  end
end
