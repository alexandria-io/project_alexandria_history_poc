class ArchiveCreationPricer
  @queue = :archive_creation_pricer
  def self.perform(archive_data)
    require 'chain_api'
    #create account and address
    accountaddress = Chain::ChainAPI.new({}).getaccountaddress

    #update model
    archive = Archive.find archive_data['id']
    archive[:florincoin_price] = 2
    archive[:florincoin_address] = accountaddress['accountaddress']
    archive.save

    ##create delayed job to check for transaction confirmation
    Archive.delay({run_at: 10.seconds.from_now}).confirm_transaction({account: accountaddress['account']}, archive)
  end
end
