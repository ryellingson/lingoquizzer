class UsersController < ApplicationController
  # before_filter :show_online, only: [:new]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @online_users = User.where("last_seen_at > ?", 5.minutes.ago)
  end
end
