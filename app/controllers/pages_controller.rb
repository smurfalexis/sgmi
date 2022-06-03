class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home about]

  def home
    @popular_collections = Collection.order(volume: :desc).first(10)
    @upcoming_collections = Collection.where(volume: 0).first(3)
    @performing_collections = Collection.where('volume24 > 25').first(3)
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
      delta = nft.collection.floor_price - nft.price
      @array << { delta: delta, nft: nft }
    end

    @highest_delta = @array.sort_by { |element| -element[:delta] }.first(4)
    @best_performing_nfts = @highest_delta.map { |element| element[:nft] }

    @wallet = Wallet.where(user: current_user)
    @nfts = Nft.where(wallet: @wallet)
    @user = current_user
    @data_keys = [
      'January 21',
      'February 21',
      'March 21',
      'April 21',
      'May 21',
      'June 21',
      'July 21',
      'August 21',
      'September 21',
      'October 21',
      'November 21',
      'December 21',
      'January 22',
      'February 22',
      'March 22',
      'April 22',
      'May 22',
      'June 22',
      'July 22',
      'August 22',
      'September 22',
      'October 22',
      'November 22',
      'December 22'
    ]
    @data_values = [100, 400, 175, 200, 50, 350, 600]

    @collections = Collection.all
  end

  def about; end

  # Best performing NFTs
  def best_nfts
    raise
    @nfts = Nft.all.order(:price).first(10)
  end

  # The price in USD that you bought it for vs. what it's worth in USD right now.
  # Purchased price of NFT in Solana.
  # Purchased price of NFT in USD.

  # Floor price of NFT collection in Solana
  # Floor price of NFT collection in USD

  # Sort by desc highest profil in USD. Grab the top four.

  # Add collections button --> promt user to search for collection with an allert

  # Grab all watchlist items related to the current user

  def best_nfts
    @nfts = Nft.all.order(:price).first(10) # price of the user
  end

  def about

  end
end

# Grab all NFTs related to current user from the wallet

# Grab all collections in a watchlist related to current user
# Make it possible to add collection from search result



# Chart Wallet
# Start date = The purchase date of the first bought NFT
# Add purchase dates to NFT Model as column
# Important break points will be the purchase date of each NFT which increases the value of the wallet.
# Add purschase price in USD of each NFT including the purschase date


# Chart NFT
# Start date = The purchase date of the first bought NFT
# Start point = purchased date end point = today/yesterday
# Purchase price - What was USD at the point of purchase?
# Floor price today - USD today?
