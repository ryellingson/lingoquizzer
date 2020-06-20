class UsersController < ApplicationController
  before_filter :show_online, only: [:new]
  def show
    @user = User.find(params[:id])
  end
end
