class ArchiveCreationPricer
  @queue = :archive_creation_pricer
  def self.perform(archive_data)
    require 'chain_api'
    # create account and address
    accountaddress = Chain::ChainAPI.new({}).getaccountaddress

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

    # Number of tweets in Volume 1, Page 1 of an archive
    volume1_page1_tweets = 1300
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

    # update model
    archive[:florincoin_price] = archive_create_price_per_month * archive.archive_time_length
    archive[:florincoin_address] = accountaddress['accountaddress']
    archive.save

    # create delayed job to check for transaction confirmation
    Archive.delay({run_at: 60.seconds.from_now}).confirm_transaction({account: accountaddress['account']}, archive)
  end
end
