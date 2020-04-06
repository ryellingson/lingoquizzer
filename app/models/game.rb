class Game < ApplicationRecord
  has_many :problems, dependent: :destroy
end
