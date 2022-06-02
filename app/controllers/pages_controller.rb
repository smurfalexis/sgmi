class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home about]

  def home
    @popular_collections = Collection.order(volume: :desc).first(10)
    @upcoming_collections = Collection.where(volume: 0).first(3)
  end

  def profile
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
  end

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


  # Highest floor price
  # Check floor price of collections
  # Grab the first two with the highest floor price



  # Add collections button --> promt user to search for collection with an allert

  # Grab all watchlist items related to the current user

  # Grab all NFTs related to current user from the wallet

  def about; end
end
