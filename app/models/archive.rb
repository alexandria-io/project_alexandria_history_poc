class Archive < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :title, :archive_items_attributes, :slug
  friendly_id :title, use: :slugged

  has_many :archive_items, dependent: :destroy
  belongs_to :account

  accepts_nested_attributes_for :archive_items, allow_destroy: true

end
