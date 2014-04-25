class SessionsController < ApplicationController
  def create
    puts request.env['omniauth.auth']
    puts env["omniauth.params"]
    @success = 'SUCCESS!'
    #@users = HTTParty.get("https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=twitterapi&count=2")
    puts "USers: #{@users}"
  end

  def failure
    @failure = params
  end

  def application_only
    require 'open-uri'
    require 'base64'

    bearer_token = HTTParty.post('https://api.twitter.com/1.1/oauth2/token',
      query: { grant_type: 'client_credentials' },
      headers: { 
        'Authorization' => "BASIC #{Base64.encode64("#{URI::encode(Figaro.env.twitter_api_key)}:#{URI::encode(Figaro.env.twitter_api_secret)}")}",
        'Content-Type' => 'application/x-www-form-urlencoded;charset=UTF-8',
      }
    )
    puts bearer_token
  end
end
