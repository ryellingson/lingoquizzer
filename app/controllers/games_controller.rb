class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @games = policy_scope(Game)
  end

  def show
    #select the game by id and store it in a variable creating an instance
    @game = Game.find(params[:id])
    authorize @game
    #create an instance variable assigning problems to the game instance
    if @game.icon_based
      @problems = @game.problems.sample(32)
    else
      @problems = @game.problems.shuffle
    end
  end
end
