class Language < ApplicationRecord
  has_many :games
  has_many :posts
  has_many :messages
end
