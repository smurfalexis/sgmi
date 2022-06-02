require 'uri'
require 'net/http'
require 'json'

def sol_transfers(wallet_key)
  url = URI("https://public-api.solscan.io/account/solTransfers?account=#{wallet_key}&offset=0&limit=50")
  http = Net::HTTP.new(url.hostname, url.port)
  request = Net::HTTP::Get.new(url)
  http.use_ssl = true
  response = http.request(request)
  result = JSON.parse(response.body)
  sending_transfers = []
  result['data'].each do |transfer|
    sending_transfers << transfer if transfer['src'] == wallet_key
  end
  sending_transfers
end

def transaction_details(txhash)
  url = URI("https://public-api.solscan.io/transaction/#{txhash}")
  http = Net::HTTP.new(url.hostname, url.port)
  request = Net::HTTP::Get.new(url)
  http.use_ssl = true
  response = http.request(request)
  JSON.parse(response.body)
end

def price(wallet_key, mint_address)
  sol_transfers = sol_transfers(wallet_key)
  transaction_with_mint_address = sol_transfers.select do |transfer|
    transaction_details(transfer['txHash'])['signer'].include? mint_address
  end
  transaction_with_mint_address[0] ? transaction_with_mint_address[0]['lamport'] : 0
end

puts price(wallet_key, mint_address)
