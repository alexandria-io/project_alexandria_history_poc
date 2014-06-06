require 'chain_api'
class Librarian < ActiveRecord::Base
  attr_accessible :title

  def self.check_for_requested_archives
    #create account and address
    puts 'checking for requested archive'
    transactions = Chain::ChainAPI.new({account: ''}).listtransactions
    transactions['transactions'].each do |transaction|
      if transaction['amount'].to_i >= 1 && transaction['confirmations'].to_i >= 1 && transaction['txid'] == Figaro.env.tmp_tx
        Librarian.delay({run_at: 5.seconds.from_now}).create_archive(JSON.parse(transaction['tx-comment']))
      end
    end
  end

  def self.create_archive(archive_details)
    puts 'creating archive'
    puts "`scp /public/robots.txt #{Figaro.env.torrent_username}@#{Figaro.env.torrent_box}:/root/`" 
    puts 'file copied'
     
    client = Twitter::REST::Client.new do |config|
      config.consumer_key    = Figaro.env.twitter_api_key
      config.consumer_secret = Figaro.env.twitter_api_secret
    end
    tweets = client.user_timeline(archive_details['term'], options = {count: 200, include_rts: 1})
    puts tweets
    tweets.each do |tweet|
      File.open("#{RAILS_ROOT}/tmp/myfile_#{Process.pid}", 'a') do |f|
        f.write "#{tweet.text}\n"
      end
    end

    #transactions = Chain::ChainAPI.new({account: ''}).listtransactions
    #transactions.each do |transaction|
    #  if transaction['amount'] >= 1 && transaction['confirmations'] >= 1 && transaction['txid'] == Figaro.env.tmp_tx
    #    transaction_comment = JSON.parse transaction['tx-comment']
    #    puts transaction_comment

    #    #client = return_twitter_client
    #    #tweets = client.user_timeline(term, options = {count: 200, include_rts: 1})
    #  end
    #end
  end
end
