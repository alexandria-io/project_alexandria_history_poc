class Volume < ActiveRecord::Base
  attr_accessible :archive_id, :volume_title
  belongs_to :archive
  has_many :pages, dependent: :destroy
end
