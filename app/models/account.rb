class Account < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :address, :name, :slug
  friendly_id :address, use: :slugged

  has_many :archives
end
