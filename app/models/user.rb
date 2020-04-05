class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_writer :login

  validates :email, uniqueness: true
  validates :username, uniqueness: true

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]

  def login
    @login || self.username || self.email
  end
end
