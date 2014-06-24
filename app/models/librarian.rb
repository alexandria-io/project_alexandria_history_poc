require 'chain_api'

class Librarian < ActiveRecord::Base

  attr_accessible :title

  def self.check_for_requested_archives

    #create account and address
    puts 'Librarian: Waking up to check for requested archives'

    transactions = Chain::ChainAPI.new({account: ''}).listtransactions

    transactions['transactions'].each do |transaction|

      unless transaction['tx-comment'].empty?

        transaction_comment = JSON.parse(transaction['tx-comment'])

        archive = Archive.where('archive_title = ?', transaction_comment['title'])[0]

        unless archive.nil?

          if transaction['confirmations'].to_i >= 1 && transaction_comment['app'] == 'Alexandria' && archive.creating_archive == false

            archive.creating_archive = true

            archive.save

            Resque.enqueue(VolumeCreator, archive)

          end
        end
      end
    end

    Librarian.delay({run_at: 60.seconds.from_now}).check_for_requested_archives()

  end
end
