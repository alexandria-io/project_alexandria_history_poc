class ArchiveCreationPricer
  @queue = :archive_creation_pricer
  def self.perform(archive_data, request_params)
    require 'chain_api'
    #create account and address
    accountaddress = Chain::ChainAPI.new(request_params).getaccountaddress

    #update model
    archive = Archive.find archive_data['id']
    archive[:florincoin_price] = 1000
    archive[:florincoin_address] = accountaddress['accountaddress']
    archive.save
  end
end
