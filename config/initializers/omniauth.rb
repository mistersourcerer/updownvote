Rails.application.config.middleware.use OmniAuth::Builder do
  configuration = YAML::load_file("config/omniauth.yml")[Rails.env.to_s]
  provider :github,
    configuration[:github][:consumer_key],
    configuration[:github][:consumer_secret]
end
