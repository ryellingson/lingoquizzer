# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  config.checks_on_each_request = true

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'
  config.add_observer 'ReputationChangeObserver'

  # Define :user_model_name. This model will be used to grant badge if no
  # `:to` option is given. Default is 'User'.
  # config.user_model_name = 'User'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
  # config.current_user_method = 'current_user'
end

# Create application badges (uses https://github.com/norman/ambry)

badge_id = 0

badges = []

Language.all.pluck(:language_code).each do |language_code|
  games_path = Rails.root.join("app/assets/images/badges/games/perfect_plays/#{language_code}")

  pp_filenames = Dir.children(games_path)
  pp_filenames.delete('.DS_Store')
  pp_filenames.map { |e| e.split('.') }.each do |fname|
    badges << {
      id: (badge_id = badge_id+1),
      name: fname[1],
      description: fname[1].gsub("_", " ").titleize,
      custom_fields: {
        image_path: "badges/games/perfect_plays/#{language_code}/#{fname.join('.')}",
        game_slug: fname[0],
        language_code: language_code
      }
    }
  end
end

conversations_path = Rails.root.join("app/assets/images/badges/conversations/")

conversations_filenames = Dir.children(conversations_path)
conversations_filenames.delete('.DS_Store')
conversations_filenames.map { |e| e.split('.') }.each do |fname|
  badges << {
    id: (badge_id = badge_id+1),
    name: fname[0],
    description: fname[1].gsub("_", " ").titleize,
    custom_fields: {
      image_path: "badges/conversations/#{fname.join('.')}"
    }
  }
end

general_path = Rails.root.join("app/assets/images/badges/general/")

general_filenames = Dir.children(general_path)
general_filenames.delete('.DS_Store')
general_filenames.map { |e| e.split('.') }.each do |fname|
  badges << {
    id: (badge_id = badge_id+1),
    name: fname[0],
    description: fname[1].gsub("_", " ").titleize,
    custom_fields: {
      image_path: "badges/general/#{fname.join('.')}"
    }
  }
end

stats_path = Rails.root.join("app/assets/images/badges/stats/")

stats_filenames = Dir.children(stats_path)
stats_filenames.delete('.DS_Store')
stats_filenames.map { |e| e.split('.') }.each do |fname|
  badges << {
    id: (badge_id = badge_id+1),
    name: fname[0],
    description: fname[1].gsub("_", " ").titleize,
    custom_fields: {
      image_path: "badges/stats/#{fname.join('.')}"
    }
  }
end

badges.each do |attrs|
  Merit::Badge.create! attrs
end
