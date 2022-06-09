class WatchlistItemsController < ApplicationController
  def create
    # flash[:watchlist_item] = 'The collection has already been saved to your watchlist!'
    @watchlist_item = WatchlistItem.new
    @watchlist_item.watchlist = current_user.watchlist
    @watchlist_item.collection = Collection.find(params[:collection_id])

    authorize current_user.watchlist
    @watchlist_item.save

    if params[:stop_redirect]
      if !@watchlist_item.errors.any?
        flash[:success] = "The collection has been saved to your watchlist!"
        redirect_back(fallback_location: root_path)
      else
        flash[:danger] = "The collection has already been saved!"
        redirect_back(fallback_location: root_path)
      end
    else
      if !@watchlist_item.errors.any?
        flash[:success] = "The collection has been saved to your watchlist!"
        redirect_to profile_path
      else
        flash[:danger] = "The collection has already been saved!"
        redirect_to profile_path
      end
    end

  end

  def destroy
    @watchlist_item = WatchlistItem.find(params[:id])
    authorize @watchlist_item
    @watchlist_item.destroy
    redirect_to profile_path
  end
end
