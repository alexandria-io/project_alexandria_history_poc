class WelcomeController < ApplicationController
  def index
    @archives = Archive.all
    #client = return_twitter_client
    #tweets = client.user_timeline(@archives.first.title, options = {count: 200, include_rts: true})
    #tweets.each do |tweet|
    #  puts tweet['created_at']
    #end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @archives }
    end
  end

  def brainwallet
  end

  def demos
  end
end
