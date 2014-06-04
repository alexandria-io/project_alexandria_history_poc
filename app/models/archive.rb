class Archive < ActiveRecord::Base
  attr_accessible :archive_term, :archive_type

  has_many :records, dependent: :destroy
end
