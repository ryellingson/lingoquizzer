class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :update_last_seen_at, if: -> { user_signed_in? && (current_user.last_seen_at.nil? || current_user.last_seen_at < 5.minutes.ago) }
  before_action :authenticate_user!
  before_action :set_online_users
  layout :layout_by_resource
  before_action :banned?
  before_action :check_badges, if: :user_signed_in?

  include Pundit
  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?
  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end
  private

  def check_badges
    grant_badge('community member') if current_user.created_at <= Date.today - 1.month
    grant_badge('community leader') if current_user.created_at <= Date.today - 1.year
  end

  def grant_badge(badge_name)
    badge = Merit::Badge.all.find { |badge| badge.name == badge_name }
    current_user.add_badge(badge.id) unless current_user.badges.include?(badge)
    # Merit::Judge.notify_observers(
    #       description: I18n.t("merit.granted_badge", badge_name: badge.name),
    #       merit_object: current_user.sash,
    #       sash_id: current_user.sash_id
    #     )
  end

  def banned?
    if current_user.present? && current_user.banned?
      sign_out current_user
      flash[:notice] = "This account has been suspended..."
      root_path
    end
  end

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

  def set_online_users
    @online_users = User.where("last_seen_at > ?", 5.minutes.ago)
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def update_last_seen_at
    logger.info "Update last seen at timestamp for user id #{current_user.id}"
    current_user.update_attribute(:last_seen_at, Time.current)
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :avatar, :city, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
