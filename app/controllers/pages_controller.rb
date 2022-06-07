require 'json'

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

    # Grab all NFTs related to current user from the wallet
    @nfts = @wallet.nfts
    # Highest floor price

    # Check floor price of collections
    # Grab the first two with the highest floor price

    @highest_floor_price_nfts = @nfts.sort_by { |nft| -nft.collection.floor_price }.first(2)

    # Best performing NFTs
    # highest floor price - original price

    @array = []
    @nfts.each do |nft|
      delta = nft.collection.floor_price
      @array << { delta: delta, nft: nft }
    end

    @highest_delta = @array.sort_by { |element| -element[:delta] }
    @best_performing_nfts = @highest_delta.map { |element| element[:nft] }

    @wallet = Wallet.where(user: current_user)
    @nfts = Nft.where(wallet: @wallet)
    @user = current_user
    @data_keys = { '12.04.2022' => 5,
                   '19.04.2022' => 7,
                   '26.04.2022' => 10,
                   '03.05.2022' => 25,
                   '10.05.2022' => 36,
                   '17.05.2022' => 47,
                   '24.05.2022' => 33,
                   '31.05.2022' => 110 }

    @okay = Collection.find_by(name: 'Okay Bears')
    @okay.floor_price = @data_keys

    @data_values = [100, 400, 175, 200, 50, 350, 600]

    @degods_fp = { '12.04.2022' => 8,
                   '19.04.2022' => 10,
                   '26.04.2022' => 14,
                   '03.05.2022' => 23,
                   '10.05.2022' => 29,
                   '17.05.2022' => 55,
                   '24.05.2022' => 33,
                   '31.05.2022' => 110 }
    @degods = Collection.find_by(name: 'DeGods')
    @degods.floor_price = @degods_fp
    @smokeheads = Collection.find_by(name: 'Smoke Heads')
    @smokeheads_fp = { '12.04.2022' => 5,
                       '19.04.2022' => 29,
                       '26.04.2022' => 90,
                       '03.05.2022' => 25,
                       '10.05.2022' => 16,
                       '17.05.2022' => 47,
                       '24.05.2022' => 53,
                       '31.05.2022' => 193 }
    @smokeheads.floor_price = @smokeheads_fp
    @cardboard = Collection.find_by(name: 'Cardboard Citizens')
    @cardboard_fp = { '12.04.2022' => 5,
                      '19.04.2022' => 7,
                      '26.04.2022' => 10,
                      '03.05.2022' => 5,
                      '10.05.2022' => 26,
                      '17.05.2022' => 97,
                      '24.05.2022' => 32,
                      '31.05.2022' => 300 }
    @cardboard.floor_price = @cardboard_fp
    @nfts_chart = []
    @nfts_chart << @okay
    @nfts_chart << @degods
    @nfts_chart << @smokeheads
    @nfts_chart << @cardboard
    @collections = Collection.all
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
    first3 = result["collections"].first(3).map {|collection| collection["name"]}
    first3.map {|collection| Collection.find_by(name: collection)}
  end

  def upcoming_collections
    url = URI("https://api-mainnet.magiceden.dev/v2/launchpad/collections?offset=0&limit=200")
    http = Net::HTTP.new(url.hostname, url.port)
    request = Net::HTTP::Get.new(url)
    http.use_ssl = true
    response = http.request(request)
    result = JSON.parse(response.body)
    first4 = result.map do |collection|
      next unless collection["launchDatetime"].present? && Date.parse(collection["launchDatetime"]) > Date.today
      {name: collection["name"], price: collection["price"], image: collection["image"], supply: collection["size"], description: collection["description"]}
    end
    first4.compact.first(4)
  end
end
