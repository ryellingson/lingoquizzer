class Play < ApplicationRecord
  belongs_to :user
  belongs_to :game

  def perfect_score
    game.icon_based ? 36 : game.problems.count
  end

  def perfect?
    count == perfect_score
  end
end
