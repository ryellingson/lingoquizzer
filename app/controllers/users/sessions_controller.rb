# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :html, :js
  after_action :add_user_cookie, only: :create
  after_action :remove_user_cookie, only: :destroy
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.banned?
      sign_out resource
      flash[:notice] = "This account has been suspended for violation of...."
      root_path
    else
      super
    end
  end

  def add_user_cookie
    cookies.signed[:user_id] = current_user.id
  end

  def remove_user_cookie
    cookies.delete(:user_id)
  end



  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
