class Message < ApplicationRecord
  belongs_to :user
  belongs_to :language
  has_rich_text :content
end
