Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins [
      # Local server
      %r{\Ahttps?://localhost:\d{4}},
      # Heroku
      %r{\Ahttps?://lingoquizzer\.herokapp\.com}
    ]
    resource '*', headers: :any, methods: [:get, :post, :patch, :put]
  end
end
