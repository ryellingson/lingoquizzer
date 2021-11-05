class Play < ApplicationRecord
  belongs_to :user
  belongs_to :game

  ICON_PROBLEM_COUNT = 30

  def perfect_score
    game.icon_based ? ICON_PROBLEM_COUNT : game.problems.count
  end

  def perfect?
    case game.genre
      when "table_game" then count == perfect_score
      # when "number_guess" then true
      else true # defines that by default completing a game is enough to get the badge
    end
  end
end
