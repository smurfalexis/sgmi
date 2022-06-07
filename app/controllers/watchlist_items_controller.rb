class WatchlistItemsController < ApplicationController
  def create
    flash[:watchlist_item] = 'The collection has already been saved to your watchlist!'
    @watchlist_item = WatchlistItem.new
    @watchlist_item.watchlist = current_user.watchlist
    @watchlist_item.collection = Collection.find(params[:collection_id])
    @error = false
    @error = true unless @watchlist_item.save!
    authorize current_user.watchlist
    redirect_to profile_path
  end

  def destroy
    @watchlist_item = WatchlistItem.find(params[:id])
    authorize @watchlist_item
    @watchlist_item.destroy
    redirect_to profile_path
  end
end
