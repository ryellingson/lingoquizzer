class ReputationChangeObserver
  def update(changed_data)
    # description = changed_data[:description]

    # If user is your meritable model, you can query for it doing:
    user = User.where(sash_id: changed_data[:sash_id]).first
    badge = Merit::Badge.find(changed_data[:merit_object][:badge_id])

    NotifyBadgeJob.set(wait: 5.seconds).perform_later(user.id, badge.id)
    # When did it happened:
    # datetime = changed_data[:granted_at]
  end
end
