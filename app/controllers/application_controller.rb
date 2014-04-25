class ApplicationController < ActionController::Base
  protect_from_forgery

  def return_twitter_client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key    = Figaro.env.twitter_api_key
      config.consumer_secret = Figaro.env.twitter_api_secret
    end
  end
end
