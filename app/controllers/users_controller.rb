class UsersController < ApplicationController
  # before_filter :show_online, only: [:new]

  def profile
    skip_authorization
    redirect_to user_path(current_user)
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end
end
