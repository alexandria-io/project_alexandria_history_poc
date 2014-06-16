class Record < ActiveRecord::Base
  attr_accessible :archive_id, :favorite_count, :filter_level, :in_reply_to_screen_name, :in_reply_to_attrs_id, :in_reply_to_status_id, :in_reply_to_user_id, :lang, :retweet_count, :source, :tweet_text, :created_date

  belongs_to :archive
end
