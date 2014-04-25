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
end
