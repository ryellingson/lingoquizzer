class ReputationChangeObserver
  def update(changed_data)
    # description = changed_data[:description]

    # If user is your meritable model, you can query for it doing:
    user = User.where(sash_id: changed_data[:sash_id]).first
    badge = Merit::Badge.find(changed_data[:merit_object][:badge_id])
    ActionCable.server.broadcast("user_#{user.id}",
      type: 'badge',
      badge: badge,
      badge_image_url: ActionController::Base.helpers.image_url(badge.custom_fields[:image_path])
    )


    # When did it happened:
    # datetime = changed_data[:granted_at]
  end
end
