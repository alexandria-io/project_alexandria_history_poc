module Chain
  require 'httparty'
  class ChainAPI 
    include HTTParty
  
    COMMANDS = %w[addmultisigaddress backupwallet createrawtransaction decoderawtransaction dumpprivkey encryptwallet getaccount getaccountaddress getaddressesbyaccount getbalance getblock getblockcount getblockhash getblocktemplate getconnectioncount getdifficulty getgenerate gethashespersec getinfo getmininginfo getnetworkhashps getnewaddress getpeerinfo getrawmempool getrawtransaction getreceivedbyaccount getreceivedbyaddress gettransaction getwork getworkex help importprivkey keypoolrefill listaccounts listreceivedbyaccount listreceivedbyaddress listsinceblock listtransactions listunspent makekeypair move sendfrom sendmany sendrawtransaction sendtoaddress setaccount setgenerate setmininput settxfee signmessage signrawtransaction stop validateaddress verifymessage]
  
    def initialize(options)
      self.class.base_uri "http://#{Figaro.env.flochain}:#{Figaro.env.flochain_port}"
      @options = { 
        headers: { 'Chain-Auth-Token' => Figaro.env.chain_auth_token },
        body: options
      }   
    end 
  
    COMMANDS.each do |command|
      define_method(command) do 
        puts @options
        if ['getaccountaddress', 'getnewaddress'].include? command
          self.class.post("/api/v1/chain/#{command}.json", @options)  
        else
          self.class.get("/api/v1/chain/#{command}.json", @options)  
        end
      end
    end
  end
end
