class Record < ActiveRecord::Base
  attr_accessible :archive_item_id, :record_type

  belongs_to :archive_item
  has_one :tweet, dependent: :destroy
end
