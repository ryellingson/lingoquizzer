class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @games = policy_scope(Game)
  end

  def show
    #create an instance variable assigning problems to the game instance
    @game = Game.find(params[:id])
    authorize @game
    # Initializes a Markdown parser
    @description = @game.markdown_content
    if @game.icon_based
      @problems = @game.problems.sample(36)
    else
      @problems = @game.problems.shuffle
    end
  end
end
