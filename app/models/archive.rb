class Archive < ActiveRecord::Base
  attr_accessible :title, :archive_items_attributes

  has_many :archive_items, dependent: :destroy

  accepts_nested_attributes_for :archive_items, allow_destroy: true
end
