class Record < ActiveRecord::Base
  attr_accessible :archive_id, :record_type

  belongs_to :archive
  has_one :tweet, dependent: :destroy
end
