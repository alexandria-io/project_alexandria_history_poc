class ArchiveCreationPricer
  @queue = :archive_creation_pricer
  def self.perform(archive_data)
    #create account
#create address
#update model
    archive = Archive.find archive_data['id']
    archive[:florincoin_price] = 1000
    archive.save
    puts archive
  end
end
