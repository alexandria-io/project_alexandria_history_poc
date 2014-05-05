class ArchiveItem < ActiveRecord::Base
  attr_accessible :archive_id, :item_term, :item_type

  belongs_to :archive
  has_many :records, dependent: :destroy
end
