class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :comment, required: false
  has_many :comments, dependent: :destroy
  alias_method :replies, :comments
  alias_method :parent_comment, :comment
end
