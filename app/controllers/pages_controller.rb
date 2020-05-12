class PagesController < ApplicationController
  def home
  end

  def index
  end

  def forum
    @messages = Message.all
    @message = Message.new
  end

  def user_profile
  end
end
