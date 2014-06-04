class Archive < ActiveRecord::Base
  attr_accessible :archive_term, :archive_type, :florincoin_address, :florincoin_price

  has_many :records, dependent: :destroy
end
