class ArchiveCreationPricer
  @queue = :archive_creation_pricer
  def self.perform(archive)
    puts archive
  end
end
