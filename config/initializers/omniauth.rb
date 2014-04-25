Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Figaro.env.twitter_api_key, Figaro.env.twitter_api_secret
end
