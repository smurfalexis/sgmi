require "uri"
require "net/http"
require 'json'

# Magic Eden: Provides info about a wallet and the NFTs it holds
# Name, collection and image
# url = URI("https://api-mainnet.magiceden.dev/v2/wallets/#{public_wallet_key}")

# Floor price: Pass in collection
# url = URI("https://api-mainnet.magiceden.dev/v2/collections/#{collection}/stats")

# Transactions for a wallet
# Access the "txHash":
# url = URI("https://public-api.solscan.io/account/transactions?account=CdzTz2wRZPdhkYfj3xfevmPrkmVcftA2QPJSzotvZ4ij&limit=200")

def transactions(wallet_key) # API to get all transactions connected to a wallet
  url = URI("https://public-api.solscan.io/account/transactions?account=#{wallet_key}&limit=200")
  http = Net::HTTP.new(url.hostname, url.port)
  request = Net::HTTP::Get.new(url)
  http.use_ssl = true
  response = http.request(request)
  JSON.parse(response.body)
end

def transaction(txhash) # API to get more information about one specific transaction
  url = URI("https://public-api.solscan.io/transaction/#{txhash}")
  http = Net::HTTP.new(url.hostname, url.port)
  request = Net::HTTP::Get.new(url)
  http.use_ssl = true
  response = http.request(request)
  JSON.parse(response.body)
end

# Method that checks if the type of transaction is mintTo and if the value of mintAuthority is the wallet_key.
# If true it will return the amount of Solana the transaction was for i.e. what price the NFT was bought for.
def price(wallet_key)
  transactions = transactions(wallet_key)
  transaction_details = []
  transactions.each do |transaction|
    transaction_details << transaction(transaction['txhash'])
  end
  transaction_details.each do |transaction|
    type = transaction['innerInstructions'][0]['parsedInstructions'][8]['type']
    wallet = transaction['innerInstructions'][0]['parsedInstructions'][8]['params']['mintAuthority']
    if type == 'mintTo' && wallet == wallet_key
      puts transaction['parsedInstruction'][1]['params']['amount']
    else
      puts "Can't find price information"
    end
  end
end


# API call for current price with start high low close. DO NOT DELETE THIS
# https://api.coingecko.com/api/v3/coins/solana/ohlc?vs_currency=usd&days=1

puts price('Fxu4D17LYhgyxQsrF6Xt5d1Kfe1AiZXD71U6wjamGDLn') # Pass in wallet_key as string and run ruby lib/api.rb to try it in the terminal.
