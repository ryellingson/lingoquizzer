class UsersController < ApplicationController
  # before_filter :show_online, only: [:new]

  def show
    @user = User.find(params[:id])
    authorize @user
    @online_users = User.where("last_seen_at > ?", 5.minutes.ago)
  end
end
