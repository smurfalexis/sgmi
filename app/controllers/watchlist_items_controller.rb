class WatchlistItemsController < ApplicationController

    def create
      WatchlistItem.create(collection_id: params[:collection_id], user_id: current_user.id)
      redirect_to profile_path
    end 

end
