class Play < ApplicationRecord
  belongs_to :user
  belongs_to :game

  def perfect?
    if game.icon_based
      count == 36
    else
      count == game.problems.count
    end
  end
end
