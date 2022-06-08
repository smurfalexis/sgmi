class WatchlistItemsController < ApplicationController
  def create
    flash[:watchlist_item] = 'The collection has already been saved to your watchlist!'
    @watchlist_item = WatchlistItem.new
    @watchlist_item.watchlist = current_user.watchlist
    @watchlist_item.collection = Collection.find(params[:collection_id])
    if @watchlist_item.save!
      flash[:notice] = "The collection has been saved to your watchlist!"
    else
      flash[:notice] = "The collection has already been saved to your watchlist!"
    end
    authorize current_user.watchlist
    respond_to do |format|
      format.html { redirect_to profile_path }
      format.text
    end
  end

  def destroy
    @watchlist_item = WatchlistItem.find(params[:id])
    authorize @watchlist_item
    @watchlist_item.destroy
    redirect_to profile_path
  end
end
