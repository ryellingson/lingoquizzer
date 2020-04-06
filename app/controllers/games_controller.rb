class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @problems = @game.problems
  end
end
