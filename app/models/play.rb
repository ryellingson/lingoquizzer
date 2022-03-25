class Play < ApplicationRecord
  belongs_to :user
  belongs_to :game

  ICON_PROBLEM_COUNT = 30
  CLASSIC_PROBLEM_COUNT = 20

  def perfect_score
    if game.icon_based
      ICON_PROBLEM_COUNT
    elsif game.genre == "classic_quiz"
      CLASSIC_PROBLEM_COUNT
    else
      game.problems.count
    end
  end

  # update for classic quiz, maybe remove true

  def perfect?
    case game.genre
      when "table_game" then count == perfect_score
      when "number_guess" then score.positive?
      else true # defines that by default completing a game is enough to get the badge
    end
  end
end
