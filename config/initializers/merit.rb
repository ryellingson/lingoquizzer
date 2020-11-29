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
badge_jsons = ["001_100_stats.json", "101_200_general.json", "201_300_conversations.json", "301_400_perfect_plays.json"]

badge_jsons.each do |json|
  JSON.parse(File.read(Rails.root + "db/data/badges/#{json}")).each do |attrs|
    Merit::Badge.create! attrs
  end
end
