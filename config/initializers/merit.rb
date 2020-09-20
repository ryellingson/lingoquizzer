# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  config.checks_on_each_request = true

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'

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
  path = Rails.root.join("app/assets/images/badges/games/perfect_plays/#{language_code}")

  filenames = Dir.children(path).map { |e| e.split('.') }
  filenames.each do |fname|
    badges << {
      id: (badge_id = badge_id+1),
      name: fname[1],
      custom_fields: {
        image_path: "badges/games/perfect_plays/#{language_code}/#{fname.join('.')}",
        game_slug: fname[0],
        language_code: language_code
      }
    }
  end
end


badges.each do |attrs|
  Merit::Badge.create! attrs
end
