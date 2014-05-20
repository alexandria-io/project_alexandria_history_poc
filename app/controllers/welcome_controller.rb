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

  def new_archive
    secret = "#{`rake secret`}".gsub("\n","")
    account_name = secret[0, 40]
    newaddress  = HTTParty.get "#{Figaro.env.florincoin_blockchain_ip}command?command=getaccountaddress&account=#{account_name}", 
      headers: {
        'Content-Type' => 'application/json', 
        'Gitcoin-API-Auth-Token' => 'tmp for now of course'
      }   
    @account = Account.create address: newaddress['account_address'], name: account_name

    @archive = Account.last.archives.new
    @archive_item = @archive.archive_items.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end
end
