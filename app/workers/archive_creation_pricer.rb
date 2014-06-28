class ArchiveCreationPricer

  @queue = :archive_creation_pricer

  def self.perform(archive_data)

    require 'chain_api'

    # create account and address

    account_address = Chain::ChainAPI.new({}).getaccountaddress

    archive = Archive.find archive_data['id']

    # price archive
    # Rate Alexandria pays for distributed archiving per concurrent archive per day
    archive_make_pay = 0.0004
    puts "archive_make_pay: #{archive_make_pay}"

    # Target number of active archivers per archive
    target_archivers_per_archive = 10
    puts "target_archivers_per_archive: #{target_archivers_per_archive}"

    # Storage lease price per GB per month
    lease_gb_month = 0.02
    puts "lease_gb_month: #{lease_gb_month}"

    # Target number of active seeders per archive
    target_seed = 50
    puts "target_seed: #{target_seed}"

    client = Twitter::REST::Client.new do |config|

      config.consumer_key    = Figaro.env.twitter_api_key

      config.consumer_secret = Figaro.env.twitter_api_secret

    end

    page_text_array = []

    if archive['archive_type'] == 'username'

      tweets = client.user_timeline(archive['archive_term'], options = {count: 200, include_rts: 1})

    elsif archive['archive_type'] == 'search'

      tweets = client.search(archive['archive_term'], result_type: 'recent').take(200)

    end

    tweets.each do |message|

      tweet_details = {
        'tweet_id' => message.id,
        'favorite_count' => message.favorite_count,
        'filter_level' => message.filter_level,
        'in_reply_to_screen_name' => message.in_reply_to_screen_name,
        'in_reply_to_attrs_id' => message.in_reply_to_attrs_id,
        'in_reply_to_status_id' => message.in_reply_to_status_id,
        'in_reply_to_user_id' => message.in_reply_to_user_id,
        'lang' => message.lang,
        'retweet_count' => message.retweet_count,
        'source' => message.source,
        'tweet_text' => message.text,
        'created_date' => message.created_at.to_i
      }

      page_text_array << tweet_details

    end

    last_id = tweets.last.id

    5.times do |index| 

      if archive['archive_type'] == 'username'

        tweetz = client.user_timeline(archive['archive_term'], options = {count: 200, include_rts: 1, max_id: last_id})

      elsif archive['archive_type'] == 'search'

        tweetz = client.search(archive['archive_term'], result_type: 'recent', max_id: last_id).take(200)

      end

      tweetz.each do |tweet|

        tweet_details = {
          'tweet_id' => tweet.id,
          'favorite_count' => tweet.favorite_count,
          'filter_level' => tweet.filter_level,
          'in_reply_to_screen_name' => tweet.in_reply_to_screen_name,
          'in_reply_to_attrs_id' => tweet.in_reply_to_attrs_id,
          'in_reply_to_status_id' => tweet.in_reply_to_status_id,
          'in_reply_to_user_id' => tweet.in_reply_to_user_id,
          'lang' => tweet.lang,
          'retweet_count' => tweet.retweet_count,
          'source' => tweet.source,
          'tweet_text' => tweet.text,
          'created_date' => tweet.created_at.to_i
        }

        page_text_array << tweet_details
        
      end

      if index == 4

        archive['archive_start_date'] = Time.at(tweetz.first['created_at'].to_i)

        archive[:archive_start_date_formatted] = DateTime.strptime(archive[:archive_start_date].to_i.to_s,'%s').strftime '%b %d'

      end

      last_id = tweetz.last.id

    end

    volume = archive.volumes.create volume_title: "#{archive_data['archive_title']}_volume_1" 

    volume.save

    page = volume.pages.create page_title: "#{volume['volume_title']}_page_1_#{page_text_array.count}tweets", page_text: page_text_array.to_json

    page.save

    # Number of tweets in Volume 1, Page 1 of an archive
    volume1_page1_tweets = page_text_array.count
    puts "volume1_page1_tweets: #{volume1_page1_tweets}"

    # Timestamp of earliest tweet in Volume 1, Page 1 of an archive
    volume1_page1_oldest = Date.new(2014, 6, 1).to_time.to_i
    puts "volume1_page1_oldest: #{volume1_page1_oldest}"

    # Timestamp of when Volume 1, Page 1 of an archive is created
    volume1_page1_time = Date.new(2014, 6, 21).to_time.to_i
    puts "volume1_page1_time: #{volume1_page1_time}"

    # Size of first page of first volume of archive (bytes)
    volume1_page1_size = volume1_page1_tweets * 500
    puts "volume1_page1_size: #{volume1_page1_size}"

    # Rate of new tweets per minute
    tweet_rate = volume1_page1_tweets.to_f / ((volume1_page1_time - volume1_page1_oldest) / 60)
    puts "Tweet rate: #{tweet_rate}"

    # Estimated number of pages per month with zero new tweets in them
    estimated_zero_page_tweets = 365 / 12 * 24 * 60 * (1 - tweet_rate)
    puts "estimated_zero_page_tweets: #{estimated_zero_page_tweets}"

    # Estimated number of pages per month with one tweet in them
    estimated_one_page_tweets = 365 / 12 * 24 * 60 * (tweet_rate)
    puts "estimated_one_page_tweets: #{estimated_one_page_tweets}"

    # Estimated size of archive per month (bytes)
    archive_size_month = volume1_page1_size + (estimated_zero_page_tweets * 63) + (estimated_one_page_tweets * 600)
    puts "archive_size_month: #{archive_size_month}"

    # Total estimated size of archive (in bytes)
    archive_total_size_calc = archive_size_month  * archive.archive_time_length
    puts "archive_total_size_calc: #{archive_total_size_calc}"

    # Cost to make archive (per month)
    archive_make_cost = archive_make_pay * target_archivers_per_archive * 365 / 12
    puts "archive_make_cost: #{archive_make_cost}"

    # 12 months of storage (per month of archiving)
    annual_archive_storage_cost = lease_gb_month * target_seed / ( 1024 * 1024 * 1024) * archive_size_month * 12
    puts "annual_archive_storage_cost: #{annual_archive_storage_cost}"

    # Total price per month of creating a new archive (including 1 year of storage)
    archive_create_price_per_month = archive_make_cost + annual_archive_storage_cost
    puts "archive_create_price_per_month: #{archive_create_price_per_month}"

    final_archive_cost = sprintf('%.2f', (annual_archive_storage_cost + archive_make_cost) * archive.archive_time_length)
    puts "final_archive_cost: #{final_archive_cost}"

    # final_archive_cost -> btc
    final_archive_cost_btc = sprintf('%.8f', final_archive_cost.to_f * HTTParty.get('https://coinbase.com/api/v1/currencies/exchange_rates')['usd_to_btc'].to_f)
    puts "final_archive_cost_btc: #{final_archive_cost_btc}"

    # final_archive_cost -> ltc
    final_archive_cost_ltc = sprintf('%.8f', final_archive_cost_btc.to_f / HTTParty.get('http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=3')['return']['markets']['LTC']['lasttradeprice'].to_f)
    puts "final_archive_cost_ltc: #{final_archive_cost_ltc}"

    # final_archive_cost -> flo
    final_archive_cost_flo = sprintf('%.8f', final_archive_cost_ltc.to_f / HTTParty.get('http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=61')['return']['markets']['FLO']['lasttradeprice'].to_f)
    puts "final_archive_cost_flo: #{final_archive_cost_flo}"

    # update model
    archive[:florincoin_price] = final_archive_cost_flo

    archive[:florincoin_address] = account_address['accountaddress']

    archive.save

    # create delayed job to check for transaction confirmation
    Archive.delay({run_at: 60.seconds.from_now}).confirm_transaction({account: account_address['account']}, archive)
  end
end
