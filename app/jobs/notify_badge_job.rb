class NotifyBadgeJob < ApplicationJob
  queue_as :default

  def perform(user_id, badge_id)
    # Do something later
    user = User.find(user_id)
    badge = Merit::Badge.find(badge_id)
    UserChannel.broadcast_to(user,
      type: 'badge',
      badge: badge,
      badge_image_url: ActionController::Base.helpers.image_url(badge.custom_fields["image_path"])
    )
  end
end
