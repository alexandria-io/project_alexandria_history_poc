class Record < ActiveRecord::Base
  attr_accessible :archive_id, :record_text, :record_type

  belongs_to :archive
end
