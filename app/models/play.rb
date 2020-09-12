class Play < ApplicationRecord
  belongs_to :user
  belongs_to :game

  def perfect?
    count == game.answers.count
  end
end
