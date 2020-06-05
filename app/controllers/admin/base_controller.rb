class Admin::BaseController < ApplicationController
  before_action :admin_check

  def admin_check
    unless current_user.admin?
      # head is equivalent to a rendering
      head(403)
    end
  end
end
