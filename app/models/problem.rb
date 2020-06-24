class Problem < ApplicationRecord
  belongs_to :game
  has_many :answers, dependent: :destroy
  has_one_attached :problem_icon
end
