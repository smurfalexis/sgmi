require 'uri'
require 'net/http'
require 'json'
SOL = 0.000000001
class WalletsController < ApplicationController
  before_action :set_wallet, only: %i[edit update]

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
      redirect_to profile_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @wallet.update(wallet_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  private

  def set_wallet
    @wallet = Wallet.find_by(user: current_user)
    authorize @wallet
  end

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
        wallet: wallet,collection: new_collection)
    end
  end


  def wallet_params
    params.require(:wallet).permit(:wallet_key)
  end
end
