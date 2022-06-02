class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home about]

  def home
    @popular_collections = Collection.order(volume: :desc).first(10)
    @upcoming_collections = Collection.where(volume: 0).first(3)
    @performing_collections = Collection.where("volume24 > 25").first(3)
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

    @nfts = @wallet.nfts

    @highest_floor_price_nfts = @nfts.sort_by { |nft| nft.collection.floor_price }
    raise
  end

  # Best performing NFTs
  def best_nfts
    @nfts = Nft.all.order(:price).first(10) #price of the user
  end

  def about

  end

  def nft_original_price
    raise
  end

  #5 nfts for 10 Sol ->
    # Nft nr. 1 after one month. Floor_price of the collection = 20 Sol
    # Nft nr. 2 after one month. Floor_price of the collection = 15 Sol
    # Nft nr. 3 after one month. Floor_price of the collection = 10 Sol
    # Nft nr. 4 after one month. Floor_price of the collection = 5 Sol
    # Nft nr. 5 after one month. Floor_price of the collection = 2 Sol
end



  # The price in USD that you bought it for vs. what it's worth in USD right now.
  # Purchased price of NFT in Solana.
  # Purchased price of NFT in USD.

  # Floor price of NFT collection in Solana
  # Floor price of NFT collection in USD

  # Sort by desc highest profil in USD. Grab the top four.


  # Highest floor price
def highest_floor_price
  @floor_price = Collection.all()
end
  # Check floor price of collections
  # Grab the first two with the highest floor price



  # Add collections button --> promt user to search for collection with an allert

  # Grab all watchlist items related to the current user

  # Grab all NFTs related to current user from the wallet
