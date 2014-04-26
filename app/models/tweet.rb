class Tweet < ActiveRecord::Base
  attr_accessible :record_id, :tweet_text, :created_date

  belongs_to :record
end
