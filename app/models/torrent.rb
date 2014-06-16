class Torrent < ActiveRecord::Base
  attr_accessible :archive_id, :title

  belongs_to :archive
end
