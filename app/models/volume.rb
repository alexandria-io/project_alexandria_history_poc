class Volume < ActiveRecord::Base

  attr_accessible :archive_id, :volume_title, :volume_start_date, :volume_end_date

  belongs_to :archive

  has_many :pages, dependent: :destroy

end
