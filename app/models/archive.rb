class Archive < ActiveRecord::Base
  attr_accessible :title
  has_many :records, dependent: :destroy
end
