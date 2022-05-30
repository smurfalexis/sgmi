require "uri"
require "net/http"
require 'json'

# Magic Eden: Provides info about a wallet and the NFTs it holds
# Name, collection and image
# url = URI("https://api-mainnet.magiceden.dev/v2/wallets/#{public_wallet_key}")

# Floor price: Pass in collection
url = URI("https://api-mainnet.magiceden.dev/v2/collections/#{collection}/stats")

#

http = Net::HTTP.new(url.hostname, url.port);
request = Net::HTTP::Get.new(url)
http.use_ssl = true
response = http.request(request)
p result = JSON.parse(response.body)
