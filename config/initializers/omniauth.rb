Rails.application.config.middleware.use OmniAuth::Builder do
  configuration = Rails.application.config.omniauth
  provider :github,
    configuration[:github][:consumer_key],
    configuration[:github][:consumer_secret]
end
