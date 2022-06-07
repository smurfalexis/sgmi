# These methods should be used for when the user connects the wallet for the first time.
require 'uri'
require 'net/http'
require 'json'

# All the nfts in a wallet
def nfts(wallet_key)
  url = URI("https://api-mainnet.magiceden.dev/v2/wallets/#{wallet_key}/tokens?offset=0&limit=500&listStatus=both")
  http = Net::HTTP.new(url.hostname, url.port)
  request = Net::HTTP::Get.new(url)
  http.use_ssl = true
  response = http.request(request)
  JSON.parse(response.body)
end

# Information about the collection
def collection(collection)
  url = URI("https://api-mainnet.magiceden.dev/v2/collections/#{collection}/stats")
  http = Net::HTTP.new(url.hostname, url.port)
  request = Net::HTTP::Get.new(url)
  http.use_ssl = true
  response = http.request(request)
  JSON.parse(response.body)
end

# Creates a wallet, watchlist, all nfts and collections when user connects wallet.
def connect_wallet(wallet_key)
  wallet = Wallet.create(wallet_key: wallet_key, user_id: current_user)
  Watchlist.create(user_id: current_user)
  nfts = nfts(wallet_key)
  nfts.each do |nft|
    collection = collection(nft['collection'])
    Nft.create(mint_address: nft['mintAddress'], name: nft['name'], image: nft['image'],
               wallet_id: wallet, user_id: current_user)
    Collection.create(collection_name: nft['collectionName'], collection: nft['collection'],
                      floor_price: collection['floorPrice'], listed: collection['listedCount'],
                      volume: collection['volumeAll'])
  end
end

connect_wallet
