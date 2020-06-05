class Problem < ApplicationRecord
  belongs_to :game
  has_many :answers
end
