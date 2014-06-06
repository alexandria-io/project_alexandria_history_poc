class Archive < ActiveRecord::Base
  attr_accessible :archive_term, :archive_type, :florincoin_address, :florincoin_price

  has_many :records, dependent: :destroy

  def self.confirm_transaction(request_options, archive)
    require 'chain_api'
    transactions = Chain::ChainAPI.new(request_options).listtransactions
    if transactions['transactions'].empty?
      puts 'nope no transactions. checking again in 10 seconds'
      Archive.delay({run_at: 10.seconds.from_now}).confirm_transaction(request_options, archive)
    else 
      transactions_spent_total = 0
      transactions['transactions'].each do |transaction|
        unless transaction['address'] != archive['florincoin_address'] || transaction['confirmations'] <= 0
          transactions_spent_total += transaction['amount']
        end
      end

      if transactions_spent_total >= archive['florincoin_price'] 
        require 'chain_api'
        # get account of recently created archive/address
        account = Chain::ChainAPI.new({address: archive['florincoin_address']}).getaccount

        # get account address for ''
        default_account_address = Chain::ChainAPI.new({account: ''}).getaccountaddress

        # send from account -> new address w/ deets in message
        puts 'Ok we are good to go. Creating a `sendfrom` tx w/ the archive details'
        tx = Chain::ChainAPI.new({account: account['account'], address: default_account_address['accountaddress'], message: "{\"title\" : \"Alexandria\", \"term\" : \"#{archive['archive_term']}\", \"type\" : \"#{archive['archive_type']}\"}"}).sendfrom
        puts tx
      else
        puts 'there were transactions but not enough was paid checking again in 10 seconds'
        Archive.delay({run_at: 10.seconds.from_now}).confirm_transaction(request_options, archive)
      end
    end
  end
end
