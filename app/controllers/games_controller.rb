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
    if params[:genre].present?
      @games = @games.where(genre: params[:genre])
    end
  end

  def show
    #create an instance variable assigning problems to the game instance
    @game = Game.find(params[:id])
    game_badges = Merit::Badge.find do |badge|
      badge.custom_fields[:game_slug] == @game.slug && @game.language.language_code == badge.custom_fields[:language_code]
    end
    @badge = game_badges.first unless !current_user || current_user.badges.include?(game_badges.first)
    authorize @game
    # Initializes a Markdown parser
    @description = @game.markdown_content

    send "init_#{@game.genre}"

    # the above is an alternative to the case

    # case @game.genre
    # when "table_game" then init_table_game
    # when "number_guess" then init_number_guess
    # end
  rescue NoMethodError
    render :show
    # this was created for the place holder genre, if a game doesn't need specific configuration then it doesn't need one of the init methods below, if you don't have an init it won't crash
  end

  private

  def init_table_game
    @problems = @game.icon_based ? @game.problems.sample(@game.problem_count) : @game.problems.shuffle
  end

  def init_number_guess
    json_file_path = Rails.root + "db/data/#{@game.language.name}/#{@game.slug}.json"
    @numbers = JSON.parse(File.read(json_file_path))
  end

  # We are initializing through the API
  # def init_classic_quiz
  #   @problems = [ Problem.new(question: "食べる", game: @game) ]
  # end
end
