class Play < ApplicationRecord
  belongs_to :user
  belongs_to :game

  # this method was made obsolete from game.problem_count
  # def perfect_score 
  #   if game.icon_based
  #     Game::ICON_PROBLEM_COUNT
  #   elsif game.genre == "classic_quiz"
  #     Game::CLASSIC_PROBLEM_COUNT
  #   else
  #     game.problems.count
  #   end
  # end

  def perfect?
    case game.genre
      when "number_guess" then score.positive?
      else count == game.problem_count # default behavior
    end
  end
end
