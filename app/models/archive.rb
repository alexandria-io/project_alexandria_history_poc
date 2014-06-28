class Archive < ActiveRecord::Base

  attr_accessible :archive_term, :archive_type, :archive_title, :archive_time_length, :florincoin_address, :florincoin_price, :creating_archive, :archive_start_date, :archive_end_date, :archive_start_date_formatted

  has_many :torrents, dependent: :destroy

  has_many :volumes, dependent: :destroy

  has_many :records, dependent: :destroy

  def self.confirm_transaction(account_address, archive)

    require 'chain_api'

    transactions = Chain::ChainAPI.new(account_address).listtransactions

    if transactions['transactions'].empty?

      Archive.delay({run_at: 60.seconds.from_now}).confirm_transaction(account_address, archive)

    else 

      transactions_spent_total = 0

      transactions['transactions'].each do |transaction|

        unless transaction['address'] != archive['florincoin_address'] || transaction['confirmations'] <= 0

          transactions_spent_total += transaction['amount']

        end
      end

      #TODO : Verify that the full price has been paid
      #if transactions_spent_total >= archive['florincoin_price'] 
      if transactions_spent_total >= 2 

        require 'chain_api'

        # get account of recently created archive/address
        account = Chain::ChainAPI.new({address: archive['florincoin_address']}).getaccount

        # get account address for ''
        default_account_address = Chain::ChainAPI.new({account: ''}).getaccountaddress

        # send from account -> new address w/ deets in message
        tx = Chain::ChainAPI.new({account: account['account'], address: default_account_address['accountaddress'], message: "{\"app\" : \"Alexandria\", \"term\" : \"#{archive['archive_term']}\", \"type\" : \"#{archive['archive_type']}\", \"title\" : \"#{archive['archive_title']}\"}"}).sendfrom

      else

        Archive.delay({run_at: 60.seconds.from_now}).confirm_transaction(account_address, archive)

      end
    end
  end
end
