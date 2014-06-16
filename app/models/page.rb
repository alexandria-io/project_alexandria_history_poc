class Page < ActiveRecord::Base
  attr_accessible :page_text, :page_title, :volume_id
  belongs_to :volume

  def self.write_page(archive, volume)
    puts 'Page: writing page'
    client = Twitter::REST::Client.new do |config|
      config.consumer_key    = Figaro.env.twitter_api_key
      config.consumer_secret = Figaro.env.twitter_api_secret
    end

    if archive['archive_type'] == 'search'
      tweets = client.search(archive['archive_term'], result_type: 'recent').take(200).collect
    else 
      tweets = client.user_timeline(archive['archive_term'], options = {count: 200, include_rts: 1})
    end
    
    page_text_array = []
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
      #record = archive.records.create(tweet_details)
      #record.save

      page_text_array << tweet_details
    end
    mapped_page_text_array = page_text_array.map do |x| 
      x.except('favorite_count', 'filter_level', 'in_reply_to_screen_name', 'in_reply_to_attrs_id', 'in_reply_to_status_id', 'in_reply_to_user_id', 'lang', 'retweet_count', 'source', 'tweet_text', 'created_date')
    end

    pages = volume.pages
    unless pages.empty?

      difference = []
      complete_array = []

      pages.each do |page|
        existing_page_array = JSON.parse(page.page_text)

        mapped_existing_page_array = existing_page_array.map do |x| 
          x.except('favorite_count', 'filter_level', 'in_reply_to_screen_name', 'in_reply_to_attrs_id', 'in_reply_to_status_id', 'in_reply_to_user_id', 'lang', 'retweet_count', 'source', 'tweet_text', 'created_date')
        end

        complete_array = complete_array | mapped_existing_page_array
      end

      current_difference = mapped_page_text_array - complete_array 

      unless current_difference.empty?
        difference << current_difference
      end
    end

    unless difference.nil?
      remapped_page_text_array = [] 
      page_text_array.map do |x| 
        difference.each do |tweet_hash|
          if tweet_hash[0]['tweet_id'] == x['tweet_id']
            remapped_page_text_array << x
          end
        end
      end
    end

    page = volume.pages.create page_title: "#{volume['volume_title']}_page_#{pages.nil? ? '1' : (pages.count + 1)}", page_text: (pages.empty? ? page_text_array.to_json : (difference.empty? ?  difference.to_json : remapped_page_text_array.to_json))
    page.save

    if pages.count < 5
      Page.delay({run_at: 10.seconds.from_now}).write_page(archive, volume)
    else
      Resque.enqueue(VolumeCreator, archive)
      Resque.enqueue(TorrentCreator, archive, volume)
    end

  end
end
