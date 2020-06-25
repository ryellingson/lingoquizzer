class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  belongs_to :language
  has_rich_text :content
end
