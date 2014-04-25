class Tweet < ActiveRecord::Base
  attr_accessible :record_id, :tweet_text

  belongs_to :record
end
