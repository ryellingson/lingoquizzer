class Language < ApplicationRecord
  has_many :games
  has_many :posts
  has_many :messages
  validates :name, uniqueness: true
  validates :language_code, uniqueness: true
end
