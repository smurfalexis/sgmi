class WatchlistItemsController < ApplicationController

    def create
      @watchlist_item = WatchlistItem.new
      @watchlist_item.watchlist = current_user.watchlist
      @watchlist_item.collection = Collection.find(params[:collection_id])
      @watchlist_item.save
      p current_user.watchlist
      authorize current_user.watchlist
      redirect_to profile_path
    end

end
