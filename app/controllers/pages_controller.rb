class PagesController < ApplicationController
  def home
  end

  def user_profile
  end

  def leaderboards
    @games = Game.all
  end
end
