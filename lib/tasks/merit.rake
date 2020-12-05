namespace :merit do
  task :delete_user_badges do |task, args|
    puts "delete user badges"
    User.all.each do |user|
      Merit::BadgesSash.where(sash_id: user.sash_id).pluck(:badge_id).each do |badge_id|
        user.rm_badge(badge_id)
      end
    end
    puts "job done"
  end
end
