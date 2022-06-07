require 'uri'
require 'net/http'
require 'json'
SOL = 0.000000001
class WalletsController < ApplicationController
  def new
    @wallet = Wallet.new
    authorize @wallet
  end

  def create
    @wallet = Wallet.new(wallet_params)
    @wallet.user = current_user
    authorize @wallet
    if @wallet.save
      connect_wallet(@wallet)
      get_buy_and_sell_transactions(@wallet)
      redirect_to profile_path
    else
      render :new
    end
  end

  private

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
  def connect_wallet(wallet)
    @watchlist = current_user.watchlist
    @nfts = nfts(wallet.wallet_key)
    @nfts.each do |nft|
      collection = collection(nft['collection'])
      new_collection = Collection.create(name: nft['collectionName'], symbol: nft['symbol'],
                                         floor_price: (collection['floorPrice'] * SOL), listings: collection['listedCount'],
                                         volume: collection['volumeAll'], description: collection['description'])
      Nft.create(mint_address: nft['mintAddress'], name: nft['name'], image: nft['image'],
                 wallet: wallet, collection: new_collection)
    end
  end


  def get_buy_and_sell_transactions(wallet)
    offset = 0
    limit = 500
    result = transactions_by_offset(offset, limit, wallet)
      while result.length == limit
        sleep 2
        puts "slept for 2 secs, calling api again"
        offset = offset + limit
        result = transactions_by_offset(offset, limit)
        p offset
      end
    end

    def transactions_by_offset(offset, limit, wallet)
      url = URI("https://api-mainnet.magiceden.dev/v2/wallets/#{wallet.wallet_key}/activities?offset=#{offset}&limit=#{limit}")
      http = Net::HTTP.new(url.hostname, url.port)
      request = Net::HTTP::Get.new(url)
      http.use_ssl = true
      response = http.request(request)
      result = JSON.parse(response.body)
      result.each do |r|
        if r['type'] == 'buyNow'
          wallet.nfts.each do
              n = Nft.find_by(mint_address: r['tokenMint'])
              if n != nil
              n.update(price: r['price'])
              end
            end
        end
      end
    end
  def wallet_params
    params.require(:wallet).permit(:wallet_key)
  end
end
