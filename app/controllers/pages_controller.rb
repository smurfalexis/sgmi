require 'json'
NFT_PRICES = [2.4, 5 ,3.2 ,1.3 ,1.5, 1.9 ]
NFT_OWNERS = "No Data"
NFT_SUPPLY = "No Data"
class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home about]

  def home
    @popular_collections = Collection.order('volume DESC NULLS LAST').first(5)
    @upcoming_collections = upcoming_collections()
    @popular_collections_today = popular_collections_24h()
    @nft_prices = NFT_PRICES
    @nft_owners = NFT_OWNERS
    @nft_supply = NFT_SUPPLY
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
    @nft_owners = NFT_OWNERS
    @nft_supply = NFT_SUPPLY
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
      delta = nft.collection.floor_price_in_sol.round(2)
      @wallet_value += nft.collection.floor_price_in_sol.round(2)
      @array << { delta: delta, nft: nft }
    end

    @usd_wallet_value = (@wallet_value * 39.7).round(2) #Find real time Sol to Usd
    @highest_delta = @array.sort_by { |element| -element[:delta] }
    @best_performing_nfts = @highest_delta.map { |element| element[:nft] }

    @wallet = Wallet.where(user: current_user)
    @nfts = Nft.where(wallet: @wallet)
    @user = current_user
    # @data_keys = { '12.04.2022' => 5,
    #                '19.04.2022' => 7,
    #                '26.04.2022' => 10,
    #                '03.05.2022' => 25,
    #                '10.05.2022' => 36,
    #                '17.05.2022' => 47,
    #                '24.05.2022' => 33,
    #                '31.05.2022' => 110 }

    # @okay = Collection.find_by(name: 'Okay Bears')
    # @okay.floor_price = @data_keys

    # @data_values = [100, 400, 175, 200, 50, 350, 600]

    # @degods_fp = { '12.04.2022' => 8,
    #                '19.04.2022' => 10,
    #                '26.04.2022' => 14,
    #                '03.05.2022' => 23,
    #                '10.05.2022' => 29,
    #                '17.05.2022' => 55,
    #                '24.05.2022' => 33,
    #                '31.05.2022' => 110 }
    # @degods = Collection.find_by(name: 'DeGods')
    # @degods.floor_price = @degods_fp
    # @smokeheads = Collection.find_by(name: 'Smoke Heads')
    # @smokeheads_fp = { '12.04.2022' => 5,
    #                    '19.04.2022' => 29,
    #                    '26.04.2022' => 90,
    #                    '03.05.2022' => 25,
    #                    '10.05.2022' => 16,
    #                    '17.05.2022' => 47,
    #                    '24.05.2022' => 53,
    #                    '31.05.2022' => 193 }
    # @smokeheads.floor_price = @smokeheads_fp
    # @cardboard = Collection.find_by(name: 'Cardboard Citizens')
    # @cardboard_fp = { '12.04.2022' => 5,
    #                   '19.04.2022' => 7,
    #                   '26.04.2022' => 10,
    #                   '03.05.2022' => 5,
    #                   '10.05.2022' => 26,
    #                   '17.05.2022' => 97,
    #                   '24.05.2022' => 32,
    #                   '31.05.2022' => 300 }
    # @cardboard.floor_price = @cardboard_fp
    # @nfts_chart = []
    # @nfts_chart << @okay
    # @nfts_chart << @degods
    # @nfts_chart << @smokeheads
    # @nfts_chart << @cardboard
    # @collections = Collection.all

    # @collections = Collection.all

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
    popular_three = result['collections'].first(10)
    array = []

    popular_three.each do |popular_collection|
     db_collection = Collection.find_by(name: popular_collection["name"])
      if db_collection.present?

        if db_collection.volume.nil?

          collection_data = collection(popular_collection["symbol"])
          updated_collection = Collection.update(db_collection.id, :volume => collection_data["volumeAll"])
          array << updated_collection if updated_collection.valid?
        else
          array << db_collection
        end
      else

        collection_data = collection(popular_collection["symbol"])

        new_collection = Collection.create(name: popular_collection['name'], symbol: popular_collection['symbol'],
                                         floor_price: (collection_data['floorPrice']), listings: collection_data['listedCount'],
                                         volume: collection_data['volumeAll'], description: popular_collection['description'],
                                         discord: popular_collection["discord"], twitter: popular_collection["twitter"],
                                         website: popular_collection["website"], image: popular_collection["image"])
        array << new_collection if new_collection.valid?
      end

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
    first10 = []
    result.each do |upcoming_collection|
      next unless upcoming_collection["launchDatetime"].present? && Date.parse(upcoming_collection["launchDatetime"]) > Date.today
      db_collection = Collection.find_by(name: upcoming_collection["name"])

      if !db_collection.present?
        db_collection = Collection.create(name: upcoming_collection['name'], symbol: upcoming_collection['symbol'],
                                         floor_price: upcoming_collection['price']*1000000000, description: upcoming_collection['description'],
                                         discord: upcoming_collection["discord"], twitter: upcoming_collection["twitter"],
                                         website: upcoming_collection["website"], image: upcoming_collection["image"],
                                         supply: upcoming_collection["size"])
      end
      first10 << db_collection if db_collection.valid?
      break if first10.length == 10
      # { name: collection["name"], price: collection["price"], image: collection["image"], supply: collection["size"], description: collection["description"]}
    end
    first10
  end

#need to be DRY put all apis in one place that can be imported
  def collection(collection)
    url = URI("https://api-mainnet.magiceden.dev/v2/collections/#{collection}/stats")
    http = Net::HTTP.new(url.hostname, url.port)
    request = Net::HTTP::Get.new(url)
    http.use_ssl = true
    response = http.request(request)
    JSON.parse(response.body)
  end

end
