class Game < ApplicationRecord
  validates :name, uniqueness: :true
  has_many :problems, dependent: :destroy
  has_many :plays, dependent: :destroy
end
