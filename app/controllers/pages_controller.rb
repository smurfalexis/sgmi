require 'json'
NFT_PRICES = [2.4, 5 ,3.2 ,1.3 ,1.5, 1.9 ]
class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home about]

  def home
    @popular_collections = Collection.order(volume: :desc).first(5)
    @upcoming_collections = upcoming_collections()
    @popular_collections_today = popular_collections_24h()
  end

  # def highest_floor_price
  #   nfts = []
  #   user_wallet = Wallet.where(user_id: current_user)
  #   user_wallet.nfts.each do |nft|
  #     nfts << nft
  #   end
  #   nfts.sort { |a, b| a[:floor_price] <=> b[:floor_price] }
  #   raise
  # end

  def profile
    @wallet = Wallet.find_by(user: current_user)
    @watchlist = Watchlist.where(user: current_user)
    @watchlist_items = WatchlistItem.where(watchlist: @watchlist)
    @nft_prices = NFT_PRICES
    # Grab all NFTs related to current user from the wallet
    @nfts = @wallet.nfts
    # Highest floor price

    # Check floor price of collections
    # Grab the first two with the highest floor price

    @highest_floor_price_nfts = @nfts.sort_by { |nft| -nft.collection.floor_price }.first(2)

    # Best performing NFTs
    # highest floor price - original price
    @wallet_value = 0
    @array = []
    @nfts.each do |nft|
      delta = nft.collection.floor_price
      @wallet_value += nft.collection.floor_price
      @array << { delta: delta, nft: nft }
    end

    @usd_wallet_value = (@wallet_value * 39.7).round(2) #Find real time Sol to Usd
    @highest_delta = @array.sort_by { |element| -element[:delta] }
    @best_performing_nfts = @highest_delta.map { |element| element[:nft] }

    @collections = Collection.all

    # url = URI("https://api-mainnet.magiceden.dev/v2/wallets/#{wallet_key}/tokens?offset=0&limit=500&listStatus=both")
    # http = Net::HTTP.new(url.hostname, url.port)
    # request = Net::HTTP::Get.new(url)
    # http.use_ssl = true
    # response = http.request(request)
    # JSON.parse(response.body)
  end

  def about; end

  def introduction
  end

  # Best performing NFTs
  def best_nfts
    @nfts = Nft.all.order(:price).first(10)
  end

  private

  def popular_collections_24h
    url = URI("https://api-mainnet.magiceden.io/popular_collections?more=true&timeRange=1d&edge_cache=true")
    http = Net::HTTP.new(url.hostname, url.port)
    request = Net::HTTP::Get.new(url)
    http.use_ssl = true
    response = http.request(request)
    result = JSON.parse(response.body)
    popular_all = result["collections"].map {|collection| collection["name"]}
    array = []
    popular_all.each do |collection|
      db_collection = Collection.find_by(name: collection)
      array << db_collection if db_collection.present?
      break if array.length == 10
    end
    array
  end

  def upcoming_collections
    url = URI("https://api-mainnet.magiceden.dev/v2/launchpad/collections?offset=0&limit=200")
    http = Net::HTTP.new(url.hostname, url.port)
    request = Net::HTTP::Get.new(url)
    http.use_ssl = true
    response = http.request(request)
    result = JSON.parse(response.body)
    first12 = result.map do |collection|
      next unless collection["launchDatetime"].present? && Date.parse(collection["launchDatetime"]) > Date.today
      {name: collection["name"], price: collection["price"], image: collection["image"], supply: collection["size"], description: collection["description"]}
    end
    first12.compact.first(12)
  end
end