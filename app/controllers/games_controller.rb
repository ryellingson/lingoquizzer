class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @games = policy_scope(Game)
    if params[:language].present?
      @games = @games.where(language: Language.find_by(language_code: params[:language]))
    end
    if params[:difficulty].present?
      @games = @games.where(difficulty: params[:difficulty])
    end
    if params[:category].present?
      @games = @games.where(category: params[:category])
    end
  end

  def show
    #create an instance variable assigning problems to the game instance
    @game = Game.find(params[:id])
    perfect_badges = Merit::Badge.find do |badge|
      badge.custom_fields[:game_slug] == @game.slug && @game.language.language_code == badge.custom_fields[:language_code]
    end
    @perfect_badge = perfect_badges.first unless !current_user || current_user.badges.include?(perfect_badges.first)
    authorize @game
    # Initializes a Markdown parser
    @description = @game.markdown_content
    if @game.icon_based
      @problems = @game.problems.sample(30)
    else
      @problems = @game.problems.shuffle
    end
  end
end
